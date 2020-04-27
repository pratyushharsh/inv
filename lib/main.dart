import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inv/bloc/authentication/bloc.dart';
import 'package:inv/bloc/settings/bloc.dart';
import 'package:inv/bloc/theme/bloc.dart';
import 'package:inv/repository/user_repository.dart';
import 'package:inv/screen/dashboard_screen.dart';
import 'package:inv/screen/login_screen.dart';
import 'package:inv/simple_bloc_delegate.dart';

void main() {
  final UserRepository userRepository = UserRepository();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<ThemeBloc>(
        create: (BuildContext context) => ThemeBloc(),
      ),
      BlocProvider<SettingsBloc>(
        create: (BuildContext context) => SettingsBloc(),
      ),
      BlocProvider(
        create: (context) => AuthenticationBloc(
          repository: userRepository
        )..add(AppStarted()),
      )
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (BuildContext context, AuthenticationState state) {
          if (state is UnAuthenticated) {
            return LoginScreen();
          } else if (state is Authenticated) {
            return DashboardScreen();
          }
          else {
            return Container();
          }
        },
      ),
    );
  }
}
