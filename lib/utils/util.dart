import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'network_connectivity.dart';

class Util {
  static Map<int, Color> color = {
    50: const Color(0xFF47964A),
    100: const Color(0xFF47964A),
    200: const Color(0xFF47964A),
    300: const Color(0xFF47964A),
    400: const Color(0xFF47964A),
    500: const Color(0xFF47964A),
    600: const Color(0xFF47964A),
    700: const Color(0xFF47964A),
    800: const Color(0xFF47964A),
    900: const Color(0xFF47964A),
  };

  static MaterialColor colorCustomPrimary = MaterialColor(0xFF47964A, color);

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  static Color colorPrimary = fromHex('#47964A');
  static Color newHomeColor = fromHex('#22A45D');
  static Color endColor = fromHex('#87DC69');
  static Color newBlueTextColor = fromHex('#03334F');
  static Color orangee = fromHex('#EF9920');
  static Color lightGreen = fromHex('#D1F4B6');

  // late AnimationController _controller;
  //
  // @override
  // void initState() {
  //   _controller = AnimationController(
  //     duration: const Duration(milliseconds: 3000),
  //     vsync: this,
  //   );
  //
  //   _controller.addListener(() {
  //     if (_controller.isCompleted) {
  //       _controller.reset();
  //       _controller.forward();
  //     }
  //   });
  //   super.initState();
  // }
  //
  // @override
  // void dispose() {
  //   _controller.dispose();
  //   super.dispose();
  // }

  static void animatedProgressDialog(
      BuildContext context, AnimationController controller) {
    showDialog<String>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(''),
          content: RotationTransition(
            turns: Tween(begin: 0.0, end: 1.0).animate(controller),
            child: Image.asset('assets/images/progress_image.png'),
          ),
        ),
      ),
    );
    controller.forward();
  }

  static List<Map<String, dynamic>> stateList = [
    {"STATE_ID": "27", "STATE_NAME": "MAHARASHTRA"},
    {"STATE_ID": "1", "STATE_NAME": "JAMMU & KASHMIR"},
    {"STATE_ID": "2", "STATE_NAME": "HIMACHAL PRADESH"},
    {"STATE_ID": "3", "STATE_NAME": "PUNJAB"},
    {"STATE_ID": "4", "STATE_NAME": "CHANDIGARH"},
    {"STATE_ID": "5", "STATE_NAME": "UTTARANCHAL"},
    {"STATE_ID": "6", "STATE_NAME": "HARYANA"},
    {"STATE_ID": "7", "STATE_NAME": "DELHI"},
    {"STATE_ID": "8", "STATE_NAME": "RAJASTHAN"},
    {"STATE_ID": "9", "STATE_NAME": "UTTAR"},
    {"STATE_ID": "10", "STATE_NAME": "BIHAR"},
    {"STATE_ID": "11", "STATE_NAME": "SIKKIM"},
    {"STATE_ID": "12", "STATE_NAME": "ARUNACHAL PRADESH"},
    {"STATE_ID": "13", "STATE_NAME": "NAGALAND"},
    {"STATE_ID": "14", "STATE_NAME": "MANIPUR"},
    {"STATE_ID": "15", "STATE_NAME": "MIZORAM"},
    {"STATE_ID": "16", "STATE_NAME": "TRIPURA"},
    {"STATE_ID": "17", "STATE_NAME": "MEGHALAYA"},
    {"STATE_ID": "18", "STATE_NAME": "ASSAM"},
    {"STATE_ID": "19", "STATE_NAME": "WEST BENGAL"},
    {"STATE_ID": "20", "STATE_NAME": "JHARKHAND"},
    {"STATE_ID": "21", "STATE_NAME": "ORISSA"},
    {"STATE_ID": "22", "STATE_NAME": "CHHATTISGARH"},
    {"STATE_ID": "23", "STATE_NAME": "MADHYA PRADESH"},
    {"STATE_ID": "24", "STATE_NAME": "GUJARAT"},
    {"STATE_ID": "25", "STATE_NAME": "DAMAN & DIU"},
    {"STATE_ID": "26", "STATE_NAME": "DADRA & NAGAR HAVELI"},
    {"STATE_ID": "28", "STATE_NAME": "ANDHRA PRADESH"},
    {"STATE_ID": "29", "STATE_NAME": "KARNATAKA"},
    {"STATE_ID": "30", "STATE_NAME": "GOA"},
    {"STATE_ID": "31", "STATE_NAME": "LAKSHADWEEP"},
    {"STATE_ID": "32", "STATE_NAME": "KERALA"},
    {"STATE_ID": "33", "STATE_NAME": "TAMIL NADU"},
    {"STATE_ID": "34", "STATE_NAME": "PONDICHERRY"},
    {"STATE_ID": "35", "STATE_NAME": "ANDAMAN & NICOBAR ISLANDS"},
  ];

  static bool checkInternetConnection() {
    Map _source = {ConnectivityResult.none: false};
    final NetworkConnectivity _networkConnectivity =
        NetworkConnectivity.instance;
    String string = '';
    _networkConnectivity.initialise();
    _networkConnectivity.myStream.listen((source) {
      _source = source;
      print('source $_source');
      // 1.
      switch (_source.keys.toList()[0]) {
        case ConnectivityResult.mobile:
          string =
              _source.values.toList()[0] ? 'Mobile: Online' : 'Mobile: Offline';
          break;
        case ConnectivityResult.wifi:
          string =
              _source.values.toList()[0] ? 'WiFi: Online' : 'WiFi: Offline';
          break;
        case ConnectivityResult.none:
        default:
          string = 'Offline';
      }
    });
    _networkConnectivity.disposeStream();

    if (string == 'Offline') {
      return false;
    }
    return true;
  }

  // final InternetConnectionChecker customInstance =
  // InternetConnectionChecker.createInstance(
  //   checkTimeout: const Duration(seconds: 1),
  //   checkInterval: const Duration(seconds: 1),
  // );
  //
  // customInstance.hasConnection.then((value) {
  // print(value);
  // if (value) {
  // Fluttertoast.showToast(
  // msg: "Online",
  // toastLength: Toast.LENGTH_SHORT,
  // gravity: ToastGravity.CENTER,
  // timeInSecForIosWeb: 1,
  // backgroundColor: Colors.black,
  // textColor: Colors.white,
  // fontSize: 16.0);
  // } else {
  // Fluttertoast.showToast(
  // msg: "You are offline",
  // toastLength: Toast.LENGTH_SHORT,
  // gravity: ToastGravity.CENTER,
  // timeInSecForIosWeb: 1,
  // backgroundColor: Colors.black,
  // textColor: Colors.white,
  // fontSize: 16.0);
  // }
  // });

  static Future<bool> isNetworkConnected() async{
    final InternetConnectionChecker customInstance =
    InternetConnectionChecker.createInstance(
      checkTimeout: const Duration(seconds: 1),
      checkInterval: const Duration(seconds: 1),
    );

    return customInstance.hasConnection;
  }
}
