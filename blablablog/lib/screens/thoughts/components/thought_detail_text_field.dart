import 'package:flutter/material.dart';
import 'package:blabloglucy/Localization/t_keys.dart';
import 'package:blabloglucy/utills/constant.dart';

class ThoughtDetailTextField extends StatelessWidget {
  const ThoughtDetailTextField({
    Key? key,
    required this.textEditingController,
  }) : super(key: key);

  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      maxLines: null,
      minLines: null,
      expands: true,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.done,
      style: TextStyle(
        fontSize: 14,
        fontFamily: Constants.fontFamilyName,
        color: Constants.editTextColor,
      ),
      decoration: InputDecoration(
        hintText: TKeys.your_thoughts.translate(context),
        border: InputBorder.none,
        contentPadding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
      ),
    );
  }
}

class ThoughtDetailTextFieldForWriteUs extends StatelessWidget {
  const ThoughtDetailTextFieldForWriteUs({
    Key? key,
    required this.textEditingController,
  }) : super(key: key);

  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      maxLines: null,
      minLines: null,
      expands: true,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.done,
      style: TextStyle(
        fontSize: 14,
        fontFamily: Constants.fontFamilyName,
        color: Constants.editTextColor,
      ),
      decoration: InputDecoration(
        hintText: TKeys.thoghtForWriteUs.translate(context),
        border: InputBorder.none,
        contentPadding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
      ),
    );
  }
}
