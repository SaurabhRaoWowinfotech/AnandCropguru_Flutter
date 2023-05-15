import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart'as http;
import '../../utils/Colors.dart';
import '../../utils/util.dart';
class AgronomistVisits extends StatefulWidget {
    AgronomistVisits({Key? key, this.userID, this.cropId, this.plotID}) : super(key: key);
   final userID;
   final cropId;
   final plotID;
   @override
   State<AgronomistVisits> createState() => _AgronomistVisitsState();
 }
 class _AgronomistVisitsState extends State<AgronomistVisits>  with TickerProviderStateMixin{
   late Map mapresponse;
   List? listresponse;
   var jsonResponse;
   String? msg;
   String?data ;
   late AnimationController _controller;
   bool isLoaded = false;

   Future agronomist_visits_api() async {
     http.Response response;
     response = await http.post(
         Uri.parse(
             'http://mycropguruapiwow.cropguru.in/api/PlotVisit?&USER_ID=${widget.userID}&TYPE=User&AGRONOMIST_ID=${widget.userID}&PLOT_ID=${widget.plotID}'),
         headers: {'Content-Type': 'application/json'},
         body: jsonEncode(<String, String>{
           "START": "0",
           "END": "10",
           "WORD": "NONE",
           "LANG_ID": "3"
         }));
     jsonResponse = json.decode(response.body);
     print(jsonResponse["ResponseMessage"]);
     if (response.statusCode == 200) {
       mapresponse = json.decode(response.body);
       listresponse = mapresponse["DATA"];
       data = listresponse.toString();
       msg = jsonResponse["ResponseMessage"];
       isLoaded = true;
     }
   }
   @override
  void initState() {
     _controller = AnimationController(
       duration: const Duration(
           milliseconds: 3000),
       vsync: this,
     );
     _controller.addListener(() {
       if (_controller.isCompleted) {
         _controller.reset();
         _controller.forward();
       }
     });
     WidgetsBinding.instance
         .addPostFrameCallback(
             (timeStamp) {
           Util.animatedProgressDialog(
               context, _controller);
           _controller.forward();
         });
     agronomist_visits_api().then((value) {
       _controller.reset();
       Navigator.pop(context);
       setState(() {});
       return value;
     });
    // TODO: implement initState
    super.initState();
  }
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
                         colors: [Util.newHomeColor, Util.endColor]),
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
                       onTap: () {
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
                 title: Text(
                   "Agronomist Visits",
                   style: TextStyle(
                       color: kWhite, fontSize: 20, fontWeight: FontWeight.bold),
                 ),
               ))),
       body:data == "[]" ?Column(
         children: [
           SizedBox(height: 15,),
           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 25,),
             child: Material(
               elevation: 1.0,
               child: Container(
                 height: MediaQuery.of(context).size.height -230,
                 decoration: BoxDecoration(
                   color: kWhite,
                   borderRadius: BorderRadius.only(
                     topLeft: Radius.circular(5.0),
                     topRight: Radius.circular(5),
                     bottomLeft: Radius.zero,
                     bottomRight: Radius.zero,
                   ),
                 ),
                 child:Html(
                     data:msg.toString()),
               ),
             ),
           ),
           Padding(
             padding:const EdgeInsets.symmetric(horizontal: 25,),
             child: Material(
               elevation: 1.0,
               child: InkWell(
                 child: Container(
                   alignment: Alignment.center,
                   height: 50,
                   decoration: BoxDecoration(
                       color: kgreen,
                       borderRadius: BorderRadius.only(
                         topLeft: Radius.zero,
                         topRight: Radius.zero,
                         bottomLeft: Radius.circular(5),
                         bottomRight: Radius.circular(5),
                       )
                   ),
                   child: Text('Ok',
                     style: TextStyle(
                         color: kWhite,
                         fontSize: 15,
                         fontWeight: FontWeight.bold),
                   ),
                 ),
               ),
             ),
           )
         ],
       ):Text("data")
     );
   }
 }
