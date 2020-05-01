import 'package:flutter/material.dart';
import 'package:inv/screen/dashboard_screen.dart';
import 'package:inv/screen/item_screen/tab1.dart';

class ItemScreen extends StatefulWidget {
  @override
  _ItemScreenState createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Item'),
      ),
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            Container(
              constraints: BoxConstraints.expand(height: 60),
              child: TabBar(
                labelColor: Colors.black,
                 tabs: [
                   Tab(icon: Icon(Icons.edit),text: "Edit",),
                   Tab(icon: Icon(Icons.add), text: "Add",),
                   Tab(icon: Icon(Icons.settings), text: "Setting",)
                 ],
              ),
            ),
            Expanded(
              child: Container(
                child: TabBarView(
                  children: [
                    ItemTabA(),
                    Container(
                      child: Text("Body 2"),
                    ),
                    Container(
                      child: Text("Body 3"),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
