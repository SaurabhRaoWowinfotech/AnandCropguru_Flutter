import 'dart:async';

import 'package:dr_crop_guru/home_page.dart';
import 'package:dr_crop_guru/screens/address_screen.dart';
import 'package:dr_crop_guru/screens/login_screen.dart';
import 'package:dr_crop_guru/screens/select_language_screen.dart';
import 'package:dr_crop_guru/test.dart';
import 'package:dr_crop_guru/utils/prefs_util.dart';
import 'package:dr_crop_guru/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late Timer timer;

  void startTimer() {
    timer = Timer(Duration(seconds: 3), () {
      _controller.stop();

      // bool OTPVerified = false;
      // bool addressUploaded = false;
      //
      // Function getProgress = () async {
      //   OTPVerified = await PrefsUtil.getOTPVerified();
      //   addressUploaded = await PrefsUtil.getAddressUploaded();
      // };
      //
      // getProgress();
      // PrefsUtil.removeUser().then((value) {
      // PrefsUtil.getOTPVerified().then((value) {
      //   if (!value) {
      //     Navigator.pushReplacementNamed(context, LoginScreen.routeName);
      //     return;
      //   }
      //   PrefsUtil.getAddressUploaded().then((value) {
      //     if (!value) {
      //       Navigator.pushReplacementNamed(context, AddressScreen.routeName);
      //       return;
      //     }
      //     Navigator.pushReplacementNamed(context, HomePage.routeName);
      //   });
      // });
      Navigator.of(context).pushReplacementNamed(HomePage.routeName);
      // });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(
        seconds: 6,
      ),
      vsync: this,
      value: 0.1,
    )..repeat(
        reverse: false,
      );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.decelerate,
    );

    Util.isNetworkConnected().then((value) {
      if (value) {
        startTimer();
      } else {
        // timer.cancel();
        // _controller.reset();
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return WillPopScope(
              onWillPop: () async => false,
              child: AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25))),
                contentPadding: EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 5),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Util.colorPrimary,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25))),
                      height: 70,
                      width: double.infinity,
                      child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'No internet connection',
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          )),
                    ),
                    SizedBox(height: 15),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                          'It looks like your internet connection is off. Please turn it on and try again',
                          textAlign: TextAlign.center, style: TextStyle(color: Colors.black54, fontSize: 14),),
                    ),
                    SizedBox(height: 15),
                    SizedBox(
                      width: 150,
                      child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(width: 2, color: Util.colorPrimary),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SplashScreen(),
                                ));
                          },
                          child: Text('OK')),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Container(
            height: 250,
            width: 250,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    // gradient: RadialGradient(
                    //   colors: [
                    //     Util.endColor,
                    //     Util.colorPrimary,
                    //   ],
                    // ),
                  ),
                ),
                ScaleTransition(
                  scale: _animation,
                  child: Image.asset('assets/images/splash_logo.png'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
