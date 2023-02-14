import 'package:flutter/material.dart';
import 'package:blabloglucy/Localization/t_keys.dart';
import 'package:blabloglucy/utills/constant.dart';

class CreateConsultPostTextField extends StatelessWidget {
  const CreateConsultPostTextField({
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
        color: Colors.black,
      ),
      decoration: InputDecoration(
        hintText: TKeys.typing.translate(context),
        border: InputBorder.none,
        contentPadding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
      ),
    );
  }
}
