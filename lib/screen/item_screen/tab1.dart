import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inv/bloc/item_category/bloc.dart';
import 'package:inv/model/item_category.dart';
import 'package:inv/repository/item_repository.dart';

class ItemTabA extends StatefulWidget {
  @override
  _ItemTabAState createState() => _ItemTabAState();
}

class _ItemTabAState extends State<ItemTabA> {
  File _image;
  ItemCategory _cat;

  TextEditingController _idController;
  TextEditingController _nameController;
  TextEditingController _descController;

//  @TODO Deleting the cached image created
  Future getImage(ImageSource imgSrc) async {
    print('Opening camera');
    var image = await ImagePicker.pickImage(source: imgSrc);
    print(image.lengthSync());
    File croppedImage = await ImageCropper.cropImage(
      sourcePath: image.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
      ],
      maxHeight: 512,
      compressQuality: 30,
      cropStyle: CropStyle.rectangle,
    );
//    image.deleteSync();

//    File result = await FlutterImageCompress.compressAndGetFile(
//      croppedImage.path, croppedImage.path,
//      quality: 50,
//    );
//    print(result.lengthSync());
    setState(() {
      _image = croppedImage;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(15)),
                margin: EdgeInsets.all(25),
                child: Center(
                  child: _image == null
                      ? IconButton(
                          iconSize: 150,
                          alignment: Alignment.center,
                          color: Colors.purple,
                          icon: Icon(
                            Icons.add,
                          ),
                          onPressed: () {
                            _buildModal(context);
                          },
                        )
                      : SizedBox(
                          height: 150,
                          width: 150,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Image.file(
                              _image,
                              fit: BoxFit.contain,
                            ),
                          )),
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    TextField(
                      keyboardType: TextInputType.numberWithOptions(signed: true, decimal: false),
                      controller: _idController,
                      decoration: InputDecoration(labelText: "Item Id"),
                    ),
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(labelText: "Item Name"),
                    ),
                    FutureBuilder<List<ItemCategory>>(
                      future: BlocProvider.of<ItemCategoryBloc>(context)
                          .getAllItemCategory(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          print(snapshot.data);
                          return DropdownButton<ItemCategory>(
                            isExpanded: true,
                            value: _cat,
                            items: snapshot.data.map((ItemCategory itmCat) {
                              return new DropdownMenuItem<ItemCategory>(
                                value: itmCat,
                                child: Container(
                                  width: double.maxFinite,
                                  padding: EdgeInsets.all(8.0),
                                  margin: EdgeInsets.all(5.0),
                                  child: Text(itmCat.name),
                                  decoration: BoxDecoration(
                                    color: Color(itmCat.color).withAlpha(180),
                                    borderRadius: BorderRadius.circular(5)
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (val) {
                              setState(() {
                                _cat = val;
                              });
                            },
                          );
                        }
                        return Container();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          TextField(
            controller: _descController,
            decoration: InputDecoration(labelText: "Item Description"),
          ),
        ],
      ),
    );
  }

  _buildModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: Wrap(
              children: [
                ListTile(
                  leading: Icon(Icons.photo_camera),
                  title: Text('Camera'),
                  onTap: () async {
                    await getImage(ImageSource.camera);
                    Navigator.pop(bc);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.filter),
                  title: Text('Gallery'),
                  onTap: () async {
                    await getImage(ImageSource.gallery);
                    Navigator.pop(bc);
                  },
                )
              ],
            ),
          );
        });
  }
}
