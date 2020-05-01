import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inv/bloc/item_category/bloc.dart';
import 'package:inv/model/item_category.dart';

class ItemGroupScreen extends StatefulWidget {
  @override
  _ItemGroupScreenState createState() => _ItemGroupScreenState();
}

class _ItemGroupScreenState extends State<ItemGroupScreen> {
  var rng = new Random();
  TextEditingController controller;
  List<Color> colorList = [
    Colors.purpleAccent,
    Colors.yellowAccent,
    Colors.green,
    Colors.blue,
    Colors.grey,
    Colors.orange,
    Colors.pinkAccent
  ];
  Color selectedColor;
  bool colorSelected = true;
  String groupName = "";
  bool _editEnabled;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    selectedColor = colorList[rng.nextInt(colorList.length - 1)];
    _editEnabled = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Item Group'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              setState(() {
                _editEnabled = !_editEnabled;
              });
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 9,
                  child: TextField(
                    controller: controller,
                    onChanged: (val) {
                      setState(() {
                        groupName = val.trim();
                      });
                    },
                    decoration: InputDecoration(
                        labelText: 'Group Title',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          colorSelected = !colorSelected;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: selectedColor,
                            borderRadius: BorderRadius.circular(5)),
                        height: 30,
                        width: 30,
                      ),
                    ),
                  ),
                )
              ],
            ),
            colorSelected
                ? SizedBox(
                    height: 10,
                  )
                : Container(),
            !colorSelected
                ? Container()
                : Row(
                    children: colorList
                        .map((e) => Expanded(
                              flex: 1,
                              child: Center(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      colorSelected = !colorSelected;
                                      selectedColor = e;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: e.withAlpha(180),
                                        borderRadius: BorderRadius.circular(5)),
                                    height: 30,
                                    width: 30,
                                  ),
                                ),
                              ),
                            ))
                        .toList(),
                  ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(),
                ),
                Expanded(
                  child: RaisedButton(
                    color: Theme.of(context).primaryColor,
                    child: Text('Add'),
                    onPressed: groupName.isNotEmpty
                        ? () {
                            FocusScopeNode currentFocus =
                                FocusScope.of(context);
                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                            }
                            ItemCategory itmCat = ItemCategory(
                                name: groupName, color: selectedColor.value);
                            controller.clear();
                            groupName = "";
                            BlocProvider.of<ItemCategoryBloc>(context)
                                .add(ItemCategoryAdded(itemCategory: itmCat));
                          }
                        : null,
                  ),
                ),
              ],
            ),
            CategoryChip(isEditable: _editEnabled,)
          ],
        ),
      ),
    );
  }
}

class CategoryChip extends StatelessWidget {
  final bool isEditable;

  CategoryChip({this.isEditable = false});

  Widget _buildChip(BuildContext context, ItemCategory e) {
    if (isEditable) {
      return Chip(
        elevation: 10,
        avatar: CircleAvatar(
          child: Text(e.name.substring(0, 1).toUpperCase()),
        ),
        onDeleted: () {
          BlocProvider.of<ItemCategoryBloc>(context)
              .add(ItemCategoryDeleted(itemCategory: e));
        },
        deleteIcon: Icon(Icons.delete),
        label: Text(e.name),
        backgroundColor: e.color != null
            ? Color(e.color).withAlpha(180)
            : Colors.grey,
      );
    } else {
      return Chip(
        elevation: 10,
        avatar: CircleAvatar(
          child: Text(e.name.substring(0, 1).toUpperCase()),
        ),
        label: Text(e.name),
        backgroundColor: e.color != null
            ? Color(e.color).withAlpha(180)
            : Colors.grey,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ItemCategoryBloc, ItemCategoryState>(
        builder: (BuildContext context, ItemCategoryState state) {
      if (state is ItemCategoryLoadSuccess) {
        if (state.category.isEmpty) {
          return Container(
            child: Image.asset(
              'assets/images/no_data.png',
              fit: BoxFit.contain,
            ),
          );
        }
        return Wrap(
          spacing: 10.0,
          children: state.category
              .map((e) => _buildChip(context, e))
              .toList(),
        );
      }
      if (state is ItemCategoryLoading) {
        return Center(child: CircularProgressIndicator());
      }

      if (state is ItemCategoryLoadFailure) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          child: Icon(
            Icons.error,
            color: Colors.red,
            size: 150,
          ),
        );
      }
      return Container();
    });
  }
}
