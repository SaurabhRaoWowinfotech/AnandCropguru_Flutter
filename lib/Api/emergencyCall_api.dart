import 'dart:convert';
import 'dart:io';

import 'package:dr_crop_guru/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../Componts/MyPloatPage/question_answer_list.dart';
class EmergencyCallPostApi{
  bool _loading = false;
  bool get loading => _loading;
  var jsonResponse;
  int? _value;
  int? _value2;
  dynamic imageData = "";


  setLoading(bool vlaue) {
    _loading = vlaue;
  }

  static  emergencycall(userID,callcat,cropId) async {

    Map<String, dynamic> data = {
      "USER_ID":userID.toString(),
      "PLOT_ID": "",
      "REMARK": "Emergency Call",
      "CALL_CAT": callcat,
      "LOCATION": "",
      "LATITUDE": "",
      "LONGITUDE": "",
      "CROP_ID":cropId,
      "CALL_DATETIME": "",
      "FD_IMAGE": "QEA="
    };
    try {
      var response = await http.post(
          Uri.parse("http://mycropguruapiwow.cropguru.in/api/EmergencyCall"),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(data));

      var jsonResponse = json.decode(response.body);
      print(data);

      if (jsonResponse["ResponseCode"] == "0") {
        Fluttertoast.showToast(
          msg: "${jsonResponse["ResponseMessage"]}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: kblack,
          textColor: kWhite,
          fontSize: 13.0,



        );
        //et.to(QuestionAnswer());


      } else if (jsonResponse![0]["ResponseCode"] == "1") {
        print("failed");

      }
    } catch (e) {
      print(e.toString());
    }
  }


}