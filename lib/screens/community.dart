import 'dart:convert';
import 'dart:io';

import 'package:dr_crop_guru/screens/add_post_community_page.dart';
import 'package:dr_crop_guru/screens/post_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:share_plus/share_plus.dart';
import '../utils/Colors.dart';
import '../utils/util.dart';

class Communitty extends StatefulWidget {
  const Communitty({Key? key}) : super(key: key);

  @override
  State<Communitty> createState() => _CommunittyState();
}

class _CommunittyState extends State<Communitty> with TickerProviderStateMixin {
  late Map mapresponse;
  List? listresponse;
  bool isLoaded = false;
  late AnimationController _controller;
  var jsonResponse;
  Future postApi() async {
    http.Response response;
    response = await http.post(
        Uri.parse(
            'http://mycropguruapiwow.cropguru.in/api/Get_Data'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(<String, dynamic>{
          "START": 0,
          "END": 10000,
          "WORD": "NONE",
          "GET_DATA": "Get_AllPost",
          "ID1": "62819",
          "ID2": "",
          "ID3": "",
          "STATUS": "",
          "START_DATE": "",
          "END_DATE": "",
          "EXTRA1": "",
          "EXTRA2": "",
          "EXTRA3": "",
          "LANG_ID": "3"
        }));
    jsonResponse = json.decode(response.body);
    print(jsonResponse["ResponseMessage"]);
    if (response.statusCode == 200) {
      print(response.body);

      mapresponse = json.decode(response.body);
      listresponse = mapresponse["DATA"];
      isLoaded = true;
    }
  }

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );
    _controller.addListener(() {
      if (_controller.isCompleted) {
        _controller.reset();
        _controller.forward();
      }

    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Util.animatedProgressDialog(context, _controller);
      _controller.forward();
    });
    postApi().then((value) {
      _controller.reset();
      Navigator.pop(context);
      setState(() {});
      return value;
    });
    postApi();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
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
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 9,
                          ),
                          Text(
                            "Krushi Charcha",
                            style: TextStyle(
                                color: kWhite,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          InkWell(
                            onTap: (){
                              Get.to(AddPostCommunity());
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 40,
                              width: 90,
                              decoration: BoxDecoration(
                                color: Colors.orange
                                    ,borderRadius: BorderRadius.circular(50)
                              ),
                              child:Text(
                                  "ADD POST",
                                  style: TextStyle(
                                      color: kWhite,
                                      fontSize: 15,
                                    fontWeight: FontWeight.bold
                                      )),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: 40,
                            width: 90,
                            decoration: BoxDecoration(
                                color: Colors.orange
                                ,borderRadius: BorderRadius.circular(50)
                            ),
                            child:Text(
                                "MY POST",
                                style: TextStyle(
                                    color: kWhite,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold
                                )),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),


              SizedBox(height: 5,),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: ListView.builder(
                    shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Material(
                        borderRadius: BorderRadius.circular(13),
                        elevation: 5,
                        child: InkWell(
                          onTap: (){
                            Get.to(PostDetailsScreen(
                              profilePhoto: listresponse![index]["PROFILE_PHOTO"],
                              postId:listresponse![index]["POST_ID"] ,
                              userId: listresponse![index]["USER_ID"],
                              likeecount: listresponse![index]["MY_LIKE_COUNT"],
                              todaydate:listresponse![index]["REG_DATE"],
                              image: listresponse![index]["POST_PHOTO"],
                              username:listresponse![index]["FULL_NAME"].toString(),
                              cropName: listresponse![index]["FULL_NAME"].toString(),
                              information: listresponse![index]["POST_DESCRIPTION"].toString(),));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: kWhite,
                              borderRadius: BorderRadius.circular(13),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 8,),
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 22,
                                        backgroundColor: kgreen,
                                        child: CircleAvatar(
                                          radius: 20,
                                          child: Image.network(listresponse![index]["PROFILE_PHOTO"].toString(),
                                              errorBuilder: (context, error, stackTrace) {
                                                return Image.asset(
                                                  "assets/images/profile.png",
                                                  height: 200,
                                                );
                                              }
                                          ),
                                         )
                                      ),
                                      SizedBox(width: 8,),
                                      Text(listresponse![index]["FULL_NAME"].toString(), style: TextStyle(
                                          color: kblack,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  Divider(thickness: 1,),

                                  Container(
                                      alignment: Alignment.center,
                                      height: 20,
                                      width: 60,
                                      decoration: BoxDecoration(
                                          color: sgreen,
                                          borderRadius: BorderRadius.circular(50),
                                          border: Border.all(color: kgreen)

                                      ),
                                      child: Text(listresponse![index]["CROP_NAME"].toString(), style: TextStyle(
                                          color: kblack,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold
                                      ),)),
                                  SizedBox(height: 8,),

                                  Text(listresponse![index]["POST_NAME"].toString(), style: TextStyle(
                                      color: kblack,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold
                                  ),),
                                  SizedBox(height: 12,),
                                  Container(
                                    height: 250,
                                    decoration: BoxDecoration(

                                        image: DecorationImage(
                                          image: NetworkImage(
                                            listresponse![index]["POST_PHOTO"].toString() == ""?"https://us.123rf.com/450wm/mathier/mathier1905/mathier190500002/134557216-no-thumbnail-image-placeholder-for-forums-blogs-and-websites.jpg?ver=6":listresponse![index]["POST_PHOTO"].toString() ),

                                            fit: BoxFit.fill,

                                        )
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .center,
                                          crossAxisAlignment: CrossAxisAlignment
                                              .center,
                                          children: [
                                            Image.asset("assets/images/like.png",
                                                height: 25, color: kgreen),
                                            SizedBox(width: 5,),

                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 5),
                                              child: Text( listresponse![index]["MY_LIKE_COUNT"].toString(), style: TextStyle(
                                                  color: kblack, fontSize: 20),),
                                            ),

                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 40, width: 1, color: kblack,),
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .center,
                                          crossAxisAlignment: CrossAxisAlignment
                                              .center,
                                          children: [
                                            Icon(Icons.message, size: 27,
                                                color: kgreen),
                                            SizedBox(width: 8,),
                                            Text(listresponse![index]["TOTAL_COMMENT_COUNT"].toString(), style: TextStyle(
                                                color: kblack, fontSize: 20),),

                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 40, width: 1, color: kblack,),
                                      SizedBox(width: 2,),
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .center,
                                          crossAxisAlignment: CrossAxisAlignment
                                              .center,
                                          children: [
                                            GestureDetector(

                                              child: Icon(Icons.share, size: 25,
                                                color: kgreen,),
                                              onTap: (){
                                                Share.shareFiles([], text: 'Great picture');
                                              },
                                            ),
                                            SizedBox(width: 8,),
                                            Text("Share", style: TextStyle(
                                                color: kblack, fontSize: 16),),

                                          ],
                                        ),
                                      ),

                                    ],
                                  ),
                                  Divider(thickness: 1,),
                                  SizedBox(height: 10,),

                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text("16 May 2023", style: TextStyle(
                                          color: kgreyy, fontSize: 16),),
                                    ],
                                  ),
                                  SizedBox(height: 10,),


                                ],
                              ),
                            ),


                          ),
                        ),
                      ),
                    );
                  },itemCount: listresponse == null ? 0 : listresponse!.length,
                  ),
                ),
              )
            ],
          ),
    );
  }
}
