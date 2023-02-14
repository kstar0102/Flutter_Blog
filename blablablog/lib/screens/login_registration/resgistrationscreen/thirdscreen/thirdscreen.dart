import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:blabloglucy/Localization/t_keys.dart';
import 'package:blabloglucy/application/auth/auth_provider.dart';
import 'package:blabloglucy/domain/auth/models/countries.dart';
import 'package:blabloglucy/domain/auth/models/language.dart';
import 'package:blabloglucy/screens/login_registration/resgistrationscreen/thirdscreen/components/customtextformfiled.dart';

import '../../../../domain/auth/models/colors.dart';
import 'initiate_debounce.dart';

class ThirdScreen extends HookConsumerWidget {
  final ColorsModel color;
  const ThirdScreen({
    Key? key,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final TextEditingController nicknameController = useTextEditingController();

    final genderList = useState([
      TKeys.dialog_text4.translate(context),
      TKeys.dialog_text5.translate(context),
    ]);

    final state = ref.watch(authProvider);

    final genderSelected = useState(false);
    // TODO
    // final dob = useState(true);
    final countrySelected = useState(false);
    final languageSelected = useState(false);
    final enteredName = useState(false);
    final lastCheckedValue = useState('');

    // TODO
    // final ValueNotifier yearValue = useState('1983');
    final ValueNotifier genderValue = useState(null);
    final ValueNotifier languageValue = useState(null);
    final ValueNotifier countryValue = useState(null);

    //final stateSelected = useState(false);

    initiateDebouce(
        controller: nicknameController,
        task: (value) {
          if (value.isNotEmpty &&
              value != lastCheckedValue.value &&
              value.length > 5 &&
              value.length < 13) {
            enteredName.value = true;
            lastCheckedValue.value = value;
            ref.read(authProvider.notifier).checkNickName(value);
            // stateSelected.value = state.validName;
            // print(stateSelected.value);
          }
        });

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 25,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 15),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_ios),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Text(
              TKeys.nick_name_in.translate(context),
              style: GoogleFonts.montserrat(
                fontSize: 15,
                color: const Color(0xff121556),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
//nickname textfield
            CustomEmailTextFormFiled(
              onChanged: (val) {},
              controller: nicknameController,
              hintText: TKeys.jfufufu_text.translate(context),
              prefixicon: Icon(
                Icons.person_outline,
                color: Colors.grey.withOpacity(0.5),
              ),
              suffixicon: enteredName.value
                  ? state.valueChecking
                      ? const Padding(
                          padding: EdgeInsets.all(10),
                          child: CircularProgressIndicator(
                            color: Colors.teal,
                            strokeWidth: 2,
                          ),
                        )
                      : RegExp(r'^[a-zA-Z0-9]+$')
                                  .hasMatch(nicknameController.text) &&
                              nicknameController.text.length > 5 &&
                              state.validName
                          ? const Icon(
                              Icons.check,
                              color: Colors.green,
                            )
                          : const Icon(
                              Icons.close,
                              color: Colors.red,
                            )
                  : const SizedBox(),
              // : const Icon(Icons.question_marrk_rounded,color: Colors.white,),
              obsecure: false,
            ),
            const SizedBox(
              height: 15,
            ),
            //Gender Selection
            Container(
              margin: const EdgeInsets.only(
                left: 35,
                right: 35,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 17),
              decoration: BoxDecoration(
                  border:
                      Border.all(color: Colors.grey.withOpacity(0.5), width: 1),
                  borderRadius: BorderRadius.circular(100)),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                    onTap: () {
                      genderSelected.value = true;
                    },
                    hint: Row(
                      children: [
                        Icon(
                          Icons.male,
                          color: Colors.grey.withOpacity(0.5),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          TKeys.dialog_text3.translate(context),
                          style: const TextStyle(
                              color: Colors.black, fontSize: 14),
                        ),
                      ],
                    ),
                    icon: const Icon(Icons.keyboard_arrow_down_sharp),
                    isExpanded: true,
                    value: genderValue.value,
                    items:
                        genderList.value.map<DropdownMenuItem<String>>((value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (dynamic value) {
                      genderValue.value = value;
                    }),
              ),
            ),

            const SizedBox(
              height: 15,
            ),

            //Country Selection
            Container(
              margin: const EdgeInsets.only(
                left: 35,
                right: 35,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 17),
              decoration: BoxDecoration(
                  border:
                      Border.all(color: Colors.grey.withOpacity(0.5), width: 1),
                  borderRadius: BorderRadius.circular(100)),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<Countries>(
                    onTap: () {
                      countrySelected.value = true;
                    },
                    hint: Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          color: Colors.grey.withOpacity(0.5),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          TKeys.Usa_text.translate(context),
                          style: const TextStyle(
                              color: Colors.black, fontSize: 14),
                        ),
                      ],
                    ),
                    icon: const Icon(Icons.keyboard_arrow_down_sharp),
                    isExpanded: true,
                    value: countryValue.value,
                    items: state.countryList
                        .map<DropdownMenuItem<Countries>>((value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value.value),
                      );
                    }).toList(),
                    onChanged: (dynamic value) {
                      countryValue.value = value;
                    }),
              ),
            ),
            const SizedBox(
              height: 15,
            ),

            //Language Selection
            Container(
              margin: const EdgeInsets.only(
                left: 35,
                right: 35,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 17),
              decoration: BoxDecoration(
                  border:
                      Border.all(color: Colors.grey.withOpacity(0.5), width: 1),
                  borderRadius: BorderRadius.circular(100)),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<Language>(
                    onTap: () {
                      languageSelected.value = true;
                    },
                    hint: Row(
                      children: [
                        Icon(
                          Icons.language_outlined,
                          color: Colors.grey.withOpacity(0.5),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          TKeys.english_text.translate(context),
                          style: const TextStyle(
                              color: Colors.black, fontSize: 14),
                        ),
                      ],
                    ),
                    icon: const Icon(Icons.keyboard_arrow_down_sharp),
                    isExpanded: true,
                    value: languageValue.value,
                    items: state.languageList
                        .map<DropdownMenuItem<Language>>((value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value.value),
                      );
                    }).toList(),
                    onChanged: (dynamic value) {
                      languageValue.value = value;
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }

//Gender menu item
  DropdownMenuItem genderItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(item),
      );
  //Date of birth menu item
  DropdownMenuItem yearItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(item),
      );
  //country meny item
  DropdownMenuItem countryItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(item),
      );
  //language meny item
  DropdownMenuItem languageItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(item),
      );
//Flushbar widget
  void showflushbar(BuildContext context, String title) {
    Flushbar(
      isDismissible: true,
      messageSize: 16,
      messageText: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
      backgroundColor: const Color(0xff121556),
      flushbarPosition: FlushbarPosition.TOP,
      duration: const Duration(milliseconds: 1800),
    ).show(context);
  }
}
