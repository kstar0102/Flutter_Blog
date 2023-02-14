import 'package:another_flushbar/flushbar.dart';
import 'package:clean_api/clean_api.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:provider/provider.dart' as provider;
import 'package:blabloglucy/Localization/localization_service.dart';
import 'package:blabloglucy/Localization/t_keys.dart';
import 'package:blabloglucy/application/auth/auth_provider.dart';
import 'package:blabloglucy/application/auth/auth_state.dart';
import 'package:blabloglucy/domain/auth/models/user_info.dart';
import 'package:blabloglucy/presentation/screens/main_screen.dart';
import 'package:blabloglucy/providers/user_provider.dart';
import 'package:blabloglucy/screens/login_registration/forgot_password.dart';
import 'package:blabloglucy/screens/login_registration/resgistrationscreen/sceondscreen/secondscreen.dart';
import 'package:blabloglucy/widgets/custom_text_field.dart';

import '../enddrawer/privacy_policy/privacy_policy_screen.dart';
import '../enddrawer/terms_of_use/terms_of_use_screen.dart';

// ignore: must_be_immutable
class LoginScreen extends HookConsumerWidget {
  String? demo;
  int count = 0;
  final bool newScreen;
  LoginScreen({
    Key? key,
    this.demo,
    this.newScreen = true,
  }) : super(key: key);

  final localizationController = Get.find<LocalizationController>();
  final box = GetStorage();
  ConnectivityResult? connection;

  @override
  Widget build(BuildContext context, ref) {
    UserProvider userProvider = provider.Provider.of<UserProvider>(context);
    // useEffect(() {
    //   Future.delayed(const Duration(milliseconds: 1), () async {
    //     ref.read(authProvider.notifier).getColors();
    //     ref.read(authProvider.notifier).getCountries();
    //     ref.read(authProvider.notifier).getLanguage();
    //
    //     Logger.e(connection);
    //
    //     // String? locale = await Devicelocale.currentLocale;
    //     String? locale = 'en';
    //
    //     debugPrint(locale);
    //     if (box.read('IsUserHaveChangedTheLanguage') == false || box.read('IsUserHaveChangedTheLanguage') == null) {
    //       if (locale.startsWith('en')) {
    //         box.write('lang', 'en');
    //         localizationController.engLanguage();
    //         localizationController.dirctionLtr();
    //       } else if (locale.startsWith('he')) {
    //         Logger.w(locale.startsWith('he'));
    //         box.write('lang', 'he');
    //         localizationController.directionRtl();
    //         localizationController.hebLanguage();
    //       } else {
    //         box.write('lang', 'en');
    //         localizationController.engLanguage();
    //         localizationController.dirctionLtr();
    //       }
    //     }
    //   });
    //   return null;
    // }, []);

    TextEditingController emailController = useTextEditingController();

    TextEditingController passwordController = useTextEditingController();
    // TODO
    // double value = 0;
    void getConnection() async {
      connection = await Connectivity().checkConnectivity();
    }

    ref.listen<AuthState>(authProvider, (previous, next) async {
      getConnection();

      if (demo != null && count == 0) {
        count = 0;
        showflushbar(
          context,
          TKeys.account_created.translate(context),
        );
      }

      count++;

      if (next.userInfo != UserInfo.empty() ||
          previous!.userInfo != UserInfo.empty()) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MainScreen(),
          ),
        );
      }

      if (previous?.failure != next.failure &&
          next.failure != CleanFailure.none() &&
          next.userInfo == UserInfo.empty()) {
        Logger.w('clicked $connection hello');
        if (connection == ConnectivityResult.none) {
          showflushbar(context, TKeys.connectionStatus.translate(context));
        } else {
          showflushbar(
            context,
            TKeys.user_not_found.translate(context),
          );
        }
      }
    });

    if (newScreen) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: SvgPicture.asset('assets/images/reply_back.svg'),
            onPressed: () {
              Navigator.pop(context);
            },
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
                child: Image.asset('assets/images/LandingPage2.png',
                    width: double.maxFinite,
                    height: double.maxFinite,
                    fit: BoxFit.cover),
              ),
              Positioned(
                child: Image.asset('assets/images/hero2.png'),
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
                      Container(
                        width: Get.width * 0.8,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 3),
                        alignment: Alignment.center,
                        decoration: const ShapeDecoration(
                            shape: StadiumBorder(), color: Colors.white),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: emailController,
                                obscureText: false,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(0),
                                  hintText:
                                      TKeys.Email_Address.translate(context),
                                  fillColor: Colors.white,
                                  filled: true,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  border: InputBorder.none,
                                  focusedErrorBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                ),
                              ),
                            ),
                            Image.asset('assets/images/email_textfield.png',
                                width: 30, height: 30),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: Get.width * 0.8,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 3),
                        alignment: Alignment.center,
                        decoration: const ShapeDecoration(
                            shape: StadiumBorder(), color: Colors.white),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: passwordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(0),
                                  hintText:
                                      TKeys.Password_text.translate(context),
                                  fillColor: Colors.white,
                                  filled: true,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  border: InputBorder.none,
                                  focusedErrorBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                ),
                              ),
                            ),
                            Image.asset('assets/images/password_textfield.png',
                                width: 30, height: 30),
                          ],
                        ),
                      ),
                      const SizedBox(height: 25),
                      Container(
                        height: 45,
                        width: Get.width * 0.4,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(32),
                        ),
                        child: TextButton(
                          onPressed: () {
                            final bool isValid = EmailValidator.validate(
                                emailController.text.trim());
                            if (isValid && passwordController.text.isNotEmpty) {
                              ref.read(authProvider.notifier).login(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                              userProvider
                                  .userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                                context: context,
                              )
                                  .then(
                                (value) {
                                  Logger.e(
                                      '${userProvider.authToken} =======================================|');
                                  box.write('userTokenForAuth',
                                      userProvider.authToken);
                                },
                              );
                            } else if (emailController.text.isEmpty) {
                              showflushbar(
                                context,
                                TKeys.email_require.translate(context),
                              );
                            } else if (passwordController.text.isEmpty) {
                              showflushbar(
                                context,
                                TKeys.password_is_require.translate(context),
                              );
                            } else {
                              showflushbar(
                                context,
                                TKeys.invalid_email.translate(context),
                              );
                            }
                          },
                          child: Text(
                            TKeys.Login_text.translate(context)
                                    .capitalizeFirst ??
                                TKeys.Login_text.translate(context),
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 34),
                      SvgPicture.asset('assets/icons/logo_text.svg',
                          width: 200, color: Colors.black),
                      const SizedBox(height: 34),
                      SizedBox(
                        width: 300,
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: TKeys.by_clicking_on.translate(context),
                            style: const TextStyle(
                                fontSize: 14, color: Colors.black),
                            children: [
                              TextSpan(
                                text: 'Terms of Use',
                                style: const TextStyle(
                                    color: Colors.lightBlueAccent),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const TermsOfUseScreen(),
                                        ),
                                      ),
                              ),
                              const TextSpan(text: ' / '),
                              TextSpan(
                                text: 'Privacy Policy',
                                style: const TextStyle(
                                    color: Colors.lightBlueAccent),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const PrivacyPolicyScreen(),
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

    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: Get.height,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  children: [
                    Row(
                      textDirection: TextDirection.rtl,
                      children: [
                        TextButton(
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
                            ),
                          ),
                        ),
                        const Spacer(),
                        TextButton(
                          child: Text(
                            'English',
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
                              color: const Color(0xff606060),
                            ),
                          ),
                          onPressed: () {
                            box.write('IsUserHaveChangedTheLanguage', true);
                            localizationController.engLanguage();
                            localizationController.dirctionLtr();
                          },
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.05),
                      child: SvgPicture.asset(
                        'assets/images/Logo.svg',
                        height: MediaQuery.of(context).size.height * 0.12,
                        fit: BoxFit.cover,
                      ),
                    ),

                    //Container(
                    // padding: EdgeInsets.only(
                    //   top: MediaQuery.of(context).size.height * 0.01),
                    // child: Text(
                    ///////////////////////////////////////////////////////////////EVERYTHING THATS REAL//////
                    // TKeys.Anonymous_world.translate(context),
                    // style: GoogleFonts.montserrat(
                    // fontSize: 16,
                    //fontWeight: FontWeight.w600,
                    //color: const Color(0xff737373),
                    // ),

                    const SizedBox(height: 10),
                    SizedBox(
                      width: Get.width * 0.9,
                      child: CustomTextFiled(
                        /////////////////////////////////////////////////////EMAIL  PLACEMENT///////
                        hintText: TKeys.Email_Address.translate(context),

                        obsecureText: false,

                        textController: emailController,
                      ),
                    ),
                    SizedBox(
                      width: Get.width * 0.9,
                      child: CustomTextFiled(
                        ///////////////////////////////////////////////////////PASSWORD PLACEMENT///////
                        hintText: TKeys.Password_text.translate(context),
                        obsecureText: true,
                        textController: passwordController,
                      ),
                    ),
                    const SizedBox(height: 25),
                    Container(
                      height: 40,
                      ////////////////////////////////////////////////////////LOGIN BACKGROUND//////////////
                      width: Get.width * 0.7,
                      decoration: BoxDecoration(
                        color: const Color(0xff00c2cb),
                        borderRadius: BorderRadius.circular(32),
                      ),
                      child: TextButton(
                        onPressed: () {
                          //Email validateor function

                          final bool isValid = EmailValidator.validate(
                              emailController.text.trim());
                          if (isValid && passwordController.text.isNotEmpty) {
                            ref.read(authProvider.notifier).login(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                            userProvider
                                .userLogin(
                              email: emailController.text,
                              password: passwordController.text,
                              context: context,
                            )
                                .then(
                              (value) {
                                Logger.e(
                                    '${userProvider.authToken} =======================================|');
                                box.write(
                                    'userTokenForAuth', userProvider.authToken);
                              },
                            );

                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => const MainScreen()));
                          } else if (emailController.text.isEmpty) {
                            showflushbar(
                              context,
                              TKeys.email_require.translate(context),
                            );
                          } else if (passwordController.text.isEmpty) {
                            showflushbar(
                              context,
                              TKeys.password_is_require.translate(context),
                            );
                          } else {
                            showflushbar(
                              context,
                              TKeys.invalid_email.translate(context),
                            );
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              ///////////////////////////////////////////////////////LOGIN TEXT////////////////////
                              TKeys.Login_text.translate(context),
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextButton(
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
                          /////////////////////////////////////////////////////FORGOT PASSWORD//////
                          color: Color(0xff737373),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      child: Container(
                        // margin: const EdgeInsets.symmetric(horizontal: 40),
                        height: 40,
                        width: Get.width * 0.7,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(32),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              offset: const Offset(0, 3),
                              spreadRadius: 0,
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        alignment: Alignment.center,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SecondScreen(),
                              ),
                            );
                          },
                          child: Text(
                            TKeys.Create_New_Account.translate(context),
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
                              /////////////////////////////////////////////////////CREATE NEW ACCOUNT////
                              color: const Color(0xff737373),
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

/*    return Scaffold(
      backgroundColor: Colors.redAccent,
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Padding(
                    padding:  EdgeInsets.only(right: 25, left: 25, top: 25),
                    child: Icon(Icons.cancel_outlined, size: 28, color: Colors.white,),
                  )
                ],
              ),

              Expanded(
                child: Padding(
                  padding: EdgeInsets.all((MediaQuery.of(context).size.width * 0.1)),
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 400),
                    opacity: 1,
                    child: Center(
                      child: Text(
                        TKeys.quote1.translate(context),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 24,
                          fontFamily: Constants.fontFamilyName,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          )
        ),
      ),
    );*/
  }

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
      backgroundColor: const Color(0xff5c5c8a),
      flushbarPosition: FlushbarPosition.TOP,
      duration: const Duration(milliseconds: 1300),
    ).show(context);
  }

  void wrongShowflushbar(BuildContext context) {
    Flushbar(
      isDismissible: true,
      messageSize: 16,
      messageText: const Text(
        'Wrong email or password',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
      backgroundColor: const Color(0xff5c5c8a),
      flushbarPosition: FlushbarPosition.TOP,
      duration: const Duration(milliseconds: 1300),
    ).show(context);
  }

  //progress indicatior

}
