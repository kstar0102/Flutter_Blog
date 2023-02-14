import 'package:flutter/material.dart';
import 'package:blabloglucy/Localization/t_keys.dart';
import 'package:blabloglucy/utills/constant.dart';

class ThoughtTitleTextField extends StatefulWidget {
  final bool? isEnabled;
  const ThoughtTitleTextField(
      {Key? key, required this.textEditingController, this.isEnabled})
      : super(key: key);

  final TextEditingController textEditingController;

  @override
  State<ThoughtTitleTextField> createState() => _ThoughtTitleTextFieldState();
}

class _ThoughtTitleTextFieldState extends State<ThoughtTitleTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.textEditingController,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      minLines: 2,
      maxLines: 2,
      style: TextStyle(
        fontSize: 14,
        fontFamily: Constants.fontFamilyName,
        color: Constants.editTextColor,
      ),
      decoration: InputDecoration(
        hintText: TKeys.title_for_you.translate(context),
        fillColor: Constants.editTextBackgroundColor,
        isDense: true,
        enabled: widget.isEnabled ?? true,
        filled: true,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: const BorderSide(width: 0.0, style: BorderStyle.none)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: const BorderSide(width: 0.0, style: BorderStyle.none)),
        contentPadding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
      ),
    );
  }
}

class ThoughtTitleTextFieldForWriteUS extends StatelessWidget {
  final bool? isEnabled;
  const ThoughtTitleTextFieldForWriteUS(
      {Key? key, required this.textEditingController, this.isEnabled})
      : super(key: key);

  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      minLines: 2,
      maxLines: 2,
      style: TextStyle(
        fontSize: 14,
        fontFamily: Constants.fontFamilyName,
        color: Constants.editTextColor,
      ),
      decoration: InputDecoration(
        hintText: TKeys.titleForWriteUs.translate(context),
        fillColor: Constants.editTextBackgroundColor,
        isDense: true,
        enabled: isEnabled ?? true,
        filled: true,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: const BorderSide(width: 0.0, style: BorderStyle.none)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: const BorderSide(width: 0.0, style: BorderStyle.none)),
        contentPadding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
      ),
    );
  }
}
