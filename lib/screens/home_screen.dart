import 'package:dr_crop_guru/screens/dr_post_screen.dart';
import 'package:dr_crop_guru/widgets/upper_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  static final routeName = '/home-screen';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values); // to re-show bars
  }

  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 3, vsync: this);
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            // surfaceTintColor: Colors.transparent,
            // automaticallyImplyLeading: false,
            shadowColor: Theme.of(context).primaryColor,
            expandedHeight: 415,
            title: Text('Dr. Crop Guru'),
            actions: [
              Icon(Icons.notifications, color: Colors.white),
              SizedBox(width: 8),
              Icon(
                Icons.shopping_cart_outlined,
                color: Colors.white,
              ),
              SizedBox(
                width: 15,
              ),
            ],
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(415),
              child: Column(
                children: [
                  UpperHomeScreen(),
                  // Container(
                  //   height: 5,
                  //   color: Colors.white,
                  // ),
                ],
              ),
            ),
          ),
        ],
        body: Expanded(
          child: Column(
            children: [
              Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(9),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 1.0), //(x,y)
                      blurRadius: 5.0,
                    ),
                  ],
                ),
                child: TabBar(
                  controller: _tabController,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  labelStyle: TextStyle(),
                  indicatorWeight: 3.5,
                  tabs: [
                    Tab(
                      text: 'DR. POST',
                    ),
                    Tab(
                      text: 'BLOGS',
                    ),
                    Tab(
                      text: 'FARMING\n  VIDEOS',
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: <Widget>[
                    DrPostScreen(),
                    Container(
                      // height: 800,
                      child: Center(
                        child: Text("It's rainy here"),
                      ),
                    ),
                    Container(
                      height: 800,
                      color: Colors.red,
                      child: Center(
                        child: Text("It's sunny here"),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
