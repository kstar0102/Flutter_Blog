import 'package:flutter/material.dart';

Color fromRGBColor(String data) {
  try {
    final x = data.replaceAll('rgb(', '').replaceAll(')', '');
    final y = x.split(',').map((e) => int.parse(e)).toList();

    Color color = Color.fromRGBO(y[0], y[1], y[2], 1);
    return color;
  } catch (e) {
    return Colors.white;
  }
}
