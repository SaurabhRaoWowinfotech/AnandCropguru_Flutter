
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../utils/Colors.dart';
import '../../utils/util.dart';

class RepositoryOfKnowledge extends StatelessWidget {
   RepositoryOfKnowledge({Key? key, this.firstname, this.image, this.text, this.scheduledetails}) : super(key: key);
  final firstname;
  final image;
  final text;
  final scheduledetails;


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
                      onTap: (){
                        Navigator.pop(context);
                      },
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
                title: InkWell(
                  onTap: (){

                  },
                  child: Text('Repository Of Knowledge',
                    style: TextStyle(color: kWhite, fontSize: 20,fontWeight: FontWeight.bold),
                  ),
                ),
              )
          ),

      ),
      body: SingleChildScrollView(
        child: Column(
         // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 8,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(firstname,maxLines: 3,
                style: TextStyle(color: kgreen,overflow: TextOverflow.ellipsis, fontSize: 18,fontWeight: FontWeight.bold), 
                
                
              ),
            ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Image.network(image,height: 310,),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Html(
                        data:text),
                  ),
          ],
        ),
      ),
    );
  }
}
