


import 'dart:convert';

import 'package:dr_crop_guru/Componts/AppBar.dart';
import 'package:dr_crop_guru/utils/url.dart';
import 'package:http/http.dart' as http;

late Map oldschedulemapresponse;
List? oldschedulelistresponse;
var jsonResponse;

bool oldisLoaded = false;
Future oldSchedule() async {
  http.Response response;
  response = await http.post(
      Uri.parse('http://mycropguruapiwow.cropguru.in/api/Schedule?AGRONOMIST_ID=60640'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(<String, String>{
        "START":"0",
        "END":"100000",
        "WORD":"Previous Schedule",
        "LANG_ID":"3",
        "CROP_ID":"1",
        "PLOT_ID":"69234",
        "ACCESS_CODE":"123456",
        "USER_ID":"60640",
        "TYPE":"Fertilizer"
      }));
  jsonResponse = json.decode(response.body);
  print(jsonResponse["ResponseMessage"]);
  if (response.statusCode == 200) {



    oldschedulemapresponse = json.decode(response.body);
    oldschedulelistresponse = oldschedulemapresponse["DATA"];
    print(oldschedulelistresponse![0]["SCHEDUEL_ID"]);
    oldisLoaded = true;
  }
}