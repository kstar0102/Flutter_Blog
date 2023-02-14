import 'package:flutter/material.dart';
import 'package:blabloglucy/bloc/connectivity.dart';

class Constants {
  static var fontFamilyName = 'Montserrat';

  static Color blueColor = const Color(0xff121556);
  static Color commentBackgroundColor = const Color(0xffFAFAFA);
  static Color commentDateColor = const Color(0xff83919e);
  static Color vertIconColor = const Color(0xff737373);
  static Color editTextBackgroundColor = const Color(0xffFAFAFA);
  static Color editTextColor = const Color(0xff7d8b99);
  // static Color editTextColor = Color(0xfffafafa);
  static Color textTitleColor = const Color(0xff3B383D);
  static Color userCommentColor = const Color(0xff272727);
  static Color readMoreColor = const Color(0xff242660);
  static Color heartColor = const Color(0xff1c2239);
  static Color lineColor = const Color(0xffe9e9e9);

  static String backgroundImage1 = 'assets/images/background.jpg';
  static String backgroundImage2 = 'assets/images/background2.png';
  static String consult1 = 'assets/images/consult/1.png';
  static String consult2 = 'assets/images/consult/2.png';
  static String consult3 = 'assets/images/consult/3.png';
  static String consult4 = 'assets/images/consult/4.png';
  static String consult5 = 'assets/images/consult/5.png';
  static String consult6 = 'assets/images/consult/6.png';
  static String consult7 = 'assets/images/consult/7.png';
  static String consult8 = 'assets/images/consult/8.png';

  List<String> consultGroupNames = [
    'startup',
    'food',
    'motherhood',
    'divorced',
    'lgbt',
    'mankind',
    'discrimination',
    'Vegan',
  ];

  static String videoPath = 'assets/videos/video1.mp4';

  static const String userName = '25likesuser@blabloglucy.com';
  static const String password = '12345611';

  static BlocClass? blocClass;

  static authenticatedHeaders(
      {required BuildContext context, String? userToken}) {
    // TODO
    // var box = GetStorage();
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${userToken ?? ''}',
    };
  }

  static authenticatedHeadersForNotifications({
    required BuildContext context,
    String? userToken,
    String? lang,
  }) {
    return {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${userToken ?? ''}',
      'Accept-Language': lang ?? ''
    };
  }
}
