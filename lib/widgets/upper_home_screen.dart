import 'package:carousel_slider/carousel_slider.dart';
import 'package:dr_crop_guru/Componts/MyFarms.dart';
import 'package:dr_crop_guru/Componts/MyPlot.dart';
import 'package:dr_crop_guru/utils/dummy_data.dart';
import 'package:dr_crop_guru/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpperHomeScreen extends StatefulWidget {
  const UpperHomeScreen({super.key});

  @override
  State<UpperHomeScreen> createState() => _UpperHomeScreenState();
}

class _UpperHomeScreenState extends State<UpperHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(bottom: 5),
      child: Column(
        children: [
          Container(
            height: 225,
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
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // TitleAndActions(),
                UpperHomeScreenSearchBar(),
                Container(
                  margin: EdgeInsets.only(left: 15, top: 15),
                  child: Text(
                    'See By',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 15, left: 15),
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    children: [
                      InkWell(
                        onTap: (){
                          Get.to(MyFarms());

                        },

                          child: SeeByListItem(DummyData.seeByFeed[0]['title'], DummyData.seeByFeed[0]['imageSrc'], DummyData.seeByFeed[0]['title'] == 'Weather' ? Image.asset(DummyData.seeByFeed[0]['imageSrc'], color: Util.orangee,) : Image.asset(DummyData.seeByFeed[0]['imageSrc'],))

                      ),
                      InkWell(child: SeeByListItem(DummyData.seeByFeed[1]['title'], DummyData.seeByFeed[0]['imageSrc'], DummyData.seeByFeed[0]['title'] == 'Weather' ? Image.asset(DummyData.seeByFeed[0]['imageSrc'], color: Util.orangee,) : Image.asset(DummyData.seeByFeed[0]['imageSrc'],))),
                      SeeByListItem(DummyData.seeByFeed[2]['title'], DummyData.seeByFeed[0]['imageSrc'], DummyData.seeByFeed[0]['title'] == 'Weather' ? Image.asset(DummyData.seeByFeed[0]['imageSrc'], color: Util.orangee,) : Image.asset(DummyData.seeByFeed[0]['imageSrc'],)),
                      SeeByListItem(DummyData.seeByFeed[3]['title'], DummyData.seeByFeed[0]['imageSrc'], DummyData.seeByFeed[0]['title'] == 'Weather' ? Image.asset(DummyData.seeByFeed[0]['imageSrc'], color: Util.orangee,) : Image.asset(DummyData.seeByFeed[0]['imageSrc'],)),
                      SeeByListItem(DummyData.seeByFeed[4]['title'], DummyData.seeByFeed[0]['imageSrc'], DummyData.seeByFeed[0]['title'] == 'Weather' ? Image.asset(DummyData.seeByFeed[0]['imageSrc'], color: Util.orangee,) : Image.asset(DummyData.seeByFeed[0]['imageSrc'],)),
                      SeeByListItem(DummyData.seeByFeed[5]['title'], DummyData.seeByFeed[0]['imageSrc'], DummyData.seeByFeed[0]['title'] == 'Weather' ? Image.asset(DummyData.seeByFeed[0]['imageSrc'], color: Util.orangee,) : Image.asset(DummyData.seeByFeed[0]['imageSrc'],))
                    ]


                  ),
                ),
              ],
            ),
          ),
          UpperHomeScreenCarouselSlider(),
        ],
      ),
    );
  }
}

//Widget - Title and actions (note :- Unused)
class TitleAndActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: EdgeInsets.only(
          top: MediaQuery.of(context).viewPadding.top, left: 15, right: 15),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            'Dr. Crop Guru',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 21,
            ),
          ),
          Expanded(child: Container()),
          Icon(Icons.notifications, color: Colors.white),
          SizedBox(width: 8),
          Icon(
            Icons.shopping_cart_outlined,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}

//Widget - SearchBar
class UpperHomeScreenSearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
          color: Colors.white60,
          borderRadius: BorderRadius.all(Radius.circular(30))),
      margin: EdgeInsets.only(
        left: 15,
        right: 15,
        top: 15,
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
          hintStyle: TextStyle(color: Util.colorPrimary, fontSize: 16),
          suffixIcon: Icon(
            Icons.search,
            color: Util.colorPrimary,
          ),
        ),
      ),
    );
  }
}

//Widget - SeeByListItem
class SeeByListItem extends StatelessWidget {
  final String title;
  final String imageSrc;
  final Image image;

  SeeByListItem(this.title, this.imageSrc, this.image);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      // height: 50,
      // width: 50,
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 37,
            child: Container(
              height: 40,
              child: image,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            title,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}

//Widget - Upper Home Screen Carousel Slider
class UpperHomeScreenCarouselSlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: CarouselSlider(
          items: [
            'https://cropguru.in/Cropguru_Admin/upload/v2.jpg',
            'https://cropguru.in/Cropguru_Admin/upload/4.png',
          ].map((link) {
            return Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 1.0), //(x,y)
                    blurRadius: 3.0,
                  ),
                ],
              ),
              height: 180,
              margin: EdgeInsets.only(
                left: 8,
                right: 8,
                bottom: 6,
                top: 8,
              ),
              // decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(25))),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(11)),
                child: Image.network(
                  link,
                  fit: BoxFit.cover,
                ),
              ),
            );
          }).toList(),
          options: CarouselOptions(
            height: 180,
            aspectRatio: 2 / 3,
            autoPlay: true,
            viewportFraction: 1,
            // onPageChanged: (index, reason) {},
            // reverse: true,
          )),
    );
  }
}
