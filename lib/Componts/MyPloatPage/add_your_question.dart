import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../Api/add_your_question.dart';
import '../../utils/Colors.dart';
import '../../utils/util.dart';

class AddYourQuestion extends StatefulWidget {
  const AddYourQuestion({Key? key, this.userID, this.cropId, this.plotId}) : super(key: key);
  final userID;
  final cropId;
  final plotId;

  @override
  State<AddYourQuestion> createState() => _AddYourQuestionState();
}

class _AddYourQuestionState extends State<AddYourQuestion> {
  TextEditingController questtionansController = TextEditingController();
  dynamic imageData = "";
  final _addQutionsShop = GlobalKey<FormState>();
  File? image;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(80.0),
            child: Container(
                child: AppBar(
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                  ),
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Util.newHomeColor, Util.endColor]),
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25.0),
                  bottomRight: Radius.circular(25.0),
                ),
              ),
              elevation: 0,
              backgroundColor: Colors.green,
              leading: Builder(
                builder: (context) => IconButton(
                  icon: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: kWhite,
                    ),
                  ),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  tooltip:
                      MaterialLocalizations.of(context).openAppDrawerTooltip,
                ),
              ),
              title: Text(
                'Add your Question ',
                style: TextStyle(
                    color: kWhite, fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ))),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Form(
            key: _addQutionsShop,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Enter Question :",
                        style: TextStyle(
                            color: kblack,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        controller: questtionansController,
                        maxLines: 5,
                        onChanged: (value) {},

                        /// keyboardType: TextInputType.number,

                        // maxLength: 10,
                        // controller: _mobile,
                        decoration: InputDecoration(
                          //   errorText: _mobileValidated ? null : _mobileError,
                          //  suffixIcon: Icon(Icons.call),
                          hintText: 'Enter Question',
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
                            return "Please enter question";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        "Select Image :",
                        style: TextStyle(
                            color: kblack,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
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
                Spacer(),
                InkWell(
                  onTap: () {
                    print("hello${widget.userID} ");
                    if (_addQutionsShop.currentState!.validate()) {
                      Navigator.pop(context);
                      AddQuestion.userRegistration(
                        widget.userID.toString(),widget.plotId.toString(),
                          questtionansController.text, imageData.toString());
                    } else {}
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.green,
                    ),
                    child: Center(
                        child: Text(
                      "Submit",
                      style: TextStyle(
                          color: kWhite,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    )),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
