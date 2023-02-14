import 'package:get/get.dart';

class AutoGenBackground extends GetxController {
  // int index = 0;
  generate(index) {
    if (index >= 2) {
      index = 0;
    } else {
      index = index + 1;
    }
    update();
  }
}
