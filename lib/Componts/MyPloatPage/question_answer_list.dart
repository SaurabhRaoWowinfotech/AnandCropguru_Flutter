

import 'dart:convert';

import 'package:dr_crop_guru/Componts/MyPloatPage/question_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../Api/add_your_question.dart';
import '../../utils/Colors.dart';
import '../../utils/util.dart';
import 'add_your_question.dart';

class QuestionAnswer extends StatefulWidget {
   QuestionAnswer({Key? key, this.userId, this.plotID, this.cropID}) : super(key: key);
  final userId;
  final plotID;
  final cropID;

  @override
  State<QuestionAnswer> createState() => _QuestionAnswerState();
}

class _QuestionAnswerState extends State<QuestionAnswer> with TickerProviderStateMixin{
  late Map mapresponse;
  List? listresponse;
  var jsonResponse;

  String? msg;
  String?data ;
  late AnimationController _controller;



  bool isLoaded = false;
  Future questionAnswerlist() async {
    http.Response response;
    response = await http.post(
        Uri.parse(
            'https://mycropguruapiwow.cropguru.in/api/QANDAAgronomist?USER_ID=${widget.plotID}&TYPE=user&AGRONOMIST_ID=${widget.userId}&PLOT_ID=${widget.plotID}'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(<String, String>{
          "START": "0",
          "END": "10",
          "WORD": "NONE",
          "LANG_ID": "1"
        }));
     jsonResponse = json.decode(response.body);
    print(jsonResponse["ResponseMessage"]);
    if (response.statusCode == 200) {
      mapresponse = json.decode(response.body);
    listresponse = mapresponse["DATA"];
      data = listresponse.toString();
      msg = jsonResponse["ResponseMessage"];
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
                title: InkWell(
                  onTap: (){

                  },
                  child: Text('Question Answer',
                    style: TextStyle(color: kWhite, fontSize: 20,fontWeight: FontWeight.bold),
                  ),
                ),
              )
          )
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
                    data:msg.toString()),
              ),
            ),
          ),
          Padding(
            padding:const EdgeInsets.symmetric(horizontal: 25,),
            child: Material(
              elevation: 1.0,
              child: InkWell(
                onTap: (){
                  Get.to(AddYourQuestion(userID: widget.userId,cropId: widget.cropID,plotId: widget.plotID,));
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
                  child: Text('Ok',
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
          shrinkWrap: true,
   // physics: NeverScrollableScrollPhysics(),
    itemBuilder: (context, index) {
      return Padding(
        padding: const EdgeInsets.all(4.0),
        child: InkWell(
          onTap: (){
            Get.to(Question_details(ans:listresponse![index]["FD_ANSWER"].toString(),question: listresponse![index]["FD_DESCRIPTION"].toString(),datetime:listresponse![index]["REG_DATE"].toString(),image:listresponse![index]["FD_IMAGE"].toString() ,));
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
            Text(listresponse![index]["FD_DESCRIPTION"].toString(), style: TextStyle(
                color: kblack,
                fontSize: 16,
                fontWeight: FontWeight.bold)),
            Center(child: Image.network(
              listresponse![index]["FD_IMAGE"].toString(),height: 250,errorBuilder: (context, error,
                stackTrace) {
              return Text("");
            },)),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(listresponse![index]["REG_DATE"].toString(),style: TextStyle(
                  color: kgrey,
                  fontSize: 16,
                )),

                Container(
                  height: 35,
                  width: 90,

                  decoration: BoxDecoration(color:listresponse![index]["STATUS"] == "Solved"  ?kgreen : kdarkred,
                      borderRadius: BorderRadius.circular(5)),
                  child: Center(
                    child: Text(listresponse![index]["STATUS"].toString(), style: TextStyle(
                        color: kWhite,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
                  ),),

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
      floatingActionButton: data == "[]" ?Text(""):Container(
        height: 70.0,
        width: 90.0,

        child: FittedBox(
          child: FloatingActionButton(
              backgroundColor: Colors.orange,
              child: Expanded(child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text("  Add Question",style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold)),
              )),

              onPressed: () {
                Get.to(AddYourQuestion(userID: widget.userId,cropId: widget.cropID,plotId: widget.plotID,));
              }),
        ),
      )
    );
  }
}
