

import 'package:dr_crop_guru/utils/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:get/get.dart';

import '../Api/select_crop_api.dart';
import '../utils/util.dart';
import 'AddNewPlot.dart';

class SelecctCrop extends StatefulWidget {
   SelecctCrop({Key? key}) : super(key: key);

  @override
  State<SelecctCrop> createState() => _SelecctCropState();
}

class _SelecctCropState extends State<SelecctCrop> {
  bool visibility = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    StateLIst();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 200,

              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Util.newHomeColor,
                      Util.endColor
                    ]

                ),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
              ),


              child: Column(
                children: [
                  SizedBox(height: 70,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        InkWell(

                          child: InkWell(

                            child: Icon(
                              Icons.arrow_back,
                              color: kWhite,
                              size: 30,
                            ),
                          ),
                          onTap: (){
                            Navigator.pop(context);
                          },
                        ),
                        SizedBox(width: 10,),
                        Text("Select crop",style: TextStyle(color: kWhite, fontSize: 25,fontWeight: FontWeight.bold),)
                      ],
                    ),
                  ),
        SizedBox(height: 10,),
        Container(
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
        ),

                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: InkWell(
                onTap: (){
                  setState(() {

                    visibility= true;

                  });
                },
                child: Visibility(
                  visible: isLoaded,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),

    itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 50,
                color: Colors.red,
                child: ListTile(

                    leading: Text(selectCroplistresponse![index]['CROPCAT_NAME'].toString(), style: TextStyle(
                      color: kblack, fontSize: 20),),
                    trailing: visibility == true ? Icon(Icons.arrow_drop_down_sharp,
                      color: kblack, size: 33,) : Image.asset(
                      "assets/images/right-arrow.png", height: 10,)
                ),

              ),
              Visibility(
                visible:visibility ,
                  child: ShopList())
            ],
          ),

        );


    }  , itemCount: selectCroplistresponse == null ? 0 : selectCroplistresponse!.length,
                  ),
                ),
              ),
            ),
            VisibilityDetector(
              key: Key('my-widget-key'),
              onVisibilityChanged: (visibilityInfo) {
                var visiblePercentage = visibilityInfo.visibleFraction * 0;
                debugPrint(
                    'Widget ${visibilityInfo.key} is ${visiblePercentage}% visible');
              },
              child:  ShopList()),



          ],
        ),
      ),
    );
  }

  Widget ShopList(){

    return GridView.count(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 3,
        childAspectRatio: 1.0,
        padding: const EdgeInsets.all(4.0),
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
        children:[
          Column(
            children: [
              InkWell(
                onTap: (){
                  Get.to(AddNewPlot());
                },
                child: CircleAvatar(radius: 45,
                  backgroundColor: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Image.network("https://th.bing.com/th/id/OIP._zosxU03HNiWGicygmvmMwHaFP?pid=ImgDet&rs=1",fit: BoxFit.cover,),
                  ),),
              ),
              SizedBox(height: 5,),
              Text("Tomato".tr)
            ],
          ),
          Column(
            children: [
              CircleAvatar(radius: 45,
                backgroundColor: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Image.network("https://th.bing.com/th/id/OIP._zosxU03HNiWGicygmvmMwHaFP?pid=ImgDet&rs=1",fit: BoxFit.cover,),
                ),),
              SizedBox(height: 5,),
              Text("Tomato".tr)
            ],
          ),
          Column(
            children: [
              CircleAvatar(radius: 45,
                backgroundColor: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Image.network("https://th.bing.com/th/id/OIP._zosxU03HNiWGicygmvmMwHaFP?pid=ImgDet&rs=1",fit: BoxFit.cover,),
                ),),
              SizedBox(height: 5,),
              Text("data")
            ],
          ),
          Column(
            children: [
              CircleAvatar(radius: 45,
                backgroundColor: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Image.network("https://th.bing.com/th/id/OIP._zosxU03HNiWGicygmvmMwHaFP?pid=ImgDet&rs=1",fit: BoxFit.cover,),
                ),),
              SizedBox(height: 5,),
              Text("Tomato".tr)
            ],
          ),
          Column(
            children: [
              CircleAvatar(radius: 45,
                backgroundColor: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Image.network("https://th.bing.com/th/id/OIP._zosxU03HNiWGicygmvmMwHaFP?pid=ImgDet&rs=1",fit: BoxFit.cover,),
                ),),
              SizedBox(height: 5,),
              Text("Tomato".tr)
            ],
          ),
          Column(
            children: [
              CircleAvatar(radius: 45,
                backgroundColor: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Image.network("https://th.bing.com/th/id/OIP._zosxU03HNiWGicygmvmMwHaFP?pid=ImgDet&rs=1",fit: BoxFit.cover,),
                ),),
              SizedBox(height: 5,),
              Text("Tomato".tr)
            ],
          ),

        ]
    );  }
}
