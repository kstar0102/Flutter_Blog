import 'package:clean_api/clean_api.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:otp_timer_button/otp_timer_button.dart';
import 'package:blabloglucy/Localization/t_keys.dart';
import 'package:blabloglucy/application/auth/auth_provider.dart';
import 'package:blabloglucy/application/auth/auth_state.dart';
import 'package:blabloglucy/domain/auth/models/recovery.dart';
import 'package:blabloglucy/widgets/custom_flushbar.dart';

// ignore: must_be_immutable
class ForgotPassword extends HookConsumerWidget {
  ForgotPassword({Key? key}) : super(key: key);

  bool showLoader = false;

  @override
  Widget build(BuildContext context, ref) {
    bool showTimer = false;
    final emailController = useTextEditingController();
    // TODO
    // final optTimerButtonController = OtpTimerButtonController();
    ref.listen<AuthState>(authProvider, (previous, next) {
      if (previous != next) {
        Logger.i(next.failure.toString());
        if (next.loading == false && next.failure == CleanFailure.none()) {
          Logger.i(next.toString());

          showFlushBar(
            context,
            TKeys.resetpassword.translate(context),
          );
        } else if (next.failure != CleanFailure.none()) {
          Logger.i(next.toString());
          // showFlushBar(context, next.failure.error);
          showTimer = false;
        }
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => FirstScreen()));
      }
    });

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: StatefulBuilder(
        builder: (context, setState1) {
          return Stack(
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: 80,
                  ),
                  Text(
                    TKeys.password_recovery.translate(context),
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xff2d2d6c),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  StatefulBuilder(
                    builder: (context, setState) {
                      return Container(
                        alignment: AlignmentDirectional.center,
                        child: GestureDetector(
                          onTap: () {
                            final bool isValid = EmailValidator.validate(
                                emailController.text.trim());
                            if (isValid && emailController.text.isNotEmpty) {
                              final Recovery email =
                                  Recovery(email: emailController.text);

                              ref
                                  .read(authProvider.notifier)
                                  .passWordRecovery(email);
                              setState1(() {
                                showLoader = true;
                              });
                              Future.delayed(
                                const Duration(seconds: 0),
                                () {
                                  setState(() {
                                    showTimer = true;
                                  });
                                },
                              );
                              Future.delayed(
                                const Duration(milliseconds: 2000),
                                () {
                                  emailController.clear();
                                },
                              );

                              Future.delayed(
                                const Duration(milliseconds: 2200),
                                () {
                                  setState1(() {
                                    showLoader = false;
                                  });
                                },
                              );

                              Future.delayed(
                                const Duration(seconds: 125),
                                () {
                                  setState(() {
                                    showTimer = false;
                                  });
                                },
                              );
                            } else if (emailController.text.isEmpty) {
                              if (showTimer == false) {
                                showFlushBar(
                                  context,
                                  TKeys.email_require.translate(context),
                                );
                              }
                            } else {
                              if (showTimer == false) {
                                showFlushBar(
                                  context,
                                  TKeys.invalid_email.translate(context),
                                );
                              }
                            }
                          },
                          child: showTimer
                              ? OtpTimerButton(
                                  height: 60,
                                  text: Text(
                                    TKeys.forget_password_timer
                                        .translate(context),
                                  ),
                                  duration: 120,
                                  radius: 30,
                                  backgroundColor: Colors.blue,
                                  textColor: Colors.white,
                                  buttonType: ButtonType
                                      .text_button, // or ButtonType.outlined_button
                                  loadingIndicator:
                                      const CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.red,
                                  ),
                                  loadingIndicatorColor: Colors.red,
                                  onPressed: () {},
                                )
                              : Image.asset(
                                  'assets/images/pswrd.PNG',
                                  height: 90,
                                ),
                        ),
                      );
                    },
                  ),
                ],
              ),
              showLoader
                  ? Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      color: Colors.black87.withOpacity(0.4),
                      child: const Center(
                        child: SpinKitFadingFour(
                          size: 60,
                          color: Color(0xff52527a),
                        ),
                      ),
                    )
                  : Container()
            ],
          );
        },
      ),
    );
  }
}

class ResendButton extends StatefulWidget {
  const ResendButton({Key? key}) : super(key: key);

  @override
  State<ResendButton> createState() => _ResendButtonState();
}

class _ResendButtonState extends State<ResendButton> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
