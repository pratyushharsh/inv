import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inv/bloc/item/item_bloc.dart';
import 'package:inv/bloc/item/item_state.dart';
import 'package:inv/model/item.dart';

class ItemDisplayScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Item List"),
      ),
      body: BlocBuilder<ItemBloc, ItemState>(
        builder: (context, state) {
          if (state is ItemLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ItemLoadSuccess) {
            if (state.items.isEmpty) {
              return Center(
                child: Text("Nothing To diaplay"),
              );
            }

            return ListView.separated(
              separatorBuilder: (context, index) => Divider(
                color: Colors.black,
              ),
              itemBuilder: (context, index) {
                Item itm = state.items[index];
                return ListTile(

                  leading: CircleAvatar(
                    child: FutureBuilder<File>(
                      future: BlocProvider.of<ItemBloc>(context)
                          .getItemImage(itm.itemId),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Image.file(snapshot.data);
                        }
                        return Text("N");
                      },
                    ),
                  ),
                  title: Text(itm.name),
                  subtitle: Text(itm.description),
                  trailing: Text("₹ 50", style: TextStyle(
                    fontSize: 25
                  ),),
                );
              },
              itemCount: state.items.length,
            );
          }

          return Center(
            child: Icon(
              Icons.error,
              color: Colors.red,
            ),
          );
        },
      ),
    );
  }
}
