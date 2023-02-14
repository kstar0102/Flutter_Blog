import 'package:flutter/material.dart';
import 'package:blabloglucy/utills/functions/from_rgb_color.dart';

class CustomUserAvatar extends StatelessWidget {
  const CustomUserAvatar({
    Key? key,
    required this.imageUrl,
    required this.userColor,
    this.size = 40,
  }) : super(key: key);
  final String imageUrl;
  final String userColor;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [
            fromRGBColor(userColor),
            fromRGBColor('userColor.withOpacity(0.8)')
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
      ),
      alignment: Alignment.center,
      height: size,
      width: size,
      child: Image.asset(
        imageUrl,
        fit: BoxFit.cover,
      ),
    );
  }
}
