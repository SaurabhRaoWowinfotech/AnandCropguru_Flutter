import 'dart:convert';

import 'package:dr_crop_guru/Componts/AppBar.dart';
import 'package:dr_crop_guru/utils/url.dart';
import 'package:http/http.dart' as http;

late Map SelectCropmapresponse;
List? selectCroplistresponse;
bool isLoaded = false;
Future StateLIst() async {
  http.Response response;
  response = await http.post(
      Uri.parse(AppUrl.GetData),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(<String, String>{
        "START":"1",
        "END":"10000",
        "WORD":"",
        "EXTRA1":"",
        "EXTRA2":"",
        "EXTRA3":"",
        "LANG_ID":"1",
        "USER_ID":"62239"
      }));
  if (response.statusCode == 200) {
    print(response.body);

    SelectCropmapresponse = json.decode(response.body);
    selectCroplistresponse = SelectCropmapresponse["DATA"];
      isLoaded = true;
  }
}