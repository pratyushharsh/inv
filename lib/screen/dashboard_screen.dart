import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inv/bloc/item_category/bloc.dart';
import 'package:inv/repository/item_repository.dart';
import 'package:inv/screen/item_group.dart';
import 'package:inv/screen/item_screen.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      drawer: AppDrawer(),
      body: Center(
        child: Text('Dashboard'),
      ),
    );
  }
}

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Text("Shop Detail and avatar"),
            decoration: BoxDecoration(
                color: Theme.of(context).accentColor.withAlpha(150)),
          ),
          ListTile(
            title: Text("Item"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ItemScreen()));
            },
          ),
          ListTile(
            title: Text("Item Group"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ItemGroupScreen()));
            },
          )
        ],
      ),
    );
  }
}
