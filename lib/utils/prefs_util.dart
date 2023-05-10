import 'package:dr_crop_guru/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsUtil {
  static Future<void> setUserDetailsFromResponse(List<dynamic> details) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    details[0].forEach((key, value) {
      Function temp = () async {
        if (value != null) {
          await prefs.setString(key, value.toString() ?? '');
        }
      };
      temp();
    });
  }

  static Future<void> setUserDetails(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (user.USER_ID != null) {
      await prefs.setString('USER_ID', user.USER_ID ?? '');
    }
    if (user.FULL_NAME != null) {
      await prefs.setString('FULL_NAME', user.FULL_NAME ?? '');
    }
    if (user.MOBILE_NO != null) {
      await prefs.setString('MOBILE_NO', user.MOBILE_NO ?? '');
    }
    if (user.REFERENCE_NO != null) {
      await prefs.setString('REFERENCE_NO', user.REFERENCE_NO ?? '');
    }
    if (user.ADDRESS != null) {
      await prefs.setString('ADDRESS', user.ADDRESS ?? '');
    }
    if (user.EMAIL != null) {
      await prefs.setString('EMAIL', user.EMAIL ?? '');
    }
    if (user.PASSWORD != null) {
      await prefs.setString('PASSWORD', user.PASSWORD ?? '');
    }
    if (user.TOKEN != null) {
      await prefs.setString('TOKEN', user.TOKEN ?? '');
    }
    if (user.PROFILE_PHOTO != null) {
      await prefs.setString('PROFILE_PHOTO', user.PROFILE_PHOTO ?? '');
    }
    if (user.DISTRICT_NAME != null) {
      await prefs.setString('DISTRICT_NAME', user.DISTRICT_NAME ?? '');
    }
    if (user.TALUKA_NAME != null) {
      await prefs.setString('TALUKA_NAME', user.TALUKA_NAME ?? '');
    }
    if (user.C_PIN != null) {
      await prefs.setString('C_PIN', user.C_PIN ?? '');
    }
    if (user.MAC_ADDRESS != null) {
      await prefs.setString('MAC_ADDRESS', user.MAC_ADDRESS ?? '');
    }
    if (user.FROM_DATE != null) {
      await prefs.setString('FROM_DATE', user.FROM_DATE ?? '');
    }
    if (user.TO_DATE != null) {
      await prefs.setString('TO_DATE', user.TO_DATE ?? '');
    }
    if (user.DOB != null) {
      await prefs.setString('DOB', user.DOB ?? '');
    }
    if (user.STATUS != null) {
      await prefs.setString('STATUS', user.STATUS ?? '');
    }
    if (user.REG_DATE != null) {
      await prefs.setString('REG_DATE', user.REG_DATE ?? '');
    }
    if (user.HUA_ID != null) {
      await prefs.setString('HUA_ID', user.HUA_ID ?? '');
    }
    if (user.STATE_ID != null) {
      await prefs.setString('STATE_ID', user.STATE_ID ?? '');
    }
    if (user.VILLAGE_ID != null) {
      await prefs.setString('VILLAGE_ID', user.VILLAGE_ID ?? '');
    }
    if (user.BANK_NAME != null) {
      await prefs.setString('BANK_NAME', user.BANK_NAME ?? '');
    }
    if (user.ACC_HOLDER_NAME != null) {
      await prefs.setString('ACC_HOLDER_NAME', user.ACC_HOLDER_NAME ?? '');
    }
    if (user.ACC_NO != null) {
      await prefs.setString('ACC_NO', user.ACC_NO ?? '');
    }
    if (user.IFSC_CODE != null) {
      await prefs.setString('IFSC_CODE', user.IFSC_CODE ?? '');
    }
    if (user.BRANCH_NAME != null) {
      await prefs.setString('BRANCH_NAME', user.BRANCH_NAME ?? '');
    }
    if (user.DISTRICT_ID != null) {
      await prefs.setString('DISTRICT_ID', user.DISTRICT_ID ?? '');
    }
    if (user.TALUKA_ID != null) {
      await prefs.setString('TALUKA_ID', user.TALUKA_ID ?? '');
    }
    if (user.PAYMETAMT != null) {
      await prefs.setString('PAYMETAMT', user.PAYMETAMT ?? '');
    }
    if (user.PAYMETDATE != null) {
      await prefs.setString('PAYMETDATE', user.PAYMETDATE ?? '');
    }
    if (user.PAYMETSTATUS != null) {
      await prefs.setString('PAYMETSTATUS', user.PAYMETSTATUS ?? '');
    }
    if (user.TRANSACTION_ID != null) {
      await prefs.setString('TRANSACTION_ID', user.TRANSACTION_ID ?? '');
    }
    if (user.BPCL_TRANSACTION_ID != null) {
      await prefs.setString(
          'BPCL_TRANSACTION_ID', user.BPCL_TRANSACTION_ID ?? '');
    }
    if (user.ALT_MOB_NO != null) {
      await prefs.setString('ALT_MOB_NO', user.ALT_MOB_NO ?? '');
    }
    if (user.DETAILS_ADDRESS != null) {
      await prefs.setString('DETAILS_ADDRESS', user.DETAILS_ADDRESS ?? '');
    }
    if (user.ABOUT_INFO != null) {
      await prefs.setString('ABOUT_INFO', user.ABOUT_INFO ?? '');
    }
    if (user.CITY_NAME != null) {
      await prefs.setString('CITY_NAME', user.CITY_NAME ?? '');
    }
    if (user.STATE_NAME != null) {
      await prefs.setString('STATE_NAME', user.STATE_NAME ?? '');
    }
    if (user.AGRONOMIST_ID != null) {
      await prefs.setString('AGRONOMIST_ID', user.AGRONOMIST_ID ?? '');
    }
    if (user.USER_PAYMENTSTATUS != null) {
      await prefs.setString(
          'USER_PAYMENTSTATUS', user.USER_PAYMENTSTATUS ?? '');
    }
    if (user.VENDOR_PAYMENTSTATUS != null) {
      await prefs.setString(
          'VENDOR_PAYMENTSTATUS', user.VENDOR_PAYMENTSTATUS ?? '');
    }
    if (user.IS_VENDOR != null) {
      await prefs.setString('IS_VENDOR', user.IS_VENDOR ?? '');
    }
    if (user.REFERENCE_NOFINAL != null) {
      await prefs.setString('REFERENCE_NOFINAL', user.REFERENCE_NOFINAL ?? '');
    }
    if (user.AVL_BAL != null) {
      await prefs.setString('AVL_BAL', user.AVL_BAL ?? '');
    }
    if (user.LONGITUDE != null) {
      await prefs.setString('LONGITUDE', user.LONGITUDE ?? '');
    }
    if (user.LATITUDE != null) {
      await prefs.setString('LATITUDE', user.LATITUDE ?? '');
    }
    if (user.VILLAGE_NAME != null) {
      await prefs.setString('VILLAGE_NAME', user.VILLAGE_NAME ?? '');
    }
  }

  static Future<User> getUserDetails() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return User(
      USER_ID: prefs.getString('USER_ID'),
      FULL_NAME: prefs.getString('FULL_NAME'),
      MOBILE_NO: prefs.getString('MOBILE_NO'),
      REFERENCE_NO: prefs.getString('REFERENCE_NO'),
      ADDRESS: prefs.getString('ADDRESS'),
      EMAIL: prefs.getString('EMAIL'),
      PASSWORD: prefs.getString('PASSWORD'),
      TOKEN: prefs.getString('TOKEN'),
      PROFILE_PHOTO: prefs.getString('PROFILE_PHOTO'),
      DISTRICT_NAME: prefs.getString('DISTRICT_NAME'),
      TALUKA_NAME: prefs.getString('TALUKA_NAME'),
      C_PIN: prefs.getString('C_PIN'),
      MAC_ADDRESS: prefs.getString('MAC_ADDRESS'),
      FROM_DATE: prefs.getString('FROM_DATE'),
      TO_DATE: prefs.getString('TO_DATE'),
      DOB: prefs.getString('DOB'),
      STATUS: prefs.getString('STATUS'),
      REG_DATE: prefs.getString('REG_DATE'),
      HUA_ID: prefs.getString('HUA_ID'),
      STATE_ID: prefs.getString('STATE_ID'),
      VILLAGE_ID: prefs.getString('VILLAGE_ID'),
      BANK_NAME: prefs.getString('BANK_NAME'),
      ACC_HOLDER_NAME: prefs.getString('ACC_HOLDER_NAME'),
      ACC_NO: prefs.getString('ACC_NO'),
      IFSC_CODE: prefs.getString('IFSC_CODE'),
      BRANCH_NAME: prefs.getString('BRANCH_NAME'),
      DISTRICT_ID: prefs.getString('DISTRICT_ID'),
      TALUKA_ID: prefs.getString('TALUKA_ID'),
      PAYMETAMT: prefs.getString('PAYMETAMT'),
      PAYMETDATE: prefs.getString('PAYMETDATE'),
      PAYMETSTATUS: prefs.getString('PAYMETSTATUS'),
      TRANSACTION_ID: prefs.getString('TRANSACTION_ID'),
      BPCL_TRANSACTION_ID: prefs.getString('BPCL_TRANSACTION_ID'),
      ALT_MOB_NO: prefs.getString('ALT_MOB_NO'),
      DETAILS_ADDRESS: prefs.getString('DETAILS_ADDRESS'),
      ABOUT_INFO: prefs.getString('ABOUT_INFO'),
      CITY_NAME: prefs.getString('CITY_NAME'),
      STATE_NAME: prefs.getString('STATE_NAME'),
      AGRONOMIST_ID: prefs.getString('AGRONOMIST_ID'),
      USER_PAYMENTSTATUS: prefs.getString('USER_PAYMENTSTATUS'),
      VENDOR_PAYMENTSTATUS: prefs.getString('VENDOR_PAYMENTSTATUS'),
      IS_VENDOR: prefs.getString('IS_VENDOR'),
      REFERENCE_NOFINAL: prefs.getString('REFERENCE_NOFINAL'),
      AVL_BAL: prefs.getString('AVL_BAL'),
      VILLAGE_NAME: prefs.getString('VILLAGE_NAME'),
    );
  }

  static Future<void> removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    User.userParams.forEach((element) {
      Function temp = () async {
        await prefs.remove('element');
      };
      temp();
    });

    await prefs.remove('OTPVerified');
    await prefs.remove('AddressUploaded');

    await prefs.remove('state');
    await prefs.remove('district');
    await prefs.remove('taluka');
    await prefs.remove('village_name');
    await prefs.remove('pin_code');
    await prefs.remove('address');

    removeCurrentAppliedCoupon();
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

  static Future<bool> setDeliveryAddress(Map<dynamic, dynamic> values) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('state', values['state']);
    await prefs.setString('district', values['district']);
    await prefs.setString('taluka', values['taluka']);
    await prefs.setString('village_name', values['village_name']);
    await prefs.setString('pin_code', values['pin_code']);
    await prefs.setString('address', values['address']);
    return true;
  }

  static Future<Map<dynamic, dynamic>> getDeliveryAddress() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return {
      'state': await prefs.getString('state'),
      'district': await prefs.getString('district'),
      'taluka' : await prefs.getString('taluka'),
      'village_name': await prefs.getString('village_name'),
      'pin_code': await prefs.getString('pin_code'),
      'address': await prefs.getString('address'),
    };
  }

  static Future<bool> setCurrentAppliedCoupon(Map<dynamic, dynamic> values) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    values.forEach((key, value) async {
      await prefs.setString(key, value.toString());
    });
    return true;
  }

  static Future<Map<dynamic, dynamic>> getCurrentAppliedCoupon() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return {
      'COUPEN_CODE': await prefs.getString('COUPEN_CODE'),
      'COUPEN_AMOUNT': await prefs.getString('COUPEN_AMOUNT'),
      'FIXED_OR_PERCENTAGE' : await prefs.getString('FIXED_OR_PERCENTAGE'),
      'DESCRIPTION': await prefs.getString('DESCRIPTION'),
    };
  }

  static Future<void> removeCurrentAppliedCoupon() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('COUPEN_ID');
    await prefs.remove('COUPEN_CODE');
    await prefs.remove('COUPEN_AMOUNT');
    await prefs.remove('FIXED_OR_PERCENTAGE');
    await prefs.remove('COUPEN_TYPE');
    await prefs.remove('COUPEN_COUNT');
    await prefs.remove('FROM_DATE');
    await prefs.remove('TO_DATE');
    await prefs.remove('DESCRIPTION');
    await prefs.remove('TAC');
    await prefs.remove('STATUS');
    await prefs.remove('REG_DATE');
  }

}
