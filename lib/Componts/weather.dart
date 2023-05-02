

import 'package:dr_crop_guru/utils/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Weather extends StatelessWidget {
  const Weather({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.height ,

        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/images/weaimg.png'),
            fit: BoxFit.fill,
          ),

        ),
        child: Column(
          children: [

            Container(
              height: 100,
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    SizedBox(height: 47,),
                    Row(
                      children: [
                        Icon(Icons.arrow_back,size: 30, color: kWhite,),
                        SizedBox(width: 8,),
                        Text("Weather",style: TextStyle(fontSize: 25 ,fontWeight: FontWeight.bold ,color: kWhite),)
                      ],
                    ),
                  ],
                ),
              ),

            ),
            Expanded(

              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 8,),
                   Text('2023-04-4 11:01',style: TextStyle(color: kWhite, fontWeight: FontWeight.bold, fontSize: 20), ),
                   Row(
                     children: [

                     ],

                   ),
                    SizedBox(height: 110,),
                Text('14.0 C',style: TextStyle(color: kWhite, fontWeight: FontWeight.bold, fontSize: 80), ),

                    SizedBox(height: 20,),
                 Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 15),
                   child: Container(
                     height: 330,

                     decoration: BoxDecoration(
                         gradient: LinearGradient(
                             begin: Alignment.topCenter,
                             end: Alignment.bottomCenter,
                             colors: [
                               lblue,
                             dblue,

                             ]


                         ),
                       border: Border.all(width: 0.5, color: kwBorder),
                       borderRadius: BorderRadius.circular(16)
                     ),
                     child:Column(
                       children: [
                         SizedBox(height: 9,),
                         Center(child: Text('2023-04-4 11:01',style: TextStyle(color: kWhite, fontWeight: FontWeight.bold, fontSize: 20), )),
                         SizedBox(height: 40,),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                           children: [

                             Text('Partly\ncloudy',style: TextStyle(color: kWhite, fontWeight: FontWeight.bold, fontSize: 30), ),
                             Image.asset("assets/images/weather.png",height: 80,),
                           ],
                         ),
                         SizedBox(height: 60,),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                           children: [
                             Row(
                               children: [
                                 Image.asset("assets/images/heat.png",height: 30,color: kWhite),
                                 SizedBox(width: 9,),
                                 Column(
                                   children: [
                                     Text("Min max Temp",style:  TextStyle(color: kWhite, fontSize: 15), ) , Text("19.0/19.0",style:  TextStyle(color: kWhite,  fontSize: 15))
                                   ],
                                 )
                               ],
                             ),
                             Row(
                               children: [


                                 Image.asset("assets/images/humidity.png",height: 28,color: kWhite,),
                                 SizedBox(width: 9,),
                                 Column(
                                   children: [
                                     Text("Min max Temp",style:  TextStyle(color: kWhite, fontSize: 15), ) , Text("43 %",style:  TextStyle(color: kWhite,  fontSize: 15))
                                   ],
                                 )
                               ],
                             )
                           ],
                         ),
                         SizedBox(height: 18,),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                           children: [
                             Row(
                               children: [
                                 Image.asset("assets/images/wind.png",height: 30,color: kWhite),
                                SizedBox(width: 9,),
                                 Column(
                                   children: [
                                     Text("Wind Speed",style:  TextStyle(color: kWhite, fontSize: 15), ) , Text("19.0/19.0",style:  TextStyle(color: kWhite,  fontSize: 15))
                                   ],
                                 )
                               ],
                             ),
                             Row(
                               children: [
                                 Image.asset("assets/images/pressure.png",height: 28,color: kWhite,),
                                 SizedBox(width: 9,),
                                 Column(
                                   children: [
                                     Text("Pressure",style:  TextStyle(color: kWhite, fontSize: 15), ) , Text(" 1013.0 hpa %",style:  TextStyle(color: kWhite,  fontSize: 15))
                                   ],
                                 )
                               ],
                             )
                           ],
                         ),
                       ],
                     ) ,
                   ),
                 )
















                  ],
                ),
              ),
            )
          ],
        ),
        ),

    );
  }
}
