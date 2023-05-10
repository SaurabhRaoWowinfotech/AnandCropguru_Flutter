import 'package:dr_crop_guru/utils/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DummyData {
  static double iconSize = 30;

  static List<Map<String, dynamic>> seeByFeed = [
    {
      'title': 'My Plot',
      'imageSrc': 'assets/images/see_by_list_item_icons/field.png',
    },
    {
      'title': 'Weather',
      'imageSrc': 'assets/images/see_by_list_item_icons/weather.png',
    },
    {
      'title': 'Mart',
      'imageSrc': 'assets/images/see_by_list_item_icons/mart1.png',
    },
    {
      'title': 'Lab',
      'imageSrc': 'assets/images/see_by_list_item_icons/lab.png',
    },
    {
      'title': 'Emergency Call',
      'imageSrc': 'assets/images/see_by_list_item_icons/emergencycall.png',
    },
    {
      'title': 'Social',
      'imageSrc': 'assets/images/see_by_list_item_icons/social.png',
    },
  ];

  static List<Map<String, dynamic>> drPosts = [
    {
      'title': 'Grapes growth in January',
      'imageUrl':
          'https://cropguru.in/Cropguru_Admin/upload/nskgrapesloss.jpeg',
      'likes': 11,
      'views': 157,
    },
    {
      'title': 'Grapes growth in January',
      'imageUrl':
          'https://cropguru.in/Cropguru_Admin/upload/nskgrapesloss.jpeg',
      'likes': 11,
      'views': 157,
    }
  ];

  static List<Map<String, dynamic>> profileOptions = [
    {
      'title': 'Profile',
      'icon': Icon(Icons.person, color: Util.orangee, size: iconSize),
    },
    {
      'title': 'My Orders',
      'icon': Icon(Icons.list_alt, color: Util.orangee, size: iconSize),
    },
    {
      'title': 'Bulk Order',
      'icon': Icon(Icons.shopping_cart_outlined, color: Util.orangee, size: iconSize),
    },
    {
      'title': 'Change App Language',
      'icon': Icon(Icons.language, color: Util.orangee, size: iconSize),
    },
    {
      'title': 'rewards',
      'icon': Image.asset('assets/images/gift.png', width: iconSize, height: iconSize,color: Colors.yellow,),
    },
    {
      'title': 'Share',
      'icon': Icon(Icons.share, color: Util.orangee, size: iconSize),
    },
    {
      'title': 'Refer & Earn',
      'icon': Image.asset('assets/images/rate.png', width: iconSize, height: iconSize),
    },
    {
      'title': 'Rate CropGuru App',
      'icon': Icon(Icons.star_rate, color: Util.orangee, size: iconSize),
    },
    {
      'title': 'Terms and Conditions',
      'icon': Icon(Icons.policy, color: Util.orangee, size: iconSize),
    },
    {
      'title': 'Return Policy',
      'icon': Icon(Icons.policy, color: Util.orangee, size: iconSize),
    },
    {
      'title': 'Privacy Policy',
      'icon': Icon(Icons.privacy_tip, color: Util.orangee, size: iconSize),
    },
    {
      'title': 'Contact us',
      'icon': Icon(Icons.contact_phone, color: Util.orangee, size: iconSize),
    },
    {
      'title': 'About us',
      'icon': Icon(Icons.info, color: Util.orangee, size: iconSize),
    },
    {
      'title': 'View Bank Details',
      'icon': Icon(Icons.payment, color: Util.orangee, size: iconSize),
    },
    {
      'title': 'Agronomist Login',
      'icon': Icon(Icons.person, color: Util.orangee, size: iconSize),
    },
    {
      'title': 'Logout',
      'icon': Icon(Icons.logout, color: Util.orangee, size: iconSize),
    },

  ];
}
