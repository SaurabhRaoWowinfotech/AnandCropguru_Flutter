

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Api/old_schedule_api.dart';
import '../../utils/Colors.dart';
import '../../utils/util.dart';
import 'Schedule_details.dart';

class OldSchedule extends StatefulWidget {
  const OldSchedule({Key? key}) : super(key: key);

  @override
  State<OldSchedule> createState() => _OldScheduleState();
}

class _OldScheduleState extends State<OldSchedule> {
  @override
  void initState() {
    Future.delayed( Duration(seconds: 0), () {
      oldSchedule().then((value){
        setState(() {
        });
      });
// Here you can write your code


    });

    // TODO: implement initState
    super.initState();
  }
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
                title: Text('Old Schedule(Fertilizer)',
                  style: TextStyle(color: kWhite, fontSize: 20,fontWeight: FontWeight.bold),
                ),
              )
          )
      ),

      body: Visibility(
        visible: oldisLoaded,
        child: ListView.builder(
    itemBuilder: (context, index) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
        child: InkWell(
          onTap: () {
            Get.to(ScheduleDetails(image:oldschedulelistresponse![index]["SCHEDULE_IMAGE"]  , title:oldschedulelistresponse![index]["TITLE"] ,daysafter:oldschedulelistresponse![index]["SCHEDULE_DAY"] ,scheduletype:oldschedulelistresponse![index]["SCHEDULE_TYPE"],schedule:oldschedulelistresponse![index]["SCHEDULE"]));
          },
          child: Container(


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
                  padding: const EdgeInsets.symmetric(
                      horizontal: 5, vertical: 5),
                  child: Container(
                    height: 25,
                    color: kgreen,
                    child: Row(
                      children: [
                        SizedBox(width: 5,),
                        Text(   overflow: TextOverflow.ellipsis,
                            maxLines:2,oldschedulelistresponse![index]["SCHEDULE_DAY"].toString(), style: TextStyle(
                            color: kWhite,
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),

                ),
                SizedBox(height: 5,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Flexible(
                    child: Row(
                      children: [
                        Text("Title:", style: TextStyle(color: kblack,
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                        Expanded(
                          child: Text(overflow: TextOverflow.ellipsis,
                              maxLines:2,oldschedulelistresponse![index]["TITLE"].toString(), style: TextStyle(color: kgreen,
                              fontSize: 15,
                              fontWeight: FontWeight.bold)),
                        ),

                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    children: [
                      Text("Schedule Type:", style: TextStyle(color: kblack,
                          fontSize: 15,
                          fontWeight: FontWeight.bold)),
                      Text(oldschedulelistresponse![index]["SCHEDULE_TYPE"].toString(), style: TextStyle(color: kgreen,
                          fontSize: 15,
                          fontWeight: FontWeight.bold)),

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
      );
    },itemCount:oldschedulelistresponse == null ? 0 : oldschedulelistresponse!.length,
        ),replacement: Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
