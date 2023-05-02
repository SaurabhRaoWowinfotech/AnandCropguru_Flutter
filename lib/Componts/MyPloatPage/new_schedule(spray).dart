

import 'package:dr_crop_guru/Componts/MyPloatPage/Schedule.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/Colors.dart';
import '../../utils/util.dart';

class NewSchedule extends StatelessWidget {
  const NewSchedule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              )
          )
      ),
       body: Column(
         children: [
           SizedBox(height: 10,),
           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 15),
             child: InkWell(
               onTap: () => Navigator.pop(context),


               child: Container(
                 height: 40,
                 color: Colors.orange,
                 child: Center(
                   child:  Text("View Previous Schedule",style: TextStyle(color: kWhite,fontSize: 15,fontWeight: FontWeight.bold)),
                 ),
               ),
             ),

           ),
           SizedBox(height: 10,),
           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 7,vertical: 5),
             child: Container(
               height: 110,

               decoration: BoxDecoration(
                   boxShadow: [
                     BoxShadow(
                       color: Colors.grey,
                       offset: const Offset(
                         2.0,
                         2.0,
                       ),
                       blurRadius: 2.0,
                       spreadRadius: 0.0,
                     ),
                   ],
                   color: kWhite,
                   borderRadius: BorderRadius.circular(5)
               ),
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.start,
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [

                   Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                     child: Container(
                       height: 25,
                       color: kgreen,
                       child: Row(
                         children: [
                           SizedBox(width: 5,),
                           Text("View Previous Schedule",style: TextStyle(color: kWhite,fontSize: 15,fontWeight: FontWeight.bold)),
                         ],
                       ),
                     ),

                   ),
                   SizedBox(height: 5,),
                   Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 5),
                     child: Row(
                       children: [
                         Text("Title:",style: TextStyle(color: kblack,fontSize: 15,fontWeight: FontWeight.bold)),
                         Text("  To control Fungal Diseases and Sucking Pests",style: TextStyle(color: kgreen,fontSize: 15,fontWeight: FontWeight.bold)),

                       ],
                     ),
                   ),
                   SizedBox(height: 10,),
                   Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 5),
                     child: Row(
                       children: [
                         Text("Schedule Type:",style: TextStyle(color: kblack,fontSize: 15,fontWeight: FontWeight.bold)),
                         Text("  Spray",style: TextStyle(color: kgreen,fontSize: 15,fontWeight: FontWeight.bold)),

                       ],
                     ),
                   ),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.end,
                     crossAxisAlignment: CrossAxisAlignment.end,
                     children: [
                       Icon(
                         Icons.arrow_right_alt_sharp,
                         size: 28,
                         color: Colors.orange,
                       )
                     ],
                   )

                 ],
               ),

             ),
           ),


         ],
       ),
    );
  }
}
