

import 'dart:convert';

import 'package:dr_crop_guru/Componts/MyPloatPage/question_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../Api/add_your_question.dart';
import '../../utils/Colors.dart';
import '../../utils/util.dart';
import 'add_your_question.dart';

class QuestionAnswer extends StatefulWidget {
  const QuestionAnswer({Key? key}) : super(key: key);

  @override
  State<QuestionAnswer> createState() => _QuestionAnswerState();
}

class _QuestionAnswerState extends State<QuestionAnswer> {
  late Map mapresponse;
  List? listresponse;



  bool isLoaded = false;
  Future questionAnswerlist() async {
    http.Response response;
    response = await http.post(
        Uri.parse(
            'https://mycropguruapiwow.cropguru.in/api/QANDAAgronomist?USER_ID=60640&TYPE=user&AGRONOMIST_ID=60640&PLOT_ID=69234'),
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
    listresponse = mapresponse["DATA"];
    //  print(listresponse![0]["SCHEDUEL_ID"]);
      isLoaded = true;
    }
  }
  @override
  void initState() {
    questionAnswerlist();
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
      body: Visibility(
        visible: isLoaded,
        child: ListView.builder(
          shrinkWrap: true,
    itemBuilder: (context, index) {
      return Padding(
        padding: const EdgeInsets.all(4.0),
        child: InkWell(
          onTap: (){
            Get.to(Question_details(ans:listresponse![index]["FD_ANSWER"].toString()));
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
              listresponse![index]["FD_IMAGE"],height: 250,errorBuilder: (context, error,
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
      floatingActionButton: Container(
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
                Get.to(AddYourQuestion());
              }),
        ),
      ),
    );
  }
}
