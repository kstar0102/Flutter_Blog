import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:blabloglucy/Localization/t_keys.dart';
import 'package:blabloglucy/application/auth/auth_provider.dart';
import 'package:blabloglucy/domain/auth/models/colors.dart';

import 'package:blabloglucy/screens/login_registration/components/block_picker.dart';
import 'package:blabloglucy/screens/login_registration/components/custom_next_button.dart';

class RegistrationScreen extends HookConsumerWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final state = ref.watch(authProvider);

    final ValueNotifier<ColorsModel?> color = useState(null);
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
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
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        size: 25,
                        color: Color(0xff121556),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(end: 15),
                    child: CustomNextButton(
                      text: TKeys.next_button.translate(context),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                alignment: AlignmentDirectional.topCenter,
                child: Text(
                  TKeys.First_What_color_are_you.translate(context),
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    color: const Color(0xff121556),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                alignment: AlignmentDirectional.topCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    TKeys.responding_to_other.translate(context),
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(fontSize: 14),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              if (state.loading)
                const SizedBox(
                  height: 300,
                  width: double.infinity,
                  child: Center(
                      child: SpinKitFadingFour(
                    size: 60,
                    color: Color(0xff52527a),
                  )
                      //child: CircularProgressIndicator(),
                      ),
                )
              else
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.45,
                  child: BlockPicker(
                    availableColors: state.colorsList
                        .where((element) => element.colorHex.isNotEmpty)
                        .toList(),
                    pickerColor: color.value,
                    onColorChanged: (colorx) {
                      color.value = colorx;
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
