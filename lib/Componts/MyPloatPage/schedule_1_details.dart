

import 'package:dr_crop_guru/Componts/MyPloatPage/add_to_diary.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

import '../../utils/Colors.dart';
import '../../utils/util.dart';

class Schedule1Details extends StatefulWidget {
  const Schedule1Details({Key? key, this.titile, this.daysplanning, this.scheduleType, this.Quantitty, this.image, this.text, }) : super(key: key);
  final titile;
  final daysplanning;
  final scheduleType;
  final Quantitty;
  final image;
  final text;


  @override
  _ScheduleDetails1State createState() => _ScheduleDetails1State();
}

class _ScheduleDetails1State extends State<Schedule1Details> {
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
              title: Text('Schedule Details',
                style: TextStyle(color: kWhite, fontSize: 20,fontWeight: FontWeight.bold),
              ),
            )
        ),
      ),
      body: SingleChildScrollView(
        child: Column(

          children: [
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Container(


                decoration: BoxDecoration(
                  color: kWhite,

                  borderRadius: BorderRadius.circular(8),
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


                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                      child: Container(
                        height: 25,
                        color: kgreen,
                        child: Row(
                          children: [
                            SizedBox(width: 5,),
                            Text(" ${widget.daysplanning}",style: TextStyle(color: kWhite,fontSize: 15,fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),

                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Row(
                                children: [
                                  Text("Title:",style: TextStyle(color: kblack,fontSize: 15,fontWeight: FontWeight.bold)),
                                  SizedBox(
                                    width: 280,
                                    child: Text(maxLines:3, overflow: TextOverflow.ellipsis,
                                        " ${widget.titile}",style: TextStyle(color: kgreen,fontSize: 15,fontWeight: FontWeight.bold)),
                                  ),
                                ],
                              ),

                            ],
                          ),
                          SizedBox(height: 15,),
                          Row(
                            children: [
                              Text("Schedule Type :",style: TextStyle(color: kblack,fontSize: 15,fontWeight: FontWeight.bold)),
                              SizedBox(
                                  child: Text(maxLines:2, overflow: TextOverflow.ellipsis," ${widget.scheduleType}",style: TextStyle(color: kgreen,fontSize: 15,fontWeight: FontWeight.bold))),
                            ],
                          ),
                          SizedBox(height: 15,),
                          Center(child: Image.network(widget.image,height: 200,errorBuilder: (context, error,
                              stackTrace) {
                            return Image.asset("assets/images/noimage.png",height: 200,);
                          },)),
                          SizedBox(height: 20,),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("",style: TextStyle(color: kblack,fontSize: 15,fontWeight: FontWeight.bold,height: 3)),
                          ),
                        ],
                      ),
                    ),

                    Html(
                        data:widget.text),








                  ],
                ),
              ),
            ),
          ],
        ),
      ),

    );
  }
}


