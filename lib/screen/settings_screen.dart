import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inv/bloc/theme/bloc.dart';
import 'package:inv/generated/l10n.dart';

class SettingsScreen extends StatelessWidget {

  static String path = "/settings";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).settings),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.pop(context);
              }
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RaisedButton(
                onPressed: () {
                  BlocProvider.of<ThemeBloc>(context).add(ChangeLocale(locale: Locale("en")));
                },
                child: Text(S.of(context).english),
              ),
              RaisedButton(
                onPressed: () {
                  BlocProvider.of<ThemeBloc>(context).add(ChangeLocale(locale: Locale("hi")));
                },
                child: Text(S.of(context).hindi),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(S.of(context).dark_mode),
              ThemeSwitch()
            ],
          )
        ],
      ),
    );
  }
}

class ThemeSwitch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeMode mode = BlocProvider.of<ThemeBloc>(context).state.themeMode;
    return Padding(
      padding: const EdgeInsetsDirectional.only(end: 8),
      child: Switch(
        value: ThemeMode.dark == mode,
        onChanged: (isOn) {
          ThemeMode newMode = isOn ? ThemeMode.dark : ThemeMode.light;
          BlocProvider.of<ThemeBloc>(context).add(ChangeThemeMode(themeMode: newMode));
        },
      ),
    );
  }
}

