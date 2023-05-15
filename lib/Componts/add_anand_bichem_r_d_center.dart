

import 'package:dr_crop_guru/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Api/add_anand_bichem_r_d_ceenter_api.dart';
import '../utils/util.dart';
import 'Purchase.dart';

class AddAnandBichemRDCenter extends StatelessWidget {
   AddAnandBichemRDCenter({Key? key, this.category, this.amount, this.imageurl, this.videourl}) : super(key: key);
  final category;
  final amount;
  final imageurl;
  final videourl;

  String? url;
   TextEditingController pincodeController = TextEditingController();
   TextEditingController addresssController = TextEditingController();
   TextEditingController remarkController = TextEditingController();
   dynamic imageData = "";
   final anandcenter = GlobalKey<FormState>();

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
                    mainAxisAlignment: MainAxisAlignment.center,
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
                        "Anand Biochem R & D Center",
                        style: TextStyle(
                            color: kWhite,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: SingleChildScrollView(
                  child: Form(
                    key: anandcenter,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20,),
                        Text(
                          "Category :",
                          style: TextStyle(
                              color: kgreen,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                      Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: ksoilColor,
                          borderRadius: BorderRadius.circular(5)
                        ),
                        child:  Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Row(
                            children: [
                              Text(
                                category,
                                style: TextStyle(
                                    color: kblack,
                                    fontSize: 12,
                                   ),
                              ),
                            ],
                          ),
                        ),

                      ),
                        SizedBox(height: 10,),
                        Text(
                          "Amount :",
                          style: TextStyle(
                              color: kgreen,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: 40,
                          decoration: BoxDecoration(
                            border: Border.all(width: 1,color: kgrey),
                              borderRadius: BorderRadius.circular(5)

                          ),
                          child:   Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Row(
                              children: [
                                Text(
                                  amount.toString(),
                                  style: TextStyle(
                                    color: kblack,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),


                        ),
                        SizedBox(height: 10,),

                        Text(
                          "How to collect sample ? ",
                          style: TextStyle(
                              color: kgreen,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        InkWell(
                          onTap: () async {
                            print("hello");

                            url = "https://www.youtube.com/watch?v=${videourl}";
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
                          child: Container(
                            alignment: Alignment.center,
                            height: 150,
                            decoration: BoxDecoration(
                                border: Border.all(width: 1,color: kgrey),
                                borderRadius: BorderRadius.circular(5)

                            ),
                            child: Stack(
                              children: [

                                Image.network(imageurl,fit: BoxFit.cover,width: MediaQuery.of(context).size.width,height:MediaQuery.of(context).size.height ,),
                                Center(child: Image.asset("assets/images/play.png",height: 40,color: Colors.red,)),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),

                        Text(
                          "Pin Code :",
                          style: TextStyle(
                              color: kgreen,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                         controller: pincodeController,
                          onChanged: (value) {},
                          style: TextStyle(fontSize: 13),
                           keyboardType: TextInputType.number,
                          // maxLength: 10,
                          // controller: _mobile,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(5.0),
                            //   errorText: _mobileValidated ? null : _mobileError,
                            //  suffixIcon: Icon(Icons.call),
                            hintText: 'Enter Question',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                //  color: Util.colorPrimary,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          validator: (text) {
                            if (text!.isEmpty) {
                              return "pincode";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10,),
                        Text(
                          "Address :",
                          style: TextStyle(
                              color: kgreen,
                              fontSize: 14,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(height: 10,),
                        TextFormField(
                         controller: addresssController,
                          maxLines: 5,
                          onChanged: (value) {},
                          style: TextStyle(fontSize: 13),
                          decoration: InputDecoration(
                            hintText: 'Enter Address',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          validator: (text) {
                            if (text!.isEmpty) {
                              return "Address";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10,),
                        Text(
                          "Remark:",
                          style: TextStyle(
                              color: kgreen,
                              fontSize: 14,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(height: 10,),
                        TextFormField(
                          style: TextStyle(fontSize: 13),
                           controller: remarkController,
                          maxLines: 5,
                          onChanged: (value) {},

                          /// keyboardType: TextInputType.number,

                          // maxLength: 10,
                          // controller: _mobile,
                          decoration: InputDecoration(
                            //   errorText: _mobileValidated ? null : _mobileError,
                            //  suffixIcon: Icon(Icons.call),
                            hintText: 'Remark',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                //  color: Util.colorPrimary,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          validator: (text) {
                            if (text!.isEmpty) {
                              return "remark";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 3,)
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: (){
      if (anandcenter.currentState!.validate()) {
        Navigator.pop(context);

      } else {

      }
    },


            child: InkWell(
              onTap: (){
                AnandBiochemCenterApi.anandBiochemRanddcenter(category,amount);
              },
              child: Container(
                alignment: Alignment.center,
                height: 50,
                color: kgreen,
                child: Text(
                  "Submit",
                  style: TextStyle(
                      color: kWhite,
                      fontSize: 18,

                  ),
                ),
              ),
            ),
          )
        ],
      ),

    );
  }
}
