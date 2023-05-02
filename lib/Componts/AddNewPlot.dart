

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../utils/Colors.dart';
import '../utils/util.dart';

class AddNewPlot extends StatefulWidget {
  const AddNewPlot({Key? key}) : super(key: key);

  @override
  State<AddNewPlot> createState() => _AddNewPlotState();
}

class _AddNewPlotState extends State<AddNewPlot> {
  List<String> items = <String>['Soil type', 'Light clay', 'Medium red', 'Black', 'Medium Black','Black solid', 'Limestone' , 'Sherwat'', Light Soil' , 'sandy soil'];
  String dropdownvalue = 'Soil type';
  String _selectedGender = 'male';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.0),

          child: Container(
           //  color: kgreen,
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

                leading: Builder(
                  builder: (context) => IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: kWhite,
                    ),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    tooltip:
                    MaterialLocalizations.of(context).openAppDrawerTooltip,
                  ),
                ),
                centerTitle: true,
                title: Text('Add new plot (Capsicum)',
                  style: TextStyle(color: kWhite, fontSize: 25,fontWeight: FontWeight.bold),
                ),
              ),
          )
      ),
      body: SingleChildScrollView(

        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              SizedBox(height: 20,),
              Text("Crop Variety:",style: TextStyle(color: kgreen ,fontSize: 17,fontWeight: FontWeight.bold),),
              SizedBox(height: 8,),
              TextField(

               // controller: _mobile,
                decoration: InputDecoration(

                  isDense: true, // important line
                  contentPadding: EdgeInsets.fromLTRB(13,13,13,13),
                  //errorText: _mobileValidated ? null : _mobileError,

                  hintText: 'Crop Variety',
                  border: OutlineInputBorder(

                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Text("Soil Type:",style: TextStyle(color: kgreen ,fontSize: 17,fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
          Container(
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(width: 1,color:Colors.grey, ),
              borderRadius: BorderRadius.circular(5)
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: DropdownButtonHideUnderline(

                child: DropdownButton<String>(

                  isExpanded: true,
                  iconSize: 34,
                  value: dropdownvalue,
                  items: items
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                        value: value, child: Text(value));
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownvalue = newValue ?? '';
                    });
                  },
                ),
              ),
            ),
          ),
              SizedBox(height: 10,),
              Text("Is your crop pruned / planted?:",style: TextStyle(color: kgreen ,fontSize: 17,fontWeight: FontWeight.bold),),
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
                      activeColor: kblue,
                      value: 'Yes',
                      groupValue: _selectedGender,
                      onChanged: (value) {
                        setState(() {
                          _selectedGender = value!;
                        });
                      },
                    ),
                    Text("Yes",style:   TextStyle(color: kblack, fontSize: 15 , fontFamily: 'newfont'),)
                  ],
                ),
                SizedBox(width: 20,),
                Row(
                  children: [
                    Radio<String>(
                      activeColor: kblue,
                      value: 'No',
                      groupValue: _selectedGender,
                      onChanged: (value) {
                        setState(() {
                          _selectedGender = value!;
                        });
                      },
                    ),
                    Text(" No",style:   TextStyle(color: kblack, fontSize: 15 , fontFamily: 'newfont'),)
                  ],
                ),

              ],
            ),
          ),

              SizedBox(height: 15,),
              Text("Please select Plantation type:",style: TextStyle(color: kgreen ,fontSize: 17,fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              InkWell(
                onTap: (){
                  Get.bottomSheet(
                    Container(
                        height: 300,
                        color: Colors.white,
                        child:Column(
                          children: [
                            Container(
                              height: 50,
                              color: kgreen,
                              child: Center(
                                child: Text("Please select Plantation type",style: TextStyle(color: kWhite,fontWeight: FontWeight.bold,fontSize: 20),),
                              ),
                            ),
                            Container(
                                height: 45,
                                decoration: BoxDecoration(
                                    color: kWhite,
                                  border: Border.all(width: 0,color: Colors.grey)
                                ),
                                child: ListTile(title: Text("Summer Season Capcicum Plantation"))),


                        Container(
                            height: 45,
                            decoration: BoxDecoration(
                                color: kWhite,
                                border: Border.all(width: 0,color: Colors.grey)
                            ),
                            child: ListTile(title: Text("Summer Season Capcicum Plantation"))),



                          ],
                        )
                    ),


                  );
                },
                child: TextField(
                  enabled: false,

         onTap: (){
           Get.bottomSheet(

             Container(
                   height: 300,
                   color: Colors.greenAccent,
                   child:Column(
                     children: [
                       Container(
                         height: 40,
                         color: kgreen,
                       ),




                     ],
                   )
             ),


           );
         },
                  // controller: _mobile,
                  decoration: InputDecoration(

                    isDense: true, // important line
                    contentPadding: EdgeInsets.fromLTRB(12,12,12,12),
                    //errorText: _mobileValidated ? null : _mobileError,

                    hintText: 'Please select Plantation type',
                    border: OutlineInputBorder(

                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Text("Select the Pruning / planting date",style: TextStyle(color: kgreen ,fontSize: 17,fontWeight: FontWeight.bold),),
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
              Text("Garden method",style: TextStyle(color: kgreen ,fontSize: 17,fontWeight: FontWeight.bold),),
              SizedBox(height: 5,),
              TextField(
  enabled: false,
                // controller: _mobile,
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
              SizedBox(height: 10,),
              SizedBox(height: 10,),
              Text("Total Area (Acers):",style: TextStyle(color: kgreen ,fontSize: 17,fontWeight: FontWeight.bold),),
              SizedBox(height: 5,),
              TextField(

                // controller: _mobile,
                decoration: InputDecoration(

                  isDense: true, // important line
                  contentPadding: EdgeInsets.fromLTRB(14,14,14,14),
                  //errorText: _mobileValidated ? null : _mobileError,

                  hintText: 'Total Area (Acers)',
                  border: OutlineInputBorder(

                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
              SizedBox(height: 20,),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100),
                child: Container(
                  height: 40,

                  decoration: BoxDecoration(
                      color: kgreen,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Center(
                    child: Text('Submit',style: TextStyle(color: kWhite,fontSize: 18, fontWeight: FontWeight.bold),),
                  ),
                ),
              ),
              SizedBox(height: 20,),

            ],
          ),
        ),
      ),



    );
  }
}
