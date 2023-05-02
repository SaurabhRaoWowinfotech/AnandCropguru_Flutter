import 'package:dr_crop_guru/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsUtil {
  static Future<void> setUserDetails(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (user.userID != null) {
      await prefs.setString('userID', user.userID ?? '');
    }
    if (user.fullName != null) {
      await prefs.setString('fullName', user.fullName ?? '');
    }
    if (user.mobileNo != null) {
      await prefs.setString('mobileNo', user.mobileNo ?? '');
    }
    if (user.referenceNo != null) {
      await prefs.setString('referenceNo', user.referenceNo ?? '');
    }
    if (user.address != null) {
      await prefs.setString('address', user.address ?? '');
    }
    if (user.email != null) {
      await prefs.setString('email', user.email ?? '');
    }
    if (user.longitude != null) {
      await prefs.setString('longitude', user.longitude ?? '');
    }
    if (user.latitude != null) {
      await prefs.setString('latitude', user.latitude ?? '');
    }
    if (user.stateName != null) {
      await prefs.setString('stateName', user.stateName ?? '');
    }
  }

  static Future<User> getUserDetails() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return User(
      userID: prefs.getString('userID'),
      fullName: prefs.getString('fullName'),
      mobileNo: prefs.getString('mobileNo'),
      referenceNo: prefs.getString('referenceNo'),
      address: prefs.getString('address'),
      email: prefs.getString('email'),
      longitude: prefs.getString('longitude'),
      latitude: prefs.getString('latitude'),
      stateName: prefs.getString('stateName'),
    );
  }

  static Future<void> removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('userID');
    await prefs.remove('fullName');
    await prefs.remove('mobileNo');
    await prefs.remove('referenceNo');
    await prefs.remove('address');
    await prefs.remove('email');
    await prefs.remove('longitude');
    await prefs.remove('latitude');
    await prefs.remove('stateName');

    await prefs.remove('OTPVerified');
    await prefs.remove('AddressUploaded');

  }

  static Future<void> setOTPVerified() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('OTPVerified', true);
  }

  static Future<bool> getOTPVerified() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('OTPVerified') ?? false;
  }

  static Future<void> setAddressUploaded() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('AddressUploaded', true);
  }

  static Future<bool> getAddressUploaded() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('AddressUploaded') ?? false;
  }
}
