import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../Api/emergencyCall_api.dart';
import '../utils/Colors.dart';
import '../utils/util.dart';
import 'Emergency_call_detail.dart';

class EmergencyCall extends StatefulWidget {
  const EmergencyCall({Key? key}) : super(key: key);

  @override
  State<EmergencyCall> createState() => _EmergencyCallState();

}

class _EmergencyCallState extends State<EmergencyCall>
    with TickerProviderStateMixin {


  _MyFromState(){
    _selectedvalue = varietylistresponse![0];
    _value3 =varietylistresponse![0];

  }
  String? _selectedvalue = "";
  late Map mapresponse;
  List? listresponse;
  late Map varietymapresponse;
  List? varietylistresponse;
  bool isLoaded = false;
  int? _value3;
  String cropNameGlobal = '';
  String cropId = '';
  var jsonResponse;
  dynamic massage;
  String? cropName;
  String url = "";
  String data = " ";
  late AnimationController _controller;
  _callNumber() async {
    //  const number = widget.mobileNumber; //set the number here
    bool? res = await FlutterPhoneDirectCaller.callNumber("9403415664");
  }

  Future emergencycall() async {
    http.Response response;
    response = await http.post(
        Uri.parse(
            'http://mycropguruapiwow.cropguru.in/api/EmergencyCall?AGRONOMIST_ID=60640'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(<String, dynamic>{
          "START": 0,
          "END": 5000,
          "WORD": "NONE",
          "USER_ID": "60640",
          "LANG_ID": "1",
          "CROP_ID": "1",
          "ACCESS_TOKEN": "1",
          "PLOT_ID": "1",
          "TYPE": "User"
        }));
    jsonResponse = json.decode(response.body);
    print(jsonResponse["ResponseMessage"]);
    if (response.statusCode == 200) {
      print(response.body);

      mapresponse = json.decode(response.body);
      massage = jsonResponse["ResponseMessage"];
      listresponse = mapresponse["DATA"];
      data = listresponse.toString();
      isLoaded = true;
    }
  }

  Future varietylist() async {
    http.Response response;
    response = await http.post(
        Uri.parse(
            'http://mycropguruapiwow.cropguru.in/api/CropMaster'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(<String, dynamic>{
          "START": 0,
          "END": 10000,
          "WORD": "NONE",
          "LANG_ID": 3,
          "USER_ID": 60640,
          "ACCESS_TOKEN": "123456"
        }));
    jsonResponse = json.decode(response.body);
    print(response.body);
    print(jsonResponse["ResponseMessage"]);
    if (response.statusCode == 200) {


      varietymapresponse = json.decode(response.body);
      massage = jsonResponse["ResponseMessage"];
      varietylistresponse = varietymapresponse["DATA"];
      data = listresponse.toString();
      isLoaded = true;
    }
  }

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );
    _controller.addListener(() {
      if (_controller.isCompleted) {
        _controller.reset();
        _controller.forward();
      }

    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Util.animatedProgressDialog(context, _controller);
      _controller.forward();
    });
    emergencycall().then((value) {
      _controller.reset();
      Navigator.pop(context);
      setState(() {});
      return value;
    });
    varietylist();
    // TODO: implement initState
    super.initState();
  }

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
                          "Emergency Call ",
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
                  child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Image.asset(
                            "assets/images/phone-call.png",
                            height: 50,
                            color: kgreen,
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Text(
                            "Connect Agronomist Call",
                            style: TextStyle(
                                color: kgreen,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Visibility(
                      visible: isLoaded,
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 0),
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Material(
                              elevation: 5,
                              borderRadius: BorderRadius.circular(8),
                              child: InkWell(
                                onTap: () {
                                  Get.to(EmergencyCallDetail(
                                    callcategory: listresponse![index]
                                        ["CALL_CAT"],
                                    calldate: listresponse![index]
                                        ["CALL_DATETIME"],
                                    remark: listresponse![index]["USER_REMARK"],
                                    callsolution: listresponse![index]
                                        ["CALL_SOLUTION"],
                                  ));
                                },
                                child: Container(
                                  height: 150,
                                  decoration: BoxDecoration(
                                      color: kWhite,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 25,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "Call Category",
                                                  style: TextStyle(
                                                    color: kblack,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  listresponse![index]
                                                      ["CALL_CAT"],
                                                  style: TextStyle(
                                                    color: kgreen,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 9,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "CALL DATE :",
                                                  style: TextStyle(
                                                    color: kblack,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  listresponse![index]["CALL_DATETIME"].toString(),
                                                  style: TextStyle(
                                                    color: kgreen,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 9,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "Remark :",
                                                  style: TextStyle(
                                                    color: kblack,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              listresponse![index]
                                                              ["USER_REMARK"].toString() ==
                                                      null
                                                  ? listresponse![index]
                                                          ["USER_REMARK"]
                                                      .toString()
                                                  : "-",
                                              style: TextStyle(
                                                color: kgreen,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Container(
                                              alignment: Alignment.center,
                                              height: 30,
                                              width: 55,
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                    colors: [
                                                      Util.newHomeColor,
                                                      Util.endColor
                                                    ]),
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.zero,
                                                  topRight:
                                                      Radius.circular(15.0),
                                                  bottomLeft: Radius.zero,
                                                  bottomRight: Radius.zero,
                                                ),
                                              ),
                                              child: Text(
                                                listresponse![index]["STATUS"]
                                                    .toString(),
                                                style: TextStyle(
                                                    color: kWhite,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Spacer(),
                                            Icon(
                                              Icons.arrow_right_alt_sharp,
                                              size: 30,
                                              color: Colors.redAccent,
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount:
                            listresponse == null ? 0 : listresponse!.length,
                      ),
                    )
                  ],
                ),
              )),
            )
          ],
        ),
        floatingActionButton: Container(
          height: 70.0,
          width: 90.0,
          child: FittedBox(
            child: FloatingActionButton(
                backgroundColor: Colors.orange,
                child: Expanded(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Image.asset(
                    "assets/images/emcall.png",
                    height: 30,
                    color: kWhite,
                  ),
                )),
                onPressed: () {
                  showDialog(
                      barrierDismissible: true,
                      context: context,
                      builder: (context) {
                        return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                      height: 230,
                                      width: MediaQuery.of(context).size.width,

                                      child: Material(
                                          borderRadius: BorderRadius.circular(25),
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                            Container(
                                              height: 40,

                                              decoration: BoxDecoration(
                                                color: kgreen,
                                                borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(25),
                                                  topLeft:  Radius.circular(25),
                                                ),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 12),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Center(
                                                        child: Text(
                                                      "",
                                                      style: TextStyle(
                                                          color: kWhite,
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )),
                                                    Center(
                                                        child: Text(
                                                      "Emergency Call",
                                                      style: TextStyle(
                                                          color: kWhite,
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )),
                                                    Align(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: Material(
                                                        color:
                                                            Colors.transparent,
                                                        child: InkWell(
                                                          onTap: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Icon(
                                                            Icons.cancel,
                                                            size: 25,
                                                            color: kWhite,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                                SizedBox(height: 35,),
                                                Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 12),
                                                  child: Text(
                                                    "Select crop variety",
                                                    style: TextStyle(
                                                        color:kgreen,
                                                        fontSize: 15,
                                                       ),
                                                  ),
                                                ),
                                                SizedBox(height: 10,),
                                                Padding(
                                                  padding: const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                                  child: productName(),
                                                ),
                                                SizedBox(height: 30,),

                                                Padding(
                                                  padding:  const EdgeInsets.symmetric(
                                                      horizontal: 30),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: InkWell(
                                                          onTap: (){
                                                            Navigator.pop(context);
                                                          },
                                                          child: Container(
                                                            height: 35,
                                                            alignment: Alignment.center,
                                                            decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(5),
                                                                border: Border.all(width: 1 , color: kblack)

                                                            ),
                                                            child:  Text(
                                                              "Cancel",
                                                              style: TextStyle(
                                                                color:kblack,
                                                                fontSize: 13,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 5,
                                                        color: kWhite,
                                                      ),
                                                      Expanded(
                                                        child: InkWell(
                                                          onTap: (){
                                                            if(cropNameGlobal == ''){

                                                              Fluttertoast.showToast(
                                                                msg: "Select Crop",
                                                                toastLength: Toast.LENGTH_SHORT,
                                                                gravity: ToastGravity.BOTTOM,
                                                                timeInSecForIosWeb: 1,
                                                                backgroundColor: kblack,
                                                                textColor: kWhite,
                                                                fontSize: 13.0,


                                                              );
                                                            }else{
                                                              _callNumber();
                                                              _controller = AnimationController(
                                                                duration: const Duration(milliseconds: 3000),
                                                                vsync: this,
                                                              );
                                                              _controller.addListener(() {
                                                                if (_controller.isCompleted) {
                                                                  _controller.reset();
                                                                  _controller.forward();
                                                                }

                                                              });
                                                              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                                                                Util.animatedProgressDialog(context, _controller);
                                                                _controller.forward();
                                                              });
                                                              EmergencyCallPostApi.emergencycall(60640,cropNameGlobal,cropId).then((value) {
                                                                _controller.reset();
                                                                Navigator.pop(context);
                                                                setState(() {});
                                                                return value;
                                                              });

                                                              Future.delayed(const Duration(milliseconds: 500), () {

// Here you can write your code

                                                                setState(() {
                                                                  emergencycall();
                                                                  Navigator.pop(context);
                                                                  // Here you can write your code for open new view
                                                                });

                                                              });


                                                            }


                                                          },
                                                          child: Container(
                                                            height: 35,
                                                            alignment: Alignment.center,
                                                            decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(5),
                                                              border: Border.all(width: 1 , color: kblack)

                                                            ),
                                                            child:  Text(
                                                              "Submit",
                                                              style: TextStyle(
                                                                color:kblack,
                                                                fontSize: 13,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(height: 10,),



                                          ])))
                                ]));
                      });
                  // Get.to(AddYourQuestion(userID: widget.userId,cropId: widget.cropID,plotId: widget.plotID,));
                }),
          ),
        ));
  }
  Widget productName() {
    // final cityapi = Provider.of<CityApiProvider>(context);


    return DropdownButtonHideUnderline(

      child: ButtonTheme(

          alignedDropdown: true,
          child: DropdownButtonFormField(

            decoration: InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            ),
            value: _value3,

            hint: Text(
              "Select Crop",
              style: TextStyle(fontSize: 12, color: kgreyy),
            ),
            isExpanded: true,

            items: varietylistresponse?.map((product) {


              return DropdownMenuItem(
onTap: (){
  cropNameGlobal= product["CROP_NAME"].toString();
  cropId= product["CROP_ID"].toString();
},
                child: Text(product["CROP_NAME"]),
                value: product,
              );
            }).toList(),
            onChanged: (value) {
              print(cropNameGlobal);
              print(cropId);
              setState(() {
                _value3 = value as int;
              });
              print("Selected list demo is  $_value3");
            },
            validator: (text) {
              if (!text.toString().isEmpty) {
                return "Please select Product";
              }
              return null;
            },
          )),
    );
  }
}
