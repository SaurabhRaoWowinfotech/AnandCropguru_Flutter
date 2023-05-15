import 'package:dotted_border/dotted_border.dart';
import 'package:dr_crop_guru/services.dart';
import 'package:dr_crop_guru/utils/prefs_util.dart';
import 'package:flutter/material.dart';

import '../models/user.dart';
import '../utils/dash_rect.dart';
import '../utils/util.dart';

double basicScreenPadding = 20;

class ApplyCouponScreen extends StatefulWidget {
  User user;

  ApplyCouponScreen(this.user, {Key? key}) : super(key: key);

  @override
  State<ApplyCouponScreen> createState() => _ApplyCouponScreenState();
}

class _ApplyCouponScreenState extends State<ApplyCouponScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  List<dynamic>? couponList;
  void getData() async {
    Util.animatedProgressDialog(context, _controller);
    _controller.forward();
    couponList = await Services.getCoupons(widget.user.USER_ID!).then((value) {
      _controller.reset();
      Navigator.of(context).pop();
      setState(() {
        couponList = value;
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
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: basicScreenPadding),
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
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
                    child: const Icon(
                      Icons.arrow_back_outlined,
                      color: Colors.white,
                      size: 27,
                    ),
                  ),
                  SizedBox(width: 15),
                  Container(
                    child: const Text('Apply Coupon Code',
                        style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  ),
                ],
              ),
            ),
          ),
          // SizedBox(height: 15),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 260,
                    child: Image.asset('assets/images/walletamt.png'),
                  ),
                  Column(
                    children: couponList != null
                        ? couponList!.map((element) {
                            return Container(
                              padding: EdgeInsets.only(top: 7),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          height: 30,
                                          width: 65,
                                          child: Stack(
                                            children: [
                                              Container(
                                                height: 30,
                                                width: 65,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(5)),
                                                    color: Colors.green[100]),
                                                child: DashedRect(
                                                    color: Colors.green[600]!,
                                                    strokeWidth: 1.2,
                                                    gap: 4.0),
                                              ),
                                              Align(alignment: Alignment.center, child: Text('${element['COUPEN_CODE']}', style: TextStyle(color: Colors.green[600], fontWeight: FontWeight.bold, fontSize: 16),))
                                            ],
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: (){
                                            PrefsUtil.setCurrentAppliedCoupon(element).then((value) {
                                              Navigator.of(context).pop();
                                              return value;
                                            });
                                          },
                                          child: Text('APPLY',
                                              style: TextStyle(
                                                  color: Colors.teal[400],
                                                  fontWeight: FontWeight.bold)),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 12),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Text('${element['DESCRIPTION']}', style: TextStyle(fontSize: 13)),
                                  ),
                                  SizedBox(height: 12),
                                  Divider(color: Colors.grey[200], thickness: 1.3,)
                                ],
                              ),
                            );
                          }).toList()
                        : [Container()],
                  ),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
