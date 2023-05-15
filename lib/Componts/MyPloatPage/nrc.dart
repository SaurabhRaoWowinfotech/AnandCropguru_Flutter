
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/Colors.dart';
import '../../utils/util.dart';
import 'package:http/http.dart' as http;

class NRC extends StatefulWidget {
   NRC({Key? key, this.userid, this.cropId, this.plotId}) : super(key: key);
   final userid;
   final cropId;
   final plotId;

  @override
  State<NRC> createState() => _NRCState();
}

class _NRCState extends State<NRC> with TickerProviderStateMixin{
  late Map mapresponse;
  bool isLoaded = false;
  var jsonResponse;
  dynamic massage;
  String url ="";
  String data = " ";
  late AnimationController _controller;
  List? listresponse;
  Future<void> openUrl(String url) async {
    final _url = Uri.parse(url);
    if (!await launchUrl(_url, mode: LaunchMode.externalApplication)) { // <--
      throw Exception('Could not launch $_url');
    }
  }

  Future Myploat() async {
    http.Response response;
    response = await http.post(
        Uri.parse('http://mycropguruapiwow.cropguru.in/api/NRCRecord?CROP_ID=${widget.cropId}&TYPE=ALL&AGRONOMIST_ID=${widget.userid}&PLOT_ID=${widget.plotId}'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(<String, dynamic>{
          "START": 0,
          "END": 5,
          "WORD": "NONE",
          "LANG_ID": "3",
          "ACCESS_CODE": "123456",
          "USER_ID": widget.userid
        }));
    jsonResponse = json.decode(response.body);
    print(jsonResponse["ResponseMessage"]);
    if (response.statusCode == 200) {
      print(response.body);

      mapresponse = json.decode(response.body);
      massage=      jsonResponse["ResponseMessage"];
      listresponse = mapresponse["DATA"];
      data =listresponse.toString() ;
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
    Myploat().then((value) {
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
                title: InkWell(
                  onTap: (){
                    Myploat();
                  },
                  child: Text(
                    "N.R.C",
                    style: TextStyle(
                        color: kWhite, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ))),
      body:data == "[]"?Column(
        children: [
          SizedBox(height: 15,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Container(
              height: MediaQuery.of(context).size.height -230,
              decoration: BoxDecoration(
                boxShadow: [BoxShadow(
                  color: Colors.grey,
                  blurRadius: 5.0,
                ),],
                color: kWhite,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5.0),
                  topRight: Radius.circular(5),
                  bottomLeft: Radius.zero,
                  bottomRight: Radius.zero,
                ),
              ),
              child:Center(
                child: Html(
                    data:massage.toString()),
              ),
            ),
          ),
          Padding(
            padding:const EdgeInsets.symmetric(horizontal: 25,),
            child: Material(
              elevation: 1.0,
              child: InkWell(
                onTap: (){
                  Navigator.pop(context);
                },
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
      ): Column(
        children: [
          SizedBox(height: 5,),
          Visibility(
            visible:isLoaded ,
            child: ListView.builder(
              shrinkWrap: true,
            itemBuilder: (context, index) {
             return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: InkWell(
                  onTap: ()async{
                    url=listresponse![index]["CM_PDF"].toString();
                    if (await canLaunch(url)){
                    await launch(url,
                    headers: { "Content-Type":"application/pdf",
                    "Content-Disposition":"inline"}, );
                    print("browser url");
                    print(url);
                    }
                    else
                    // can't launch url, there is some error
                    throw "Could not launch $url";
                  },
                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                      boxShadow: [new BoxShadow(
                        color: kgrey,
                        blurRadius: 10.0,
                      ),
                      ],
                      color: kWhite,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            listresponse![index]["TITLE"].toString(),
                            style: TextStyle(
                                color: kblack,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              Image.asset("assets/images/pdf.png", height: 25,),
                              Image.asset("assets/images/right.png", height: 25,
                                  color: kgreen),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },itemCount:listresponse == null ? 0 : listresponse!.length,
            ),
          ),
        ],
      ),

    );
  }
}
