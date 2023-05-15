import 'package:dr_crop_guru/models/user.dart';
import 'package:dr_crop_guru/screens/my_orders_screen.dart';
import 'package:dr_crop_guru/screens/select_language_screen.dart';
import 'package:dr_crop_guru/screens/update_profile.dart';
import 'package:dr_crop_guru/utils/dummy_data.dart';
import 'package:dr_crop_guru/utils/prefs_util.dart';
import 'package:dr_crop_guru/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  User? user;

  void setUser() async {
    user = await PrefsUtil.getUserDetails();
  }

  @override
  void initState() {
    setUser();
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Util.newHomeColor,
    ));
    Future.delayed(const Duration(milliseconds: 0), () {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin:
                  EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
              height: 290,
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
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: EdgeInsets.only(left: 12, top: 12),
                        child: Text('My Account',
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      )),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: 110,
                    width: 110,
                    decoration: BoxDecoration(
                        border: Border.all(width: 0.2, color: Colors.black),
                        borderRadius: BorderRadius.circular(60)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(63),
                      child: Image.network(
                        'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // CircleAvatar(
                  //   radius: 55,
                  //   child: Stack(
                  //     children: [
                  //       CircleAvatar(radius: 55, child: Image.asset('assets/images/user.webp', fit: BoxFit.cover,)),
                  //   Container(
                  //       height: 110,
                  //       width: 110,
                  //       decoration: BoxDecoration(border: Border.all(width: 0.2, color: Colors.black), borderRadius: BorderRadius.circular(60)),
                  //   )
                  //     ],
                  //   ),
                  // ),

                  SizedBox(height: 15),
                  Text(user?.FULL_NAME ?? '',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white)),
                  Text('+91${user?.MOBILE_NO}',
                      style: TextStyle(color: Colors.white)),
                  user?.ADDRESS != null
                      ? Text(
                          '${user?.ADDRESS}, ${user?.STATE_NAME}',
                          style: TextStyle(color: Colors.white),
                        )
                      : Text('${user?.STATE_NAME}',
                          style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
            SizedBox(height: 35),
            profileOption(DummyData.profileOptions[0], () {
              Navigator.of(context).pushNamed(UpdateProfile.routeName, arguments: user);
            }),
            profileOption(DummyData.profileOptions[1], () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyOrdersScreen(user!),));
            }),
            profileOption(DummyData.profileOptions[2], () {}),
            profileOption(DummyData.profileOptions[3], () {}),
            profileOption(DummyData.profileOptions[4], () {}),
            profileOption(DummyData.profileOptions[5], () {}),
            profileOption(DummyData.profileOptions[6], () {}),
            profileOption(DummyData.profileOptions[7], () {}),
            profileOption(DummyData.profileOptions[8], () {}),
            profileOption(DummyData.profileOptions[9], () {}),
            profileOption(DummyData.profileOptions[10], () {}),
            profileOption(DummyData.profileOptions[11], () {}),
            profileOption(DummyData.profileOptions[12], () {}),
            profileOption(DummyData.profileOptions[13], () {}),
            profileOption(DummyData.profileOptions[14], () {}),
            profileOption(DummyData.profileOptions[15], () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Anand CropGuru'),
                    content: Text('Do you want to logout ?'),
                    actions: [
                      Text('NO'),
                      Text('YES'),
                    ],
                  );
                },
              );
              PrefsUtil.removeUser();
              Navigator.of(context)
                  .pushReplacementNamed(SelectLanguageScreen.routeName);
            }),
          ],
        ),
      ),
    );
  }
}

class profileOption extends StatelessWidget {
  Map<String, dynamic> element;
  Function function;

  profileOption(this.element, this.function, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        function();
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(width: 0.2, color: Colors.grey))),
        child: ListTile(
          leading: element['icon'],
          title: Text(element['title']),
          trailing: Icon(Icons.arrow_forward_ios),
        ),
      ),
    );
  }
}
