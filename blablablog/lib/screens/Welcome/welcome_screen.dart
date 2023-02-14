import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:blabloglucy/Localization/t_keys.dart';
import 'package:blabloglucy/presentation/screens/main_screen.dart';
import 'package:blabloglucy/utills/constant.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  double value = 0;
  final box = GetStorage();
  List<int> colors = [
    0xffc9e265,
    0xff5e17eb,
    0xffff66c4,
    0xff00c2cb,
    0xff660066,
    0xff003366,
    0xff3399ff,
    0xffff66cc,
    0xff00cc66,
    0xff993333
  ];
  var randomColor = Random().nextInt(9);
  var randomQuote = Random().nextInt(14);
  @override
  void initState() {
    super.initState();

    Future.delayed(
      const Duration(seconds: 1),
      () {
        setState(() {
          value = 1;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<String> quotes = [
      TKeys.quote1.translate(context),
      TKeys.quote2.translate(context),
      TKeys.quote3.translate(context),
      TKeys.quote4.translate(context),
      TKeys.quote5.translate(context),
      TKeys.quote6.translate(context),
      TKeys.quote7.translate(context),
      TKeys.quote8.translate(context),
      TKeys.quote9.translate(context),
      TKeys.quote10.translate(context),
      TKeys.quote11.translate(context),
      TKeys.quote12.translate(context),
      TKeys.quote13.translate(context),
      TKeys.quote14.translate(context),
    ];
    return SafeArea(
      child: Container(
          color: Color(colors[randomColor]),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      box.write('isUserLoggedInTheApp', true);
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (builder) => MainScreen(),
                        ),
                      );
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(right: 25, left: 25, top: 25),
                      child: Icon(
                        Icons.cancel_outlined,
                        size: 28,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
              Expanded(
                child: Padding(
                  padding:
                      EdgeInsets.all((MediaQuery.of(context).size.width * 0.1)),
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 400),
                    opacity: value,
                    child: Center(
                      child: Text(
                        quotes[randomQuote],
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
          )),
    );
  }
}
