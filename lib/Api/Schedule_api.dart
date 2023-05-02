


import 'dart:convert';

import 'package:dr_crop_guru/Componts/AppBar.dart';
import 'package:dr_crop_guru/utils/url.dart';
import 'package:http/http.dart' as http;

late Map schedulemapresponse;
List? schedulelistresponse;
var jsonResponse;

bool isLoaded = false;
Future scheduleapi(type) async {
  http.Response response;
  response = await http.post(
      Uri.parse('http://mycropguruapiwow.cropguru.in/api/Schedule?AGRONOMIST_ID=60640'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(<String, String>{
        "START":"0",
        "END":"100000",
        "WORD":"Current Schedule",
        "LANG_ID":"3",
        "CROP_ID":"1",
        "PLOT_ID":"69234",
        "ACCESS_CODE":"123456",
        "USER_ID":"60640",
        "TYPE":type
      }));
  jsonResponse = json.decode(response.body);
  print(jsonResponse["ResponseMessage"]);
  if (response.statusCode == 200) {



    schedulemapresponse = json.decode(response.body);
    schedulelistresponse = schedulemapresponse["DATA"];
     print(schedulelistresponse![0]["SCHEDUEL_ID"]);
    isLoaded = true;
  }
}