


import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../utils/Colors.dart';
import '../utils/util.dart';

class EmergencyCallDetail extends StatefulWidget {
  const EmergencyCallDetail({Key? key, this.callcategory, this.calldate, this.remark, this.callsolution}) : super(key: key);
  final callcategory;
  final calldate;
  final remark;
  final callsolution;

  @override
  State<EmergencyCallDetail> createState() => _EmergencyCallDetailState();
}

class _EmergencyCallDetailState extends State<EmergencyCallDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 110,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Util.newHomeColor, Util.endColor]),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),

            ),
            child: Column(
              children: [
                SizedBox(height: 55,),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 3,),

                      IconButton(
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.arrow_back,size: 30,color: kWhite)

                      ),
                      SizedBox(width: 9,),
                      Text(
                        "Emergency Call ",
                        style: TextStyle(
                            color: kWhite,
                            fontSize: 27,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                )
              ],
            ),

          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
            child: Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(8),
              child: Container(

                decoration: BoxDecoration(
                    color: kWhite,
                    borderRadius: BorderRadius.circular(8)
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 18,),
                      Row(
                        children: [
                          Text(
                            "Call Category",
                            style: TextStyle(
                              color: kblack,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            widget.callcategory,
                            style: TextStyle(
                              color: kgreen,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 9,),
                      Row(
                        children: [
                          Text(
                            "CALL DATE:",
                            style: TextStyle(
                              color: kblack,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                           widget.calldate,
                            style: TextStyle(
                              color: kgreen,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 9,),
                      Row(
                        children: [
                          Text(
                            "Remark :",
                            style: TextStyle(
                              color: kblack,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "",
                            style: TextStyle(
                              color: kblack,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5,),
                      Text(
                       widget.remark,
                        style: TextStyle(
                          color: kgreen,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 10,),
                      widget.callsolution==null? Text(""):   Text(
                        "CALL SOLUTION ",
                        style: TextStyle(
                          color: kblack,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(
                        width: 52,
                      ),
                      widget.callsolution==null?  Text("") :   Html(
                          data:widget.callsolution.toString())

                    ],
                  ),
                ),

              ),
            ),
          ),

        ],
      ),
    );
  }

}
