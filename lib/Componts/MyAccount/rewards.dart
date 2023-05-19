


import 'package:flutter/material.dart';

import '../../utils/Colors.dart';
import '../../utils/util.dart';

class Rewards extends StatelessWidget {
  const Rewards({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
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
                SizedBox(
                  height: 55,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 3,
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.arrow_back,
                              size: 30, color: kWhite)),
                      SizedBox(
                        width: 9,
                      ),
                      Text(
                        "Rewards",
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
          SizedBox(height: 40,),
          Image.asset("assets/images/social.jpg"),
          SizedBox(height: 50,),
         Padding(
           padding: const EdgeInsets.symmetric(horizontal: 12),
           child: Container(
             alignment: Alignment.center,
             height: 48,
             decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(16),
               color: lgery,
             ),
             child: Text(
               "Wallet Amount = Rs.0",
               style: TextStyle(
                   color: kblack,
                   fontSize: 15,
                   fontWeight: FontWeight.bold),
             ),

           ),
         ),
          SizedBox(height: 25,),
          Divider(thickness: 1,) ,
          SizedBox(height: 25,),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Text(
                  "My Rewards >>",
                  style: TextStyle(
                      color: kblack,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),


        ],
      ),

    );
  }
}
