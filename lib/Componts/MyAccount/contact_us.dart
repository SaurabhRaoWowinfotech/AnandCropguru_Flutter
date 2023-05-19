import 'package:dr_crop_guru/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/util.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({Key? key}) : super(key: key);
  _callNumber() async {
    //  const number = widget.mobileNumber; //set the number here
    bool? res = await FlutterPhoneDirectCaller.callNumber("9403415664");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar:AppBar(
        leading:  IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back,size: 30,color: kWhite)

        ),
        title:  Text(
          "Contact Us",
          style: TextStyle(
              color: kWhite,
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
      ) ,
      body: Column(
        children: [
          Center(child: SizedBox(
            height: 300,
              width: 400,
              child: Image.asset("assets/images/splash_logo.png",))),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(5),
              child: Container(
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: kWhite
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround

                  ,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/images/telephone-call.png",height: 45,color: kgreen,)

                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Customer care no.",
                          style: TextStyle(
                              color: kgrey,
                              fontSize: 15,
                             ),
                        ),
                     SizedBox(height: 3,),
                     SizedBox(
                       width:MediaQuery.of(context).size.width-100,
                         child: Container(height: 1,color: kgreyy,)),
                        SizedBox(height: 3,),
                       GestureDetector(
                         onTap: (){
                           _callNumber();
                         },
                         child: Text(
                            "9403415664",
                            style: TextStyle(
                                color: mblue,
                                fontSize: 15,
                               ),
                          ),
                       ),


                      ],
                    )
                  ],
                ),
              ),
            ),
          ),

       SizedBox(height: 15,),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(5),
              child: Container(
                height: 70,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: kWhite
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround

                  ,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                       Icon(Icons.mail,size: 45,color: kgreen,)

                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Email",
                          style: TextStyle(
                            color: kgrey,
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(height: 3,),
                        SizedBox(
                            width:MediaQuery.of(context).size.width-100,
                            child: Container(height: 1,color: kgreyy,)),
                        SizedBox(height: 3,),
                        GestureDetector(
                          onTap: ()async{

                            String url;
                            url =
                            "https://mail.google.com/mail/u/0/?tab=rm&ogbl=drcropguru@gmail.com";
                            if (await canLaunch(url!)) {
                            await launch(
                            url!,
                            headers: {
                            "Content-Type": "application/x-www-form-urlencoded",
                            "Content-Disposition": "inline"
                            },
                            );
                            } else
                            // can't launch url, there is some error
                            throw "Could not launch $url";
                          },
                          child: Text(
                            "drcropguru@gmail.com",
                            style: TextStyle(
                              color: mblue,
                              fontSize: 15,
                            ),
                          ),
                        ),


                      ],
                    )
                  ],
                ),
              ),
            ),
          ),

          SizedBox(height: 15,),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(5),
              child: Container(
                height: 70,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: kWhite
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround

                  ,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.mail,size: 45,color: kgreen,)

                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Website",
                          style: TextStyle(
                            color: kgrey,
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(height: 3,),
                        SizedBox(
                            width:MediaQuery.of(context).size.width-100,
                            child: Container(height: 1,color: kgreyy,)),
                        SizedBox(height: 3,),
                        GestureDetector(
                          onTap: ()async{

                            String url;
                            url =
                            "https://cropguru.in/";
                            if (await canLaunch(url!)) {
                              await launch(
                                url!,
                                headers: {
                                  "Content-Type": "application/x-www-form-urlencoded",
                                  "Content-Disposition": "inline"
                                },
                              );
                            } else
                              // can't launch url, there is some error
                              throw "Could not launch $url";
                          },
                          child: Text(
                            "drcropguru@gmail.com",
                            style: TextStyle(
                              color: mblue,
                              fontSize: 15,
                            ),
                          ),
                        ),


                      ],
                    )
                  ],
                ),
              ),
            ),
          ),

          SizedBox(height: 15,),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(5),
              child: Container(
                height: 70,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: kWhite
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround

                  ,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.mail,size: 45,color: kgreen,)

                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Address",
                          style: TextStyle(
                            color: kgrey,
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(height: 3,),
                        SizedBox(
                            width:MediaQuery.of(context).size.width-100,
                            child: Container(height: 1,color: kgreyy,)),
                        SizedBox(height: 3,),
                        Text(
                          "176 , khatwad phata,Talegaon\n dindori,Dindori,Nashik",
                          style: TextStyle(
                            color: lgreen,
                            fontSize: 15,
                          ),
                        ),


                      ],
                    )
                  ],
                ),
              ),
            ),
          )


        ],
      ),
    );
  }
}
