import 'dart:convert';
import 'dart:io';
import 'package:dr_crop_guru/Api/expense_list_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'package:dr_crop_guru/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../Api/add_expence_post_api.dart';
import '../../Api/expense_api.dart';
import '../../utils/util.dart';
import 'expenceList.dart';

class Expenses extends StatefulWidget {
  const Expenses({Key? key}) : super(key: key);

  @override
  _ExpensesState createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> with TickerProviderStateMixin {
  int? _value2;
  int? _value3;
  int? _value5;
  bool isVisible = true;
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
  late Map expensmapresponse;
  List? expenslistresponse;

  final timedate_Controller = TextEditingController();
  var jsonResponse;
  DateTime? dateTiming;
  File? image;
  var addProduct_Controller = TextEditingController();
  var quantity_Controller = TextEditingController();
  var remak_controller = TextEditingController();
  var packing_controller = TextEditingController();
  var dateController = TextEditingController();
  var from_date_Controller = TextEditingController();
  var to_date_Controller = TextEditingController();

  DateTime _dateTime = DateTime.now();
  String? salectedDatebackundDevloper;
  dynamic imageData = "";
  final _addProduct = GlobalKey<FormState>();
  final _expenses = GlobalKey<FormState>();

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
        body: jsonEncode(<String, dynamic>{
          "START": "1",
          "END": "1000",
          "WORD": "",
          "GET_DATA": "Get_ExpencesUnitMasterList",
          "ID1": _value3,
          "ID2": "60640",
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

  Future expenseslist() async {
    Map<String, dynamic> data = {
      "CAT_ID": "",
      "START": "1",
      "END": "1000",
      "WORD": "",
      "EXTRA1": "",
      "EXTRA2": "",
      "EXTRA3": "",
      "LANG_ID": "1",
      "USER_ID": "60640",
      "START_DATE":from_date_Controller.text,
      "END_DATE":  to_date_Controller.text,
      "PLOT_ID": "67898"
    };
    http.Response response;
    response = await http.post(
        Uri.parse(
            'http://mycropguruapiwow.cropguru.in/api/FarmerPlotExpence/1'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data));
    jsonResponse = json.decode(response.body);
    print(jsonResponse["ResponseMessage"]);
    if (response.statusCode == 200) {
      print(data);

      expensmapresponse = json.decode(response.body);
      expenslistresponse = expensmapresponse["DATA"];
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

  late Map unitcountmapresponse;
  List? unitcountlistresponse;
  dynamic unitCountnumber = "";
  String unitname = "";

  Future unitcount() async {
    Map<String, dynamic> data = {
      "START": "1",
      "END": "1000",
      "WORD": "",
      "EXTRA1": "",
      "EXTRA2": "",
      "PRODUCT_ID": "17",
      "USER_ID": "21013",
      "CAT_ID": "14",
      "UNIT_ID": "5"
    };
    http.Response response;
    response = await http.post(
        Uri.parse('http://mycropguruapiwow.cropguru.in/api/UserProductUnit'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data));
    jsonResponse = json.decode(response.body);
    print(jsonResponse["ResponseMessage"]);
    if (response.statusCode == 200) {
      print(data);

      unitcountmapresponse = json.decode(response.body);
      unitcountlistresponse = unitcountmapresponse["DATA"];
      unitCountnumber = unitcountlistresponse![0]["QUANTITY"];
      isLoaded = true;
    }
  }

  late AnimationController _controller;

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

    setState(() {});
    categoryname().then((value) {
      productname().then((value) {
        unitapi().then((value) {
          _controller.reset();
          Navigator.pop(context);
          setState(() {});
          return value;
        });

        return value;
      });

      return value;
    });
    expenseslist().then((value) {
      return value;
    });

    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _expenses,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: InkWell(
                        onTap: () {
                          isVisible == !isVisible;
                          print(_value3);
                          print("hello");
                          unitcount();
                        },
                        child: Container(
                          height: 36,
                          decoration: BoxDecoration(
                              border: Border.all(width: 3, color: kbordergrey),
                              borderRadius: BorderRadius.circular(5),
                              color: kWhite),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Add Expense",
                                  style: TextStyle(
                                      color: kblack,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Icon(
                                  Icons.add_circle,
                                  color: kgreen,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    Visibility(
                      visible: isVisible,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Container(
                          ///height: 200,
                          decoration: BoxDecoration(
                            color: kWhite,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 3,
                                blurRadius: 5,
                                offset:
                                    Offset(0, 3), // changes position of shadow
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: SizedBox(
                                      height: 30, child: CityDrropDown()),
                                ),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: SizedBox(
                                      height: 30, child: productName()),
                                ),
                              ),
                              SizedBox(height: 7),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: 55,
                                        width: 60,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 3),
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
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "Quantity",
                                                          style: TextStyle(
                                                              color: kblack,
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Text(
                                                          " ${unitCountnumber.toString()}",
                                                          style: TextStyle(
                                                            color: kgreyy,
                                                            fontSize: 13,
                                                          ),
                                                        ),
                                                        Text(
                                                          " ${unitname.toString()}",
                                                          style: TextStyle(
                                                            color: kgreyy,
                                                            fontSize: 13,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Expanded(
                                                      child: SizedBox(
                                                        height: 30,
                                                        child: Container(
                                                          color: kWhite,
                                                          child: TextField(
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            inputFormatters: [
                                                              LengthLimitingTextInputFormatter(
                                                                  6),
                                                            ],
                                                            controller:
                                                                packing_controller,
                                                            style: TextStyle(
                                                                fontSize: 15),
                                                            decoration:
                                                                InputDecoration(
                                                              hintStyle:
                                                                  TextStyle(
                                                                      color:
                                                                          kgreyy,
                                                                      fontSize:
                                                                          13),
                                                              contentPadding:
                                                                  EdgeInsets.only(
                                                                      top: 1,
                                                                      bottom: 0,
                                                                      left: 6,
                                                                      right: 6),
                                                              // errorText: _mobileValidated ? null : _mobileError,

                                                              hintText:
                                                                  'Quantity',
                                                              border:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: Util
                                                                      .colorPrimary,
                                                                  width: 1.0,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            2),
                                                              ),
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
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Expanded(
                                                      child: SizedBox(
                                                          height: 30,
                                                          child: InkWell(
                                                            onTap: () {
                                                              unitapi();
                                                            },
                                                            child: Container(
                                                                color: kWhite,
                                                                child:
                                                                    unitDrropDown()),
                                                          )),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: InkWell(
                                  onTap: () async {
                                    //   datetiming();
                                    var date = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        lastDate: DateTime.now(),
                                        firstDate: DateTime(2002));
                                    if (date != null) {
                                      dateController.text =
                                          DateFormat('yyyy/MM/dd')
                                              .format(date)
                                              .toString();
                                    }
                                  },
                                  child: Container(
                                    height: 30,
                                    decoration: BoxDecoration(
                                      border:
                                          Border.all(width: 1, color: kgreyy),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: 120,
                                          height: 30,
                                          child: TextFormField(
                                            onTap: () async {
                                              var date = await showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  lastDate: DateTime.now(),
                                                  firstDate: DateTime(2002));
                                              if (date != null) {
                                                dateController.text =
                                                    DateFormat('yyyy/MM/dd')
                                                        .format(date);
                                              }
                                            },
                                            enabled: false,
                                            controller: dateController,
                                            style: TextStyle(fontSize: 14),
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintStyle: TextStyle(
                                                  color: kgreyy, fontSize: 13),
                                              contentPadding: EdgeInsets.only(
                                                  top: 0,
                                                  bottom: 16,
                                                  left: 6,
                                                  right: 6),
                                              // errorText: _mobileValidated ? null : _mobileError,

                                              hintText: 'Enter date',
                                            ),
                                            validator: (text) {
                                              if (!text.toString().isEmpty) {
                                                return "Please enter question";
                                              }
                                              return null;
                                            },
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
                                height: 15,
                              ),
                              Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: SizedBox(
                                    height: 70,
                                    child: TextField(
                                      controller: remak_controller,
                                      decoration: InputDecoration(
                                        hintStyle: TextStyle(
                                            color: kgreyy, fontSize: 13),

                                        // errorText: _mobileValidated ? null : _mobileError,

                                        hintText: 'Remark',
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Util.colorPrimary,
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                      ),
                                    ),
                                  )),
                              Center(
                                child: InkWell(
                                  onTap: () {
                                    AddExpense.expensesapi(
                                        _value2,
                                        _value3,
                                        quantity_Controller.text,
                                        _value5,
                                        remak_controller.text,
                                        dateController.text);
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 150,
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 2,
                                            blurRadius: 5,
                                            offset: Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                        border:
                                            Border.all(width: 1, color: kWhite),
                                        color: kgreen,
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Center(
                                        child: Text(
                                      "Submit",
                                      style: TextStyle(
                                          color: kWhite,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    )),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 23,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(6),
                        child: Container(
                          height: 80,
                          decoration: BoxDecoration(
                            color: GreenA100,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Column(
                                children: [
                                  SizedBox(height: 15),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "From Date",
                                            style: TextStyle(
                                                color: kblack, fontSize: 15),
                                          ),
                                          SizedBox(height: 6),
                                          InkWell(
                                            onTap: () async {
                                              var date = await showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  lastDate: DateTime.now(),
                                                  firstDate: DateTime(2002));
                                              if (date != null) {
                                                from_date_Controller.text =
                                                    DateFormat('yyyy/MM/dd')
                                                        .format(date);
                                              }
                                            },
                                            child: Container(
                                              height: 30,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 1, color: kgreyy),
                                                color: kWhite,
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    width: 80,
                                                    height: 30,
                                                    child: TextField(
                                                      enabled: false,
                                                      controller:
                                                          from_date_Controller,
                                                      style: TextStyle(
                                                          fontSize: 14),
                                                      decoration:
                                                          InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        hintStyle: TextStyle(
                                                            color: kgreyy,
                                                            fontSize: 13),
                                                        contentPadding:
                                                            EdgeInsets.only(
                                                                top: 0,
                                                                bottom: 16,
                                                                left: 6,
                                                                right: 6),
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
                                          )
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "To Date",
                                            style: TextStyle(
                                                color: kblack, fontSize: 15),
                                          ),
                                          SizedBox(height: 6),
                                          InkWell(
                                            onTap: () async {
                                              var date = await showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  lastDate: DateTime.now(),
                                                  firstDate: DateTime(2002));
                                              if (date != null) {
                                                to_date_Controller.text =
                                                    DateFormat('yyyy/MM/dd')
                                                        .format(date);
                                              }
                                            },
                                            child: Container(
                                              height: 30,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 1, color: kgreyy),
                                                color: kWhite,
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  SizedBox(
                                                    width: 80,
                                                    height: 30,
                                                    child: TextField(
                                                      enabled: false,
                                                      controller:
                                                          to_date_Controller,
                                                      style: TextStyle(
                                                          fontSize: 14),
                                                      decoration:
                                                          InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        hintStyle: TextStyle(
                                                            color: kgreyy,
                                                            fontSize: 13),
                                                        contentPadding:
                                                            EdgeInsets.only(
                                                                top: 0,
                                                                bottom: 16,
                                                                left: 6,
                                                                right: 6),
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
                                          )
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 15),
                                        child: InkWell(
                                          onTap: () {
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

                                            AddExpense_Post_Api.addexpensepost(
                                                    from_date_Controller.text,
                                                    to_date_Controller.text)
                                                .then((value) {
                                              _controller.reset();
                                              Navigator.pop(context);
                                              expenseslist().then((value) {
                                                return value;
                                              });
                                              setState(() {});
                                              return value;
                                            });

                                          },
                                          child: Container(
                                            height: 30,
                                            width: 90,
                                            decoration: BoxDecoration(
                                              color: kgreen,
                                              border: Border.all(
                                                  width: 2, color: kWhite),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: Center(
                                              child: Text(
                                                "Submit",
                                                style: TextStyle(
                                                    color: kWhite,
                                                    fontSize: 15),
                                              ),
                                            ),
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
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      child: Text("Add Expense",
                          style: TextStyle(color: kblack, fontSize: 20)),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8),
                      child: listdemo(),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 50,
              color: kpink,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Total Expense :-",
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    " ₹43.23",
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
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
              contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
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
            },
            validator: (text) {
              if (!text.toString().isEmpty) {
                return "Please enter question";
              }
              return null;
            },
          )),
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
            contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
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
              print(
                value,
              );
              _value5 = value as int;
              //unitname =  value as String;
              unitname = unitlistresponse![value as int]["UL_NAME"].toString();
            });
            print("Selected city is $_value5");
          },
          validator: (text) {
            if (!text.toString().isEmpty) {
              return "Please enter question";
            }
            return null;
          },
        ),
      ),
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
              contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
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
                                        child: TextFormField(
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
                                          validator: (text) {
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
                                        if (_addProduct.currentState!
                                            .validate()) {
                                          addProduct();

                                          // _addProduct.userRegistration(questtionansController.text,imageData.toString());
                                        } else {}
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
                                                    padding:
                                                        const EdgeInsets.all(
                                                            3.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        SizedBox(
                                                          height: 15,
                                                          width: 15,
                                                          child:
                                                              CircularProgressIndicator(
                                                                  strokeWidth:
                                                                      2,
                                                                  color:
                                                                      kWhite),
                                                        ),
                                                        SizedBox(
                                                          width: 13,
                                                        ),
                                                        Text(
                                                          "Please Wait...",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ))),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
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

  Widget listdemo() {
    return Visibility(
      visible: isLoaded,
      child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount:
              expenslistresponse == null ? 0 : expenslistresponse!.length,
          itemBuilder: (context, index) {
            return Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(8),
              child: Container(
                height: 95,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: kWhite,
                    border: Border.all(width: 3, color: pgrey)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text("Product Name",
                              style: TextStyle(
                                color: kgreyy,
                                fontSize: 13,
                              )),
                          Text(
                              " ${expenslistresponse![index]["PRODUCT_NAME"].toString()}",
                              style: TextStyle(
                                  color: kblack,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold))
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text("Quantity:-",
                                  style: TextStyle(
                                    color: kgreyy,
                                    fontSize: 13,
                                  )),
                              Text(
                                  expenslistresponse![index]["QUANTITY"]
                                      .toString(),
                                  style: TextStyle(
                                    color: kgreyy,
                                    fontSize: 13,
                                  )),
                            ],
                          ),
                          SizedBox(
                            width: 50,
                          ),
                          Row(
                            children: [
                              Text(" Unit",
                                  style: TextStyle(
                                    color: kgreyy,
                                    fontSize: 13,
                                  )),
                              Text(
                                  expenslistresponse![index]["UNIT_NAME"]
                                      .toString(),
                                  style: TextStyle(
                                    color: kgreyy,
                                    fontSize: 13,
                                  )),
                            ],
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text("Category:-",
                                  style: TextStyle(
                                    color: kgreyy,
                                    fontSize: 13,
                                  )),
                              Text(
                                  expenslistresponse![index]["CAT_NAME"]
                                      .toString(),
                                  style: TextStyle(
                                    color: kgreyy,
                                    fontSize: 13,
                                  )),
                            ],
                          ),
                          Icon(
                            Icons.arrow_right_alt_sharp,
                            size: 28,
                            color: kgreen,
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(" Remark :-",
                              style: TextStyle(
                                color: kblack,
                                fontSize: 13,
                              )),
                          Text(expenslistresponse![index]["REMARK"].toString(),
                              style: TextStyle(
                                color: kgreyy,
                                fontSize: 13,
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
