import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../Api/add_expence_post_api.dart';
import '../../Api/expense_api.dart';
import '../../Api/income_post_api.dart';
import '../../utils/Colors.dart';
import '../../utils/util.dart';

class Income extends StatefulWidget {
  const Income({Key? key, this.userId, this.cropID, this.plotID}) : super(key: key);
  final userId;
  final cropID;
  final plotID;

  @override
  State<Income> createState() => _IncomeState();
}

class _IncomeState extends State<Income> with TickerProviderStateMixin {
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
  String? unitName = "";
  var Product_Add_Controller = TextEditingController();
  var new_Product_Controller = TextEditingController();
  var quantity_Controller = TextEditingController();
  var price_contrroller = TextEditingController();
  var remark_controller = TextEditingController();
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
          "USER_ID": widget.userId.toString(),
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
          "GET_DATA": "Get_UnitMasterList",
          "ID1": "",
          "ID2": "",
          "ID3": "",
          "STATUS": "",
          "START_DATE": "",
          "END_DATE": "",
          "EXTRA1": "Income",
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
      "USER_ID": widget.userId.toString(),
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
    "USER_ID": widget.userId,
    "START_DATE": from_date_Controller,
    "END_DATE": to_date_Controller,
    "PLOT_ID": widget.plotID
    };
    http.Response response;
    response = await http.post(
        Uri.parse(
            'http://mycropguruapiwow.cropguru.in/api/FarmerPlotIncome'),
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
      "CAT_ID": _value2,
      "USER_ID": "60640",
      "PRODUCT_ID": "",
      "PRODUCT_NAME": new_Product_Controller.text,
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
      "PRODUCT_ID": _value3,
      "USER_ID": widget.userId,
      "CAT_ID": _value2,
      "UNIT_ID": _value5
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
    unitapi().then((value) {
      productname().then((value) {
        _controller.reset();
        Navigator.pop(context);
        setState(() {});
        return value;

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
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: SizedBox(
                                  height: 30,
                                  child: TextField(
                                    controller: Product_Add_Controller,
                                    style: TextStyle(fontSize: 15),
                                    decoration: InputDecoration(
                                      hintStyle: TextStyle(
                                          color: kgreyy, fontSize: 13),
                                      contentPadding: EdgeInsets.only(
                                          top: 1, bottom: 0, left: 6, right: 6),
                                      // errorText: _mobileValidated ? null : _mobileError,

                                      hintText: 'Product Name',
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Util.colorPrimary,
                                          width: 1.0,
                                        ),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  "Unit",
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
                                onTap: () {},
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: SizedBox(
                                      height: 30, child: unitDrropDown()),
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
                                                                quantity_Controller,
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
                                                      "Price(Rs.) per-gram",
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
                                                          child: TextField(
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            inputFormatters: [
                                                              LengthLimitingTextInputFormatter(
                                                                  6),
                                                            ],
                                                            controller:
                                                                price_contrroller,
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
                                                                  'Price(Rs.)',
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
                                      controller: remark_controller,
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

                                    IncomePostApi.incomePostApi(
                                        Product_Add_Controller.text,
                                        _value5,price_contrroller.text,
                                        dateController.text,
                                        quantity_Controller.text,
                                        remark_controller.text).then((value) {
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
              color: GreenA100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Total Expense :-",
                    style: TextStyle(
                        color: kblack,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    " ₹43.23",
                    style: TextStyle(
                        color: kblack,
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
            unitName = unitlistresponse![0]["UL_NAME"];
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
              _value5 = unitlistresponse![0]["UL_NAME"];
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
                                          controller: new_Product_Controller,
                                          decoration: InputDecoration(
                                            // errorText: _mobileValidated ? null : _mobileError,
                                            contentPadding: EdgeInsets.only(
                                                top: 1,
                                                bottom: 0,
                                                left: 6,
                                                right: 6),
                                            hintText: 'Product Namew',
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
