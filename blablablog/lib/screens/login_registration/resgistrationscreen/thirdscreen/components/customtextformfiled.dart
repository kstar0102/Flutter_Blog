import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormFiled extends StatelessWidget {
  final Widget? prefixicon;
  final Widget? suffixicon;
  final String? hintText;
  final bool? obsecure;

  final TextEditingController? controller;
  const CustomTextFormFiled({Key? key, this.prefixicon, this.suffixicon, this.hintText, this.obsecure, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsetsDirectional.only(
              start: 35,
              end: 35,
            ),
            child: SizedBox(
              height: 51,
              child: TextFormField(
                style: const TextStyle(color: Colors.black, fontSize: 14),
                controller: controller,
                obscureText: obsecure!,
                decoration: InputDecoration(
                  hintStyle: const TextStyle(color: Colors.black, fontSize: 14),
                  hintText: hintText,
                  isDense: true,
                  prefixIcon: prefixicon,
                  suffixIcon: suffixicon,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                    borderSide: BorderSide(
                      color: Colors.grey.withOpacity(0.5),
                      width: 1.5,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                    borderSide: BorderSide(
                      color: Colors.grey.withOpacity(0.5),
                      width: 1.5,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                    borderSide: BorderSide(
                      color: Colors.grey.withOpacity(0.5),
                      width: 1.5,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CustomEmailTextFormFiled extends StatelessWidget {
  final Widget? prefixicon;
  final Widget? suffixicon;
  final String? hintText;
  final bool? obsecure;
  final Function(String)? onChanged;

  final TextEditingController? controller;
  const CustomEmailTextFormFiled({Key? key, this.prefixicon, this.suffixicon, this.hintText, this.obsecure, this.onChanged, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsetsDirectional.only(
              start: 35,
              end: 35,
            ),
            child: SizedBox(
              height: 51,
              child: TextFormField(
                onChanged: onChanged,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(12),
                ],
                keyboardType: TextInputType.text,
                style: const TextStyle(color: Colors.black, fontSize: 14),
                controller: controller,
                obscureText: obsecure!,
                decoration: InputDecoration(
                  hintStyle: const TextStyle(color: Colors.black, fontSize: 14, height: 1),
                  hintText: hintText,
                  prefixIcon: prefixicon,
                  suffixIcon: suffixicon,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                    borderSide: BorderSide(
                      color: Colors.grey.withOpacity(0.5),
                      width: 1.5,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                    borderSide: BorderSide(
                      color: Colors.grey.withOpacity(0.5),
                      width: 1.5,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                    borderSide: BorderSide(
                      color: Colors.grey.withOpacity(0.5),
                      width: 1.5,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
