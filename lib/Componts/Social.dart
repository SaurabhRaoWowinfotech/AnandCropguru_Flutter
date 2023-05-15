import 'package:dr_crop_guru/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

import '../utils/util.dart';

class Social extends StatelessWidget {
   Social({Key? key}) : super(key: key);
  String? url;

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
                        "Social",
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
          Text(
            "Contact us",
            style: TextStyle(
                color: kblack,
                fontSize: 30,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10,),
          Text(
            "खाली दिलेल्या माध्यमांतून तुम्ही आमच्याशी संपर्क करू\nशकता.",
            style: TextStyle(
                color: kblack,
                fontSize: 15,
               ),
          ),
          SizedBox(height: 25,),
          Divider(height: 2,) ,
          SizedBox(height: 25,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
               InkWell(

                 onTap: () async {
                   final link = WhatsAppUnilink(
                     phoneNumber: "7219315664",

                   );
                   await launch('$link');
                 },

                 child: Column(
                   children: [
                     Image.asset("assets/images/whatsapp.png",height: 45,),
                     SizedBox(height: 5,),
                     Text(
                       "Whatsapp",
                       style: TextStyle(
                         color: kblack,
                         fontSize: 15,
                       ),
                     ),

                   ],
                   ),
               ),

                InkWell(
                    onTap: () async {
                      print("hello");

                      url = "https://www.facebook.com/drcropguru";
                      if (await canLaunch(url!)) {
                        await launch(
                          url!,
                          headers: {
                            "Content-Type": "application/x-www-form-urlencoded",
                            "Content-Disposition": "inline"
                          },
                        );
                        print("browser url");
                        print(url);
                      } else
                        // can't launch url, there is some error
                        throw "Could not launch $url";
                    },

                  child: Column(
                    children: [
                      Image.asset("assets/images/facebook-logo-2019.png",height: 45,),
                      SizedBox(height: 5,),
                      Text(
                        "FaceBook",
                        style: TextStyle(
                          color: kblack,
                          fontSize: 15,
                        ),
                      ),

                    ],
                  ),
                ),
                InkWell(

                    onTap: () async {
                      print("hello");
                      url = "www.instagram.com/drcropguru";
                      if (await canLaunch(url!)) {
                        await launch(
                          url!,
                          headers: {
                            "Content-Type": "application/x-www-form-urlencoded",
                            "Content-Disposition": "inline"
                          },
                        );
                        print("browser url");
                        print(url);
                      } else
                        // can't launch url, there is some error
                        throw "Could not launch $url";


                  },
                  child: Column(
                    children: [
                      Image.asset("assets/images/instagram.png",height: 45,),
                      SizedBox(height: 5,),
                      Text(
                        "Instagram",
                        style: TextStyle(
                          color: kblack,
                          fontSize: 15,
                        ),
                      ),

                    ],
                  ),
                ),
                InkWell(
                  onTap: () async {
                    print("hello");

                    url = "https://www.youtube.com/drcropguru";
                    if (await canLaunch(url!)) {
                      await launch(
                        url!,
                        headers: {
                          "Content-Type": "application/x-www-form-urlencoded",
                          "Content-Disposition": "inline"
                        },
                      );
                      print("browser url");
                      print(url);
                    } else
                      // can't launch url, there is some error
                      throw "Could not launch $url";

                  },
                  child: Column(
                    children: [
                      Image.asset("assets/images/youtube.png",height: 45,),
                      SizedBox(height: 5,),
                      Text(
                        "Youtube",
                        style: TextStyle(
                          color: kblack,
                          fontSize: 15,
                        ),
                      ),

                    ],
                  ),
                )
                ],
            ),
          )

        ],
      ),

    );
  }
}
