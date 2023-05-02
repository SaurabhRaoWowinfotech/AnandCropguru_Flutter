import 'package:dr_crop_guru/screens/home_screen.dart';
import 'package:dr_crop_guru/screens/mart.dart';
import 'package:dr_crop_guru/screens/profile.dart';
import 'package:dr_crop_guru/utils/util.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static final routeName = '/home-page';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Mart(),
    Text(
      'Index 3: Lab',
      style: optionStyle,
    ),
    Profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          resizeToAvoidBottomInset: false,
          body: Center(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
          // floatingActionButton: Container(
          //   height: 70,
          //   width: 70,
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(70),
          //     color: Util.orangee,
          //   ),
          // ),
          // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  size: 30,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.mode_comment_rounded,
                  size: 30,
                ),
                label: 'Community',
              ),

              // BottomNavigationBarItem(
              //   icon: Stack(
              //     children: [
              //       Positioned(
              //         child: Container(
              //           height: 60,
              //           width: 60,
              //           decoration: BoxDecoration(
              //             color: Util.orangee,
              //             borderRadius: BorderRadius.circular(60),
              //           ),
              //           child: Icon(Icons.access_alarm),
              //         ),
              //       ),
              //     ],
              //   ),
              //   label: '',
              // ),

              BottomNavigationBarItem(
                icon: Icon(
                  Icons.shopping_cart,
                  size: 5,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.science_outlined,
                  size: 30,
                ),
                label: 'Lab',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                  size: 30,
                ),
                label: 'Profile',
              ),
            ],
            type: BottomNavigationBarType.fixed,
            currentIndex: _selectedIndex,
            selectedItemColor: Util.newHomeColor,
            // unselectedItemColor: Colors.grey,
            // unselectedLabelStyle: TextStyle(color: Colors.grey,),
            onTap: _onItemTapped,
          ),
        ),
        Positioned(
          bottom: 0,
          right: MediaQuery.of(context).size.width / 2 - 40,
          left: MediaQuery.of(context).size.width / 2 - 40,
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(50),
            child: InkWell(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              onTap: () {
                setState(() {
                  _selectedIndex = 2;
                });
              },
              child: Container(
                padding: EdgeInsets.all(7),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(50),
                  ),
                ),
                child: Image.asset('assets/images/englishmart.png'),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
