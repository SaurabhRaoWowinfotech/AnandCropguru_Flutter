

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Componts/SelectCrop.dart';

class LanDemo extends StatelessWidget {
   LanDemo({Key? key}) : super(key: key);

  final List locale =[
     {'name':'ENGLISH','locale': Locale('en','US')},
     {'name':'ಕನ್ನಡ','locale': Locale('kn','IN')},
     {'name':'हिंदी','locale': Locale('hi','IN')},

   ];
   updateLanguage(Locale locale){
     Get.back();
     Get.updateLocale(locale);
   }
   buildLanguageDialog(BuildContext context){
     showDialog(context: context,
         builder: (builder){
           return AlertDialog(
             title: Text('Choose Your Language'),
             content: Container(
               width: double.maxFinite,
               child: ListView.separated(
                   shrinkWrap: true,
                   itemBuilder: (context,index){
                     return Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: GestureDetector(child: Text(locale[index]['name']),onTap: (){
                         print(locale[index]['name']);
                         updateLanguage(locale[index]['locale']);
                       },),
                     );
                   }, separatorBuilder: (context,index){
                 return Divider(
                   color: Colors.blue,
                 );
               }, itemCount: locale.length
               ),
             ),
           );
         }
     );
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          Text("subscribe".tr) ,

          ElevatedButton(onPressed: (){

            buildLanguageDialog(context);
          }, child:Text("select Lang")) ,

          ElevatedButton(onPressed: (){
            Get.to(SelecctCrop());
          }, child:Text("Next page"))
        ],
      ),
    );
  }
}


class demmo extends StatelessWidget {
  const demmo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(child: Text("subscribe".tr) ,),
    );
  }
}
