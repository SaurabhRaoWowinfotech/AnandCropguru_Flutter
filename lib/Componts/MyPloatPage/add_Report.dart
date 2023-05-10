import 'dart:convert';
import 'dart:io';

import 'package:dr_crop_guru/test.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';


import '../../Api/report_master_api.dart';
import '../../utils/Colors.dart';
import '../../utils/util.dart';
import 'faq.dart';
class Add_Report extends StatefulWidget {
   Add_Report({Key? key}) : super(key: key);

  @override
  State<Add_Report> createState() => _Add_ReportState();
}

class _Add_ReportState extends State<Add_Report>with TickerProviderStateMixin {
   List<String> items = <String>['Select Report Type','Leaf', 'Soil', 'Water','Other'];

   String dropdownvalue = 'Select Report Type';
   late AnimationController _controller;
   final _addreport = GlobalKey<FormState>();
   dynamic imageData = "";
   TextEditingController description_Controller = TextEditingController();
   File? image;
   Future PickImageImag(ImageSource source) async {
     try {
       final image = await ImagePicker().pickImage(source: source);
       if (image == null) return;
       final imageTemporary = File(image.path);
       imageData = base64Encode(imageTemporary.readAsBytesSync());
       print(imageData);
       setState(() {});
       this.image = imageTemporary;
     } on PlatformException catch (e) {
       print('Failed to pick image $e');
     }
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    Scaffold.of(context). openDrawer();
                  },
                  tooltip:
                  MaterialLocalizations.of(context).openAppDrawerTooltip,
                ),
              ),
              title: InkWell(
                onTap: () {},
                child: Text(
                  'Report Master',
                  style: TextStyle(
                      color: kWhite,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Form(
                  key: _addreport,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 14,),
                      Text(
                        'Select Report Type :',
                        style: TextStyle(
                            color: kblack,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                  SizedBox(height: 12,),
                  Container(
                    decoration: BoxDecoration(
                      //color: kblack,
                      border: Border.all(color: kblack),
                      borderRadius: BorderRadius.circular(5)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: DropdownButtonHideUnderline(

                      child: DropdownButton<String>(
                        hint: Text("Select Report Type"),
                        isExpanded: true,
                        iconSize: 34,
                        value: dropdownvalue,
                        items: items
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                            value: value, child: Text(value));
                      }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownvalue = newValue ?? '';
                          });
                        },
                      ),
    ),
                    ),
                  ),
                      SizedBox(height: 15,),
                      Text(
                        'Description',
                        style: TextStyle(
                            color: kblack,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8,),
                      TextFormField(
                       controller: description_Controller,
                        maxLines: 5,
                        onChanged: (value) {},
                        decoration: InputDecoration(
                          hintText: 'Description',
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
                            return "Description can not be empty";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15,),
                      Text(
                        "Select Image :",
                        style: TextStyle(
                            color: kblack,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 13,),
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
          InkWell(
            onTap: (){
              if(dropdownvalue == 'Select Report Type' ){
                Fluttertoast.showToast(
                  msg: "Please select report type",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: kblack,
                  textColor: kWhite,
                  fontSize: 13.0,


                );
              }
              else{
                if (_addreport.currentState!.validate()) {
                  if(imageData != ''){
                    _controller = AnimationController(
                      duration: const Duration(
                          milliseconds: 3000),
                      vsync: this,
                    );
                    _controller.addListener(() {
                      if (_controller.isCompleted) {
                        _controller.reset();
                        _controller.forward();
                      }
                    });
                    WidgetsBinding.instance
                        .addPostFrameCallback(
                            (timeStamp) {
                          Util.animatedProgressDialog(
                              context, _controller);
                          _controller.forward();
                        });
                    ReportMasterApi.reportMasterApi(dropdownvalue,description_Controller.text,imageData).then((value) { 
                      _controller.reset();
                       Navigator.pop(context);
                      setState(() {});
                       return value;
                     });

                  }else{
                    Fluttertoast.showToast(
                      msg: "Please select report image",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: kblack,
                      textColor: kWhite,
                      fontSize: 13.0,


                    );
                  }


                } else {

                }


              }

            },
            child: Container(
              alignment: Alignment.center,
              height: 50,
              color: kgreen,
              child:  Text(
                "Submit",
                style: TextStyle(
                    color: kWhite,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),

            ),
          )

        ],
      ),
    );
  }
}
