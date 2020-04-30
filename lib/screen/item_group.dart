import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inv/bloc/item/bloc.dart';
import 'package:inv/model/item_category.dart';

class ItemGroupScreen extends StatefulWidget {
  @override
  _ItemGroupScreenState createState() => _ItemGroupScreenState();
}

class _ItemGroupScreenState extends State<ItemGroupScreen> {
  var rng = new Random();
  TextEditingController controller;
  List<Color> colorList = [
    Colors.red,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.grey,
    Colors.orange,
    Colors.pinkAccent
  ];
  Color selectedColor;
  bool colorSelected = true;
  String groupName = "";

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    selectedColor = colorList[rng.nextInt(colorList.length - 1)];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Item Group'),
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
                                        color: e,
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
                            FocusScopeNode currentFocus = FocusScope.of(context);
                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                            }
                            ItemCategory itmCat = ItemCategory(
                                name: groupName,
                                color: selectedColor.value);
                            controller.clear();
                            BlocProvider.of<ItemBloc>(context)
                                .add(ItemCategoryAdded(itemCategory: itmCat));
                          }
                        : null,
                  ),
                ),
              ],
            ),
            CategoryChip()
          ],
        ),
      ),
    );
  }
}

class CategoryChip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ItemBloc, ItemState>(
        builder: (BuildContext context, ItemState state) {
      if (state is ItemCategoryLoadSuccess) {
        if (state.category.isEmpty) {
          return Container(
            child: Image.asset('assets/images/no_data.png', fit: BoxFit.contain,),
          );
        }
        return Wrap(
          spacing: 10.0,
          children: state.category
              .map((e) => Chip(
                    label: Text(e.name),
                    backgroundColor: e.color!= null ? Color(e.color) : Colors.grey,
                  ))
              .toList(),
        );
      }
      if (state is ItemCategoryLoading) {
        return Center(child: CircularProgressIndicator());
      }
      return Container();
    });
  }
}
