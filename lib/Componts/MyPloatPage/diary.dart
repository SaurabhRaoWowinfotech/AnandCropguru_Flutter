
import 'package:dr_crop_guru/Componts/MyPloatPage/expenses.dart';
import 'package:dr_crop_guru/Componts/MyPloatPage/income.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/Colors.dart';
import '../../utils/util.dart';
import '../add_purchase.dart';
import 'add_purchase.dart';

class Diary extends StatefulWidget {
   Diary({Key? key}) : super(key: key);

  @override
  State<Diary> createState() => _DiaryState();
}

class _DiaryState extends State<Diary> with SingleTickerProviderStateMixin  {
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
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.0),

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
                    icon: InkWell(
                      onTap: ()=>  Navigator.pop(context),
                      child: Icon(
                        Icons.arrow_back,
                        color: kWhite,
                      ),
                    ),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    tooltip:
                    MaterialLocalizations.of(context).openAppDrawerTooltip,
                  ),
                ),
                title: Text('New Schedule',
                  style: TextStyle(color: kWhite, fontSize: 20,fontWeight: FontWeight.bold),

                ),
                actions: [
                  Icon(Icons.add,size: 28,),
                  InkWell(
                    onTap: (){
                      Get.to(AddPurchases());
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Text('Add Purchase',
                        style: TextStyle(color: kWhite, fontSize: 18,fontWeight: FontWeight.bold),

                      ),
                    ),
                  ),
                  SizedBox(width: 8,)
                ],
              ),
          ),

      ),
      body: Column(
        children: [
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
                  text: 'Expenses',
                ),

                // second tab [you can add an icon using the icon property]
                Tab(
                  text: 'Income',
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
                Expenses(),


                // second tab bar view widget
                Income()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
