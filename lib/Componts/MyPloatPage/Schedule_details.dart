import 'package:dr_crop_guru/Componts/MyPloatPage/add_to_diary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

import '../../utils/Colors.dart';
import '../../utils/util.dart';

class ScheduleDetails extends StatefulWidget {
  const ScheduleDetails(
      {Key? key, this.title, this.daysafter, this.scheduletype, this.image, this.schedule})
      : super(key: key);
  final title;
  final daysafter;
  final scheduletype;
  final image;
  final schedule;

  @override
  _ScheduleDetailsState createState() => _ScheduleDetailsState();
}

class _ScheduleDetailsState extends State<ScheduleDetails> {
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
                  colors: [Util.newHomeColor, Util.endColor]),
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
                onTap: () => Navigator.pop(context),
                child: Icon(
                  Icons.arrow_back,
                  color: kWhite,
                ),
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            ),
          ),
          title: Text(
            'Old Schedule(Fertilizer)',
            style: TextStyle(
                color: kWhite, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        )),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 5),
                      child: Container(
                        height: 25,
                        color: kgreen,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 5,
                            ),
                            Text(widget.daysafter,
                                style: TextStyle(
                                    color: kWhite,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold)),
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
                              Text("Title:",
                                  style: TextStyle(
                                      color: kblack,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                              Expanded(
                                child: Text("  ${widget.title}",
                                    style: TextStyle(
                                        color: kgreen,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Text("Schedule Type :",
                                  style: TextStyle(
                                      color: kblack,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                              Text(" ${widget.scheduletype}",
                                  style: TextStyle(
                                      color: kgreen,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Center(
                              child: Image.network(widget.image, height: 200,
                                  errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              "assets/images/noimage.png",
                              height: 200,
                            );
                          })),
                          SizedBox(
                            height: 20,
                          ),

                          Html(
                              data:widget.schedule),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: InkWell(
                        onTap: () {
                         // Get.to(AddToDiary());
                        },
                        child: Container(
                          height: 40,
                          color: Colors.orange,
                          child: Center(
                            child: Text("ADD TO DIARY",
                                style: TextStyle(
                                    color: kWhite,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    )
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
