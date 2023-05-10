import 'package:flutter/material.dart';

import '../../utils/Colors.dart';
import '../../utils/util.dart';

class Question_details extends StatefulWidget {
  Question_details(
      {Key? key, this.question, this.datetime, this.image, this.ans})
      : super(key: key);
  final question;
  final datetime;
  final image;
  final ans;

  @override
  _Question_detailsState createState() => _Question_detailsState();
}

class _Question_detailsState extends State<Question_details> {
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
                    builder: (context) =>
                        IconButton(
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
                          MaterialLocalizations
                              .of(context)
                              .openAppDrawerTooltip,
                        ),
                  ),
                  title: InkWell(
                    onTap: () {

                    },
                    child: Text('Question details',
                      style: TextStyle(color: kWhite,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )
            )
        ),
        body: Column(
          children: [
            SizedBox(height: 5,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Container(

                decoration: BoxDecoration(
                    color: kWhite,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.grey,
                        blurRadius: 5,
                        spreadRadius: 1,
                        offset: Offset(4, 4)
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(widget.question,
                            style: TextStyle(color: kblack,
                                fontSize: 15,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          Text(widget.datetime,
                            style: TextStyle(color: kgreyy,
                                fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                       Center(child: Image.network(widget.image,errorBuilder: (context, error,
                           stackTrace) {
                         return Text("");
                       }))  ,

                      Row(
                        children: [
                          Text(widget.ans == null ?widget.ans : "Unsolved",
                          style: TextStyle(color: kblack,
                                fontSize: 15,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15,),
                    ],
                  ),
                )
              ),
            ),
          ],
        )
    );
  }
}