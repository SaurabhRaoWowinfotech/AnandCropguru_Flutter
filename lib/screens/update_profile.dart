import 'package:dr_crop_guru/models/user.dart';
import 'package:dr_crop_guru/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services.dart';
import '../utils/prefs_util.dart';
import '../utils/util.dart';

class UpdateProfile extends StatefulWidget {
  static final routeName = '/update-profile';

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> with TickerProviderStateMixin{
  bool isInitialized = false;
  double textSize = 16;
  double textFieldHeight = 45;
  User? user;

  void setUser() async {
    user = await PrefsUtil.getUserDetails();
  }

  // void setUser() async {
  //   user = await PrefsUtil.getUserDetails();
  // }


  String selectedStateName = 'not set';
  String selectedStateID = 'not set';

  TextEditingController? fullName;
  TextEditingController? villageName;
  TextEditingController? address;

  void selectState(String stateName, String stateID) {
    setState(() {
      selectedStateName = stateName;
      selectedDistrictName = 'not set';
      selectedTalukaName = 'not set';
      villageName?.clear();
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
      villageName?.clear();
      FocusManager.instance.primaryFocus?.unfocus();
    });
    selectedDistrictID = districtID;
  }

  String selectedTalukaName = 'not set';
  String selectedTalukaID = 'not set';

  void selectTaluka(String talukaName, String talukaID) {
    setState(() {
      selectedTalukaName = talukaName;
      villageName?.clear();
      FocusManager.instance.primaryFocus?.unfocus();
    });
    selectedTalukaID = talukaID;
  }

  late AnimationController _controller;
  // String enteredVillageName = 'not set';
  // String enteredAddress = 'not set';
  // String enteredFullName = 'not set';

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
    setUser();
    Future.delayed(const Duration(milliseconds: 0), () {
      setState(() {
        isInitialized = false;
      });
    });
    // user = Provider.of<User>(context);
    // setUser();
    // Future.delayed(const Duration(milliseconds: 0), () {
    //   setState(() {});
    // });
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
    // user = ModalRoute.of(context)?.settings.arguments as User;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool validate(){

    return true;
  }

  @override
  Widget build(BuildContext context) {
    if(!isInitialized){
      isInitialized = true;
      fullName = TextEditingController(text: user?.FULL_NAME);
      fullName!.selection = TextSelection.fromPosition(TextPosition(offset: fullName!.text.length));
      villageName = TextEditingController(text: user?.VILLAGE_NAME);
      villageName!.selection = TextSelection.fromPosition(TextPosition(offset: villageName!.text.length));
      address = TextEditingController(text: user?.ADDRESS);
      address!.selection = TextSelection.fromPosition(TextPosition(offset: address!.text.length));
      selectedStateName = user?.STATE_NAME ?? 'not set';
      selectedStateID = user?.STATE_ID ?? 'not set';
      selectedDistrictName = user?.DISTRICT_NAME ?? 'not set';
      selectedDistrictID = user?.DISTRICT_ID ?? 'not set';
      selectedTalukaName = user?.TALUKA_NAME ?? 'not set';
      selectedTalukaID = user?.TALUKA_ID ?? 'not set';
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: Util.lightGreen,
        child: Column(
          children: [
            Container(
              margin:
                  EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
              height: 70,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Util.newHomeColor,
                    Util.endColor,
                  ],
                ),
                // color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25)),
              ),
              child: Row(
                children: [
                  // flag ? Icon(Icons.arrow_right_outlined) : Icon(Icons.arrow_drop_down_outlined),
                  //
                  // ElevatedButton(onPressed: (){
                  //   setState(() {
                  //     flag = !flag;
                  //   });
                  // }, child: Text('Tap')),
                  SizedBox(width: 20),
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).pop();
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  SizedBox(width: 20),
                  Text(
                    'Profile',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ScrollConfiguration(
                behavior: const ScrollBehavior().copyWith(overscroll: false),
                child: SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 25),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 12),
                        Text(
                          'Full Name',
                          style: TextStyle(
                              color: Util.newHomeColor,
                              fontWeight: FontWeight.bold,
                              fontSize: textSize),
                        ),
                        SizedBox(height: 12),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6)),
                              border: Border.all(
                                  width: 1,
                                  color: update_profile_textfield_border)),
                          height: textFieldHeight,
                          child: TextField(
                            controller: fullName,
                            decoration: InputDecoration(
                              hintStyle: TextStyle(color: hint_text_color),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        SizedBox(height: 12),
                        Text(
                          'Mobile No',
                          style: TextStyle(
                              color: Util.newHomeColor,
                              fontWeight: FontWeight.bold,
                              fontSize: textSize),
                        ),
                        SizedBox(height: 12),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6)),
                              border: Border.all(
                                  width: 1,
                                  color: update_profile_textfield_border)),
                          height: textFieldHeight,
                          child: TextField(
                            enabled: false,
                            controller: TextEditingController(text: user?.MOBILE_NO),
                            keyboardType: TextInputType.none,
                            decoration: InputDecoration(
                              hintStyle: TextStyle(color: hint_text_color),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        SizedBox(height: 12),
                        Text(
                          'State',
                          style: TextStyle(
                              color: Util.newHomeColor,
                              fontWeight: FontWeight.bold, fontSize: textSize),
                        ),
                        SizedBox(height: 12),
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
                              color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(6)),
                                border: Border.all(width: 1, color: Util.colorPrimary)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                selectedStateName == 'not set'
                                    ? Text('Select State')
                                    : Text(selectedStateName),
                                Icon(Icons.arrow_drop_down),
                              ],
                            ),
                          ),
                        ),
                        // Container(
                        //   height: textFieldHeight,
                        //   width: double.infinity,
                        //   padding: EdgeInsets.symmetric(horizontal: 15),
                        //   decoration: BoxDecoration(
                        //     color: Colors.white,
                        //       borderRadius: BorderRadius.all(Radius.circular(6)),
                        //       border: Border.all(width: 1, color: update_profile_textfield_border)),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       Text(user.STATE_NAME ?? ''),
                        //       Icon(Icons.arrow_drop_down),
                        //     ],
                        //   ),
                        // ),
                        SizedBox(height: 12),
                        Text(
                          'District',
                          style: TextStyle(
                              color: Util.newHomeColor,
                              fontWeight: FontWeight.bold,
                              fontSize: textSize),
                        ),
                        SizedBox(height: 12),
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
                              color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(6)),
                                border: Border.all(width: 1, color: Util.colorPrimary)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                selectedDistrictName == 'not set'
                                    ? Text('Select District')
                                    : Text(selectedDistrictName),
                                Icon(Icons.arrow_drop_down),
                              ],
                            ),
                          ),
                        ),
                        // Container(
                        //   height: textFieldHeight,
                        //   width: double.infinity,
                        //   padding: EdgeInsets.symmetric(horizontal: 15),
                        //   decoration: BoxDecoration(
                        //       color: Colors.white,
                        //       borderRadius: BorderRadius.all(Radius.circular(6)),
                        //       border: Border.all(width: 1, color: update_profile_textfield_border)),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       Text(user.DISTRICT_NAME ?? 'Select District'),
                        //       Icon(Icons.arrow_drop_down),
                        //     ],
                        //   ),
                        // ),
                        SizedBox(height: 12),
                        Text(
                          'Taluka',
                          style: TextStyle(
                              color: Util.newHomeColor,
                              fontWeight: FontWeight.bold,
                              fontSize: textSize),
                        ),
                        SizedBox(height: 12),
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
                              color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(6)),
                                border: Border.all(width: 1, color: Util.colorPrimary)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                selectedTalukaName == 'not set'
                                    ? Text('Select Taluka')
                                    : Text(selectedTalukaName),
                                Icon(Icons.arrow_drop_down),
                              ],
                            ),
                          ),
                        ),
                        // Container(
                        //   height: textFieldHeight,
                        //   width: double.infinity,
                        //   padding: EdgeInsets.symmetric(horizontal: 15),
                        //   decoration: BoxDecoration(
                        //       color: Colors.white,
                        //       borderRadius: BorderRadius.all(Radius.circular(6)),
                        //       border: Border.all(width: 1, color: update_profile_textfield_border)),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       Text(user.TALUKA_NAME ?? 'Select Taluka'),
                        //       Icon(Icons.arrow_drop_down),
                        //     ],
                        //   ),
                        // ),
                        SizedBox(height: 12),
                        Text(
                          'Village name',
                          style: TextStyle(
                              color: Util.newHomeColor,
                              fontWeight: FontWeight.bold,
                              fontSize: textSize),
                        ),
                        SizedBox(height: 12),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6)),
                              border: Border.all(
                                  width: 1,
                                  color: update_profile_textfield_border)),
                          height: textFieldHeight,
                          child: TextField(
                            onChanged: (value) {

                            },
                            controller: villageName,
                            decoration: InputDecoration(
                              hintStyle: TextStyle(color: hint_text_color),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        SizedBox(height: 12),
                        Text(
                          'Address',
                          style: TextStyle(
                              color: Util.newHomeColor,
                              fontWeight: FontWeight.bold,
                              fontSize: textSize),
                        ),
                        SizedBox(height: 12),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6)),
                              border: Border.all(
                                  width: 1,
                                  color: update_profile_textfield_border)),
                          height: textFieldHeight,
                          child: TextField(
                            controller: address,
                            decoration: InputDecoration(
                              hintText: 'Address',
                              hintStyle: TextStyle(color: hint_text_color),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        SizedBox(height: 12),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            margin: EdgeInsets.only(bottom: 15),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                border:
                                    Border.all(color: Colors.white, width: 1.3),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 3,
                                    offset: Offset(0.0, 1.0),
                                  ),
                                ]),
                            child: SizedBox(
                              height: 45,
                              width: 180,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (fullName!.text.trim().isEmpty) {
                                    Fluttertoast.showToast(
                                        msg: 'Please enter your name',
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.black,
                                        textColor: Colors.white,
                                        fontSize: 16.0);

                                    return;
                                  }

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

                                  if (fullName!.text.trim().length < 3) {
                                    Fluttertoast.showToast(
                                        msg: 'Please enter more than 3 characters in full name',
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.black,
                                        textColor: Colors.white,
                                        fontSize: 16.0);

                                    return;
                                  }

                                  if (villageName!.text.toString().trim().isEmpty) {
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

                                  if (villageName!.text.toString().trim().length < 3) {
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
                                      value.FULL_NAME = fullName?.text.trim();
                                      value.STATE_ID = selectedStateID;
                                      value.STATE_NAME = selectedStateName;
                                      value.DISTRICT_ID = selectedDistrictID;
                                      value.DISTRICT_NAME = selectedDistrictName;
                                      value.TALUKA_ID = selectedTalukaID;
                                      value.TALUKA_NAME = selectedTalukaName;
                                      value.VILLAGE_NAME = villageName?.text.toString().trim();
                                      value.ADDRESS = address!.text.toString().isEmpty ? '': address?.text.trim();
                                      return value;
                                    });
                                    PrefsUtil.setUserDetails(user);

                                    await Services.updateUserDetails(user).then((value) {
                                      if(value){
                                        Navigator.of(context).pop();
                                        Navigator.of(context).pop();
                                        Fluttertoast.showToast(
                                            msg: 'Profile updated successfully',
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.black,
                                            textColor: Colors.white,
                                            fontSize: 16.0);
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
                                style: ElevatedButton.styleFrom(
                                  shadowColor: Colors.black54,
                                  splashFactory: NoSplash.splashFactory,
                                  backgroundColor: Util.colorPrimary,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25)),
                                ),
                                child: Text(
                                  'Update Profile',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
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