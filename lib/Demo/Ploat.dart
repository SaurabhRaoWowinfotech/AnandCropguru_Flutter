import 'dart:convert';

import 'package:dr_crop_guru/utils/Colors.dart';
import 'package:dr_crop_guru/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Api/my_plot_api.dart';
import '../Componts/MyPloatPage/capsicum_farm.dart';
import '../Componts/SelectCrop.dart';
import 'package:http/http.dart' as http;

class Ploat extends StatefulWidget {
  Ploat({Key? key}) : super(key: key);

  @override
  State<Ploat> createState() => _PloatState();
}

class _PloatState extends State<Ploat> {
  double size = 15;

  double height = 38;

  double width = 104;
  late Map myplotmapresponse;
  List? myplotlistresponse;
  var jsonResponse;

  bool isLoaded = false;
  Future Myploat() async {
    http.Response response;
    response = await http.post(
        Uri.parse('https://mycropguruapiwow.cropguru.in/api/PlotList?&SALESTEAM_USER_ID=60640&TYPE=ALL'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(<String, String>{
          "START":"0",
          "END":"10",
          "WORD":"NPNE",
          "LANG_ID":"3",
          "ACCESS_TOKEN":"123456"
        }));
    jsonResponse = json.decode(response.body);
    print(jsonResponse["ResponseMessage"]);
    if (response.statusCode == 200) {
      print(response.body);


      myplotmapresponse = json.decode(response.body);
      myplotlistresponse = myplotmapresponse["DATA"];
      isLoaded = true;
    }
  }
 // unit Count api


@override
  void initState() {
  Future.delayed( Duration(seconds: 0), () {
    Myploat().then((value){
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
      floatingActionButton: FloatingActionButton(
        // isExtended: true,
        child: Icon(Icons.add),
        backgroundColor: Colors.orange,
        onPressed: () {
         Get.to(SelecctCrop(),transition: Transition.cupertinoDialog ,duration: Duration(seconds: 1));

        },
      ),
      body: Visibility(
        visible:  isLoaded,
        child: ListView.builder(
       shrinkWrap:  true,
       itemBuilder: (context, index) {
     var profit = myplotlistresponse![index]["TOTAL_INCOME"] - myplotlistresponse![index]["TOTAL_EXPENCES"];


        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 6),
          child: InkWell(

            onTap: (){
              Get.to(CapSicumFarm());
            },
            child: Container(
              height: 175,
              decoration: BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 3,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    child: SizedBox(
                      height: 20,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.delete,
                            size: 22,
                            color: lgreen,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5),
                            child: Container(
                              margin: EdgeInsets.all(0.0),
                              height: 22,
                              width: 50,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Util.newHomeColor,
                                        Util.endColor
                                      ]),
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(8),
                                  )),
                              child: Center(
                                  child: Text(
                                      myplotlistresponse![index]["STATUS"].toString(),
                                    style: TextStyle(
                                        color: kWhite,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: [
                        Text(
                          "Ploat Name : ",
                          style: TextStyle(color: kblack, fontSize: size),
                        ),
                        Text(
                          myplotlistresponse![index]["PLOT_NAME"].toString(),
                          style: TextStyle(
                            color: kgreen,
                            fontSize: size,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: [
                        Text(
                          "Crop name: ",
                          style: TextStyle(color: kblack, fontSize: size),
                        ),
                        Text(
                          "   ${myplotlistresponse![index]["CROP_NAME"].toString()}",
                          style: TextStyle(
                            color: kgreen,
                            fontSize: size,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 13),
                    child: Row(
                      children: [
                        Text(
                          " Crop Varietty: ",
                          style: TextStyle(color: kblack, fontSize: size),
                        ),
                        Text(
                           " ${myplotlistresponse![index]["V_NAME"].toString()}",
                          style: TextStyle(
                            color: kgreen,
                            fontSize: size,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              " Pruning date : ",
                              style: TextStyle(
                                  color: kblack, fontSize: size),
                            ),
                            Text(
                              "${myplotlistresponse![index]["PURNING_DATE"].toString()}",
                              style: TextStyle(
                                  color: kgreen,
                                  fontSize: size,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Icon(
                          Icons.arrow_right_alt_sharp,
                          size: 30,
                          color: Colors.orange,
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Expanded(
                      child: InkWell(
                        onTap: (){

                        },
                        child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                              color: kWhite,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(width: 2, color: kgrey)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Container(
                                  height: height,
                                  width: width,
                                  decoration: BoxDecoration(
                                    color: kWhite,
                                    border: Border(
                                      right: BorderSide(
                                        //                   <--- left side
                                        color: kgrey,
                                        width: 1.0,
                                      ),
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      Text("Expenses"),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      Text(
                                          myplotlistresponse![index]["TOTAL_EXPENCES"].toString()
                                        ,style: TextStyle(
                                            color: Colors.orange),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  height: height,
                                  width: width,
                                  decoration: BoxDecoration(
                                    color: kWhite,
                                    border: Border(
                                      right: BorderSide(
                                        //                   <--- left side
                                        color: kgrey,
                                        width: 1.0,
                                      ),
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      Text("Income"),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      Text(
                                        myplotlistresponse![index]["TOTAL_INCOME"].toString(),
                                        style: TextStyle(
                                            color: Colors.orange),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  height: height,
                                  width: width,
                                  color: kWhite,
                                  child: Column(
                                    children: [
                                      Text("Proffit/Loss"),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      Text(
                                         profit > 0 ?"+${profit.toString()}":profit.toString(),
                                        style: TextStyle(color:   profit == 0.0 ? Colors.red : kgreen),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },itemCount:myplotlistresponse == null ? 0 : myplotlistresponse!.length,
        ),replacement: Center(child: CircularProgressIndicator())
      ),
    );
  }
}
