import 'dart:convert';

import 'package:dr_crop_guru/utils/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../utils/util.dart';
import 'SelectCrop.dart';

class Purchase extends StatefulWidget {
  Purchase({Key? key}) : super(key: key);

  @override
  State<Purchase> createState() => _PurchaseState();
}

class _PurchaseState extends State<Purchase> with TickerProviderStateMixin {
  double size = 14;
  double Fromsize = 15;
  late Map mapresponse;
  List? listresponse;
  var jsonResponse;
  String? msg;
  String? data;

  late AnimationController _controller;
  bool isLoaded = false;

  Future agronomist_visits_api() async {
    http.Response response;
    response = await http.post(
        Uri.parse('http://mycropguruapiwow.cropguru.in/api/FarmerPurchase/1'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(<String, String>{
          "START": "1",
          "END": "1000",
          "WORD": "",
          "EXTRA1": "",
          "EXTRA2": "",
          "EXTRA3": "",
          "LANG_ID": "1",
          "USER_ID": "61012",
          "CAT_ID": ""
        }));
    jsonResponse = json.decode(response.body);
    print(jsonResponse["ResponseMessage"]);
    if (response.statusCode == 200) {
      mapresponse = json.decode(response.body);
      listresponse = mapresponse["DATA"];
      data = listresponse.toString();
      msg = jsonResponse["ResponseMessage"];
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
    agronomist_visits_api().then((value) {
      _controller.reset();
      Navigator.pop(context);
      setState(() {});
      return value;
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        // isExtended: true,
        child: Icon(Icons.add),
        backgroundColor: Colors.orange,
        onPressed: () {
          Get.to(SelecctCrop(),transition: Transition.cupertinoDialog ,duration: Duration(seconds: 1));

        },
      ),
     body:Visibility(
        visible: isLoaded,
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              child: InkWell(
                onTap: () {
                  showDialog<void>(
                    barrierDismissible: true,
                    context: context,
                    builder: (BuildContext context) {
                      return SingleChildScrollView(
                        child: new Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).orientation ==
                                              Orientation.portrait
                                          ? 15
                                          : 100,
                                  vertical: 15),
                              child: new Container(
                                decoration: BoxDecoration(
                                    color: kWhite,
                                    borderRadius: BorderRadius.circular(5)),
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height - 240,
                                child: new Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                        width: double.infinity,
                                        color: pgreen,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            // crossAxisAlignment: CrossAxisAlignment.center,

                                            children: [
                                              Center(
                                                  child: Text(
                                                "",
                                                style: TextStyle(
                                                    color: kWhite,
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold),
                                              )),
                                              Center(
                                                  child: Text(
                                                "Product Details",
                                                style: TextStyle(
                                                    color: kWhite,
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold),
                                              )),
                                              Align(
                                                alignment: Alignment.centerRight,
                                                child: Material(
                                                  color: Colors.transparent,
                                                  child: InkWell(
                                                    onTap: () {
                                                      Navigator.pop(context);
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
                                        )),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Text(
                                        "Product Name",
                                        style: TextStyle(
                                            color: kblack, fontSize: Fromsize),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    TextfildForms(
                                      name: listresponse![index]["PRODUCT_NAME"]
                                          .toString(),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Text(
                                        "Category Name",
                                        style: TextStyle(
                                            color: kblack, fontSize: Fromsize),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    TextfildForms(
                                      name: listresponse![index]["CAT_NAME"]
                                          .toString(),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            "Paking",
                                            style: TextStyle(
                                                color: kblack,
                                                fontSize: Fromsize),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(right: 120),
                                            child: Text(
                                              "Unit",
                                              style: TextStyle(
                                                  color: kblack,
                                                  fontSize: Fromsize),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            height: 35,
                                            width: 150,
                                            decoration: BoxDecoration(
                                              color: pgrey,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                          horizontal: 5),
                                                  child: Text(
                                                    listresponse![index]["SIZE"]
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: kblack,
                                                        fontSize: 15),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: 35,
                                            width: 150,
                                            decoration: BoxDecoration(
                                              color: pgrey,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                          horizontal: 5),
                                                  child: Text(
                                                    listresponse![index]
                                                            ["UNIT_NAME"]
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: kblack,
                                                        fontSize: 15),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            "Price(Rs)",
                                            style: TextStyle(
                                                color: kblack,
                                                fontSize: Fromsize),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(right: 100),
                                            child: Text(
                                              "Quantity",
                                              style: TextStyle(
                                                  color: kblack,
                                                  fontSize: Fromsize),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            height: 35,
                                            width: 150,
                                            decoration: BoxDecoration(
                                              color: pgrey,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                          horizontal: 5),
                                                  child: Text(
                                                    listresponse![index]["PRICE"]
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: kblack,
                                                        fontSize: 15),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: 35,
                                            width: 150,
                                            decoration: BoxDecoration(
                                              color: pgrey,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                          horizontal: 5),
                                                  child: Text(
                                                    listresponse![index]
                                                            ["QUANTITY"]
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: kblack,
                                                        fontSize: 15),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Text(
                                        "Purchase Date",
                                        style: TextStyle(
                                            color: kblack, fontSize: Fromsize),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Container(
                                        height: 35,
                                        decoration: BoxDecoration(
                                          color: pgrey,
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 5),
                                                child: Text(
                                                  listresponse![index]["PURCHASE_DATE "].toString(),
                                                  style: TextStyle(
                                                      color: kblack,
                                                      fontSize: 15),
                                                ),
                                              ),
                                              Icon(
                                                Icons.calendar_month,
                                                color: Util.newHomeColor,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    // Padding(
                                    //   padding: const EdgeInsets.symmetric(
                                    //       horizontal: 10),
                                    //   child: Text(
                                    //     "Product Name",
                                    //     style: TextStyle(
                                    //         color: kblack, fontSize: Fromsize),
                                    //   ),
                                    // ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    // Padding(
                                    //   padding: const EdgeInsets.symmetric(
                                    //       horizontal: 10),
                                    //   child: Container(
                                    //     height: 150,
                                    //     decoration: BoxDecoration(
                                    //       color: kblack,
                                    //       borderRadius: BorderRadius.circular(5),
                                    //     ),
                                    //     child: Center(
                                    //       child: Icon(
                                    //         Icons.camera_alt_sharp,
                                    //         color: lgreen,
                                    //         size: 30,
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Text(
                                        "Remark",
                                        style: TextStyle(
                                            color: kblack, fontSize: Fromsize),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Container(
                                        height: 60,
                                        decoration: BoxDecoration(
                                          color: pgrey,
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 5),
                                              child: Text(
                                                listresponse![index]["REMARK "] ==
                                                        null
                                                    ? ""
                                                    : listresponse![index]
                                                            ["REMARK "]
                                                        .toString(),
                                                style: TextStyle(
                                                    color: kblack, fontSize: 15),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          // offset: const Offset(3.0, 3.0),
                          blurRadius: 1.0,
                          spreadRadius: 0.0,
                          color: kgrey),
                    ],
                    color: kWhite,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Product Name -",
                                  style: TextStyle(color: kgrey, fontSize: size),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  listresponse![index]["PRODUCT_NAME"],
                                  style: TextStyle(color: kblack, fontSize: size),
                                ),
                              ],
                            ),
                            Icon(
                              Icons.arrow_right_alt_rounded,
                              size: 30,
                              color: kgreen,
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 25),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Packing -",
                                    style:
                                        TextStyle(color: kgrey, fontSize: size),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    listresponse![index]["SIZE"].toString(),
                                    style:
                                        TextStyle(color: kgrey, fontSize: size),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Unit -",
                                    style:
                                        TextStyle(color: kgrey, fontSize: size),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    listresponse![index]["UNIT_NAME"],
                                    style:
                                        TextStyle(color: kgrey, fontSize: size),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Quantity -",
                                    style:
                                        TextStyle(color: kgrey, fontSize: size),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    listresponse![index]["QUANTITY"].toString(),
                                    style:
                                        TextStyle(color: kgrey, fontSize: size),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Row(
                          children: [
                            Text(
                              "Price(Rs) -",
                              style: TextStyle(color: kblack, fontSize: size),
                            ),
                            Text(
                              "5555.0 x 96.0 ",
                              style: TextStyle(color: kblack, fontSize: size),
                            ),
                            Text(
                              "Total ₹",
                              style: TextStyle(color: kblack, fontSize: size),
                            ),
                            Text(
                              ".553358.00",
                              style: TextStyle(color: kblack, fontSize: size),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text(
                              "Available Stock - ",
                              style: TextStyle(color: kgreen, fontSize: size),
                            ),
                            Text(
                              listresponse![index]["AVL_STOCK"].toString(),
                              style: TextStyle(color: kgreen, fontSize: size),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Remark - ",
                                  style: TextStyle(color: kblack, fontSize: size),
                                ),
                                Text(
                                  listresponse![index]["REMARK"] == null
                                      ? ""
                                      : listresponse![index]["REMARK"].toString(),
                                  style: TextStyle(color: kgrey, fontSize: size),
                                ),
                              ],
                            ),
                            CircleAvatar(
                              radius: 12,
                              backgroundColor: Util.newHomeColor,
                              child: Center(
                                child: Icon(
                                  Icons.add,
                                  color: kWhite,
                                  size: 17,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
          itemCount: listresponse == null ? 0 : listresponse!.length,
        ),
      ),
    );
  }
}

class TextfildForms extends StatelessWidget {
  TextfildForms({Key? key, this.name}) : super(key: key);
  final name;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        height: 35,
        decoration: BoxDecoration(
          color: pgrey,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                name,
                style: TextStyle(color: kblack, fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
