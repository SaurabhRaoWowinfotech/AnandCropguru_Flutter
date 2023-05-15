

import 'package:dr_crop_guru/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FullSizeImage extends StatelessWidget {
  const FullSizeImage({Key? key, this.image}) : super(key: key); 
  final image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kblack,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(height: 40,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14,vertical: 2),
            child: IconButton(
              icon:  Icon(
                Icons.cancel,
                size: 35,
                color: kWhite,
              ),
              iconSize: 30,
              onPressed: (){
                Navigator.pop(context);
              },

            ),),
          Container(
            height:MediaQuery.of(context).size.height-100,
            color: kWhite,
            child: Image.network(image.toString(),fit:BoxFit.fill,errorBuilder: (context, error,
                stackTrace) {
              return Center(child: Image.asset("assets/images/noimage.png",height: 200,));
            }),

          )

        ],
      ),
    );
  }
}
