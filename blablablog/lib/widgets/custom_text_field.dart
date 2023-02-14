import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class CustomTextFiled extends StatefulWidget {
  final String? hintText;
  final bool? obsecureText;
  TextEditingController? textController;
  CustomTextFiled({
    Key? key,
    this.hintText,
    this.obsecureText,
    this.textController,
  }) : super(key: key);

  @override
  State<CustomTextFiled> createState() => _CustomTextFiledState();
}

class _CustomTextFiledState extends State<CustomTextFiled> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 6),
      child: Container(
        height: 40,
        width: Get.width,
        decoration: const BoxDecoration(),
        child: TextFormField(
          controller: widget.textController,
          obscureText: widget.obsecureText!,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(0),
            hintText: widget.hintText,
            fillColor: Colors.white,
            filled: true,
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
