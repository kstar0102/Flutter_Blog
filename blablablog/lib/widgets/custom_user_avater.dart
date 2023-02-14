import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:blabloglucy/utills/functions/from_rgb_color.dart';

class CustomUserAvatar2 extends StatelessWidget {
  const CustomUserAvatar2({
    Key? key,
    required this.imageUrl,
    required this.userColor,
  }) : super(key: key);
  final String imageUrl;
  final String userColor;

  @override
  Widget build(BuildContext context) {
    // Logger.w(imageUrl);
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
      height: 40,
      width: 40,
      // alignment: Alignment.center,
      child: imageUrl.contains('.svg')
          ? SvgPicture.asset(
              imageUrl,
              fit: BoxFit.cover,
            )
          : Image.asset(
              imageUrl,
              fit: BoxFit.cover,
            ),
    );
  }
}
