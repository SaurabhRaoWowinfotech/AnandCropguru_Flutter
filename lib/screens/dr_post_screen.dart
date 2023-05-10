import 'package:dr_crop_guru/utils/dummy_data.dart';
import 'package:dr_crop_guru/widgets/post.dart';
import 'package:flutter/material.dart';

class DrPostScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        padding: EdgeInsets.only(top: 12,),
        itemCount: DummyData.drPosts.length,
        itemBuilder: (context, index) {
          return Post(
            DummyData.drPosts[index]['title'],
            DummyData.drPosts[index]['imageUrl'],
            DummyData.drPosts[index]['likes'],
            DummyData.drPosts[index]['views'],
          );
        },
      ),
    );
  }
}
