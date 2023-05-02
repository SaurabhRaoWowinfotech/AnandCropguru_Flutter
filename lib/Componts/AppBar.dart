

import 'package:flutter/material.dart';

import '../utils/Colors.dart';
import '../utils/util.dart';

class Appbar extends StatefulWidget {
  const Appbar({Key? key}) : super(key: key);

  @override
  _AppbarState createState() => _AppbarState();
}

class _AppbarState extends State<Appbar> {
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
    );
  }
}
