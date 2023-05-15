import 'package:dr_crop_guru/models/user.dart';
import 'package:dr_crop_guru/screens/apply_coupon_screen.dart';
import 'package:dr_crop_guru/utils/Colors.dart';
import 'package:dr_crop_guru/utils/prefs_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../services.dart';
import '../utils/util.dart';
import 'delivery_address_screen.dart';

double basicScreenPadding = 20;

class PlaceOrderScreen extends StatefulWidget {
  static final routeName = '/place-order-screen';

  User user;

  PlaceOrderScreen(this.user, {super.key});

  @override
  State<PlaceOrderScreen> createState() => _PlaceOrderScreenState();
}

class _PlaceOrderScreenState extends State<PlaceOrderScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  List<dynamic>? cartItemList;
  List<dynamic>? appVersion;
  Map<dynamic, dynamic>? deliveryAddress;
  double totalAmount = 0;
  int couponCount = 0;
  bool isDataLoaded = false;

  Map<dynamic, dynamic>? currentAppliedCoupon;

  void getData() async {
    Util.animatedProgressDialog(context, _controller);
    _controller.forward();
    cartItemList = await Services.getCartItems(widget.user.USER_ID ?? '')
        .then((value1) async {
      deliveryAddress =
          await PrefsUtil.getDeliveryAddress().then((value2) async {
        appVersion = await Services.getAppVersion(widget.user.USER_ID!)
            .then((value) async {
          currentAppliedCoupon =
              await PrefsUtil.getCurrentAppliedCoupon().then((value) {
            _controller.reset();
            Navigator.of(context).pop();
            setState(() {
              isDataLoaded = true;
              cartItemList = value1;
              currentAppliedCoupon = value;
            });
            return value;
          });
          couponCount = value[0]['ACTIVE_COUPEN_COUNT'];
          return value;
        });
        return value2;
      });
      return value1;
    });
  }

  void refresh() async {
    print('Inside refresh');
    currentAppliedCoupon =
        await PrefsUtil.getCurrentAppliedCoupon().then((value) {
      setState(() {
        currentAppliedCoupon = value;
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

  String mode = '';
  TextStyle textStyle1 = TextStyle(fontWeight: FontWeight.w600);
  double sizeBoxHeight = 5;

  double totalPrice = 0;
  int totalProducts = 0;
  int deliveryCharges = 0;
  double savedPercentage = 0;
  double savedAmount = 0;
  double usedWalletAmount = 0;
  double appliedCouponDiscount = 0;
  double grandTotal = 0;
  double totalDiscount = 0;

  void calculateData() {
    totalPrice = 0;
    totalProducts = 0;
    deliveryCharges = 0;
    savedPercentage = 0;
    savedAmount = 0;
    usedWalletAmount = 0;
    appliedCouponDiscount = 0;
    grandTotal = 0;
    totalDiscount = 0;

    setState(() {
      cartItemList?.forEach((element) {
        totalPrice += element['PRICE'] * element['QTY'];
        savedPercentage += element['DISCOUNT_IN_PERCENTAGE'];
        savedAmount += element['DISCOUNT'] * element['QTY'];
      });

      totalProducts = cartItemList!.length;
      deliveryCharges = appVersion?[0]['SHIPPING_CHARGES'];
      usedWalletAmount = appVersion?[0]['WALLET_AMOUNT'];

      savedPercentage = savedPercentage / totalProducts;

      if (currentAppliedCoupon?.values.first != null) {
        //Uncomment below lines if correction for percentage and fixed calculations
        // if (widget.currentAppliedCoupon?['FIXED_OR_PERCENTAGE'] ==
        //     'Percentage') {
        //   appliedCouponDiscount = (totalPrice *
        //           double.parse(widget.currentAppliedCoupon?['COUPEN_AMOUNT'])) /
        //       100;
        // } else {
        //   appliedCouponDiscount =
        //       double.parse(widget.currentAppliedCoupon?['COUPEN_AMOUNT']);
        // }

        appliedCouponDiscount =
            double.parse(currentAppliedCoupon?['COUPEN_AMOUNT']);
      }

      grandTotal = (totalPrice + deliveryCharges) -
          (savedAmount + usedWalletAmount + appliedCouponDiscount);
      totalDiscount = savedAmount + usedWalletAmount + appliedCouponDiscount;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isDataLoaded) {
      calculateData();
    }
    return Scaffold(
        body: Container(
            color: Colors.white,
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
                        child: const Icon(
                          Icons.arrow_back_outlined,
                          color: Colors.white,
                          size: 27,
                        ),
                      ),
                      SizedBox(width: 15),
                      Container(
                        child: const Text('PLACE ORDER',
                            style: TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              ),
              // SizedBox(height: 12),
              cartItemList != null
                  ? Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              padding: EdgeInsets.all(15),
                              child: Column(
                                children: [
                                  AddressContainer(deliveryAddress!),
                                  SizedBox(height: 12),
                                  ProductListContainer(cartItemList!),
                                  SizedBox(height: 15),
                                  CouponContainer(widget.user, couponCount,
                                      refresh, currentAppliedCoupon!),
                                  SizedBox(height: 15),
                                  Column(
                                    children: [
                                      Material(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(9)),
                                        elevation: 3,
                                        child: Container(
                                          padding: EdgeInsets.all(15),
                                          width: double.infinity,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Billing Details',
                                                style: TextStyle(
                                                    color: greenTextColor,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16),
                                              ),
                                              SizedBox(height: sizeBoxHeight),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text('Total Price'),
                                                  Text('₹ $totalPrice',
                                                      style: textStyle1)
                                                ],
                                              ),
                                              SizedBox(height: sizeBoxHeight),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text('Total Products'),
                                                  Text('$totalProducts',
                                                      style: textStyle1)
                                                ],
                                              ),
                                              SizedBox(height: sizeBoxHeight),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text('Delivery Charges'),
                                                  Text('₹ $deliveryCharges',
                                                      style: textStyle1)
                                                ],
                                              ),
                                              SizedBox(height: sizeBoxHeight),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text('You Save'),
                                                  Row(
                                                    children: [
                                                      Text(
                                                          '(${savedPercentage.round()} % Off) '),
                                                      Text('-₹ $savedAmount',
                                                          style: textStyle1),
                                                    ],
                                                  )
                                                ],
                                              ),
                                              SizedBox(height: sizeBoxHeight),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text('Used Wallet Amount'),
                                                  Text('-₹ $usedWalletAmount',
                                                      style: textStyle1)
                                                ],
                                              ),
                                              SizedBox(height: sizeBoxHeight),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                      'Applied Coupon Discount'),
                                                  Text(
                                                      '-₹ $appliedCouponDiscount',
                                                      style: textStyle1)
                                                ],
                                              ),
                                              SizedBox(height: sizeBoxHeight),
                                              Divider(
                                                  color: Colors.green[100],
                                                  thickness: 2),
                                              // SizedBox(height: sizeBoxHeight),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Grand Total',
                                                    style: TextStyle(
                                                        color: greenTextColor,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16),
                                                  ),
                                                  Text(
                                                    '₹ $grandTotal',
                                                    style: TextStyle(
                                                        color: greenTextColor,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 15),
                                      Material(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(9)),
                                        elevation: 3,
                                        child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          padding: EdgeInsets.all(20),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                'Payment Method',
                                                style: TextStyle(
                                                    color: greenTextColor,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16),
                                              ),
                                              // SizedBox(height: 9),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Cash On Delivery',
                                                    style:
                                                        TextStyle(fontSize: 16),
                                                  ),
                                                  Transform.scale(
                                                      scale: 1.2,
                                                      child: Radio(
                                                          value:
                                                              'Cash On Delivery',
                                                          focusColor:
                                                              Util.colorPrimary,
                                                          groupValue: mode,
                                                          onChanged: (value) {
                                                            setState(() {
                                                              mode = value!;
                                                            });
                                                          }))
                                                ],
                                              ),
                                              // SizedBox(height: 9),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Pay Online',
                                                    style:
                                                        TextStyle(fontSize: 16),
                                                  ),
                                                  Transform.scale(
                                                    scale: 1.2,
                                                    child: Radio(
                                                        value: 'Pay Online',
                                                        groupValue: mode,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            mode = value!;
                                                          });
                                                        }),
                                                  )
                                                ],
                                              ),
                                              SizedBox(height: 9),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                  // PaymentModeContainer()
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (deliveryAddress?.values.first == null) {
                                Fluttertoast.showToast(
                                    msg: "Select delivery address",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.black,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                                return;
                              }

                              if (mode.isEmpty) {
                                Fluttertoast.showToast(
                                    msg: "Please Select Payment Method",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.black,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                                return;
                              }

                              if (mode == 'Cash On Delivery') {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      //27 April 2023 start here
                                      insetPadding: EdgeInsets.all(0),
                                      actionsPadding: EdgeInsets.only(
                                          bottom: 15, right: 20),
                                      titlePadding:
                                          EdgeInsets.only(left: 20, top: 20),
                                      contentPadding: EdgeInsets.only(
                                          left: 20,
                                          right: 20,
                                          top: 9,
                                          bottom: 20),
                                      title: Row(
                                        children: [
                                          Container(
                                            height: 40,
                                            width: 40,
                                            child: Image.asset(
                                                'assets/images/anand_crop_guru_logo.png'),
                                          ),
                                          Text('Anand Crop Guru'),
                                        ],
                                      ),
                                      content: Text(
                                          'Do you want to place this order?'),
                                      actions: [
                                        GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('NO',
                                                style: TextStyle(
                                                    color: blueTextColor,
                                                    fontWeight:
                                                        FontWeight.bold))),
                                        SizedBox(width: 7),
                                        GestureDetector(
                                          onTap: () {
                                            // Map<String, dynamic> orderDetails = {
                                            //   'USER_ID' : ,
                                            //   'TOTAL_PRICE' : ,
                                            //   'TOTAL_DISC' : ,
                                            //   'TOTAL_QTY' : ,
                                            //   'ORDER_ADDRESS' : ,
                                            //   'ORDER_DATE' : ,
                                            //   'PAYMENT_METHOD' : ,
                                            //   'SHIPPING_CHARGES' : ,
                                            //   'WALLET_AMOUNT' : ,
                                            // };
                                          },
                                          child: Text('YES',
                                              style: TextStyle(
                                                  color: blueTextColor,
                                                  fontWeight: FontWeight.bold)),
                                        )
                                      ],
                                    );
                                  },
                                );
                              } else {}
                            },
                            child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                height: 45,
                                width: MediaQuery.of(context).size.width,
                                color: Util.colorPrimary,
                                child: Center(
                                    child: Text(
                                  'Place Your Order',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ))),
                          ),
                        ],
                      ),
                    )
                  : Container(),
            ])));
  }
}

// class PaymentModeContainer extends StatefulWidget {
//   const PaymentModeContainer({
//     super.key,
//   });
//
//   @override
//   State<PaymentModeContainer> createState() => _PaymentModeContainerState();
// }

// class _PaymentModeContainerState extends State<PaymentModeContainer> {
//   String mode = '';
//
//   @override
//   Widget build(BuildContext context) {
//     return ;
//   }
// }

class BillingDetailsContainer extends StatefulWidget {
  List<dynamic> appVersion;
  List<dynamic> cartItemList;
  Map<dynamic, dynamic> currentAppliedCoupon;

  BillingDetailsContainer(
      this.appVersion, this.cartItemList, this.currentAppliedCoupon,
      {super.key});

  @override
  State<BillingDetailsContainer> createState() =>
      _BillingDetailsContainerState();
}

class _BillingDetailsContainerState extends State<BillingDetailsContainer> {
  String mode = '';
  TextStyle textStyle1 = TextStyle(fontWeight: FontWeight.w600);

  double totalPrice = 0;
  int totalProducts = 0;
  int deliveryCharges = 0;
  double savedPercentage = 0;
  double savedAmount = 0;
  double usedWalletAmount = 0;
  double appliedCouponDiscount = 0;
  double grandTotal = 0;
  double totalDiscount = 0;

  void calculateData() {
    totalPrice = 0;
    totalProducts = 0;
    deliveryCharges = 0;
    savedPercentage = 0;
    savedAmount = 0;
    usedWalletAmount = 0;
    appliedCouponDiscount = 0;
    grandTotal = 0;
    totalDiscount = 0;

    setState(() {
      widget.cartItemList.forEach((element) {
        totalPrice += element['PRICE'] * element['QTY'];
        savedPercentage += element['DISCOUNT_IN_PERCENTAGE'];
        savedAmount += element['DISCOUNT'] * element['QTY'];
      });

      totalProducts = widget.cartItemList.length;
      deliveryCharges = widget.appVersion[0]['SHIPPING_CHARGES'];
      usedWalletAmount = widget.appVersion[0]['WALLET_AMOUNT'];

      savedPercentage = savedPercentage / totalProducts;

      if (widget.currentAppliedCoupon?.values.first != null) {
        //Uncomment below lines if correction for percentage and fixed calculations
        // if (widget.currentAppliedCoupon?['FIXED_OR_PERCENTAGE'] ==
        //     'Percentage') {
        //   appliedCouponDiscount = (totalPrice *
        //           double.parse(widget.currentAppliedCoupon?['COUPEN_AMOUNT'])) /
        //       100;
        // } else {
        //   appliedCouponDiscount =
        //       double.parse(widget.currentAppliedCoupon?['COUPEN_AMOUNT']);
        // }

        appliedCouponDiscount =
            double.parse(widget.currentAppliedCoupon?['COUPEN_AMOUNT']);
      }

      grandTotal = (totalPrice + deliveryCharges) -
          (savedAmount + usedWalletAmount + appliedCouponDiscount);
      totalDiscount = savedAmount + usedWalletAmount + appliedCouponDiscount;
    });
  }

  @override
  Widget build(BuildContext context) {
    calculateData();
    double sizeBoxHeight = 5;
    return Column(
      children: [
        Material(
          borderRadius: BorderRadius.all(Radius.circular(9)),
          elevation: 3,
          child: Container(
            padding: EdgeInsets.all(15),
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Billing Details',
                  style: TextStyle(
                      color: greenTextColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                SizedBox(height: sizeBoxHeight),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total Price'),
                    Text('₹ $totalPrice', style: textStyle1)
                  ],
                ),
                SizedBox(height: sizeBoxHeight),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total Products'),
                    Text('$totalProducts', style: textStyle1)
                  ],
                ),
                SizedBox(height: sizeBoxHeight),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Delivery Charges'),
                    Text('₹ $deliveryCharges', style: textStyle1)
                  ],
                ),
                SizedBox(height: sizeBoxHeight),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('You Save'),
                    Row(
                      children: [
                        Text('(${savedPercentage.round()} % Off) '),
                        Text('-₹ $savedAmount', style: textStyle1),
                      ],
                    )
                  ],
                ),
                SizedBox(height: sizeBoxHeight),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Used Wallet Amount'),
                    Text('-₹ $usedWalletAmount', style: textStyle1)
                  ],
                ),
                SizedBox(height: sizeBoxHeight),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Applied Coupon Discount'),
                    Text('-₹ $appliedCouponDiscount', style: textStyle1)
                  ],
                ),
                SizedBox(height: sizeBoxHeight),
                Divider(color: Colors.green[100], thickness: 2),
                // SizedBox(height: sizeBoxHeight),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Grand Total',
                      style: TextStyle(
                          color: greenTextColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    Text(
                      '₹ $grandTotal',
                      style: TextStyle(
                          color: greenTextColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 15),
        Material(
          borderRadius: BorderRadius.all(Radius.circular(9)),
          elevation: 3,
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Payment Method',
                  style: TextStyle(
                      color: greenTextColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                // SizedBox(height: 9),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Cash On Delivery',
                      style: TextStyle(fontSize: 16),
                    ),
                    Transform.scale(
                        scale: 1.2,
                        child: Radio(
                            value: 'Cash On Delivery',
                            focusColor: Util.colorPrimary,
                            groupValue: mode,
                            onChanged: (value) {
                              setState(() {
                                mode = value!;
                              });
                            }))
                  ],
                ),
                // SizedBox(height: 9),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Pay Online',
                      style: TextStyle(fontSize: 16),
                    ),
                    Transform.scale(
                      scale: 1.2,
                      child: Radio(
                          value: 'Pay Online',
                          groupValue: mode,
                          onChanged: (value) {
                            setState(() {
                              mode = value!;
                            });
                          }),
                    )
                  ],
                ),
                SizedBox(height: 9),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class CouponContainer extends StatefulWidget {
  User user;
  int couponCount;
  Function refresh;
  Map<dynamic, dynamic> currentAppliedCoupon;

  CouponContainer(
    this.user,
    this.couponCount,
    this.refresh,
    this.currentAppliedCoupon, {
    super.key,
  });

  @override
  State<CouponContainer> createState() => _CouponContainerState();
}

class _CouponContainerState extends State<CouponContainer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(
                builder: (context) => ApplyCouponScreen(widget.user)))
            .then((value) {
          widget.refresh();
          return value;
        });
      },
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(9)),
        elevation: 3,
        child: Container(
          padding: EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  Container(
                      height: 27,
                      width: 27,
                      child: Image.asset('assets/images/coupon.png',
                          color: Util.colorPrimary)),
                  SizedBox(width: 12),
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Apply Coupon',
                          style: TextStyle(
                              color: greenTextColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        widget.currentAppliedCoupon?.values.first != null
                            ? Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: GestureDetector(
                                        onTap: () {
                                          PrefsUtil.removeCurrentAppliedCoupon()
                                              .then((value) {
                                            widget.refresh();
                                            return value;
                                          });
                                        },
                                        child: Icon(Icons.cancel,
                                            color: Colors.red),
                                      ),
                                    ),
                                    Text(
                                        '${widget.currentAppliedCoupon?['COUPEN_CODE']} Applied Successfully',
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.orange[500])),
                                  ],
                                ),
                              )
                            : Text('${widget.couponCount} Coupons available',
                                style: TextStyle(color: Colors.grey[600]))
                      ],
                    ),
                  )
                ],
              ),
              Icon(Icons.arrow_forward_ios, color: Colors.grey[600], size: 27)
            ],
          ),
        ),
      ),
    );
  }
}

class AddressContainer extends StatefulWidget {
  Map<dynamic, dynamic> deliveryAddress;

  AddressContainer(this.deliveryAddress, {Key? key}) : super(key: key);

  @override
  State<AddressContainer> createState() => _AddressContainerState();
}

class _AddressContainerState extends State<AddressContainer> {
  @override
  Widget build(BuildContext context) {
    return Material(
        borderRadius: BorderRadius.all(Radius.circular(9)),
        elevation: 3,
        // color: Colors.transparent,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Delivery Address',
                      style: TextStyle(
                          fontSize: 16,
                          color: greenTextColor,
                          fontWeight: FontWeight.bold)),
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => DeliveryAddressScreen(),
                        ));
                      },
                      child:
                          Icon(Icons.edit, color: Util.colorPrimary, size: 27))
                ],
              ),
              SizedBox(height: 9),
              widget.deliveryAddress['address'] == null
                  ? Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Select delivery address',
                        style: TextStyle(color: Colors.grey[600]),
                      ))
                  : Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '${widget.deliveryAddress['address']}, ${widget.deliveryAddress['pin_code']}, ${widget.deliveryAddress['village_name']}, ${widget.deliveryAddress['taluka']}, ${widget.deliveryAddress['district']}, ${widget.deliveryAddress['state']}',
                        style: TextStyle(fontSize: 13),
                        overflow: TextOverflow.clip,
                      ))
            ],
          ),
        ));
  }
}

class ProductListContainer extends StatefulWidget {
  List<dynamic> cartItemList;

  ProductListContainer(this.cartItemList, {Key? key}) : super(key: key);

  @override
  State<ProductListContainer> createState() => _ProductListContainerState();
}

class _ProductListContainerState extends State<ProductListContainer> {
  TextStyle productTextStyle = TextStyle(color: Colors.grey[600]);

  @override
  Widget build(BuildContext context) {
    return Material(
        borderRadius: BorderRadius.all(Radius.circular(9)),
        elevation: 3,
        // color: Colors.transparent,
        child: Container(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Util.orangee,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(9),
                        topRight: Radius.circular(9))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('Product',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600)),
                    Container(),
                    Text('QTY',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600)),
                    Text('Amount (₹)',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
              ...widget.cartItemList.map((item) {
                return Container(
                  height: 45,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                              height: 25,
                              width: 25,
                              child: Image.network(
                                '${item['PRODUCT_IMAGE']}',
                                fit: BoxFit.cover,
                              )),
                          SizedBox(width: 3),
                          Container(
                              // height: 25,
                              width: MediaQuery.of(context).size.width / 2.5,
                              child: Text(
                                '${item['PRODUCT_NAME']}',
                                overflow: TextOverflow.ellipsis,
                                style: productTextStyle,
                              )),
                        ],
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width / 4.5,
                          child: Text(
                              '${item['QTY']} X (${item['SIZE']} ${item['UNIT']})',
                              overflow: TextOverflow.ellipsis,
                              style: productTextStyle)),
                      Container(
                          width: MediaQuery.of(context).size.width / 5,
                          child: Text(
                              '₹ ${(item['PRICE'] - item['DISCOUNT']) * item['QTY']}',
                              overflow: TextOverflow.ellipsis,
                              style: productTextStyle)),
                    ],
                  ),
                );
              }).toList(),
            ],
          ),
        ));
  }
}
