import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:inv/bloc/authentication/bloc.dart';
import 'package:inv/bloc/item_category/bloc.dart';
import 'package:inv/bloc/settings/bloc.dart';
import 'package:inv/bloc/theme/bloc.dart';
import 'package:inv/repository/item_repository.dart';
import 'package:inv/repository/user_repository.dart';
import 'package:inv/screen/dashboard_screen.dart';
import 'package:inv/screen/login_screen.dart';
import 'package:inv/simple_bloc_delegate.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final UserRepository userRepository = UserRepository();
  BlocSupervisor.delegate = SimpleBlocDelegate();

  final Database database = await openDatabase(
      join(await getDatabasesPath(), 'inv_database.db'),
    onCreate: (db, version) {
        return db.execute(
            "CREATE TABLE ITEM_CATEGORY(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT, description TEXT, color INTEGER)"
        );
    },
    version: 1
  );

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<ThemeBloc>(
        create: (BuildContext context) => ThemeBloc()..add(InitialTheme(
          isTestMode: false,
          locale: null,
          themeMode: ThemeMode.system,
          platform: defaultTargetPlatform
        )),
      ),
      BlocProvider<SettingsBloc>(
        create: (BuildContext context) => SettingsBloc(),
      ),
      BlocProvider(
        create: (context) =>
            AuthenticationBloc(repository: userRepository)..add(AppStarted()),
      ),
      BlocProvider<ItemCategoryBloc>(
        create: (context) {
          return ItemCategoryBloc(
              itemRepository: ItemRepository(database: database)
          )..add(ItemCategoryLoaded());
        },
      )
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (BuildContext context, ThemeState state) {

        return MaterialApp(
          localizationsDelegates: [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate
          ],
//          themeMode: state.themeMode,
//          theme: AppThemeData.lightThemeData.copyWith(
//            platform: state.platform
//          ),
//          darkTheme: AppThemeData.darkThemeData.copyWith(
//            platform: state.platform
//          ),
          locale: state.locale,
          supportedLocales: S.delegate.supportedLocales,
          localeResolutionCallback: (locale, supportedLocales) {
            return locale;
          },
          home: _MainScreen(),
        );
      },
    );
  }
}

class _MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (BuildContext context, AuthenticationState state) {
        if (state is UnAuthenticated) {
          return LoginScreen();
        } else if (state is Authenticated) {
          return DashboardScreen();
        } else {
          return Container();
        }
      },
    );
  }
}

