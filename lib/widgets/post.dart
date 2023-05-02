import 'package:dr_crop_guru/utils/util.dart';
import 'package:flutter/material.dart';

class Post extends StatelessWidget {
  final String title;
  final String imageUrl;
  final int likes;
  final int views;

  Post(this.title, this.imageUrl, this.likes, this.views);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 12, right: 12, bottom: 12),
      padding: EdgeInsets.only(right: 20, left: 20, bottom: 15, top: 10),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(9),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 1.0), //(x,y)
            blurRadius: 3.0,
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
              margin: EdgeInsets.all(20),
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 19
                ),
              )),
          Container(
            height: 350,
            width: MediaQuery.of(context).size.width,
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  color: Util.endColor,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Icon(
                    Icons.share_sharp,
                    color: Colors.white,
                    size: 15,
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  color: Util.endColor,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Icon(
                    Icons.thumb_up_outlined,
                    color: Colors.white,
                    size: 15,
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                '$likes Likes',
              ),
              SizedBox(
                width: 3,
              ),
              Container(
                height: 15,
                child: VerticalDivider(
                  color: Colors.black,
                  thickness: 1,
                ),
              ),
              SizedBox(
                width: 3,
              ),
              Icon(
                Icons.remove_red_eye,
                size: 18,
                color: Colors.grey,
              ),
              Text(
                '$views Views',
              ),
              Expanded(child: Container()),
              Icon(
                Icons.arrow_right_alt,
                color: Util.orangee,
                size: 30,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
