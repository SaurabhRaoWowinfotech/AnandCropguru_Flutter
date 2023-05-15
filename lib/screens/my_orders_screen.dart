import 'package:dr_crop_guru/models/user.dart';
import 'package:dr_crop_guru/services.dart';
import 'package:dr_crop_guru/utils/Colors.dart';
import 'package:flutter/material.dart';

import '../utils/util.dart';

const double basicScreenPadding = 20;

class MyOrdersScreen extends StatefulWidget {
  User user;
  MyOrdersScreen(this.user, {Key? key}) : super(key: key);

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen>  with TickerProviderStateMixin{
  late AnimationController _controller;
  List<dynamic>? orderList;

  void getData() async {
    Util.animatedProgressDialog(context, _controller);
    _controller.forward();
    orderList = await Services.getOrderList(widget.user.USER_ID!).then((value) {
      _controller.reset();
      Navigator.of(context).pop();
      setState(() {
        orderList = value;
      });
      return value;
    });
  }

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );

    _controller.addListener(() {
      if (_controller.isCompleted) {
        _controller.reset();
        _controller.forward();
      }
    });
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   statusBarColor: Util.newHomeColor,
    // ));
    // super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      getData();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            // color: Colors.red,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: basicScreenPadding),
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).viewPadding.top),
                height: 70,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Util.newHomeColor,
                      Util.endColor,
                    ],
                  ),
                  // color: Theme.of(context).primaryColor,
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25)),
                ),
                child: IntrinsicHeight(
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Icon(
                          Icons.arrow_back_outlined,
                          color: Colors.white,
                          size: 27,
                        ),
                      ),
                      SizedBox(width: 15),
                      Container(
                        child: const Text('My Order',
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              ),

              orderList != null ? Expanded(
                child: ScrollConfiguration(
                  behavior: ScrollBehavior().copyWith(overscroll: false),
                  child: ListView.builder(padding: EdgeInsets.only(top: 15, bottom: 15), itemCount: orderList?.length, itemBuilder: (context, index) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(left: 12, right: 12, top: 12),
                      child: Material(
                        elevation: 1.5,
                        shadowColor: lightGrey,
                        borderRadius: BorderRadius.all(Radius.circular(9)),
                        child: Padding(
                          padding: EdgeInsets.all(9),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding:
                                    EdgeInsets.symmetric(horizontal: 9, vertical: 6),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                        gradient: LinearGradient(
                                            colors: [
                                              fromHex('4B9948'),
                                              fromHex('#6BB336')
                                            ],
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight)),
                                    child: Text('${orderList?[index]['STATUS']}',
                                        style:
                                        TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                                  ),
                                  SizedBox(height: 9),
                                  Row(
                                    children: [
                                      Text('Order No. ',
                                          style: TextStyle(color: Colors.black54)),
                                      Text('ORDER ID 00${orderList?[index]['ORDER_ID']}')
                                    ],
                                  ),
                                  SizedBox(height: 9),
                                  Row(
                                    children: [
                                      Text('Ordered ',
                                          style: TextStyle(color: Colors.black54)),
                                      Text(
                                        '${orderList?[index]['REG_DATE']}',
                                        style: TextStyle(
                                            color: lightGreenTextColor,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text('Total Qty '),
                                      Text('${orderList?[index]['TOTAL_QTY']}', style: TextStyle(fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  SizedBox(height: 9),
                                  Text('₹ ${orderList?[index]['TOTAL_PRICE']}', style: TextStyle(fontWeight: FontWeight.bold, color: greenTextColor, fontSize: 20),)
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  } ,),
                ),
              ) : Container(),
            ])));
  }
}
