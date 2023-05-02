import 'package:dr_crop_guru/models/user.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import './models/otp_response.dart';

class Services {
  static Future<OTPResponse> getOTP(String mobileNumber) async {
    var url = Uri.parse('http://mycropguruapiwow.cropguru.in/api/OTP_Mobile');
    try {
      final response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode({"MOBILE_NUMBER": mobileNumber}));

      if (response.statusCode >= 400) {
        throw Exception('Something went wrong!');
      }

      var decodedResponse = jsonDecode(response.body) as Map<String, dynamic>;
      OTPResponse response1 = OTPResponse(
        staticOTP: decodedResponse['DATA'],
        uniqueOTP: decodedResponse['ID'],
        // decodedResponse['DATA1'],
        responseCode: decodedResponse['ResponseCode'],
        responseMessage: decodedResponse['ResponseMessage'],

      );
      return response1;
    } catch (error) {
      rethrow;
    }
  }

  static Future<User> getUser(String fullName, String mobileNumber) async {
    var url = Uri.parse('http://mycropguruapiwow.cropguru.in/api/User_Registration');
    try {
      final response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode({"USER_ID":"1","FULL_NAME": fullName,"MOBILE_NO": mobileNumber,"REFERANCE_NO":"","ADDRESS":"","EMAIL":"","LATITUDE":"","LONGITUDE":""}
          ));

      if (response.statusCode >= 400) {
        throw Exception('Something went wrong!');
      }

      var decodedResponse = jsonDecode(response.body)['DATA'];
      User user = User(
        userID: decodedResponse[0]['USER_ID'].toString(),
        stateName: decodedResponse[0]['STATE_NAME'],
      );
      return user;
    } catch (error) {
      rethrow;
    }
  }

  static Future<List<dynamic>> getDistricts(String id) async {
    try {
      var response = await http.get(Uri.parse(
          'https://mycropguruapiwow.cropguru.in/api/GetCity?STATE_ID=$id&LANG_ID=3'));

      if (response.statusCode >= 400) {
        throw Exception('Something went wrong!');
      }

      List<dynamic> districts = jsonDecode(response.body)['DATA'];

      return districts;
    } catch (error) {
      rethrow;
    }
  }

  static Future<List<dynamic>> getTalukaList(String stateID, String cityID, String languageID) async {
    try {
      var response = await http.get(Uri.parse(
          'https://mycropguruapiwow.cropguru.in/api/GetTaluka?STATE_ID=$stateID&CITY_ID=$cityID&LANG_ID=$languageID'));

      if (response.statusCode >= 400) {
        throw Exception('Something went wrong!');
      }

      List<dynamic> talukaList = jsonDecode(response.body)['DATA'];

      return talukaList;
    } catch (error) {
      rethrow;
    }
  }
}
