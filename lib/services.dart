import 'package:dr_crop_guru/models/user.dart';
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

  static Future<List<dynamic>> getUser(
      String fullName, String mobileNumber) async {
    var url =
        Uri.parse('http://mycropguruapiwow.cropguru.in/api/User_Registration');
    try {
      final response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode({
            "USER_ID": "1",
            "FULL_NAME": fullName,
            "MOBILE_NO": mobileNumber,
            "REFERANCE_NO": "",
            "ADDRESS": "",
            "EMAIL": "",
            "LATITUDE": "",
            "LONGITUDE": ""
          }));

      if (response.statusCode >= 400) {
        throw Exception('Something went wrong!');
      }

      var decodedResponse = jsonDecode(response.body)['DATA'];

      return decodedResponse;
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

  static Future<List<dynamic>> getTalukaList(
      String stateID, String cityID, String languageID) async {
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

  static Future<bool> updateUserDetails(User user) async {
    var url = Uri.parse(
        'http://mycropguruapiwow.cropguru.in/api/User_Registration/1');
    try {
      final response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode({
            "USER_ID": user.USER_ID,
            "FULL_NAME": user.FULL_NAME,
            "MOBILE_NO": user.MOBILE_NO,
            "ADDRESS": user.ADDRESS ?? "",
            "EMAIL": "",
            "TALUKA_ID": user.TALUKA_ID,
            "TALUKA_NAME": user.TALUKA_NAME,
            "DISTRICT_ID": user.DISTRICT_ID,
            "DISTRICT_NAME": user.DISTRICT_NAME,
            "STATE_ID": user.STATE_ID,
            "VILLAGE_NAME": user.VILLAGE_NAME,
            "VILLAGE_ID": "1",
            "PROFILE_PHOTO": ""
          }));

      if (response.statusCode >= 400) {
        throw Exception('Something went wrong!');
      }

      if (int.parse(jsonDecode(response.body)['ResponseCode']) > 0) {
        throw Exception(
            int.parse(jsonDecode(response.body)['ResponseMessage']));
      }

      return true;
    } catch (error) {
      rethrow;
    }
  }

  static Future<List<dynamic>> getCropList(String userID, String langID) async {
    var url = Uri.parse('http://mycropguruapiwow.cropguru.in/api/CropMaster');
    try {
      var response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode({
            "START": 0,
            "END": 10000,
            "WORD": "NONE",
            "LANG_ID": langID,
            "USER_ID": userID,
            "ACCESS_TOKEN": "123456"
          }));

      if (response.statusCode >= 400) {
        throw Exception('Something went wrong!');
      }

      List<dynamic> cropList = jsonDecode(response.body)['DATA'];

      return cropList;
    } catch (error) {
      rethrow;
    }
  }

  static Future<List<dynamic>> getCategoryList(User user) async {
    var url = Uri.parse('http://mycropguruapiwow.cropguru.in/api/Category');
    try {
      var response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode({
            "START": 0,
            "END": 10000,
            "WORD": "NONE",
            "USER_ID": user.USER_ID,
            "LANG_ID": "3",
            "CAT_ID": "0",
            "TYPE": "CAT",
            "SUBCAT_ID": "0",
            "LATITUDE": "",
            "ACCESS_TOKEN": "123456",
            "DISTRICT_ID": user.DISTRICT_ID,
            "TALUKA_ID": user.TALUKA_ID,
            "SCHEDULE_ID": "0",
            "LONGITUDE": "",
            "CROP_ID": "0",
            "PLOT_ID": "0"
          }));

      if (response.statusCode >= 400) {
        throw Exception('Something went wrong!');
      }

      List<dynamic> categoryList = jsonDecode(response.body)['DATA'];

      return categoryList;
    } catch (error) {
      rethrow;
    }
  }

  static Future<List<dynamic>> getProductList(String id, String langId) async {
    var url = Uri.parse('http://mycropguruapiwow.cropguru.in/api/Get_Data');
    try {
      var response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode({
            "START": 0,
            "END": 10000,
            "WORD": "",
            "GET_DATA": "Get_RandomProducts",
            "ID1": id,
            "ID2": "",
            "ID3": "",
            "STATUS": "",
            "START_DATE": "",
            "END_DATE": "",
            "EXTRA1": "",
            "EXTRA2": "",
            "EXTRA3": "",
            "LANG_ID": langId
          }));

      if (response.statusCode >= 400) {
        throw Exception('Something went wrong!');
      }

      List<dynamic> productList = jsonDecode(response.body)['DATA'];

      return productList;
    } catch (error) {
      rethrow;
    }
  }

  static Future<Map<dynamic, dynamic>> getProductDetails(
      Map product, User user) async {
    var url = Uri.parse(
        'http://mycropguruapiwow.cropguru.in/api/ProductList?PRODUCT_ID=${product['PRODUCT_ID']}');
    try {
      var response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode({
            "START": 0,
            "END": 1000,
            "WORD": "None",
            "USER_ID": user.USER_ID,
            "LANG_ID": "3",
            "CAT_ID": product['PCAT_ID'],
            "TYPE": "Product",
            "SUBCAT_ID": product['PSUBCAT_ID'],
            "LATITUDE": "20.0086761",
            "ACCESS_TOKEN": "123456",
            "DISTRICT_ID": user.DISTRICT_ID,
            "TALUKA_ID": user.TALUKA_ID,
            "CROP_ID": "0",
            "PLOT_ID": "0",
            "SCHEDULE_ID": "0",
            "LONGITUDE": "73.7639122"
          }));

      if (response.statusCode >= 400) {
        throw Exception('Something went wrong!');
      }

      Map<dynamic, dynamic> productDetails = jsonDecode(response.body);

      return productDetails;
    } catch (error) {
      rethrow;
    }
  }

  static Future<bool> addQtyToCart(String userId, Map product, double qty, String task) async {
    var url = Uri.parse('http://mycropguruapiwow.cropguru.in/api/Cart');
    try {
      var response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode({
            "CART_ID": "1",
            "USER_ID":userId,
            "PRODUCT_ID":product['PRODUCT_ID'],
            "PS_ID":product['PSIZE_ID'],
            "QTY":qty,
            "TASK": "UPDATE",
            "EXTRA1": "",
            "EXTRA2": "",
            "EXTRA3": "",
            "LANG_ID": ""
          }));

      if (response.statusCode >= 400) {
        throw Exception('Something went wrong!');
      }

      // if(jsonDecode(response.body)['ResponseCode'] == 0){
      //   print('Task done');
      //   return true;
      // } else {
      //   throw Exception('Something went wrong!');
      // }
      return true;
    } catch (error) {
      rethrow;
    }
  }

  static Future<bool> addProductToCart(String userId, Map product, double qty, String task) async {
    var url = Uri.parse('http://mycropguruapiwow.cropguru.in/api/Cart');
    try {
      var response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode({
            "CART_ID": "1",
            "USER_ID":userId,
            "PRODUCT_ID":product['PRODUCT_ID'],
            "PS_ID":product['PS_ID'],
            "QTY":qty,
            "TASK": "UPDATE",
            "EXTRA1": "",
            "EXTRA2": "",
            "EXTRA3": "",
            "LANG_ID": ""
          }));

      if (response.statusCode >= 400) {
        throw Exception('Something went wrong!');
      }

      // if(jsonDecode(response.body)['ResponseCode'] == 0){
      //   print('Task done');
      //   return true;
      // } else {
      //   throw Exception('Something went wrong!');
      // }
      return true;
    } catch (error) {
      rethrow;
    }
  }

  static Future<List<dynamic>> getCartItems(String userId) async {
    var url = Uri.parse('http://mycropguruapiwow.cropguru.in/api/Get_Data');
    try {
      var response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode({
            "START": 0,
            "END": 500000000,
            "WORD": "NONE",
            "GET_DATA": "Get_MyCartList",
            "ID1": userId,
            "ID2": "",
            "ID3": "",
            "STATUS": "",
            "START_DATE": "",
            "END_DATE": "",
            "EXTRA1": "",
            "EXTRA2": "",
            "EXTRA3": "",
            "LANG_ID": ""
          }));

      if (response.statusCode >= 400) {
        throw Exception('Something went wrong!');
      }

      List<dynamic> cartItemList = jsonDecode(response.body)['DATA'];

      return cartItemList;
    } catch (error) {
      rethrow;
    }
  }

  static Future<bool> addReview(String productId, String userId, double rating, String ratingMessage) async {
    var url = Uri.parse('http://mycropguruapiwow.cropguru.in/api/Get_Data');
    try {
      var response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode({
            "UF_ID": "",
            "ORDER_ID": "",
            "PRODUCT_ID": productId,
            "USER_ID": userId,
            "RATING": rating,
            "RATING_MESSAGE": ratingMessage,
            "RATING_EMAIL": "",
            "TASK": "ADD",
            "EXTRA1": "",
            "EXTRA2": "",
            "EXTRA3": "",
            "LANG_ID": ""
          }));

      if (response.statusCode >= 400) {
        throw Exception('Something went wrong!');
      }

      return true;
    } catch (error) {
      rethrow;
    }
  }

  static Future<List<dynamic>> getAppVersion(String userId) async {
    var url = Uri.parse('http://mycropguruapiwow.cropguru.in/api/GetVersion?TYPE=1');
    try {
      var response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode({
            "MAC_ADDRESS": "",
            "USER_ID": userId
          }));

      if (response.statusCode >= 400) {
        throw Exception('Something went wrong!');
      }
      List<dynamic> cartItemList = jsonDecode(response.body)['DATA'];

      return cartItemList;
    } catch (error) {
      rethrow;
    }
  }

  static Future<List<dynamic>> getCoupons(String userId) async {
    var url = Uri.parse('http://mycropguruapiwow.cropguru.in/api/Get_Data');
    try {
      var response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode({
            "START": 0,
            "END": 500000000,
            "WORD": "",
            "GET_DATA": "Get_CoupenCodeList",
            "ID1": userId,
            "ID2": "",
            "ID3": "",
            "STATUS": "",
            "START_DATE": "",
            "END_DATE": "",
            "EXTRA1": "",
            "EXTRA2": "",
            "EXTRA3": "",
            "LANG_ID": ""
          }));

      if (response.statusCode >= 400) {
        throw Exception('Something went wrong!');
      }
      List<dynamic> cartItemList = jsonDecode(response.body)['DATA'];

      return cartItemList;
    } catch (error) {
      rethrow;
    }
  }

  static Future<List<dynamic>> getOrderList(String userId) async {
    var url = Uri.parse('http://mycropguruapiwow.cropguru.in/api/Get_Data');
    try {
      var response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode({
            "START": 0,
            "END": 500000000,
            "WORD": "NONE",
            "GET_DATA": "Get_MyOrderList",
            "ID1": userId,
            "ID2": "",
            "ID3": "",
            "STATUS": "",
            "START_DATE": "",
            "END_DATE": "",
            "EXTRA1": "",
            "EXTRA2": "",
            "EXTRA3": "",
            "LANG_ID": ""
          }));

      if (response.statusCode >= 400) {
        throw Exception('Something went wrong!');
      }
      List<dynamic> orderList = jsonDecode(response.body)['DATA'];

      return orderList;
    } catch (error) {
      rethrow;
    }
  }

  static Future<List<dynamic>> addOrder(Map<String, dynamic> orderDetails) async {
    var url = Uri.parse('http://mycropguruapiwow.cropguru.in/api/PlaceOrder');
    try {
      var response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode({
            "ORDER_ID": "",
            "USER_ID": orderDetails['USER_ID'],
            "TOTAL_PRICE": orderDetails['TOTAL_PRICE'],
            "TOTAL_DISC": orderDetails['TOTAL_DISC'],
            "TOTAL_QTY": orderDetails['TOTAL_QTY'],
            "ORDER_ADDRESS": orderDetails['ORDER_ADDRESS'],
            "ORDER_DATE": orderDetails['ORDER_DATE'],
            "COUPEN_ID": "",
            "COUPEN_CODE": "",
            "COUPEN_AMOUNT": "",
            "PAYMENT_METHOD": orderDetails['PAYMENT_METHOD'],     //"COD",
            "PAYMENT_TYPE": "",
            "GST_NO": "",
            "SHIPPING_CHARGES": orderDetails['SHIPPING_CHARGES'],
            "WALLET_AMOUNT": orderDetails['WALLET_AMOUNT'],
            "LATITUDE": "1",
            "LONGITUDE": "1",
            "TIME_SLOT": "",
            "ORDER_INSTRUCTION": "",
            "TRANSACTION_ID": "",
            "PAYMENT_STATUS": "",
            "TASK": "ADD",
            "EXTRA1": "",
            "EXTRA2": "",
            "EXTRA3": "",
            "LANG_ID": ""
          }));

      if (response.statusCode >= 400) {
        throw Exception('Something went wrong!');
      }
      List<dynamic> orderList = jsonDecode(response.body)['DATA'];

      return orderList;
    } catch (error) {
      rethrow;
    }
  }

}
