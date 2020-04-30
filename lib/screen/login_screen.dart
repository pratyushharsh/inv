import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inv/bloc/authentication/bloc.dart';
import 'package:inv/bloc/login/bloc.dart';
import 'package:inv/generated/l10n.dart';
import 'package:inv/screen/settings_screen.dart';
import 'package:inv/widget/login/login_form.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).login),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
              builder: (context) => SettingsScreen()
              ));
            },
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: BlocProvider<LoginBloc>(
        create: (create) => LoginBloc(
            authenticationBloc: BlocProvider.of<AuthenticationBloc>(context)
        ),
        child: LoginForm(),
      ),
    );
  }
}
