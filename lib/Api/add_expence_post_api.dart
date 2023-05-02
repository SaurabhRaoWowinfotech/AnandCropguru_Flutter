import 'dart:convert';
import 'dart:io';

import 'package:dr_crop_guru/utils/Colors.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../Componts/MyPloatPage/question_answer_list.dart';
class AddExpense_Post_Api{
  bool _loading = false;

  var jsonResponse;
  int? _value;
  int? _value2;
  dynamic imageData = "";

  bool get loading => _loading;
  setLoading(bool vlaue) {
    _loading = vlaue;
  }

   static Future addexpensepost(startdate,enddaate) async {

    Map<String, dynamic> data = {
      "CAT_ID": "",
      "START": "1",
      "END": "1000",
      "WORD": "",
      "EXTRA1": "",
      "EXTRA2": "",
      "EXTRA3": "",
      "LANG_ID": "1",
      "USER_ID": "21013",
      "START_DATE": enddaate,
      "END_DATE": "02\/28\/2023",
      "PLOT_ID": "67898"
    };
    try {
      var response = await http.post(
          Uri.parse("http://mycropguruapiwow.cropguru.in/api/FarmerPlotExpence/1"),
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
        // Get.to(QuestionAnswer());


      } else if (jsonResponse![0]["ResponseCode"] == "1") {
        print("failed");

      }
    } catch (e) {

      print(e.toString());
    }
  }


}