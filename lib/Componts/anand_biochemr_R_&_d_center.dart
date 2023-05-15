import 'dart:convert';

import 'package:dr_crop_guru/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../utils/util.dart';
import 'add_anand_bichem_r_d_center.dart';

class AnandBiochemRandDCenter extends StatefulWidget {
  const AnandBiochemRandDCenter({Key? key}) : super(key: key);

  @override
  State<AnandBiochemRandDCenter> createState() =>
      _AnandBiochemRandDCenterState();
}

class _AnandBiochemRandDCenterState extends State<AnandBiochemRandDCenter>with TickerProviderStateMixin {
  late Map mapresponse;
  List? listresponse;
  late Map labmapresponse;
  List? lablistresponse;

  late AnimationController _controller;

  var jsonResponse;

  bool isLoaded = false;

  Future rdcenter() async {
    http.Response response;
    response = await http.post(
        Uri.parse('http://mycropguruapiwow.cropguru.in/api/Get_Data'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(<String, String>{
          "START": '0',
          "END": "10000",
          "WORD": "NONE",
          "GET_DATA": "Get_TestingTypeList",
          "ID1": "",
          "ID2": "",
          "ID3": "",
          "STATUS": "",
          "START_DATE": "",
          "END_DATE": "",
          "EXTRA1": "",
          "EXTRA2": "",
          "EXTRA3": "",
          "LANG_ID": "3"
        }));
    jsonResponse = json.decode(response.body);
    print(jsonResponse["ResponseMessage"]);
    if (response.statusCode == 200) {
      print(response.body);
      mapresponse = json.decode(response.body);
      listresponse = mapresponse["DATA"];
      isLoaded = true;
    }
  }

  Future lab() async {
    http.Response response;
    response = await http.post(
        Uri.parse('http://mycropguruapiwow.cropguru.in/api/Get_Data'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(<String, String>{
          "START": "0",
          "END": "500000000",
          "WORD": "NONE",
          "GET_DATA": "Get_LabEnquiriesByUserId",
          "ID1": "60640",
          "ID2": "",
          "ID3": "",
          "STATUS": "",
          "START_DATE": "",
          "END_DATE": "",
          "EXTRA1": "",
          "EXTRA2": "",
          "EXTRA3": "",
          "LANG_ID": "3"
        }));
    jsonResponse = json.decode(response.body);
    print(jsonResponse["ResponseMessage"]);
    if (response.statusCode == 200) {
      print(response.body);
      labmapresponse = json.decode(response.body);
      lablistresponse = labmapresponse["DATA"];
      isLoaded = true;
    }
  }

  // unit Count api
  @override
  void initState() {
    rdcenter();
    lab();
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
    rdcenter().then((value) {
      _controller.reset();
      Navigator.pop(context);
      setState(() {});
      return value;
    });
    lab().then((value) {
      _controller.reset();
      setState(() {});
      return value;
    });

    // TODO: implement initState
    super.initState();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 220,
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
                  height: 60,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //Icon(Icons.arrow_back,size: 30,color: kWhite),
                      Text(
                        "Anand Biochem R & D Center",
                        style: TextStyle(
                            color: kWhite,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: SizedBox(
                    height: 100,
                    child: Visibility(
                      visible: isLoaded,
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Column(
                              children: [
                                InkWell(

                                  child: CircleAvatar(
                                    backgroundColor: kWhite,
                                    radius: 30,
                                    child: CircleAvatar(
                                      radius: 30,
                                      child: Container(
                                        height: 100,
                                        width: 100,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            // color: kblack,
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    listresponse![index]
                                                            ["TESTING_IMG"]
                                                        .toString()),
                                                fit: BoxFit.cover)),
                                      ),
                                    ),
                                  ),
                                   onTap: (){
                                    Get.to(AddAnandBichemRDCenter(category:listresponse![index]["TESTING_TYPE_NAME"] ,amount:listresponse![index]["AMOUNT"] ,imageurl:listresponse![index]["TESTING_IMG"],videourl:listresponse![index]["VIDEO_URL"]));
                                   },
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  listresponse![index]["TESTING_TYPE_NAME"]
                                      .toString(),
                                  style: TextStyle(
                                      color: kWhite,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          );
                        },
                        itemCount:
                            listresponse == null ? 0 : listresponse!.length,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 5,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 0),
            child: Text(
              "My Lab Enquiriess",
              style: TextStyle(
                color: kblack,
                fontSize: 16,
              ),
            ),
          ),
          SizedBox(height: 5,),
          Expanded(
            child: Container(
             margin:EdgeInsets.symmetric(horizontal: 0,vertical: 0),
              height: 500,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Visibility(
                      visible: isLoaded,
                      child: ListView.builder(
                        padding:EdgeInsets.symmetric(horizontal: 0,vertical: 0),

                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12,vertical: 5),
                          child: Material(
                            elevation: 5,
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              height: 160,
                              decoration: BoxDecoration(
                                  color: kWhite,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "Enquriy Id",
                                              style: TextStyle(
                                                color: kgrey,
                                                fontSize: 16,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              lablistresponse![index]["ENQUIRY_ID"].toString(),
                                              style: TextStyle(
                                                color: kblack,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Amount    ",
                                              style: TextStyle(
                                                color: kgrey,
                                                fontSize: 16,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              "₹ ${  lablistresponse![index]["AMOUNT"].toString()}",
                                              style: TextStyle(
                                                  color: kgreen,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Category- ",
                                              style: TextStyle(
                                                color: kgrey,
                                                fontSize: 16,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              lablistresponse![index]["TESTING_CATEGORY"].toString(),
                                              style: TextStyle(
                                                  color: kblack,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Remark ",
                                                style: TextStyle(
                                                    color: kblack,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              lablistresponse![index]["REMARK"].toString(),
                                              style: TextStyle(
                                                color: kgreyy,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "Admin Remark ",
                                              style: TextStyle(
                                                  color: kblack,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                        lablistresponse![index]["ADMIN_REMARK"]== " "?  lablistresponse![index]["ADMIN_REMARK"].toString(): "-",
                                              style: TextStyle(
                                                  color: kblack,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                          alignment: Alignment.center,
                                          height: 30,
                                          width: 65,
                                          decoration: BoxDecoration(
                                            color: kgreen,
                                            borderRadius: BorderRadius.circular(15),
                                          ),
                                          child: Text(
                                            lablistresponse![index]["STATUS"].toString(),
                                            style: TextStyle(
                                                color: kWhite,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Spacer(),
                                        Text(
                                          lablistresponse![index]["REG_DATE"].toString(),
                                          style: TextStyle(
                                              color: kblack,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },itemCount:  lablistresponse == null ? 0 : lablistresponse!.length,
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
