import 'package:flutter/material.dart';

import '../../utils/Colors.dart';

class ExpenseList extends StatelessWidget {
   ExpenseList({Key? key, this.productname}) : super(key: key);
  final productname;


  @override
  Widget build(BuildContext context) {
    return
      ListView.builder(
        itemBuilder: (context, index) {
          return Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(8),
            child: Container(
              height: 95,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: kWhite,
                  border: Border.all(width: 3, color: pgrey)
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("Product tName :-",
                            style: TextStyle(
                              color: kgreyy,
                              fontSize: 13,
                            )),
                        Text("Productname",
                            style: TextStyle(
                                color: kblack,
                                fontSize: 13,
                                fontWeight: FontWeight.bold
                            ))
                      ],
                    ),
                    SizedBox(height: 5,),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text("Quantity:-",
                                style: TextStyle(
                                  color: kgreyy,
                                  fontSize: 13,
                                )),
                            Text(" 12.0",
                                style: TextStyle(
                                  color: kgreyy,
                                  fontSize: 13,

                                )),
                          ],
                        ),
                        SizedBox(width: 50,),
                        Row(
                          children: [
                            Text(" Unit",
                                style: TextStyle(
                                  color: kgreyy,
                                  fontSize: 13,

                                )),
                            Text(" Crate",
                                style: TextStyle(
                                  color: kgreyy,
                                  fontSize: 13,

                                )),
                          ],
                        )
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text("Category:-",
                                style: TextStyle(
                                  color: kgreyy,
                                  fontSize: 13,
                                )),
                            Text(" text",
                                style: TextStyle(
                                  color: kgreyy,
                                  fontSize: 13,

                                )),
                          ],
                        ),

                        Icon(
                          Icons.arrow_right_alt_sharp,
                          size: 28,
                          color: kgreen,
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(" Remark :-",
                            style: TextStyle(
                              color: kblack,
                              fontSize: 13,

                            )),
                        Text(" vvv :-",
                            style: TextStyle(
                              color: kgreyy,
                              fontSize: 13,

                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
