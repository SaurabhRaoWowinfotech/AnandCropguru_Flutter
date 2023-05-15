import 'dart:convert';
import 'dart:io';

import 'package:dr_crop_guru/utils/Colors.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../Componts/MyPloatPage/add_Report.dart';
import '../Componts/MyPloatPage/question_answer_list.dart';
import '../Componts/MyPloatPage/report_master.dart';

class ReportMasterApi {
  bool _loading = false;
  bool get loading => _loading;
  var jsonResponse;
  int? _value;
  int? _value2;
  dynamic imageData = "";

  setLoading(bool vlaue) {
    _loading = vlaue;
  }

  static reportMasterApi(dropdownvalue ,reportdescription,image) async {
    Map<String, dynamic> data = {
      "USER_ID": "21013",
      "PLOT_ID": "67898",
      "REPORT_ID": "1",
      "REPORT_TYPE": dropdownvalue,
      "REPORT_DESCRIPTION": reportdescription,
      "LOCATION":
          "Yoga Bhavan, Opp: HPT College, College Rd, Kulkarni Baug, Nashik, Maharashtra 422005, India",
      "LATITUDE": "",
      "LONGITUDE": "",
      "REPORT_IMAGE": image
    };
    try {
      var response = await http.post(
          Uri.parse("https://mycropguruapiwow.cropguru.in/api/Report"),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(data));

      var jsonResponse = json.decode(response.body);
      print(data);

      if (jsonResponse["ResponseCode"] == "0") { 
       Get.to(ReportMaster());
        Fluttertoast.showToast(
          msg: "${jsonResponse["ResponseMessage"]}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: kblack,
          textColor: kWhite,
          fontSize: 13.0,
        );
      
      } else if (jsonResponse![0]["ResponseCode"] == "1") {
        print("failed");
         Get.to(ReportMaster());
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
