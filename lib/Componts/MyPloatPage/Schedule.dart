import 'dart:convert';

import 'package:dr_crop_guru/Componts/MyPloatPage/schedule_1_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../Api/Schedule_api.dart';
import '../../utils/Colors.dart';
import '../../utils/util.dart';
import 'new_schedule(spray).dart';
import 'old_schedule_ferilizer.dart';

class Schedule extends StatefulWidget {
  Schedule({Key? key, this.userId, this.cropId, this.plotId}) : super(key: key);
  final userId;
  final cropId;
  final plotId;

  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> with TickerProviderStateMixin {
  String typename = "Spray";
  bool visibility = true;
  bool visibility1 = false;
  bool visibility2 = false;
  String? msg;
  late Map mapresponse;
  List? listresponse;
  var jsonResponse;
  late AnimationController _controller;
  bool isLoaded = false;

  Future schedule(typename) async {
    http.Response response;
    response = await http.post(
        Uri.parse(
            'http://mycropguruapiwow.cropguru.in/api/Schedule?AGRONOMIST_ID=60640'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(<String, dynamic>{
          "START": "0",
          "END": "100000",
          "WORD": "Current Schedule",
          "LANG_ID": "3",
          "CROP_ID": 3,
          "PLOT_ID": 69371,
          "ACCESS_CODE": "123456",
          "USER_ID": 60640,
          "TYPE": "SPRAY"
        }));
    jsonResponse = json.decode(response.body);
    print(jsonResponse["ResponseMessage"]);
    if (response.statusCode == 200) {
      print(response.body);
      msg = jsonResponse["ResponseMessage"].toString();

      mapresponse = json.decode(response.body);

      listresponse = mapresponse["DATA"];
      isLoaded = true;
    }
  }

  @override
  void initState() {
    Future.delayed(Duration(seconds: 0), () {
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
      schedule(
        typename,
      ).then((value) {
        _controller.reset();
        Navigator.pop(context);
        setState(() {});
        return value;
      });
      // Here you can write your code
    }); // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 150,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Util.newHomeColor, Util.endColor]),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30)),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Icon(
                        Icons.arrow_back,
                        color: kWhite,
                        size: 30,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      InkWell(
                          onTap: () {
                            schedule(
                              typename,
                            );
                          },
                          child: Text(
                            "Schedule",
                            style: TextStyle(
                                color: kWhite,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ))
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        child: Container(
                            height: 43,
                            width: 90,
                            decoration: BoxDecoration(
                                color: visibility == true ? kgreen : kWhite,
                                borderRadius: BorderRadius.circular(22)),
                            child: Center(
                                child: Text("SPRAY",
                                    style: TextStyle(
                                        color: visibility == true
                                            ? kWhite
                                            : kgreen,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)))),
                        onTap: () {
                          setState(() {
                            visibility = true;
                            visibility1 = false;
                            visibility2 = false;
                            print(visibility);
                            typename = "Spray";
                            Future.delayed(Duration(seconds: 0), () {
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
                              schedule(
                                typename,
                              ).then((value) {
                                _controller.reset();
                                Navigator.pop(context);
                                setState(() {});
                                return value;
                              });
                              // Here you can write your code
                            }); // TODO: implement initState
                            print(typename);
                          });
                        },
                      ),
                      InkWell(
                        child: Container(
                            height: 43,
                            width: 90,
                            decoration: BoxDecoration(
                                color: visibility1 == true ? kgreen : kWhite,
                                borderRadius: BorderRadius.circular(22)),
                            child: Center(
                                child: Text("FERTILIZER",
                                    style: TextStyle(
                                        color: visibility1 == true
                                            ? kWhite
                                            : kgreen,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)))),
                        onTap: () {
                          setState(() {
                            typename = "Cultivation";
                            Future.delayed(Duration(seconds: 0), () {
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
                              schedule(
                                typename,
                              ).then((value) {
                                _controller.reset();
                                Navigator.pop(context);
                                setState(() {});
                                return value;
                              });
                              // Here you can write your code
                            }); // TODO: implement initState
                            visibility1 = true;
                            visibility = false;
                            visibility2 = false;

// Here you can write your code
                          });
                        },
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            typename = "Fertilizer";
                            Future.delayed(Duration(seconds: 0), () {
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
                              schedule(
                                typename,
                              ).then((value) {
                                _controller.reset();
                                Navigator.pop(context);
                                setState(() {});
                                return value;
                              });
                              // Here you can write your code
                            }); // TODO: implement initState
                            visibility2 = true;
                            visibility1 = false;
                            visibility = false;
                          });
                        },
                        child: Container(
                            height: 43,
                            width: 90,
                            decoration: BoxDecoration(
                                color: visibility2 == true ? kgreen : kWhite,
                                borderRadius: BorderRadius.circular(22)),
                            child: Center(
                                child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text("CULTIVATION\n    WORKS",
                                  style: TextStyle(
                                      color:
                                          visibility2 == true ? kWhite : kgreen,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold)),
                            ))),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: InkWell(
              onTap: () {
                Get.to(OldSchedule());
              },
              child: Container(
                height: 40,
                color: Colors.orange,
                child: Center(
                  child: Text("View Previous Schedule",
                      style: TextStyle(
                          color: kWhite,
                          fontSize: 15,
                          fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          ),
          Container(
              margin: EdgeInsets.all(0.0),
              height: MediaQuery.of(context).size.height - 250,
              child: SingleChildScrollView(
                  child: listresponse == []
                      ? Visibility(
                          visible: isLoaded,
                          child: ListView.builder(
                            padding: EdgeInsets.all(0.0),
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 5),
                                child: InkWell(
                                  onTap: () {
                                    Get.to(Schedule1Details(
                                      daysplanning: listresponse![index]
                                              ["SCHEDULE_DAY"]
                                          .toString(),
                                      scheduleType: listresponse![index]
                                              ["SCHEDULE_DAY"]
                                          .toString(),
                                      titile: listresponse![index]["TITLE"]
                                          .toString(),
                                      image: listresponse![index]
                                              ["SCHEDULE_IMAGE"]
                                          .toString(),
                                      text: listresponse![index]["SCHEDULE"],
                                    ));
                                  },
                                  child: Container(
                                    margin: EdgeInsets.all(0.0),
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey,
                                            offset: const Offset(
                                              2.0,
                                              2.0,
                                            ),
                                            blurRadius: 2.0,
                                            spreadRadius: 0.0,
                                          ),
                                        ],
                                        color: kWhite,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5, vertical: 5),
                                          child: Container(
                                            height: 25,
                                            color: kgreen,
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                    listresponse![index]
                                                            ["SCHEDULE_DAY"]
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: kWhite,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          child: Row(
                                            children: [
                                              Text("Title:",
                                                  style: TextStyle(
                                                      color: kblack,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              Expanded(
                                                flex: 5,
                                                child: Text(
                                                    listresponse![index]
                                                            ["TITLE"]
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: kgreen,
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          child: Row(
                                            children: [
                                              Text("Schedule Type:",
                                                  style: TextStyle(
                                                      color: kblack,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              Text(
                                                  listresponse![index]
                                                          ["SCHEDULE_TYPE"]
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: kgreen,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Icon(
                                              Icons.arrow_right_alt_sharp,
                                              size: 28,
                                              color: Colors.orange,
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            itemCount:
                                listresponse == null ? 0 : listresponse!.length,
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 5),
                          child: Container(
                            alignment: Alignment.center,
                        
                            decoration: BoxDecoration(
                              border: Border.all(width: 1, color: kgreen),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child:msg == null? Text(""):Html(
                                data:msg.toString())
                          ),
                        ))),
          SizedBox(
            height: 10,
          ),
          listresponse == [] ?  Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: InkWell(
              onTap: () {
                Get.to(NewSchedule());
              },
              child: Container(
                height: 40,
                color: Colors.orange,
                child: Center(
                  child: Text("View Next Schedule",
                      style: TextStyle(
                          color: kWhite,
                          fontSize: 15,
                          fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          ):Text("")
        ],
      ),
    );
  }
}
