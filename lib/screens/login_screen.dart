//pending:
//OTP throw error handling

import 'package:dr_crop_guru/models/user.dart';
import 'package:dr_crop_guru/screens/address_screen.dart';
import 'package:dr_crop_guru/utils/prefs_util.dart';
import 'package:intl/intl.dart';
import 'dart:async';

import 'package:dr_crop_guru/home_page.dart';
import 'package:dr_crop_guru/models/otp_response.dart';
import 'package:dr_crop_guru/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../utils/util.dart';

class LoginScreen extends StatefulWidget {
  static final routeName = '/login-screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  bool isChecked = false;

  TextEditingController _name = TextEditingController();
  TextEditingController _mobile = TextEditingController();

  bool _nameValidated = true;
  bool _mobileValidated = true;

  String? _nameError = null;
  String? _mobileError = null;

  late String userName;
  late String mobileNo;

  bool validate() {
    if (_name.text.trim().isEmpty) {
      setState(() {
        _nameValidated = false;
        _nameError = 'Please enter your name';
      });
      return false;
    }

    if (_name.text.trim().length < 3) {
      setState(() {
        _nameValidated = false;
        _nameError = 'Please enter more than 3 characters in full name';
      });
      return false;
    }

    if (_mobile.text.trim().isEmpty) {
      setState(() {
        _mobileValidated = false;
        _mobileError = 'Please enter mobile no';
      });

      return false;
    }

    if (_mobile.text.trim().length < 10 ||
        _mobile.text.trim().length > 10 ||
        !['6', '7', '8', '9'].contains(_mobile.text.trim()[0])) {
      setState(() {
        _mobileValidated = false;
        _mobileError = 'Please enter valid mobile no';
      });
      return false;
    }

    if (!isChecked) {
      Fluttertoast.showToast(
          msg: 'Please accept terms and conditions',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);

      return false;
    }

    return true;
  }

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );

    _controller.addListener(() {
      if (_controller.isCompleted) {
        _controller.reset();
        _controller.forward();
      }
    });
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Util.colorPrimary,
    ));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   statusBarColor: Colors.transparent,
    // ));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 160,
            ),
            Container(
              height: 200,
              width: 200,
              child: Image.asset('assets/images/anand_crop_guru_logo.png'),
            ),
            SizedBox(
              height: 35,
            ),
            Container(
              // height: 50,
              margin: EdgeInsets.symmetric(horizontal: 25, vertical: 9),
              child: TextField(
                onChanged: (value) {
                    if(!_nameValidated){
                      setState(() {
                        _nameValidated = true;
                      });
                    }
                },
                controller: _name,
                decoration: InputDecoration(
                  errorText: _nameValidated ? null : _nameError,
                  suffixIcon: Icon(Icons.person),
                  hintText: 'Your name',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Util.colorPrimary,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
            ),
            Container(
              // height: 50,
              margin: EdgeInsets.symmetric(horizontal: 25, vertical: 9),
              child: TextField(
                onChanged: (value) {
                  if(!_mobileValidated){
                    setState(() {
                      _mobileValidated = true;
                    });
                  }
                },
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                maxLength: 10,
                controller: _mobile,
                decoration: InputDecoration(
                  errorText: _mobileValidated ? null : _mobileError,
                  suffixIcon: Icon(Icons.call),
                  hintText: 'Mobile no',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Util.colorPrimary,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Checkbox(
                  checkColor: Colors.white,
                  activeColor: Util.colorPrimary,
                  side: BorderSide(width: 2, color: Util.colorPrimary),
                  value: isChecked,
                  onChanged: (value) {
                    setState(() {
                      isChecked = !isChecked;
                    });
                  },
                ),
                Text('I agree to Terms & Conditions',
                    style: TextStyle(
                      color: Util.colorPrimary,
                      fontWeight: FontWeight.bold,
                    )),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.white, width: 1.3),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 3,
                    offset: Offset(0.0, 1.0),
                  ),
                ],
                gradient: LinearGradient(
                  colors: [
                    Colors.green,
                    Util.endColor,
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: SizedBox(
                height: 45,
                width: 160,
                child: ElevatedButton(
                  onPressed: () {
                    String mobileNumber = _mobile.text.trim().toString();
                    if (validate()) {
                      userName = _name.text.toString().trim();
                      mobileNo = _mobile.text.toString().trim();
                      Function fun = () async {
                        var dialogContext;
                        showDialog(context: context, builder: (context) {
                          dialogContext = context;
                          return WillPopScope(
                            onWillPop: () async => false,
                            child: AlertDialog(
                              surfaceTintColor: Colors.transparent,
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                              content: RotationTransition(
                                turns: Tween(begin: 0.0, end: 1.0)
                                    .animate(_controller),
                                child: Image.asset(
                                    'assets/images/progress_image.png'),
                              ),
                            ),
                          );
                        },);
                        _controller.forward();
                        OTPResponse response = await Services.getOTP(mobileNumber).then((value) {
                          Navigator.pop(dialogContext);
                          showDialog(barrierDismissible: false ,context: context, builder: (context) {
                            return customAlertDialog(userName, _mobile.text.toString().trim(), value);
                          });
                          return value;
                        }).catchError((){
                          Fluttertoast.showToast(
                              msg: "Something went wrong!",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.black,
                              textColor: Colors.white,
                              fontSize: 16.0
                          );
                        });
                      };
                      fun();
                    }
                  },
                  child: Text(
                    'LOGIN',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    shadowColor: Colors.black54,
                    splashFactory: NoSplash.splashFactory,
                    backgroundColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class customAlertDialog extends StatefulWidget{
  String fullName;
  String mobileNumber;
  OTPResponse response;

  customAlertDialog(this.fullName, this.mobileNumber, this.response);

  @override
  State<customAlertDialog> createState() => _customAlertDialogState();
}

class _customAlertDialogState extends State<customAlertDialog> with TickerProviderStateMixin{
  TextEditingController otpTextController = TextEditingController();
  bool isTimerOn = true;
  bool isResending = false;

  void toggleIsTimerOn(){
    setState(() {
      isTimerOn = !isTimerOn;
    });
  }

  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );

    _controller.addListener(() {
      if (_controller.isCompleted) {
        _controller.reset();
        _controller.forward();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      content: Container(
        height: 500,
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.center,
          children: [
            Container(
              color: Util.colorPrimary,
              width: double.infinity,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      right: 15,
                    ),
                    child: Align(
                      alignment:
                      Alignment.centerRight,
                      child: SizedBox(
                        height: 30,
                        width: 30,
                        child: IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: Icon(
                            Icons.close,
                            size: 25,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 80,
                    width: 80,
                    child: Image.asset(
                        'assets/images/crop_guru_logo.png'),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: Image.asset(
                        'assets/images/otp.png',
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              child: Text(
                'We have sent you OTP code via SMS for mobile number verification on',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Text(
                '+91-${widget.mobileNumber}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              height: 70,
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                maxLength: 4,
                controller: otpTextController,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: '- - - -',
                  hintStyle: TextStyle(fontSize: 18),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
            // Container(
            //   height: 50,
            //   margin: EdgeInsets.symmetric(
            //     horizontal: 40,
            //   ),
            //   // padding: EdgeInsets.only(top: 15),
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.all(
            //         Radius.circular(30)),
            //     border: Border.all(
            //       width: 1.5,
            //       color: Colors.black,
            //     ),
            //   ),
            //   child: Container(
            //     height: 30,
            //     child: TextField(
            //       keyboardType: TextInputType.number,
            //       inputFormatters: <TextInputFormatter>[
            //         FilteringTextInputFormatter.digitsOnly
            //       ],
            //       maxLength: 4,
            //       controller: otpTextController,
            //       textAlign: TextAlign.center,
            //       decoration: InputDecoration(
            //         border: InputBorder.none,
            //         hintText: '- - - -',
            //         hintStyle: TextStyle(fontSize: 18),
            //       ),
            //     ),
            //   ),
            // ),

            isTimerOn ? timerText(toggleIsTimerOn) :
            Container(
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.center,
                children: [
                  Text('Didn\'t received code'),
                  TextButton(
                    onPressed: () {
                      //Resend logic
                      // setState(() {
                      //   isResending = true;
                      // });
                      Util.animatedProgressDialog(context, _controller);
                      Function temp = () async {
                        widget.response = await Services.getOTP(widget.mobileNumber).then((value) {
                          Navigator.of(context).pop();
                          setState(() {
                            isResending = false;
                            isTimerOn = true;
                          });
                          return value;
                        });
                      };
                      temp();

                    },
                    child: isResending ? Container( height: 20, width: 20, child: CircularProgressIndicator()) : Text(
                      'Resend',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            SizedBox(
              width: 150,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Util.colorPrimary,
                  shape: StadiumBorder(),
                ),
                onPressed: () {
                  String otp = otpTextController.text.toString().trim();

                  if(otp.isEmpty){
                    Fluttertoast.showToast(
                        msg: 'Please enter otp number',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                        fontSize: 16.0);

                    return;
                  }

                  if(otp == widget.response.staticOTP || otp == widget.response.uniqueOTP){
                    Util.animatedProgressDialog(context, _controller);
                    //Calling registration API
                    Services.getUser(widget.fullName, widget.mobileNumber).then((value) {
                      PrefsUtil.setUserDetailsFromResponse(value).then((value) {
                        PrefsUtil.setOTPVerified();
                      });
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      if(value[0]['STATE_NAME'] == null){
                        Navigator.pushReplacementNamed(context, AddressScreen.routeName);
                      } else {
                        PrefsUtil.setAddressUploaded();
                        Navigator.pushReplacementNamed(context, HomePage.routeName);
                      }
                    });

                    return;
                  }

                  Fluttertoast.showToast(
                      msg: 'Please enter valid otp',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                      fontSize: 16.0);

                  return;

                },
                child: Text(
                  'Verify',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class timerText extends StatefulWidget{
  Function toggleTimerOn;

  timerText(this.toggleTimerOn);

  @override
  State<timerText> createState() => _timerTextState();
}

class _timerTextState extends State<timerText> {
  late Timer _timer;
  int _start = 44;

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            widget.toggleTimerOn();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    NumberFormat formatter = new NumberFormat('00');
    return Text('00:${formatter.format(_start)}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),);
  }
}