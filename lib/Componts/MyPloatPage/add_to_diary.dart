

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/Colors.dart';
import '../../utils/util.dart';

class AddToDiary extends StatefulWidget {
   AddToDiary({Key? key}) : super(key: key);

  @override
  State<AddToDiary> createState() => _AddToDiaryState();
}

class _AddToDiaryState extends State<AddToDiary> {
  List<String> items = <String>['Soil type', 'Light clay', 'Medium red', 'Black', 'Medium Black','Black solid', 'Limestone' , 'Sherwat'', Light Soil' , 'sandy soil'];

  String dropdownvalue = 'Soil type';

  String _selectedGender = 'male';

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
                builder: (context) => IconButton(
                  icon: InkWell(
                    onTap: ()=>  Navigator.pop(context),
                    child: Icon(
                      Icons.arrow_back,
                      color: kWhite,
                    ),
                  ),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  tooltip:
                  MaterialLocalizations.of(context).openAppDrawerTooltip,
                ),
              ),
              title: Text('Add Diary',
                style: TextStyle(color: kWhite, fontSize: 20,fontWeight: FontWeight.bold),
              ),
            )
        ),
      ),
      body:SingleChildScrollView(

        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              SizedBox(height: 20,),

              Text("Schedule Type :",style: TextStyle(color: kgreen ,fontSize: 17,fontWeight: FontWeight.bold),),
              SizedBox(height: 8,),
              Container(
                height: 40,
                decoration: BoxDecoration(
                    border: Border.all(width: 1,color:Colors.grey, ),
                    borderRadius: BorderRadius.circular(5)

                ),
                child: Row(
                  children: [
                    SizedBox(width: 10,),
                    Row(
                      children: [
                        Radio<String>(
                          activeColor: gridio,
                          value: 'Spray',
                          groupValue: _selectedGender,
                          onChanged: (value) {
                            setState(() {
                              _selectedGender = value!;
                            });
                          },
                        ),
                        Text("Spray",style:   TextStyle(color: kblack, fontSize: 15 , fontFamily: 'newfont'),)
                      ],
                    ),
                    SizedBox(width: 20,),
                    Row(
                      children: [
                        Radio<String>(
                          activeColor: gridio,
                          value: 'Fertilizer',
                          groupValue: _selectedGender,
                          onChanged: (value) {
                            setState(() {
                              _selectedGender = value!;
                            });
                          },
                        ),
                        Text(" Fertilizer",style:   TextStyle(color: kblack, fontSize: 15 , fontFamily: 'newfont'),)
                      ],
                    ),

                  ],
                ),
              ),
              SizedBox(height: 15,),
              Text("Title :",style: TextStyle(color: kblack ,fontSize: 17,fontWeight: FontWeight.bold),),
              SizedBox(height: 8,),
              TextField(

                // controller: _mobile,
                decoration: InputDecoration(

                  isDense: true, // important line
                  contentPadding: EdgeInsets.fromLTRB(13,13,13,13),
                  //errorText: _mobileValidated ? null : _mobileError,

                  hintText: 'Title',
                  border: OutlineInputBorder(

                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),




              SizedBox(height: 10,),
              Text("Date :",style: TextStyle(color: kblack ,fontSize: 17,fontWeight: FontWeight.bold),),
              SizedBox(height: 5,),
              TextField(

                // controller: _mobile,
                decoration: InputDecoration(

                  isDense: true, // important line
                  contentPadding: EdgeInsets.fromLTRB(14,14,14,14),
                  //errorText: _mobileValidated ? null : _mobileError,

                  hintText: 'Please select date',
                  border: OutlineInputBorder(

                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),

              SizedBox(height: 20,),
              Text("Description :",style: TextStyle(color: kblack ,fontSize: 17,fontWeight: FontWeight.bold),),
              SizedBox(height: 5,),
              SizedBox(

                height: 120, // <-- TextField height
                child: TextField(

                  // controller: _mobile,
                  maxLines: null,
                  expands: true,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(

                    isDense: true, // important line
                    contentPadding: EdgeInsets.fromLTRB(12,12,12,12),
                    //errorText: _mobileValidated ? null : _mobileError,

                    hintText: ' ',
                    border: OutlineInputBorder(

                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Text("Total Area (Acers):",style: TextStyle(color: kgreen ,fontSize: 17,fontWeight: FontWeight.bold),),
              SizedBox(height: 5,),

              Container(
                height: 150,

                decoration: BoxDecoration(
                    color: kblack,
                  borderRadius: BorderRadius.circular(5)
                ),
                child: Center(
                  child: Icon(Icons.camera_alt_sharp,color: lgreen,size: 30,),
                ),
              ),



              SizedBox(height: 20,),

            ],
          ),
        ),
      ),

persistentFooterButtons: [


  Container(
    height: 50,
    color: kgreen,
    child:   Center(child: Text("Submit",style: TextStyle(color: kWhite ,fontSize: 15,fontWeight: FontWeight.bold),)),
  )
],

    );
  }
}
