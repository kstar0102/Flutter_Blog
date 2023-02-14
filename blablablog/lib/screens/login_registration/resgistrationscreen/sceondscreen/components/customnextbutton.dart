import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomNextButton extends StatelessWidget {
  final String? text;
  final dynamic onPressed;
  const CustomNextButton({
    Key? key,
    this.text,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.only(),
      height: 35,
      decoration: BoxDecoration(
        color: const Color(0xff121556),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: TextButton(
          onPressed: onPressed,
          child: Text(
            text!,
            style: GoogleFonts.montserrat(
                color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
