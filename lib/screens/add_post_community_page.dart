
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../Api/add_post_community_api.dart';
import '../utils/Colors.dart';
import '../utils/util.dart';

class AddPostCommunity extends StatefulWidget {
  const AddPostCommunity({Key? key}) : super(key: key);

  @override
  State<AddPostCommunity> createState() => _AddPostCommunityState();
}

class _AddPostCommunityState extends State<AddPostCommunity> {
  File? image;
  dynamic imageData = "";
  Future PickImageImag(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imageTemporary = File(image.path);
      imageData = base64Encode(imageTemporary.readAsBytesSync());
      setState(() {});
      this.image = imageTemporary;
    } on PlatformException catch (e) {
      print('Failed to pick image $e');
    }
  }
  TextEditingController titleController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  List<String> items = <String>['Select Report Type','Dealership', 'Distributorship', 'FPO','Other'];

  String dropdownvalue = 'Select Report Type';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 110,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Util.newHomeColor, Util.endColor]),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 55,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 3,
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.arrow_back,
                              size: 30, color: kWhite)),
                      SizedBox(
                        width: 9,
                      ),
                      Text(
                        "Add Post",
                        style: TextStyle(
                            color: kWhite,
                            fontSize: 27,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: SingleChildScrollView(
                  child: Form(
                  //  key: anandcenter,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20,),



                        SizedBox(height: 10,),
                        Text(
                          "Title",
                          style: TextStyle(
                              color: kgreen,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          controller: titleController,
                          onChanged: (value) {},
                          style: TextStyle(fontSize: 13),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(5.0),
                            hintText: 'Shop Name / Company Name',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                //  color: Util.colorPrimary,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          validator: (text) {
                            if (text!.isEmpty) {
                              return "Shop Name / Company Name";
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: 10,),
                        Text(
                          "Address :",
                          style: TextStyle(
                              color: kgreen,
                              fontSize: 14,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(height: 10,),
                        TextFormField(
                         controller: addressController,
                          maxLines: 5,
                          onChanged: (value) {},
                          style: TextStyle(fontSize: 13),
                          decoration: InputDecoration(
                            hintText: 'Enter Address',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          validator: (text) {
                            if (text!.isEmpty) {
                              return "Address";
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: 10,),
                        Text(
                          "Photo :",
                          style: TextStyle(
                              color: kgreen,
                              fontSize: 14,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            showModalBottomSheet(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(40),
                                        topLeft: Radius.circular(40))),
                                context: context,
                                builder: (BuildContext mContext) {
                                  return Container(
                                    height: 140,
                                    child: Row(
                                      children: [
                                        InkWell(
                                          onTap: () =>
                                              PickImageImag(ImageSource.gallery),
                                          child: Image.asset(
                                            "assets/images/gallary.png",
                                            height: 90,
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () =>
                                              PickImageImag(ImageSource.camera),
                                          child: Image.asset(
                                            "assets/images/camera.png",
                                            height: 45,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                });
                          },
                          child: Container(
                            height: 200,
                            decoration: BoxDecoration(
                                border: Border.all(width: 1, color: kgrey),
                                borderRadius: BorderRadius.circular(5)),
                            child: Center(
                              child: image != null
                                  ? Image.file(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
                                image!,
                                fit: BoxFit.fitWidth,
                              )
                                  : Image.asset(
                                width: 40,
                                height: 40,
                                "assets/images/camera.png",
                                color: kgreen,
                              ),
                            ),
                          ),
                        ),



                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: (){
              AddPostCommunittyApi.addpostapi("62819",titleController.text,addressController.text,imageData.toString());
            },
            child: Container(
              alignment: Alignment.center,
              height: 50,
              color: kgreen,
              child: Text(
                "Submit",
                style: TextStyle(
                  color: kWhite,
                  fontSize: 18,

                ),
              ),
            ),
          ),
        ],
      ),
    );

  }
}
