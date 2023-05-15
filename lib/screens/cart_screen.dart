import 'package:dr_crop_guru/screens/place_order_screen.dart';
import 'package:dr_crop_guru/utils/Colors.dart';
import 'package:flutter/material.dart';

import '../models/user.dart';
import '../services.dart';
import '../utils/util.dart';

const double basicScreenPadding = 20;
late AnimationController _controller;

class CartScreen extends StatefulWidget {
  static String routeName = '/cart-screen';
  User user;

  CartScreen(this.user);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> with TickerProviderStateMixin {
  List<dynamic>? cartItemList;
  double totalAmount = 0;

  void getData() async {
    Util.animatedProgressDialog(context, _controller);
    _controller.forward();
    cartItemList =
        await Services.getCartItems(widget.user.USER_ID ?? '').then((value) {
      _controller.reset();
      Navigator.of(context).pop();
      setState(() {
        cartItemList = value;
      });
      return value;
    });

    setTotalAmount(cartItemList!);
  }

  void reloadData() async {
    cartItemList =
        await Services.getCartItems(widget.user.USER_ID ?? '').then((value) {
      _controller.reset();
      Navigator.of(context).pop();
      setState(() {
        cartItemList = value;
      });
      return value;
    });

    setTotalAmount(cartItemList!);
  }

  // ${widget.item['PRICE'] - widget.item['DISCOUNT']
  void setTotalAmount(List<dynamic> itemList) {
    double amount = 0;

    itemList.forEach((item) {
      amount += (item['PRICE'] - item['DISCOUNT']) * item['QTY'];
    });

    setState(() {
      totalAmount = amount;
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
    super.initState();
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
            // color: Colors.white,
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
                        child: const Text('My Cart',
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ),
                      Expanded(child: Container()),
                      Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.white,
                        size: 27,
                      ),
                    ],
                  ),
                ),
              ),

              // ListView.builder(
              //   padding: EdgeInsets.only(bottom: 15, top: 15),
              //   itemCount: cartItemList?.length,
              //   itemBuilder: (context, index) {
              //     return CartItem(cartItemList?[index], widget.user, getData);
              //   },)

              cartItemList != null
                  ? Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView(
                              padding: EdgeInsets.symmetric(vertical: 15),
                              children: cartItemList!.map((item) {
                                return CartItem(item, widget.user, reloadData);
                              }).toList(),
                            ),
                          ),
                          cartItemList?.length != 0 ? Container(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            height: 65,
                            width: MediaQuery.of(context).size.width,
                            color: Util.colorPrimary,
                            child: Row(
                              children: [
                                Text('${cartItemList?.length} item',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14)),
                                SizedBox(width: 6),
                                Container(
                                    height: 20, width: 1, color: Colors.white),
                                SizedBox(width: 6),
                                Text('Total Amount ₹ $totalAmount',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14)),
                                Expanded(child: Container()),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => PlaceOrderScreen(widget.user)));
                                  },
                                  child: Row(
                                    children: [
                                      Text('Checkout',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 17)),
                                      Icon(Icons.arrow_forward_ios,
                                          color: Colors.white, size: 27),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ) : Container(),
                        ],
                      ),
                    )
                  : Container(),
            ])));
  }
}

class CartItem extends StatefulWidget {
  Map item;
  User user;
  Function reloadData;

  CartItem(this.item, this.user, this.reloadData);

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  double qty = 0;
  bool isInitialized = false;

  @override
  Widget build(BuildContext context) {
    qty = widget.item['QTY'];

    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(color: lightGrey, width: 1))),
      padding: EdgeInsets.only(bottom: 15, left: 15, right: 15),
      // margin: EdgeInsets.only(top: 15),
      height: 150,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              SizedBox(height: 25),
              Container(
                height: 70,
                width: 70,
                child: Image.network(widget.item['PRODUCT_IMAGE'],
                    fit: BoxFit.cover),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6),
                decoration: BoxDecoration(
                    color: lightGreenButton,
                    border: Border.all(width: 1, color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Text(
                    '${widget.item['DISCOUNT_IN_PERCENTAGE'].round()} % Off',
                    //${widget.item['DISCOUNT_IN_PERCENTAGE']}
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          Container(
            width: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 15),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('${widget.item['PRODUCT_NAME']}',
                      style: TextStyle(
                          color: tealTextColor, fontWeight: FontWeight.bold)),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text('₹${widget.item['PRICE'] - widget.item['DISCOUNT']}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17)),
                    SizedBox(width: 6),
                    Text(
                      'MRP ₹${widget.item['PRICE']}',
                      style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: Colors.black54,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                SizedBox(height: 6),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Size - ${widget.item['SIZE']} ${widget.item['UNIT']}',
                    style: TextStyle(
                        color: Util.orangee, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
          Container(
            width: 85,
            child: Column(
              children: [
                SizedBox(height: 15),
                Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                contentPadding: EdgeInsets.all(20),
                                actionsPadding:
                                    EdgeInsets.only(bottom: 20, right: 20),
                                title: Text('Anand Crop Guru'),
                                content: Text(
                                    'Do you want to remove this product from cart?'),
                                actions: [
                                  GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('NO',
                                          style: TextStyle(
                                              color: Util.colorPrimary))),
                                  SizedBox(width: 6),
                                  GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pop();

                                        Util.animatedProgressDialog(
                                            context, _controller);
                                        _controller.forward();

                                        Services.addProductToCart(
                                                widget.user.USER_ID!,
                                                widget.item,
                                                0,
                                                'DELETE')
                                            .then((value) {
                                          widget.reloadData();
                                        });
                                      },
                                      child: Text('YES',
                                          style: TextStyle(
                                              color: Util.colorPrimary)))
                                ],
                              );
                            },
                          );
                        },
                        child: Icon(Icons.delete, color: Colors.red))),
                SizedBox(height: 60),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        qty -= 1;

                        Util.animatedProgressDialog(context, _controller);
                        _controller.forward();

                        if (qty <= 0) {
                          Services.addProductToCart(widget.user.USER_ID!,
                                  widget.item, 0, 'DELETE')
                              .then((value) {
                            widget.reloadData();
                          });
                        } else {
                          Services.addProductToCart(widget.user.USER_ID!,
                                  widget.item, qty, 'UPDATE')
                              .then((value) {
                            widget.reloadData();
                          });
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(1.5),
                        decoration: BoxDecoration(
                            color: greenTextColor,
                            borderRadius: BorderRadius.all(Radius.circular(6))),
                        child: Icon(
                          Icons.remove,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      '${qty.round()}',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    SizedBox(width: 8),
                    GestureDetector(
                      onTap: () {
                        qty += 1;

                        Util.animatedProgressDialog(context, _controller);
                        _controller.forward();

                        Services.addProductToCart(widget.user.USER_ID!,
                                widget.item, qty, 'UPDATE')
                            .then((value) {
                          widget.reloadData();
                        });
                        // widget.getData();
                      },
                      child: Container(
                        padding: EdgeInsets.all(1.5),
                        decoration: BoxDecoration(
                            color: greenTextColor,
                            borderRadius: BorderRadius.all(Radius.circular(6))),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
