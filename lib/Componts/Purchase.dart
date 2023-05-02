import 'package:dr_crop_guru/utils/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/util.dart';

class Purchase extends StatelessWidget {
  Purchase({Key? key}) : super(key: key);
  double size = 14;
  double Fromsize = 15;

  @override
  Widget build(BuildContext context) {
    return
  SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
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
                                height:
                                    MediaQuery.of(context).size.height - 500,
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
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                              Center(
                                                  child: Text(
                                                "Product Details",
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
                                      name: "hhh",
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
                                      name: "Plant Growth Promoters",
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
                                            padding: const EdgeInsets.only(
                                                right: 120),
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
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 5),
                                                  child: Text(
                                                    "name",
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
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 5),
                                                  child: Text(
                                                    "name",
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
                                            padding: const EdgeInsets.only(
                                                right: 100),
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
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 5),
                                                  child: Text(
                                                    "name",
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
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 5),
                                                  child: Text(
                                                    "name",
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
                                          borderRadius:
                                              BorderRadius.circular(5),
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
                                                  "06/04/2023",
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
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Container(
                                        height: 150,
                                        decoration: BoxDecoration(
                                          color: kblack,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Center(
                                          child: Icon(
                                            Icons.camera_alt_sharp,
                                            color: lgreen,
                                            size: 30,
                                          ),
                                        ),
                                      ),
                                    ),
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
                                                "hhh",
                                                style: TextStyle(
                                                    color: kblack,
                                                    fontSize: 15),
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
                  height: 130,
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
                                  style:
                                      TextStyle(color: kgrey, fontSize: size),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "hhh",
                                  style:
                                      TextStyle(color: kblack, fontSize: size),
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
                                    "25",
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
                                    "ml",
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
                                    "96",
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
                              "2.40 Liter ",
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
                                  style:
                                      TextStyle(color: kblack, fontSize: size),
                                ),
                                Text(
                                  "ghh",
                                  style:
                                      TextStyle(color: kgrey, fontSize: size),
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
            )
          ],
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
