

import 'package:dr_crop_guru/Componts/MyPloatPage/Schedule.dart';
import 'package:dr_crop_guru/Componts/MyPloatPage/diary.dart';
import 'package:dr_crop_guru/Componts/MyPloatPage/question_answer_list.dart';
import 'package:dr_crop_guru/Componts/MyPloatPage/report_master.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/Colors.dart';
import '../../utils/util.dart';
import 'faq.dart';

class CapSicumFarm extends StatelessWidget {
  const CapSicumFarm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
backgroundColor: kgreen,
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
                      onTap: (){
                        Navigator.pop(context);
                      },
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
                title: Text('Capsicum Farm',
                  style: TextStyle(color: kWhite, fontSize: 20,fontWeight: FontWeight.bold),
                ),
              )
          )
      ),
      body:SingleChildScrollView(
        child: Column(
          children: [
        IntrinsicHeight(
        child: Row(
        children: [
        Expanded(
          child: GestureDetector(
            onTap: (){
              Get.to(Schedule());
            },
            child: Container(
              height: 150,


              child: Column(
                mainAxisAlignment:MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: kWhite,
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Center(child: Image.asset("assets/images/timetable.png", height:50,color: Colors.orange,)),
                    )
                  ),
                  SizedBox(height: 10,),
                  Text("Schedule",style: TextStyle(color: kWhite,fontSize: 15,fontWeight: FontWeight.bold),)
                ],
              ),
            ),
          ), 
          
        ),
        Container(width: 1,height: 100, color: Colors.white), // This is divider
          Expanded(
            child: InkWell(
              onTap: (){
                Get.to(QuestionAnswer());
              },
              child: Container(
                height: 150,

                color:kgreen,
                child: Column(
                  mainAxisAlignment:MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                        radius: 40,
                        backgroundColor: kWhite,
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Center(child: Image.asset("assets/images/timetable.png", height:50,color: Colors.orange,)),
                        )
                    ),
                    SizedBox(height: 10,),
                    Text("Question Answer",style: TextStyle(color: kWhite,fontSize: 15,fontWeight: FontWeight.bold),)
                  ],
                ),
              ),
            ),
          )

        ],
    ),
        ),
            Container(height: 1,color: kWhite,),
            IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: (){
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(builder: (context) => const FAQ()));
                       Get.to(FAQ());
                      },
                      child: Container(
                        height: 150,


                        child: Column(
                          mainAxisAlignment:MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                                radius: 40,
                                backgroundColor: kWhite,
                                child: Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Center(child: Image.asset("assets/images/faq1.png", height:50,color: Colors.orange,)),
                                )
                            ),
                            SizedBox(height: 10,),
                            Text("FAQ",style: TextStyle(color: kWhite,fontSize: 15,fontWeight: FontWeight.bold),)
                          ],
                        ),
                      ),
                    ),

                  ),
                  Container(width: 1,height: 100, color: Colors.white), // This is divider
                  Expanded(
                    child: Container(
                      height: 150,

                      color:kgreen,
                      child: Column(
                        mainAxisAlignment:MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                              radius: 40,
                              backgroundColor: kWhite,
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Center(child: Image.asset("assets/images/agrovisit.png", height:50,color: Colors.orange,)),
                              )
                          ),
                          SizedBox(height: 10,),
                          Text("Agromist Visits",style: TextStyle(color: kWhite,fontSize: 15,fontWeight: FontWeight.bold),)
                        ],
                      ),
                    ),
                  )

                ],
              ),
            ),
            Container(height: 1,color: kWhite,),
            IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: (){
                     Get.to(Diary());
                      },
                      child: Container(
                        height: 150,
                        child: Column(
                          mainAxisAlignment:MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                                radius: 40,
                                backgroundColor: kWhite,
                                child: Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Center(child: Image.asset("assets/images/mdiary.png", height:50,color: Colors.orange,)),
                                )
                            ),
                            SizedBox(height: 10,),
                            Text("Diary",style: TextStyle(color: kWhite,fontSize: 15,fontWeight: FontWeight.bold),)
                          ],
                        ),
                      ),
                    ),

                  ),
                  Container(width: 1,height: 100, color: Colors.white), // This is divider
                  Expanded(
                    child: InkWell(
                      onTap: (){
                        Get.to(ReportMaster());
                      },
                      child: Container(
                        height: 150,

                        color:kgreen,
                        child: Column(
                          mainAxisAlignment:MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                                radius: 40,
                                backgroundColor: kWhite,
                                child: Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Center(child: Image.asset("assets/images/mobservation.png", height:50,color: Colors.orange,)),
                                )
                            ),
                            SizedBox(height: 10,),
                            Text("Report master",style: TextStyle(color: kWhite,fontSize: 15,fontWeight: FontWeight.bold),)
                          ],
                        ),
                      ),
                    ),
                  )

                ],
              ),
            ),
            Container(height: 1,color: kWhite,),
            IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 150,


                      child: Column(
                        mainAxisAlignment:MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                              radius: 40,
                              backgroundColor: kWhite,
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Center(child: Image.asset("assets/images/info.png", height:50,color: Colors.orange,)),
                              )
                          ),
                          SizedBox(height: 10,),
                          Text("Plot information",style: TextStyle(color: kWhite,fontSize: 15,fontWeight: FontWeight.bold),)
                        ],
                      ),
                    ),

                  ),
                  Container(width: 1,height: 100, color: Colors.white), // This is divider
                  Expanded(
                    child: Container(



                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomRight: const Radius.circular(25.0),

                          ),
                      ),
                      child: Column(
                        mainAxisAlignment:MainAxisAlignment.center,
                        children: [

                          CircleAvatar(
                              radius: 40,
                              backgroundColor: kWhite,
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Center(child: Image.asset("assets/images/info.png", height:50,color: Colors.orange,)),
                              )
                          ),
                          SizedBox(height: 10,),
                          Text("N.R.C",style: TextStyle(color: kWhite,fontSize: 15,fontWeight: FontWeight.bold),)
                        ],
                      ),
                    ),
                  )

                ],
              ),
            ),

          ]
        ),
      )
    );

  }
}



