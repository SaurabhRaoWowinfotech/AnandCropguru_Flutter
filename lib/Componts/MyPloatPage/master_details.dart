import 'package:flutter/material.dart';

import '../../utils/Colors.dart';
import '../../utils/util.dart';

class MasterDetails extends StatelessWidget {
  MasterDetails({Key? key, this.titile, this.datetime, this.image, this.ans})
      : super(key: key);
  final titile;
  final datetime;
  final image;
  final ans;

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
                onTap: () {},
                child: Text(
                  'Question details',
                  style: TextStyle(
                      color: kWhite, fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ))),
        body: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Material(
              elevation: 5.0,
              child: Container(
                //  height: 420,
                  decoration: BoxDecoration(
                    color: kWhite,
                    borderRadius: BorderRadius.circular(7),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(2, 6), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(datetime,
                                style: TextStyle(
                                  color: kgreyy,
                                  fontSize: 16,
                                )),
                          ],
                        ),
                        Text("Title",
                            style: TextStyle(
                                color: kblack,
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                        SizedBox(
                          height: 5,
                        ),
                        Text(titile,
                            style: TextStyle(
                              color: kblack,
                              fontSize: 16,
                            )),
                        Center(
                            child: Image.network(
                          image,
                          height: 250,
                          errorBuilder: (context, error, stackTrace) {
                            return Container();
                          },
                        )),
                        Text("Description :",
                            style: TextStyle(
                                color: kblack,
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                        SizedBox(
                          height: 5,
                        ),
                        Text(ans,
                            style: TextStyle(
                              color: kblack,
                              fontSize: 16,
                            )),
                        SizedBox(
                          height: 8,
                        ),
                        Text("Admin Remark-",
                            style: TextStyle(
                              color: kblack,
                              fontSize: 16,
                            )),
                      ],
                    ),
                  )),
            )));
  }
}
