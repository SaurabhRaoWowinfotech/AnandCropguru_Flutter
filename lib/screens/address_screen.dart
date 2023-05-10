import 'package:dr_crop_guru/home_page.dart';
import 'package:dr_crop_guru/services.dart';
import 'package:dr_crop_guru/utils/prefs_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../models/user.dart';
import '../utils/util.dart';

class AddressScreen extends StatefulWidget {
  static String routeName = '/address-screen';

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen>
    with TickerProviderStateMixin {
  TextEditingController villageNameController =TextEditingController();

  String selectedStateName = 'not set';
  String selectedStateID = 'not set';

  void selectState(String stateName, String stateID) {
    setState(() {
      selectedStateName = stateName;
      selectedDistrictName = 'not set';
      selectedTalukaName = 'not set';
      villageNameController.clear();
      FocusManager.instance.primaryFocus?.unfocus();
    });
    selectedStateID = stateID;
  }

  String selectedDistrictName = 'not set';
  String selectedDistrictID = 'not set';

  void selectDistrict(String districtName, String districtID) {
    setState(() {
      selectedDistrictName = districtName;
      selectedTalukaName = 'not set';
      villageNameController.clear();
      FocusManager.instance.primaryFocus?.unfocus();
    });
    selectedDistrictID = districtID;
  }

  String selectedTalukaName = 'not set';
  String selectedTalukaID = 'not set';

  void selectTaluka(String talukaName, String talukaID) {
    setState(() {
      selectedTalukaName = talukaName;
      villageNameController.clear();
      FocusManager.instance.primaryFocus?.unfocus();
    });
    selectedTalukaID = talukaID;
  }

  late AnimationController _controller;

  void showProgressIndicator() {
    showDialog(
      context: context,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            surfaceTintColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            elevation: 0,
            content: RotationTransition(
              turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
              child: Image.asset('assets/images/progress_image.png'),
            ),
          ),
        );
      },
    );
    _controller.forward();
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
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 100,
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 200,
                width: 200,
                child: Image.asset('assets/images/anand_crop_guru_logo.png'),
              ),
            ),
            Text(
              'Select State :',
              style: TextStyle(color: Util.colorPrimary),
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return SelectStateDialog(selectState);
                  },
                );
              },
              child: Container(
                margin: EdgeInsets.only(top: 10),
                height: 45,
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                    border: Border.all(width: 1, color: Util.colorPrimary)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    selectedStateName == 'not set'
                        ? Text('State')
                        : Text(selectedStateName),
                    Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Select District :',
              style: TextStyle(color: Util.colorPrimary),
            ),
            GestureDetector(
              onTap: () {
                if (selectedStateName == 'not set') {
                  Fluttertoast.showToast(
                      msg: "Select state",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                      fontSize: 16.0);
                  return;
                }
                if (selectedStateID == 'not set') {
                  Fluttertoast.showToast(
                      msg: "Something went wrong!",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                      fontSize: 16.0);

                  return;
                }

                showProgressIndicator();
                Services.getDistricts(selectedStateID).then((value) {
                  Navigator.of(context).pop();
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return SelectDistrictDialog(selectDistrict, value);
                    },
                  );
                });
              },
              child: Container(
                margin: EdgeInsets.only(top: 10),
                height: 45,
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                    border: Border.all(width: 1, color: Util.colorPrimary)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    selectedDistrictName == 'not set'
                        ? Text('District')
                        : Text(selectedDistrictName),
                    Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Select Taluka :',
              style: TextStyle(color: Util.colorPrimary),
            ),
            GestureDetector(
              onTap: () {
                if (selectedStateName == 'not set') {
                  Fluttertoast.showToast(
                      msg: "Select state",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                      fontSize: 16.0);
                  return;
                }
                if (selectedStateID == 'not set') {
                  Fluttertoast.showToast(
                      msg: "Something went wrong!",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                      fontSize: 16.0);

                  return;
                }
                if (selectedDistrictName == 'not set') {
                  Fluttertoast.showToast(
                      msg: "Select district",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                      fontSize: 16.0);
                  return;
                }

                showProgressIndicator();
                Services.getTalukaList(selectedStateID, selectedDistrictID, '3')
                    .then((value) {
                  Navigator.of(context).pop();
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return SelectTalukaDialog(selectTaluka, value);
                    },
                  );
                });
              },
              child: Container(
                margin: EdgeInsets.only(top: 10),
                height: 45,
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                    border: Border.all(width: 1, color: Util.colorPrimary)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    selectedTalukaName == 'not set'
                        ? Text('Taluka')
                        : Text(selectedTalukaName),
                    Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Enter Village Name :',
              style: TextStyle(color: Util.colorPrimary),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              height: 45,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                  border: Border.all(width: 1, color: Util.colorPrimary)),
              child: TextField(
                controller: villageNameController,
                decoration: InputDecoration(
                    hintText: 'Village name', border: InputBorder.none),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
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
                  width: 180,
                  child: ElevatedButton(
                    onPressed: () {
                      if (selectedStateName == 'not set') {
                        Fluttertoast.showToast(
                            msg: "Please select state",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.black,
                            textColor: Colors.white,
                            fontSize: 16.0);
                        return;
                      }

                      if (selectedDistrictName == 'not set') {
                        Fluttertoast.showToast(
                            msg: "Please select district",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.black,
                            textColor: Colors.white,
                            fontSize: 16.0);

                        return;
                      }

                      if (selectedTalukaName == 'not set') {
                        Fluttertoast.showToast(
                            msg: "Please select Taluka",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.black,
                            textColor: Colors.white,
                            fontSize: 16.0);

                        return;
                      }

                      if (villageNameController.text.toString().trim().isEmpty) {
                        Fluttertoast.showToast(
                            msg: "Please enter village name",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.black,
                            textColor: Colors.white,
                            fontSize: 16.0);

                        return;
                      }

                      if (villageNameController.text.toString().trim().length < 3) {
                        Fluttertoast.showToast(
                            msg: "Please enter more than 3 characters in village name",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.black,
                            textColor: Colors.white,
                            fontSize: 16.0);

                        return;
                      }

                      showProgressIndicator();

                      User user;
                      Function temp = () async{
                        user = await PrefsUtil.getUserDetails().then((value){
                          value.STATE_ID = selectedStateID;
                          value.STATE_NAME = selectedStateName;
                          value.DISTRICT_ID = selectedDistrictID;
                          value.DISTRICT_NAME = selectedDistrictName;
                          value.TALUKA_ID = selectedTalukaID;
                          value.TALUKA_NAME = selectedTalukaName;
                          value.VILLAGE_NAME = villageNameController.text.toString().trim();
                          return value;
                        });
                        PrefsUtil.setUserDetails(user);

                        await Services.updateUserDetails(user).then((value) {
                          if(value){
                            PrefsUtil.setAddressUploaded();
                            Navigator.of(context).pop();
                            Navigator.of(context).pushReplacementNamed(HomePage.routeName);
                          } else {
                            Fluttertoast.showToast(
                                msg: 'Something went wrong!',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.black,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }
                          return value;
                        }).catchError((){
                          Fluttertoast.showToast(
                              msg: 'Something went wrong!',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.black,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        });
                      };
                      temp();
                    },
                    child: Text(
                      'Submit',
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
            ),
          ],
        ),
      ),
    );
  }
}

class SelectStateDialog extends StatelessWidget {
  Function selectState;

  SelectStateDialog(this.selectState);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      contentPadding: EdgeInsets.all(10),
      content: Stack(
        children: [
          Container(
            height: 450,
            width: double.infinity,
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Select State :',
                  style: TextStyle(fontSize: 21),
                ),
                Container(
                  margin: EdgeInsets.only(left: 15, right: 15, top: 15),
                  height: 40,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 1.0), //(x,y)
                          blurRadius: 3.0,
                        ),
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(3))),
                  child: TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search',
                        suffixIcon: Icon(Icons.close, color: Colors.grey)),
                  ),
                ),
                // Expanded(child: Container(color: Colors.red, child: Text('Test')),)

                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(
                        left: 15, right: 15, top: 20, bottom: 10),
                    width: double.maxFinite,
                    child: ListView(
                      physics: BouncingScrollPhysics(
                          decelerationRate: ScrollDecelerationRate.fast),
                      children: Util.stateList.map((state) {
                        return GestureDetector(
                          onTap: () {
                            selectState(state['STATE_NAME'], state['STATE_ID']);
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 7),
                            padding: EdgeInsets.only(bottom: 7, left: 7),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.black, width: 1))),
                            child: Text(state['STATE_NAME']),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
              right: 0,
              top: 0,
              child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(Icons.cancel, size: 30))),
        ],
      ),
    );
  }
}

class SelectDistrictDialog extends StatelessWidget {
  Function selectDistrict;
  List<dynamic> districtList;

  SelectDistrictDialog(this.selectDistrict, this.districtList);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      contentPadding: EdgeInsets.all(10),
      content: Stack(
        children: [
          Container(
            height: 450,
            width: double.infinity,
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Select District :',
                  style: TextStyle(fontSize: 21),
                ),
                // Expanded(child: Container(color: Colors.red, child: Text('Test')),)

                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(
                        left: 15, right: 15, top: 20, bottom: 10),
                    width: double.maxFinite,
                    child: ListView(
                      physics: BouncingScrollPhysics(
                          decelerationRate: ScrollDecelerationRate.fast),
                      children: districtList.map((district) {
                        return GestureDetector(
                          onTap: () {
                            //Code changes here
                            selectDistrict(district['CITY_NAME'],
                                district['CITY_ID'].toString());
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 7),
                            padding: EdgeInsets.only(bottom: 7, left: 7),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.black, width: 1))),
                            child: Text(district['CITY_NAME']),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
              right: 0,
              top: 0,
              child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(Icons.cancel, size: 30))),
        ],
      ),
    );
  }
}

class SelectTalukaDialog extends StatelessWidget {
  Function selectTaluka;
  List<dynamic> talukaList;

  SelectTalukaDialog(this.selectTaluka, this.talukaList);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      contentPadding: EdgeInsets.all(10),
      content: Stack(
        children: [
          Container(
            height: 450,
            width: double.infinity,
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Select District :',
                  style: TextStyle(fontSize: 21),
                ),
                // Expanded(child: Container(color: Colors.red, child: Text('Test')),)

                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(
                        left: 15, right: 15, top: 20, bottom: 10),
                    width: double.maxFinite,
                    child: ListView(
                      physics: BouncingScrollPhysics(
                          decelerationRate: ScrollDecelerationRate.fast),
                      children: talukaList.map((taluka) {
                        return GestureDetector(
                          onTap: () {
                            //Code changes here
                            selectTaluka(taluka['TALUKA_NAME'],
                                taluka['TALUKA_ID'].toString());
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 7),
                            padding: EdgeInsets.only(bottom: 7, left: 7),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.black, width: 1))),
                            child: Text(taluka['TALUKA_NAME']),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
              right: 0,
              top: 0,
              child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(Icons.cancel, size: 30))),
        ],
      ),
    );
  }
}
