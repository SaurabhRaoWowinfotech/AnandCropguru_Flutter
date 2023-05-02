//
//
// import 'package:dr_crop_guru/Api/my_plot_api.dart';
// import 'package:dr_crop_guru/Componts/SelectCrop.dart';
// import 'package:dr_crop_guru/utils/Colors.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:html/parser.dart' ;
// import 'package:flutter_html/flutter_html.dart';
//
// class MyPlot extends StatefulWidget {
//   const MyPlot({Key? key}) : super(key: key);
//
//   @override
//   State<MyPlot> createState() => _MyPlotState();
// }
//
// class _MyPlotState extends State<MyPlot> {
//
//   String? str = jsonResponse?['ResponseMessage'];
//       // .toString()
//       // .replaceAll("<p>", "")
//       // .replaceAll("<span", "");
//
//   @override
//   void initState() {
//
//
//     Myploat();
//     main();
//     // TODO: implement initState
//     super.initState();
//   }
//
//   void main() {
//     var document = parse(
//        jsonResponse['ResponseMessage']);
//     print(document.head);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//     body:
//
//
//
//         Column(
//           children: [
//             SizedBox(height: 30,),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 22),
//               child: Container(
//                 height: 470,
//
//                 decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(5),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey.withOpacity(0.3),
//                         spreadRadius: 1,
//                         blurRadius: 1,
//                         offset: Offset(0, 1), // changes position of shadow
//                       ),
//                     ]
//                 ),
//                 child: SingleChildScrollView(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//
//                       Center(child: Text("")
//
//
//                       )]
//                   ),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 22),
//               child: InkWell(
//                 onTap: (){
//                   main();
//                 },
//                 child: Container(
//                   height: 45,
//
//                   decoration: BoxDecoration(
//                     color: kgreen,
//                     borderRadius: BorderRadius.circular(5),
//
//                   ),
//                   child: Center(
//                     child: Text("OK", style: TextStyle(color: kWhite,
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold),),
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ));
//
//       }
//
//
//   }
//
// // class HtmlTags {
//
// //   static void removeTag({ htmlString, callback }){
// //     var document = parse(htmlString);
// //     String parsedString = parse(document.body?.text).documentElement!.text;
// //     callback(parsedString);
// //
// //     HtmlTags.removeTag(
// //       htmlString: '<h1>Hello Bug</h1>',
// //       callback: (string) => print(string),
// //     );
// //   }
// //
// // }
//
