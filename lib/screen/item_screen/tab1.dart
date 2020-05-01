import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ItemTabA extends StatefulWidget {
  @override
  _ItemTabAState createState() => _ItemTabAState();
}

class _ItemTabAState extends State<ItemTabA> {

  File _image;

  Future getImage() async {
    print('Opening camera');
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(15)
                ),
                margin: EdgeInsets.all(25),
                child: Center(
                  child: IconButton(
                    iconSize: 150,
                    alignment: Alignment.center,
                    color: Colors.purple,
                    icon: Icon(Icons.add,),
                    onPressed: () async { await getImage();},
                  ),
                ),
              ),
            ],
          ),
          Center(
            child: _image == null
                ? Text('No image selected.')
                : Image.file(_image),
          ),
        ],
      ),
    );
  }
}
