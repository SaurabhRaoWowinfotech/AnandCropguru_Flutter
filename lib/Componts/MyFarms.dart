

import 'package:dr_crop_guru/Componts/Purchase.dart';
import 'package:flutter/material.dart';

import '../Demo/Ploat.dart';
import '../utils/Colors.dart';
import '../utils/util.dart';
import 'MyPlot.dart';



class MyFarms extends StatefulWidget {
  @override
  _MyFarmsState createState() => _MyFarmsState();
}

class _MyFarmsState extends State<MyFarms>
    with SingleTickerProviderStateMixin {
late  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // floatingActionButtonLocation: FloatingActionButtonLocation,

      appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.0),

          child: Container(

              child: AppBar(
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30.0),
                      bottomRight: Radius.circular(30.0),
                    ),

                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Util.newHomeColor,
                          Util.endColor
                        ]

                    ),

                  ),
                ),

                shape: RoundedRectangleBorder(

                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25.0),
                    bottomRight: Radius.circular(25.0),
                  ),
                ),
                elevation: 0,
                backgroundColor: Colors.green,
                leading: Builder(
                  builder: (context) => IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: kWhite,
                    ),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    tooltip:
                    MaterialLocalizations.of(context).openAppDrawerTooltip,
                  ),
                ),
                title: Text('My Farms',
                  style: TextStyle(color: kWhite, fontSize: 20,fontWeight: FontWeight.bold),
                ),
              )
          )
      ),
      body: Column(
        children: [
          // give the tab bar a height [can change hheight to preferred height]
          Container(
            height: 45,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
            BoxShadow(
            color: Colors.grey,

              blurRadius: 1.0,
              spreadRadius: 0.0,
            ),
]
            ),
            child: TabBar(
              controller: _tabController,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,

              labelStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
              indicatorWeight: 5.5,
              tabs: [
                // first tab [you can add an icon using the icon property]
                Tab(
                  text: 'My Plot',
                ),

                // second tab [you can add an icon using the icon property]
                Tab(
                  text: 'Purchase',
                ),
              ],
            ),
          ),
          // tab bar view here
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // first tab bar view widget
                Ploat(),

                // second tab bar view widget
               Purchase(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
