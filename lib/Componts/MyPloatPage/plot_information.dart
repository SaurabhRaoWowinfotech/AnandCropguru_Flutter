import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import '../../utils/Colors.dart';
import '../../utils/util.dart';
import 'package:http/http.dart' as http;

class PlotInformation extends StatefulWidget {
  PlotInformation({super.key});
  @override
  State<PlotInformation> createState() => _PlotInformationState();
}
class _PlotInformationState extends State<PlotInformation> {
  double size = 14;

  double Fromsize = 15;
  var dateController = TextEditingController();
  DateTime _dateTime = DateTime.now();
  var jsonResponse;
  bool isLoaded = false;
  DateTime? dateTiming;
  String? salectedDatebackundDevloper;
  late Map mapresponse;
  List? listresponse;

  final timedate_Controller = TextEditingController();
  final totalarea_Controller = TextEditingController();


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

  List<String> items = <String>[
    'Select Report Type',
    'Leaf',
    'Soil',
    'Water',
    'Other'
  ];

  String dropdownvalue = 'Select Report Type';

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
                  Scaffold.of(context).openDrawer();
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              ),
            ),
            title: InkWell(
              child: Text(
                'Question details',
                style: TextStyle(
                    color: kWhite, fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 15, top: 10),
                child: InkWell(
                  onTap: () {
                    showDialog<void>(
                      barrierDismissible: true,
                      context: context,
                      builder: (BuildContext context) {
                        return SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        MediaQuery.of(context).orientation ==
                                                Orientation.portrait
                                            ? 15
                                            : 100,
                                    vertical: 15),
                                child: Material(
                                  child: Center(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: kWhite,
                                          borderRadius: BorderRadius.circular(5)),
                                      width: MediaQuery.of(context).size.width,
                                      height: MediaQuery.of(context).size.height - 390,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                              height: 50,
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                color: pgreen,
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                                      "Updated Plot",
                                                      style: TextStyle(
                                                          color: kWhite,
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )),
                                                    Align(
                                                      alignment: Alignment.centerRight,
                                                      child: Material(
                                                        color: Colors.transparent,
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
                                              )),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Text(
                                              "Pruning Type :",
                                              style: TextStyle(
                                                color: kgreen,
                                                fontSize: Fromsize,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  // color: kblack,
                                                  border:
                                                      Border.all(color: kblack),
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 5),
                                                child:
                                                    DropdownButtonHideUnderline(
                                                  child: DropdownButton<String>(
                                                    hint: Text(
                                                        "Select Report Type"),
                                                    isExpanded: true,
                                                    iconSize: 34,
                                                    value: dropdownvalue,
                                                    items: items.map<
                                                            DropdownMenuItem<
                                                                String>>(
                                                        (String value) {
                                                      return DropdownMenuItem<
                                                              String>(
                                                          value: value,
                                                          child: Text(value));
                                                    }).toList(),
                                                    onChanged:
                                                        (String? newValue) {
                                                      setState(() {
                                                        dropdownvalue =
                                                            newValue ?? '';
                                                      });
                                                    },
                                                  ),
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
                                              "Select the pruning date",
                                              style: TextStyle(
                                                  color: kgreen,
                                                  fontSize: Fromsize,
                                                fontWeight: FontWeight.bold
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
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
                                                height: 50,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: kgrey, width: 2),
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    SizedBox(
                                                      width: 120,
                                                      height: 30,
                                                      child: TextFormField(
                                                        onTap: () async {
                                                          var date =
                                                              await showDatePicker(
                                                                  context:
                                                                      context,
                                                                  initialDate:
                                                                      DateTime
                                                                          .now(),
                                                                  lastDate:
                                                                      DateTime
                                                                          .now(),
                                                                  firstDate:
                                                                      DateTime(
                                                                          2002));
                                                          if (date != null) {
                                                            dateController
                                                                .text = DateFormat(
                                                                    'yyyy/MM/dd')
                                                                .format(date);
                                                          }
                                                        },
                                                        enabled: false,
                                                        controller:
                                                            dateController,
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
                                                        validator: (text) {
                                                          if (!text
                                                              .toString()
                                                              .isEmpty) {
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
                                            height: 8,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Text(
                                              "Select the pruning date",
                                              style: TextStyle(
                                                  color: kgreen,
                                                  fontSize: Fromsize,
                                                  fontWeight: FontWeight.bold
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Container(
                                              height: 50,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: kgrey, width: 2),
                                                borderRadius:
                                                BorderRadius.circular(6),
                                              ),
                                              child: TextFormField(

                                                controller:
                                              totalarea_Controller,
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
                                                validator: (text) {
                                                  if (!text
                                                      .toString()
                                                      .isEmpty) {
                                                    return "Please enter question";
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 8,),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal:18),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    height: 45,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.only(
                                                        topRight: Radius.circular(12),
                                                      ),
                                                      gradient: LinearGradient(
                                                          begin: Alignment.topCenter,
                                                          end: Alignment.bottomCenter,
                                                          colors: [Util.newHomeColor, Util.endColor]),

                                                    ),
                                                    child: Text(
                                                      "Cancel",
                                                      style: TextStyle(
                                                          color: kWhite,
                                                          fontSize: Fromsize,
                                                          fontWeight: FontWeight.bold
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  width: 2,
                                                  color: kWhite,
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    alignment: Alignment.center,                                                height: 45,
                                                    decoration: BoxDecoration(
                                                      gradient: LinearGradient(
                                                          begin: Alignment.topCenter,
                                                          end: Alignment.bottomCenter,
                                                          colors: [Util.newHomeColor, Util.endColor]),
                                                      borderRadius: BorderRadius.only(
                                                        topRight: Radius.circular(12),
                                                      ),

                                                    ),
                                                    child: Text(
                                                      "Submit",
                                                      style: TextStyle(
                                                          color: kWhite,
                                                          fontSize: Fromsize,
                                                          fontWeight: FontWeight.bold
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: SizedBox(
                      height: 40,
                      width: 35,
                      child: Image.asset(
                        "assets/images/edit.png",
                        color: kWhite,
                      )),
                ),
              )
            ],
          )),
        ),
        body: SingleChildScrollView(
          child: Form(
            child: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 13),
                  child: Container(
                      height: 45,
                      decoration:
                          BoxDecoration(border: Border.all(color: kblack)),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                'Parameter',
                                style: TextStyle(
                                    color: kgreen,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Container(height: 20, width: 1, color: kblack),
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                'Values',
                                style: TextStyle(
                                    color: kgreen,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        ],
                      )),
                ),
                Container(
                  color: Colors.transparent,
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Table(
                    columnWidths: {
                      0: const FlexColumnWidth(5),
                      1: const FlexColumnWidth(5),
                    },
                    border: TableBorder.all(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(6)),
                    children: [
                      TableRow(
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 9),
                            child: Center(
                              child: Expanded(
                                child: Text(
                                  'PLOT ID',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 9),
                            child: Center(
                              child: Text(
                                '69371',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 9),
                            child: Center(
                              child: Expanded(
                                child: Text(
                                  "PLOT NAME",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 9),
                            child: Center(
                              child: Text(
                                'Plot No : 0',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 9),
                            child: Center(
                              child: Expanded(
                                child: Text(
                                  'USER NAME',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 9),
                            child: Center(
                              child: Text(
                                'pratik',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 9),
                            child: Center(
                              child: Expanded(
                                child: Text(
                                  'MOBILE NO',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 9),
                            child: Center(
                              child: Text(
                                '9168488533',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 9),
                            child: Center(
                              child: Expanded(
                                child: Text(
                                  'CROP NAME',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 9),
                            child: Center(
                              child: Text(
                                'Grapes',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 9),
                            child: Center(
                              child: Expanded(
                                child: Text(
                                  'CROPVARIETY NAME',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 9),
                            child: Center(
                              child: Text(
                                'Crimson',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 9),
                            child: Center(
                              child: Expanded(
                                child: Text(
                                  'PRUNING DATE',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 9),
                            child: Center(
                              child: Text(
                                '20 Apr 2023',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 9),
                            child: Center(
                              child: Expanded(
                                child: Text(
                                  'PLOT STATUS',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 9),
                            child: Center(
                              child: Text(
                                'ACTIVE',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 9),
                            child: Center(
                              child: Expanded(
                                child: Text(
                                  'SOIL TYPE',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 9),
                            child: Center(
                              child: Text(
                                'no',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 9),
                            child: Center(
                              child: Expanded(
                                child: Text(
                                  'EXPORT TYPE',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 9),
                            child: Center(
                              child: Text(
                                'Export',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 9),
                            child: Center(
                              child: Expanded(
                                child: Text(
                                  'CROP DISTANCE',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 9),
                            child: Center(
                              child: Text(
                                'X',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 9),
                            child: Center(
                              child: Expanded(
                                child: Text(
                                  'TOTAL AREA',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 9),
                            child: Center(
                              child: Text(
                                '500',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 9),
                            child: Center(
                              child: Expanded(
                                child: Text(
                                  'DISTRICT',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 9),
                            child: Center(
                              child: Text(
                                'AMRAVATI',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 9),
                            child: Center(
                              child: Expanded(
                                child: Text(
                                  'TALUKA',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 9),
                            child: Center(
                              child: Text(
                                'Amravati ',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 9),
                            child: Center(
                              child: Expanded(
                                child: Text(
                                  'LOCATION',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 9),
                            child: Center(
                              child: Text(
                                'Taluka: Amravati\nDistrict: Amravati',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 9),
                            child: Center(
                              child: Expanded(
                                child: Text(
                                  'PLOT DAY',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 9),
                            child: Center(
                              child: Text(
                                '15',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 9),
                            child: Center(
                              child: Expanded(
                                child: Text(
                                  'FEEDBACK_TEXT',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 9),
                            child: Center(
                              child: Text(
                                '-',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 9),
                            child: Text(
                              'LATITUDE',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 13, horizontal: 7),
                            child: Text(
                              '20.0087',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 9),
                            child: Center(
                              child: Expanded(
                                child: Text(
                                  'LONGITUDE',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 9),
                            child: Center(
                              child: Text(
                                '73.7639',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

class SvitribaiPhuleGirlsScholarshipForm extends StatefulWidget {
  const SvitribaiPhuleGirlsScholarshipForm({super.key});

  @override
  State<SvitribaiPhuleGirlsScholarshipForm> createState() =>
      _SvitribaiPhuleGirlsScholarshipFormState();
}

class _SvitribaiPhuleGirlsScholarshipFormState
    extends State<SvitribaiPhuleGirlsScholarshipForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Savitribai Phule GirlsScholarship Form"),
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Form(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    color: Colors.transparent,
                    padding: const EdgeInsets.all(8.0),
                    child: Table(
                      columnWidths: {
                        0: const FlexColumnWidth(5),
                        1: const FlexColumnWidth(5),
                      },
                      border: TableBorder.all(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(6)),
                      children: [
                        const TableRow(children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 4, vertical: 10),
                            child: Expanded(
                              child: Text(
                                'अ.क्र',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 4, vertical: 10),
                            child: Center(
                              child: Text(
                                'तपशिले',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                            ),
                          ),
                        ]),
                        TableRow(
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 9),
                              child: Center(
                                child: Expanded(
                                  child: Text(
                                    'PLOT ID',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 9),
                              child: Center(
                                child: Text(
                                  '69371',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 9),
                              child: Center(
                                child: Expanded(
                                  child: Text(
                                    "PLOT NAME",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 9),
                              child: Center(
                                child: Text(
                                  'Plot No : 0',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 9),
                              child: Center(
                                child: Expanded(
                                  child: Text(
                                    'USER NAME',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 9),
                              child: Center(
                                child: Text(
                                  'pratik',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 9),
                              child: Center(
                                child: Expanded(
                                  child: Text(
                                    'MOBILE NO',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 9),
                              child: Center(
                                child: Text(
                                  '9168488533',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 9),
                              child: Center(
                                child: Expanded(
                                  child: Text(
                                    'CROP NAME',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 9),
                              child: Center(
                                child: Text(
                                  'Grapes',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 9),
                              child: Center(
                                child: Expanded(
                                  child: Text(
                                    'CROPVARIETY NAME',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 9),
                              child: Center(
                                child: Text(
                                  'Crimson',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 9),
                              child: Center(
                                child: Expanded(
                                  child: Text(
                                    'PRUNING DATE',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 9),
                              child: Center(
                                child: Text(
                                  '20 Apr 2023',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 9),
                              child: Center(
                                child: Expanded(
                                  child: Text(
                                    'PLOT STATUS',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 9),
                              child: Center(
                                child: Text(
                                  'ACTIVE',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 9),
                              child: Center(
                                child: Expanded(
                                  child: Text(
                                    'SOIL TYPE',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 9),
                              child: Center(
                                child: Text(
                                  'no',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 9),
                              child: Center(
                                child: Expanded(
                                  child: Text(
                                    'EXPORT TYPE',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 9),
                              child: Center(
                                child: Text(
                                  'Export',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 9),
                              child: Center(
                                child: Expanded(
                                  child: Text(
                                    'CROP DISTANCE',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 9),
                              child: Center(
                                child: Text(
                                  'X',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 9),
                              child: Center(
                                child: Expanded(
                                  child: Text(
                                    'TOTAL AREA',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 9),
                              child: Center(
                                child: Text(
                                  '500',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 9),
                              child: Center(
                                child: Expanded(
                                  child: Text(
                                    'DISTRICT',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 9),
                              child: Center(
                                child: Text(
                                  'AMRAVATI',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 9),
                              child: Center(
                                child: Expanded(
                                  child: Text(
                                    'TALUKA',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 9),
                              child: Center(
                                child: Text(
                                  'Amravati ',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 9),
                              child: Center(
                                child: Expanded(
                                  child: Text(
                                    'LOCATION',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 9),
                              child: Center(
                                child: Text(
                                  'Taluka: Amravati\nDistrict: Amravati',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 9),
                              child: Center(
                                child: Expanded(
                                  child: Text(
                                    'PLOT DAY',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 9),
                              child: Center(
                                child: Text(
                                  '15',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 9),
                              child: Center(
                                child: Expanded(
                                  child: Text(
                                    'FEEDBACK_TEXT',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 9),
                              child: Center(
                                child: Text(
                                  '-',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 9),
                              child: Text(
                                'LATITUDE',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 13, horizontal: 7),
                              child: Text(
                                '20.0087',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 9),
                              child: Center(
                                child: Expanded(
                                  child: Text(
                                    'LONGITUDE',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 9),
                              child: Center(
                                child: Text(
                                  '73.7639',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
