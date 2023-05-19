import 'dart:convert';
import 'dart:io';

import 'package:dr_crop_guru/screens/profile.dart';
import 'package:dr_crop_guru/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../Componts/MyPloatPage/question_answer_list.dart';
class BulkOrderApi{
  bool _loading = false;
  bool get loading => _loading;
  var jsonResponse;
  int? _value;
  int? _value2;
  dynamic imageData = "";


  setLoading(bool vlaue) {
    _loading = vlaue;
  }

  static  bulkapi(userID,username,mobileNumber,orderType,shopOrComanyName,pinCode,pancardnumbr,gstNumber,address) async {

    Map<String, dynamic> data = {
      "BULK_ORDER_ID":"",
      "USER_ID":userID,
      "USER_NAME":"kunal",
      "MOBILE_NUMBER":mobileNumber.toString(),
      "ORDER_TYPE":orderType,
      "SHOP_OR_COMPANY_NAME":shopOrComanyName,
      "LATITUDE":"",
      "LONGITUDE":"",
      "ADDRESS": address,
      "PINCODE":pinCode,
      "REMARK":"",
      "TASK":"ADD",
      "EXTRA1":"",
      "EXTRA2":"",
      "EXTRA3":"",
      "PAN": pancardnumbr,
      "GST":gstNumber,
      "LANG_ID":""
    };
    try {
      var response = await http.post(
          Uri.parse("http://mycropguruapiwow.cropguru.in/api/BulkOrder"),
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
        Get.to(Profile());


      } else if (jsonResponse![0]["ResponseCode"] == "1") {
        print("failed");

      }
    } catch (e) {
      print(e.toString());
    }
  }


}