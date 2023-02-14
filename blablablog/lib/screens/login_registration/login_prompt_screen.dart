import 'dart:io';

import 'package:account_picker/account_picker.dart';
import 'package:clean_api/clean_api.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../Localization/localization_service.dart';
import '../../Localization/t_keys.dart';
import '../../application/auth/auth_provider.dart';
import '../enddrawer/privacy_policy/privacy_policy_screen.dart';
import '../enddrawer/terms_of_use/terms_of_use_screen.dart';
import 'forgot_password.dart';
import 'login_screen.dart';
import 'resgistrationscreen/sceondscreen/secondscreen.dart';

// ignore: must_be_immutable
class LoginPromptScreen extends HookConsumerWidget {
  LoginPromptScreen({this.demo, Key? key}) : super(key: key);

  String? demo;

  final localizationController = Get.find<LocalizationController>();
  final box = GetStorage();
  ConnectivityResult? connection;

  @override
  Widget build(BuildContext context, ref) {
    useEffect(() {
      Future.delayed(const Duration(milliseconds: 1), () async {
        ref.read(authProvider.notifier).getColors();
        ref.read(authProvider.notifier).getCountries();
        ref.read(authProvider.notifier).getLanguage();

        Logger.e(connection);

        // String locale = await Devicelocale.currentLocale ?? 'en';

        // String locale = Localizations.localeOf(context).languageCode;
        String locale = Platform.localeName.split('_')[0];

        debugPrint(locale);
        if (box.read('IsUserHaveChangedTheLanguage') == true || box.read('IsUserHaveChangedTheLanguage') == null) {
          if (locale.startsWith('en')) {
            box.write('lang', 'en');
            localizationController.engLanguage();
            localizationController.dirctionLtr();
          } else if (locale.startsWith('he')) {
            Logger.w(locale.startsWith('he'));
            box.write('lang', 'he');
            localizationController.directionRtl();
            localizationController.hebLanguage();
          } else if (locale.startsWith('ar')) {
            box.write('lang', 'ar');
            localizationController.directionRtl();
            localizationController.arLanguage();
          } else if (locale.startsWith('ru')) {
            box.write('lang', 'ru');
            localizationController.ruLanguage();
            localizationController.dirctionLtr();
          } else if (locale.startsWith('es')) {
            box.write('lang', 'es');
            localizationController.spLanguage();
            localizationController.dirctionLtr();
          } else {
            box.write('lang', 'en');
            localizationController.engLanguage();
            localizationController.dirctionLtr();
          }
        } else {
          box.write('lang', 'en');
          localizationController.engLanguage();
          localizationController.dirctionLtr();
        }
      });
      return null;
    }, []);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Row(
          textDirection: TextDirection.rtl,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FittedBox(
              child: TextButton(
                onPressed: () {
                  box.write('IsUserHaveChangedTheLanguage', true);
                  localizationController.directionRtl();
                  localizationController.hebLanguage();
                },
                child: Text(
                  'עברית',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    color: const Color(0xff606060),
                    fontWeight: localizationController.currentLanguage == 'he' ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ),
            FittedBox(
              child: TextButton(
                child: Text(
                  'English',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    color: const Color(0xff606060),
                    fontWeight: localizationController.currentLanguage == 'en' ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                onPressed: () {
                  box.write('IsUserHaveChangedTheLanguage', true);
                  localizationController.engLanguage();
                  localizationController.dirctionLtr();
                },
              ),
            ),
            FittedBox(
              child: TextButton(
                child: Text(
                  'español',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    color: const Color(0xff606060),
                    fontWeight: localizationController.currentLanguage == 'es' ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                onPressed: () {
                  box.write('IsUserHaveChangedTheLanguage', true);
                  localizationController.spLanguage();
                  localizationController.dirctionLtr();
                },
              ),
            ),
            FittedBox(
              child: TextButton(
                child: Text(
                  'Русский',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    color: const Color(0xff606060),
                    fontWeight: localizationController.currentLanguage == 'ru' ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                onPressed: () {
                  box.write('IsUserHaveChangedTheLanguage', true);
                  localizationController.ruLanguage();
                  localizationController.dirctionLtr();
                },
              ),
            ),
            FittedBox(
              child: TextButton(
                child: Text(
                  'عربي',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    color: const Color(0xff606060),
                    fontWeight: localizationController.currentLanguage == 'ar' ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                onPressed: () {
                  box.write('IsUserHaveChangedTheLanguage', true);
                  localizationController.arLanguage();
                  localizationController.directionRtl();
                },
              ),
            ),
          ].reversed.toList(),
        ),
      ),
      body: SizedBox(
        height: double.maxFinite,
        width: double.maxFinite,
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              top: MediaQuery.of(context).size.height * 0.2,
              child: Image.asset('assets/images/LandingPage1.png', width: double.maxFinite, height: double.maxFinite, fit: BoxFit.cover),
            ),
            Positioned(
              child: Image.asset('assets/images/hero1.png'),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              top: MediaQuery.of(context).size.height * 0.36,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 12),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (builder) => LoginScreen(demo: demo),
                          ),
                        );
                      },
                      child: Container(
                        height: 48,
                        width: 250,
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 22),
                        decoration: const ShapeDecoration(shape: StadiumBorder(), color: Colors.white),
                        alignment: Alignment.center,
                        child: Text(
                          TKeys.login_with_username.translate(context),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SvgPicture.asset('assets/icons/logo_text.svg', width: 200, color: Colors.black),
                    const SizedBox(height: 24),
                    InkWell(
                      onTap: () async {
                        final EmailResult? emailResult = await AccountPicker.emailHint();
                      },
                      child: Container(
                        height: 48,
                        width: 250,
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 22),
                        decoration: const ShapeDecoration(shape: StadiumBorder(), color: Colors.white),
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: Text(
                                TKeys.connect_with_google.translate(context),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Image.asset('assets/images/google_icon.png'),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SecondScreen(),
                          ),
                        );
                      },
                      child: Container(
                        height: 48,
                        width: 250,
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 22),
                        decoration: const ShapeDecoration(shape: StadiumBorder(), color: Colors.white),
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: Text(
                                TKeys.create_account_with_email.translate(context),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Image.asset('assets/images/email_icon.png'),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 250,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ForgotPassword(),
                              ),
                            );
                          },
                          child: Text(
                            TKeys.Forgot_Password.translate(context),
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 34),
                    SizedBox(
                      width: 300,
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: TKeys.by_clicking_on.translate(context),
                          style: const TextStyle(fontSize: 14, color: Colors.black),
                          children: [
                            TextSpan(
                              text: 'Terms of Use',
                              style: const TextStyle(color: Colors.lightBlueAccent),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const TermsOfUseScreen(),
                                      ),
                                    ),
                            ),
                            const TextSpan(text: ' / '),
                            TextSpan(
                              text: 'Privacy Policy',
                              style: const TextStyle(color: Colors.lightBlueAccent),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const PrivacyPolicyScreen(),
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
