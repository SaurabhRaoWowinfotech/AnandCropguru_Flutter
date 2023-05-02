import 'dart:convert';
import 'dart:io';

import 'package:dr_crop_guru/utils/Colors.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../Componts/MyPloatPage/question_answer_list.dart';
class AddQuestion{
  bool _loading = false;
  bool get loading => _loading;
  var jsonResponse;
  int? _value;
  int? _value2;
  dynamic imageData = "";


   setLoading(bool vlaue) {
    _loading = vlaue;
  }

  File? image;
   Future PickImageImag(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imageTemporary = File(image.path);
      imageData = base64Encode(imageTemporary.readAsBytesSync());

      this.image = imageTemporary;
    } on PlatformException catch (e) {
      print('Failed to pick image $e');
    }
  }

  static  userRegistration(questionanswer,imagedata) async {

    Map<String, dynamic> data = {
      "USER_ID":"60640",
      "PLOT_ID":"69234",
      "QUESTION_ID":"1",
      "AGRONOMIST_ID":"0",
      "QUESTION":questionanswer.toString(),
      "QUESTION_ANSWER":questionanswer.toString(),
      "QUESTION_CAT":"1",
      "LOCATION":"Rachita Constructions Bldg, Next to HDFC Bank, Thatte Nagar, Off College Road, Thatte Nagar, Nashik, Maharashtra 422005, India",
      "LATITUDE":"20.0087082",
      "LONGITUDE":"73.7639191",
      "ANS_IMAGE":imagedata.toString()
    };
    try {
      var response = await http.post(
          Uri.parse("https://mycropguruapiwow.cropguru.in/api/QANDAAgronomist"),
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
        Get.to(QuestionAnswer());


      } else if (jsonResponse![0]["ResponseCode"] == "1") {
        print("failed");

      }
    } catch (e) {
      print(e.toString());
    }
  }


}