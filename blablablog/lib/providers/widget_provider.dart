// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WidgetProvider with ChangeNotifier {
  final http.Client _client = http.Client();

  http.Client returnConnection() {
    return _client;
  }
}
