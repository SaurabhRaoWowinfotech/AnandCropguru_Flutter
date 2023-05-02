import 'package:dr_crop_guru/Demo/Ploat.dart';
import 'package:dr_crop_guru/home_page.dart';
import 'package:dr_crop_guru/screens/address_screen.dart';
import 'package:dr_crop_guru/screens/home_screen.dart';
import 'package:dr_crop_guru/screens/login_screen.dart';
import 'package:dr_crop_guru/screens/select_language_screen.dart';
import 'package:dr_crop_guru/screens/splash_screen.dart';
import 'package:dr_crop_guru/test.dart';
import 'package:dr_crop_guru/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'Componts/LocalString.dart';
import 'Componts/MyFarms.dart';
import 'Componts/weather.dart';
import 'Demo/LangDemo.dart';
import 'Demo/date_time.dart';

void main() {

  runApp(const MyApp());
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: Messages(),
      locale: Locale('en,US'),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Util.colorCustomPrimary,
        appBarTheme: AppBarTheme(
          color: Util.newHomeColor,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Util.newHomeColor,
          ),
        ),
      ),
      home: const SplashScreen(),
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        HomePage.routeName: (context) =>HomePage(),
        SelectLanguageScreen.routeName: (context) => SelectLanguageScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
        AddressScreen.routeName: (context) => AddressScreen(),
        Test.routeName: (context) => Test(),
      },
    );
  }
}
