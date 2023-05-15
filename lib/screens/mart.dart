import 'package:dr_crop_guru/screens/product_details_screen.dart';
import 'package:dr_crop_guru/services.dart';
import 'package:flutter/material.dart';

import '../models/user.dart';
import '../utils/Colors.dart';
import '../utils/prefs_util.dart';
import '../utils/util.dart';
import 'cart_screen.dart';

class Mart extends StatefulWidget {
  const Mart({super.key});

  @override
  State<Mart> createState() => _MartState();
}

class _MartState extends State<Mart> with TickerProviderStateMixin{
  User? user;
  bool isCropsLoaded = false;
  bool isCategoriesLoaded = false;
  bool isProductLoaded = false;
  List<dynamic>? cropList;
  List<dynamic>? categoryList;
  List<dynamic>? productList;

  late AnimationController _controller;

  void setUser() async {
      user = await PrefsUtil.getUserDetails().then((value) async {
      cropList = await Services.getCropList(value.USER_ID.toString(), '3')
          .then((value) {
        setState(() {
          isCropsLoaded = true;
        });
        return value;
      });
      categoryList = await Services.getCategoryList(value).then((value) {
        setState(() {
          isCategoriesLoaded = true;
        });
        return value;
      });
      productList = await Services.getProductList(value.USER_ID.toString(), '3').then((value) {
        setState(() {
          isProductLoaded = true;
        });
        Navigator.of(context).pop();
        return value;
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
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Util.animatedProgressDialog(context, _controller);
      _controller.forward();
      setUser();
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                // padding: EdgeInsets.only(bottom: 15),
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).viewPadding.top),
                // height: 290,
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
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: const Text('Mart',
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CartScreen(user!),
                    ));
                  },
                          child : Icon(
                            Icons.shopping_cart_outlined,
                            color: Colors.white,
                            size: 27,
                          ),)
                        ],
                      ),
                    ),
                    Container(
                      height: 45,
                      decoration: BoxDecoration(
                          color: green100,
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      margin: EdgeInsets.only(
                        left: 15,
                        right: 15,
                        top: 20,
                      ),
                      padding: EdgeInsets.only(
                        left: 20,
                        // top: 5,
                        right: 15,
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Search',
                          hintStyle: TextStyle(color: green700, fontSize: 16),
                          suffixIcon: Icon(
                            Icons.search,
                            color: green700,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: EdgeInsets.only(top: 15, left: 15),
                        child: Text(
                          'Shop for your crop',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    isCropsLoaded
                        ? Container(
                            height: 105,
                            width: MediaQuery.of(context).size.width,
                            child: ScrollConfiguration(
                              behavior: const ScrollBehavior()
                                  .copyWith(overscroll: false),
                              child: ListView.separated(
                                separatorBuilder: (context, index) =>
                                    SizedBox(width: 18),
                                padding: EdgeInsets.only(left: 15, right: 15),
                                scrollDirection: Axis.horizontal,
                                itemCount: cropList!.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      Container(
                                        height: 60,
                                        width: 60,
                                        child: Material(
                                          elevation: 3.5,
                                          shape: const CircleBorder(),
                                          child: CircleAvatar(
                                            backgroundImage: AssetImage(
                                                'assets/images/crop_ig.png'),
                                            backgroundColor: Colors.white,
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(60)),
                                              child: Image.network(
                                                cropList?[index]
                                                        ['CROP_IMAGE'] ??
                                                    'uif',
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  return Container();
                                                },
                                                fit: BoxFit.cover,
                                                // loadingBuilder: (context, child, loadingProgress) {
                                                //   if(loadingProgress == null) {
                                                //     return child;
                                                //   } else {
                                                //     return Container(color: Colors.white, child: );
                                                //   }
                                                // },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 15),
                                      Text(
                                        cropList?[index]['CROP_NAME'] ??
                                            'Loading',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600),
                                      )
                                    ],
                                  );
                                },
                              ),
                            ),
                          )
                        : Container(height: 105),
                    SizedBox(height: 5)
                  ],
                ),
              ),
              SizedBox(height: 12),

              //Showing Categories
              Container(
                height: 155,
                color: green100,
                margin: EdgeInsets.symmetric(horizontal: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 15),
                    Container(
                        margin: const EdgeInsets.only(left: 15),
                        child: Text('Shop by Category')),
                    SizedBox(height: 15),
                    isCategoriesLoaded
                        ? Container(
                            height: 105,
                            width: MediaQuery.of(context).size.width,
                            child: ScrollConfiguration(
                              behavior: const ScrollBehavior()
                                  .copyWith(overscroll: false),
                              child: ListView.separated(
                                separatorBuilder: (context, index) =>
                                    SizedBox(width: 18),
                                padding: EdgeInsets.only(left: 15, right: 15),
                                scrollDirection: Axis.horizontal,
                                itemCount: categoryList!.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    width: 100,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 60,
                                          width: 60,
                                          child: Material(
                                            elevation: 3.5,
                                            shape: const CircleBorder(),
                                            child: CircleAvatar(
                                              backgroundImage: AssetImage(
                                                  'assets/images/crop_ig.png'),
                                              backgroundColor: Colors.white,
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(60)),
                                                child: Image.network(
                                                  categoryList?[index]
                                                          ['PCAT_IMAGE'] ??
                                                      'uif',
                                                  errorBuilder: (context, error,
                                                      stackTrace) {
                                                    return Container();
                                                  },
                                                  fit: BoxFit.fitHeight,
                                                  height: 60,
                                                  width: 60,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        SizedBox(
                                          width: 100,
                                          child: Text(
                                            categoryList?[index]['PCAT_NAME'] ??
                                                'Loading',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 13),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          )
                        : Container(height: 105),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                      margin: EdgeInsets.only(left: 15),
                      child: Text('Recommended Products'))),
              // SizedBox(height: 6),

              isProductLoaded ?
              GridView(
                padding: EdgeInsets.symmetric(vertical: 9),
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 2 / 3.05),
                children: productList!.map((product) {
                  double price = product['PRICE'] ?? 0;
                  double discount = product['DISCOUNT'] ?? 0;
                  double percentage = (discount/price) * 100;
                  double priceWithDiscount =  price - discount;
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductDetailsScreen(user ?? User(), product)));
                    },
                    child: Container(
                      // width: 150,
                      margin: EdgeInsets.all(6),
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 1.0), //(x,y)
                            blurRadius: 3.0,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 3),
                              // height: 15,
                              // width: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Util.newHomeColor,
                                    Util.endColor,
                                  ],
                                ),
                              ),
                              child: Text('${percentage.toStringAsFixed(0)}% Off', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                            ),
                          ),
                          SizedBox(height: 15),
                          Stack(
                            children: [
                              Container(
                                height: 150,
                                child: Image.asset(
                                    'assets/images/bottle.png', fit: BoxFit.cover),
                              ),
                              Container(
                                height: 150,
                                color: Colors.transparent,
                                child: Image.network(
                                    product['PRODUCT_IMAGE'], fit: BoxFit.cover),
                              ),
                            ],
                          ),
                          Align(alignment: Alignment.centerLeft, child: SizedBox(width: double.infinity,
                              child: Text(product['PRODUCT_NAME'], overflow: TextOverflow.ellipsis,))),
                          SizedBox(height: 15,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('₹ ${product['PRICE']}', style: TextStyle(fontWeight: FontWeight.bold, decoration: TextDecoration.lineThrough, color: Colors.grey)),
                              Text('₹ $priceWithDiscount'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ) : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
