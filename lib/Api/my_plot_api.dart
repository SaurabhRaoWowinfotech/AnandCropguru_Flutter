//
// import 'dart:convert';
//
// import 'package:dr_crop_guru/Componts/AppBar.dart';
// import 'package:dr_crop_guru/utils/url.dart';
// import 'package:http/http.dart' as http;
//
// late Map myplotmapresponse;
// List? myplotlistresponse;
// var jsonResponse;
//
// bool isLoaded = false;
// Future Myploat() async {
//   http.Response response;
//   response = await http.post(
//       Uri.parse('https://mycropguruapiwow.cropguru.in/api/PlotList?&SALESTEAM_USER_ID=60640&TYPE=ALL'),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode(<String, String>{
//         "START":"0",
//         "END":"10",
//         "WORD":"NPNE",
//         "LANG_ID":"3",
//         "ACCESS_TOKEN":"123456"
//       }));
//    jsonResponse = json.decode(response.body);
//   print(jsonResponse["ResponseMessage"]);
//   if (response.statusCode == 200) {
//     print(response.body);
//
//
//     myplotmapresponse = json.decode(response.body);
//     myplotlistresponse = myplotmapresponse["DATA"];
//     isLoaded = true;
//   }
// }