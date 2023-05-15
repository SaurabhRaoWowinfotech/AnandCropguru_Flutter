import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../../utils/Colors.dart';
import '../../utils/util.dart';
import 'package:http/http.dart' as http;

import '../Purchase.dart';

class AddPurchases extends StatefulWidget {
  AddPurchases({Key? key}) : super(key: key);

  @override
  State<AddPurchases> createState() => _AddPurchasesState();
}

class _AddPurchasesState extends State<AddPurchases> {
  int? _value2;
  int? _value3;
  int? _value5;
  double size = 14;
  double Fromsize = 15;

  //category api
  late Map catmapresponse;
  List? catlistresponse;

  //product api
  late Map productmapresponse;
  List? productlistresponse;

  //unit api
  late Map unitmapresponse;
  List? unitlistresponse;

  final timedate_Controller = TextEditingController();
  var jsonResponse;
  DateTime? dateTiming;
  File? image;
  var addProduct_Controller = TextEditingController();

  DateTime _dateTime = DateTime.now();
  String? salectedDatebackundDevloper;
  dynamic imageData = "";
  final _addProduct = GlobalKey<FormState>();

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

  void datetiming() async {
    dateTiming = await showDatePicker(
        context: context,
        initialDate: _dateTime,
        // firstDate: DateTime(2023),
        lastDate: DateTime.now(),
        firstDate: DateTime(2002));
    if (dateTiming == null) {
      return;
    } else {
      setState(() {
        _dateTime = dateTiming!;
        salectedDatebackundDevloper =
        "${_dateTime.day}/${_dateTime.month}/${_dateTime.year}";
        timedate_Controller.text = salectedDatebackundDevloper.toString();
        print("Date $salectedDatebackundDevloper");
      });
    }
  }

  bool isLoaded = false;

  Future categoryname() async {
    isLoaded = true;
    http.Response response;
    response = await http.post(
        Uri.parse('http://mycropguruapiwow.cropguru.in/api/PurchaseCategory/1'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(<String, String>{
          "START": "1",
          "END": "1000",
          "WORD": "",
          "EXTRA1": "",
          "EXTRA2": "",
          "EXTRA3": "",
          "LANG_ID": "1",
          "USER_ID": "60640"
        }));
    jsonResponse = json.decode(response.body);
    print(jsonResponse["ResponseMessage"]);
    if (response.statusCode == 200) {
      print(response.body);

      catmapresponse = json.decode(response.body);
      catlistresponse = catmapresponse["DATA"];
      isLoaded = true;
    }
  }

  Future unitapi() async {
    isLoaded = true;
    http.Response response;
    response = await http.post(
        Uri.parse(
            'http://mycropguruapiwow.cropguru.in/api/Get_DataPlotPurchase'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(<String, String>{
          "START": "1",
          "END": "1000",
          "WORD": "",
          "GET_DATA": "Get_ExpencesUnitMasterList",
          "ID1": "17",
          "ID2": "21013",
          "ID3": "",
          "STATUS": "",
          "START_DATE": "",
          "END_DATE": "",
          "EXTRA1": "",
          "EXTRA2": "",
          "EXTRA3": "",
          "LANG_ID": "1"
        }));
    jsonResponse = json.decode(response.body);
    print(jsonResponse["ResponseMessage"]);
    if (response.statusCode == 200) {
      print(response.body);

      unitmapresponse = json.decode(response.body);
      unitlistresponse = unitmapresponse["DATA"];
      isLoaded = true;
    }
  }

  Future productname() async {
    Map<String, dynamic> data = {
      "START": "1",
      "END": "1000",
      "WORD": "",
      "EXTRA1": "",
      "EXTRA2": "",
      "EXTRA3": "",
      "LANG_ID": "1",
      "USER_ID": "60640",
      "CAT_ID": _value2
    };
    http.Response response;
    response = await http.post(
        Uri.parse('http://mycropguruapiwow.cropguru.in/api/PurchaseProduct/1'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data));
    jsonResponse = json.decode(response.body);
    print(jsonResponse["ResponseMessage"]);
    if (response.statusCode == 200) {
      print(data);

      productmapresponse = json.decode(response.body);
      productlistresponse = productmapresponse["DATA"];
      isLoaded = true;
    }
  }

  void addProduct() async {
    isLoaded = false;
    Map<String, dynamic> data = {
      "CAT_ID": "32",
      "USER_ID": "60640",
      "PRODUCT_ID": "",
      "PRODUCT_NAME": addProduct_Controller.text,
      "EXTRA1": "",
      "EXTRA2": "",
      "TASK": "ADD"
    };

    try {
      var response = await http.post(
          Uri.parse("http://mycropguruapiwow.cropguru.in/api/PurchaseProduct"),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(data));

      print(response.body);

      var jsonResponse = json.decode(response.body);

      if (jsonResponse["ResponseCode"] == "0") {
        isLoaded = false;

        print("sucsess");
      } else if (jsonResponse["ResponseCode"] == "1") {
        isLoaded = false;
        print("failed");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    setState(() {});
    categoryname().then((value) {
      setState(() {});

      productname().then((value) {
        setState(() {});
        return value;
      });
      unitapi().then((value) {
        setState(() {});
        return value;
      });

      return value;
    });

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
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
                    tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                  ),
                ),
                title: GestureDetector(
                  onTapDown: (TapDownDetails details) {
                    _showPopupMenu(details.globalPosition);
                  },
                  child: Text(
                    'Add Purchase',
                    style: TextStyle(
                        color: kWhite, fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
              ))),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Container(
                ///height: 200,
                decoration: BoxDecoration(
                  color: kWhite,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "Category Name",
                        style: TextStyle(
                            color: kblack,
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    InkWell(
                      onTap: () {
                        productname();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: SizedBox(height: 30, child: CityDrropDown()),
                      ),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "Product Name",
                        style: TextStyle(
                            color: kblack,
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    InkWell(
                      onTapDown: (TapDownDetails details) {
                        productname();
                        _showPopupMenu(details.globalPosition);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: SizedBox(height: 30, child: productName()),
                      ),
                    ),
                    SizedBox(height: 7),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 55,
                              width: 60,
                              color: lightgreen,
                              child: Padding(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 3),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "Packing",
                                            style: TextStyle(
                                                color: kblack,
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          SizedBox(
                                            width: 80,
                                            height: 30,
                                            child: Container(
                                              color: kWhite,
                                              child: TextField(
                                                keyboardType: TextInputType.number,
                                                inputFormatters: [
                                                  LengthLimitingTextInputFormatter(6),
                                                ],
                                                // controller: _mobile,
                                                style: TextStyle(fontSize: 15),
                                                decoration: InputDecoration(

                                                  hintStyle: TextStyle(

                                                      color: kgreyy,
                                                      fontSize: 13),
                                                  contentPadding: EdgeInsets.only(
                                                      top: 1,
                                                      bottom: 0,
                                                      left: 6,
                                                      right: 6),
                                                  // errorText: _mobileValidated ? null : _mobileError,

                                                  hintText: 'Packing',
                                                  border: OutlineInputBorder(

                                                    borderSide: BorderSide(
                                                      color: Util.colorPrimary,
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                    BorderRadius.circular(2),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "Unit",
                                            style: TextStyle(
                                                color: kblack,
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          SizedBox(
                                              width: 80,
                                              height: 30,
                                              child: Container(
                                                  color: kWhite,
                                                  child: unitDrropDown()))
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            flex: 2,
                          ),
                          Container(
                            height: 60,
                            width: 10,
                          ),
                          Expanded(
                            child: Container(
                              height: 55,
                              width: 60,
                              color: lightgreen,
                              child: Padding(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 3),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "Quantity",
                                            style: TextStyle(
                                                color: kblack,
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          SizedBox(
                                            width: 80,
                                            height: 30,
                                            child: Container(
                                              color: kWhite,
                                              child: TextField(
                                                style: TextStyle(fontSize: 15),
                                                keyboardType: TextInputType.number,
                                                inputFormatters: [
                                                  LengthLimitingTextInputFormatter(6),
                                                ],
                                                // controller: _mobile,
                                                decoration: InputDecoration(
                                                  hintStyle: TextStyle(
                                                      color: kgreyy,
                                                      fontSize: 13),
                                                  contentPadding: EdgeInsets.only(
                                                      top: 1,
                                                      bottom: 0,
                                                      left: 6,
                                                      right: 6),
                                                  // errorText: _mobileValidated ? null : _mobileError,

                                                  hintText: 'QTY',
                                                  border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Util.colorPrimary,
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                    BorderRadius.circular(2),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "Price(Rs.)",
                                            style: TextStyle(
                                                color: kblack,
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          SizedBox(
                                            width: 80,
                                            height: 30,
                                            child: Container(
                                              color: kWhite,
                                              child: TextField(
                                                // controller: _mobile,
                                                style: TextStyle(fontSize: 15),
                                                keyboardType: TextInputType.number,
                                                inputFormatters: [
                                                  LengthLimitingTextInputFormatter(6),
                                                ],
                                                decoration: InputDecoration(
                                                  hintStyle: TextStyle(
                                                      color: kgreyy,
                                                      fontSize: 13),
                                                  contentPadding: EdgeInsets.only(
                                                      top: 1,
                                                      bottom: 0,
                                                      left: 6,
                                                      right: 6),
                                                  // errorText: _mobileValidated ? null : _mobileError,

                                                  hintText: 'Price(Rs.)',
                                                  border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Util.colorPrimary,
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                    BorderRadius.circular(2),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            flex: 2,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "Purchase Date",
                        style: TextStyle(
                            color: kblack,
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: InkWell(
                        onTap: () {
                          datetiming();
                        },
                        child: Container(
                          height: 30,
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: kgreyy),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 120,
                                height: 30,
                                child: TextField(
                                  enabled: false,
                                  controller: timedate_Controller,
                                  style: TextStyle(fontSize: 14),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintStyle:
                                    TextStyle(color: kgreyy, fontSize: 13),
                                    contentPadding: EdgeInsets.only(
                                        top: 0, bottom: 16, left: 6, right: 6),
                                    // errorText: _mobileValidated ? null : _mobileError,

                                    hintText: 'Enter date',
                                  ),
                                ),
                              ),
                              Icon(
                                Icons.calendar_month,
                                color: kgreen,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "Bill Photo",
                        style: TextStyle(
                            color: kblack,
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: InkWell(
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (BuildContext mContext) {
                                return Container(
                                  height: 200,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text("Anand Crop Guru",
                                          style: TextStyle(
                                              color: kblack,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        children: [
                                          InkWell(
                                              onTap: () => PickImageImag(
                                                  ImageSource.camera),
                                              child: Column(
                                                children: [
                                                  Image.asset(
                                                    "assets/images/c_camera.png",
                                                    height: 45,
                                                  ),
                                                  Text("Camera")
                                                ],
                                              )),
                                          InkWell(
                                              onTap: () => PickImageImag(
                                                  ImageSource.gallery),
                                              child: Column(
                                                children: [
                                                  Image.asset(
                                                    "assets/images/image.png",
                                                    height: 45,
                                                  ),
                                                  Text("File Manager")
                                                ],
                                              )),
                                          InkWell(
                                              onTap: () => PickImageImag(
                                                  ImageSource.gallery),
                                              child: Column(
                                                children: [
                                                  Image.asset(
                                                    "assets/images/gallery.png",
                                                    height: 45,
                                                  ),
                                                  Text("Gallery")
                                                ],
                                              )),
                                        ],
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                      ),
                                      SizedBox(
                                        height: 25,
                                      ),
                                      Container(
                                        height: 40,
                                        width: 300,
                                        decoration: BoxDecoration(
                                            color: kgreen,
                                            borderRadius:
                                            BorderRadius.circular(5)),
                                        child: Center(
                                            child: Text(
                                              "Cancel",
                                              style: TextStyle(
                                                  color: kWhite,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                      )
                                    ],
                                  ),
                                );
                              });
                        },
                        child: Container(
                          height: 140,
                          decoration: BoxDecoration(
                              border: Border.all(color: kgreyy),
                              borderRadius: BorderRadius.circular(5)),
                          child: Center(
                              child: Icon(
                                Icons.camera_alt_outlined,
                                color: kgreen,
                                size: 30,
                              )),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "Remark",
                        style: TextStyle(
                            color: kblack,
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: SizedBox(
                          height: 60,
                          child: TextField(
                            // controller: _mobile,
                            decoration: InputDecoration(
                              hintStyle: TextStyle(color: kgreyy, fontSize: 13),
                              contentPadding: EdgeInsets.only(
                                  top: 1, bottom: 0, left: 6, right: 6),
                              // errorText: _mobileValidated ? null : _mobileError,

                              hintText: 'Remark',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Util.colorPrimary,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                          ),
                        )),
                    Center(
                      child: Container(
                        height: 40,
                        width: 150,

                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 3), // changes position of shadow
                              ),
                            ],
                            border: Border.all(width: 1,color: kWhite),
                            color: kgreen,
                            borderRadius: BorderRadius.circular(8)

                        ),
                        child: Center(child: Text("Submit",style: TextStyle(color: kWhite,fontSize: 18,fontWeight: FontWeight.bold),)),
                      ),
                    ),
                    SizedBox(height: 23,)
                  ],
                ),
              ),
            ),
            Purchase(),

          ],
        ),
      ),
    );
  }

  Widget CityDrropDown() {
    // final cityapi = Provider.of<CityApiProvider>(context);
    return DropdownButtonHideUnderline(
      child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButtonFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                contentPadding:
                EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              ),
              value: _value2,
              hint: Text(
                "Select Category",
                style: TextStyle(fontSize: 12, color: kgreyy),
              ),
              isExpanded: true,
              items: catlistresponse?.map((cityOne) {
                return DropdownMenuItem(
                  child: Text(cityOne["CAT_NAME"]),
                  value: cityOne["CAT_ID"],
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _value2 = value as int;
                });
                print("Selected city is $_value2");
              })),
    );
  }

  Widget unitDrropDown() {
    // final cityapi = Provider.of<CityApiProvider>(context);
    return DropdownButtonHideUnderline(
      child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButtonFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                contentPadding:
                EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              ),
              value: _value5,
              hint: Text(
                "Unit",
                style: TextStyle(fontSize: 12, color: kgreyy),
              ),
              isExpanded: true,
              items: unitlistresponse?.map((cityOne) {
                return DropdownMenuItem(
                  child: Text(cityOne["UL_NAME"]),
                  value: cityOne["UNIT_ID"],
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _value5 = value as int;
                });
                print("Selected city is $_value5");
              })),
    );
  }

  Widget productName() {
    // final cityapi = Provider.of<CityApiProvider>(context);
    return DropdownButtonHideUnderline(
      child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButtonFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                contentPadding:
                EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              ),
              value: _value3,
              hint: Text(
                "Select Category",
                style: TextStyle(fontSize: 12, color: kgreyy),
              ),
              isExpanded: true,
              items: productlistresponse?.map((product) {
                return DropdownMenuItem(
                  child: Text(product["PRODUCT_NAME"]),
                  value: product["PRODUCT_ID"],
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _value3 = value as int;
                });
                print("Selected city is $_value3");
              })),
    );
  }

  _showPopupMenu(Offset offset) async {
    double right = offset.dx;
    double top = offset.dy;
    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(right, top, 5, 0),
      items: [
        PopupMenuItem(
          value: 3,
          child: InkWell(
              onTap: () {
                showDialog(
                  barrierDismissible: true,
                  context: context,
                  builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 200,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.red,
                            child: Material(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 54,
                                    color: kgreen,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                                "Add New Product",
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
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Text(
                                      "Product Name",
                                      style: TextStyle(
                                          color: kblack,
                                          fontSize: Fromsize,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: SizedBox(
                                      height: 40,
                                      child: Form(
                                        key: _addProduct,
                                        child:  TextFormField(
                                          controller: addProduct_Controller,
                                          decoration: InputDecoration(
                                            // errorText: _mobileValidated ? null : _mobileError,
                                            contentPadding: EdgeInsets.only(
                                                top: 1,
                                                bottom: 0,
                                                left: 6,
                                                right: 6),
                                            hintText: 'Product Name',
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Util.colorPrimary,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(6),
                                            ),
                                          ),
                                          validator:  (text) {
                                            if (text!.isEmpty) {
                                              return "Please enter Product Name";
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Center(
                                    child: InkWell(
                                      onTap: () {
                                        print("hello ");
                                        if (_addProduct.currentState!.validate()) {
                                          addProduct();

                                          // _addProduct.userRegistration(questtionansController.text,imageData.toString());
                                        }else{

                                        }

                                      },
                                      child: Container(
                                        height: 40,
                                        width: 130,
                                        decoration: BoxDecoration(
                                            color: kgreen,
                                            borderRadius:
                                            BorderRadius.circular(5)),
                                        child: Center(
                                            child: isLoaded == true
                                                ? Text(
                                              "Send",
                                              style: TextStyle(
                                                  color: kWhite,
                                                  fontSize: Fromsize,
                                                  fontWeight:
                                                  FontWeight.bold),
                                            )
                                                : Center(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(3.0),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      SizedBox(
                                                        height: 15,
                                                        width: 15,
                                                        child: CircularProgressIndicator(
                                                            strokeWidth:2,
                                                            color:
                                                            kWhite),
                                                      ),
                                                      SizedBox( width: 13,),
                                                      Text("Please Wait...",  style: TextStyle(
                                                        color: Colors.white,
                                                      ),)
                                                    ],
                                                  ),
                                                ))),
                                      ),
                                    ),
                                  )
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
              child: Text("Add Product")),
        ),
      ],
      elevation: 8.0,
    );
  }
}


