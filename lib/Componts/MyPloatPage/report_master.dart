

import 'dart:convert';

import 'package:dr_crop_guru/Api/old_schedule_api.dart';
import 'package:dr_crop_guru/Componts/MyPloatPage/question_details.dart';
import 'package:dr_crop_guru/Componts/Purchase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import '../../utils/Colors.dart';
import '../../utils/util.dart';
import 'package:http/http.dart' as http;
import 'add_Report.dart';
import 'master_details.dart';

class ReportMaster extends StatefulWidget {
   ReportMaster({Key? key, this.userID, this.plotID, this.cropID}) : super(key: key);
   final userID;
   final plotID;
   final cropID;

  @override
  State<ReportMaster> createState() => _ReportMasterState();
}

class _ReportMasterState extends State<ReportMaster>with TickerProviderStateMixin  {
  late Map mapresponse;
  List? listresponse;
  String data = " ";
  String? Firstpage;

  bool isLoaded = false;
  late AnimationController _controller;

  Future questionAnswerlist() async {
    http.Response response;
    response = await http.post(
        Uri.parse(
            'https://mycropguruapiwow.cropguru.in/api/Report?USER_ID=${widget.userID}&TYPE=Agronomist&AGRONOMIST_ID=${widget.userID}&PLOT_ID=${widget.plotID}'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(<String, String>{
          "START": "0",
          "END": "10",
          "WORD": "NONE",
          "LANG_ID": "1"
        }));
    var jsonResponse = json.decode(response.body);
    print(jsonResponse["ResponseMessage"]);
    if (response.statusCode == 200) {
      mapresponse = json.decode(response.body);
      Firstpage = jsonResponse["ResponseMessage"];
      listresponse = mapresponse["DATA"];
      data =listresponse.toString();
      //  print(listresponse![0]["SCHEDUEL_ID"]);
      isLoaded = true;
    }
  }
  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(
          milliseconds: 3000),
      vsync: this,
    );
    _controller.addListener(() {
      if (_controller.isCompleted) {
        _controller.reset();
        _controller.forward();
      }
    });
    WidgetsBinding.instance
        .addPostFrameCallback(
            (timeStamp) {
          Util.animatedProgressDialog(
              context, _controller);
          _controller.forward();
        });
    questionAnswerlist().then((value) {
      _controller.reset();
      Navigator.pop(context);
      setState(() {});
      return value;
    });
   // questionAnswerlist();
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
                    onTap: () {
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
              title: InkWell(
                onTap: () {},
                child: Text(
                  'Report Master',
                  style: TextStyle(
                      color: kWhite,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )),
      ),
      body:data == "[]"?Column(
        children: [ 
          SizedBox(height: 15,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25,),
            child: Material(
              elevation: 1.0,
              child: Container( 
                height: MediaQuery.of(context).size.height -230,
                decoration: BoxDecoration(
                   color: kWhite, 
                  borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5.0),
                  topRight: Radius.circular(5),
                  bottomLeft: Radius.zero,
                  bottomRight: Radius.zero,
                ),
                ),
                 child:Html(
                          data:Firstpage),
              ),
            ),
          ),
          Padding(
            padding:const EdgeInsets.symmetric(horizontal: 25,),
            child: Material(
              elevation: 1.0,
              child: InkWell(
                onTap: (){
                  Get.to(Add_Report());
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  
                  decoration: BoxDecoration(
                      color: kgreen,
                       borderRadius: BorderRadius.only(
                    topLeft: Radius.zero,
                    topRight: Radius.zero,
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                  )
                  ),
                  child: Text(
                      'Ok',
                      style: TextStyle(
                          color: kWhite,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                ),
              ),
            ),
          )
        ],
      ): Visibility(
        visible: isLoaded,
        child: ListView.builder(
        //  physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 8),
              child: InkWell(
                onTap: (){
                  
                Get.to(MasterDetails(ans:listresponse![index]["REPORT_DESC"].toString(),datetime: listresponse![index]["REG_DATE"].toString(),titile:listresponse![index]["REPORT_TYPE"].toString(),image: listresponse![index]["REPORT_IMG"].toString(),  ));
                },
                child: Container(

                  decoration: BoxDecoration(
                    color: kWhite,
                    borderRadius: BorderRadius.circular(7),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(1, 6), // changes position of shadow
                      ),
                    ],

                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(listresponse![index]["REPORT_TYPE"].toString(), style: TextStyle(
                            color: kblack,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                        SizedBox(height: 10,),
                        Text(maxLines:2,listresponse![index]["REPORT_DESC"].toString(), style: TextStyle(
                            color: kblack,
                            fontSize: 14,
                         )),
                        Center(child: Image.network(
                          listresponse![index]["REPORT_IMG"],height: 250,errorBuilder: (context, error,
                            stackTrace) {
                          return Container();
                        },)),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(listresponse![index]["REG_DATE"].toString(),style: TextStyle(
                              color: kgrey,
                              fontSize: 16,
                            )),

                            Icon(
                              Icons.arrow_right_alt_sharp,
                              size: 30,
                              color:kdarkred,
                            )

                          ],
                        )

                      ],


                    ),
                  ),
                ),
              ),
            );
          },itemCount:listresponse == null ? 0 : listresponse!.length,
        ),
      ),
   floatingActionButton:data == "[]"? Text(""):Container(
        height: 70.0,
        width: 90.0,

        child: FittedBox(
          child: FloatingActionButton(
              backgroundColor: Colors.orange,
              child: Text("AddReport",style: TextStyle(fontSize: 9,fontWeight: FontWeight.bold)),

              onPressed: () {
                Get.to(Add_Report());
                //Get.to(AddYourQuestion());
              }),
        ),
      ),
    );
  }
}

