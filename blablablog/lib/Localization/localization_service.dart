import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LocalizationService {
  final Locale locale;
  static Locale? currentLocale;
  LocalizationService(this.locale) {
    currentLocale = locale;
  }

  static LocalizationService? of(BuildContext context) {
    return Localizations.of(context, LocalizationService);
  }

  late Map<String, String> _localizedString;
  Future<void> load() async {
    final jsonString = await rootBundle.loadString(
      'assets/translations/${locale.languageCode}.json',
    );
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    _localizedString = jsonMap.map(
      (key, value) => MapEntry(key, value.toString()),
    );
  }

  String? translate(String key) {
    return _localizedString[key];
  }

  static const supportedLocales = [Locale('en', 'US'), Locale('he', 'HE'), Locale('ar'), Locale('ru'), Locale('es')];

  static Locale? localeResolutionCallBack(Locale? locale, Iterable<Locale> supportedLocales) {
    if (locale != null) {
      return supportedLocales.firstWhere((element) => element.languageCode == locale.languageCode, orElse: () => supportedLocales.first);
    }

    return null;
  }

  static const LocalizationsDelegate<LocalizationService> _delegate = _LocalizationServiceDelegate();

  static const localizationsDelegate = [GlobalMaterialLocalizations.delegate, GlobalWidgetsLocalizations.delegate, _delegate];
}

class _LocalizationServiceDelegate extends LocalizationsDelegate<LocalizationService> {
  const _LocalizationServiceDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'he', 'ar', 'es', 'ru'].contains(locale.languageCode);
  }

  @override
  Future<LocalizationService> load(Locale locale) async {
    LocalizationService service = LocalizationService(locale);
    await service.load();
    return service;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<LocalizationService> old) {
    return false;
  }
}

class LocalizationController extends GetxController {
  String currentLanguage = ''.obs.toString();

  final box = GetStorage();
  bool directionRTL = true;
  void engLanguage() async {
    currentLanguage = 'en';
    box.write('lang', 'en');
    // final prefs = await SharedPreferences.getInstance();
    // await prefs.setString('language', 'en');
    debugPrint("lang is updated:${box.read('lang')}");

    update();
  }

  void hebLanguage() async {
    currentLanguage = 'he';
    box.write('lang', 'he');
    // final prefs = await SharedPreferences.getInstance();
    // await prefs.setString('language', 'he');
    debugPrint("lang is updated:${box.read('lang')}");

    update();
  }

  void ruLanguage() async {
    currentLanguage = 'ru';
    box.write('lang', 'ru');
    // final prefs = await SharedPreferences.getInstance();
    // await prefs.setString('language', 'he');
    debugPrint("lang is updated:${box.read('lang')}");

    update();
  }

  void spLanguage() async {
    currentLanguage = 'es';
    box.write('lang', 'es');
    // final prefs = await SharedPreferences.getInstance();
    // await prefs.setString('language', 'he');
    debugPrint("lang is updated:${box.read('lang')}");

    update();
  }

  void arLanguage() async {
    currentLanguage = 'ar';
    box.write('lang', 'ar');
    // final prefs = await SharedPreferences.getInstance();
    // await prefs.setString('language', 'he');
    debugPrint("lang is updated:${box.read('lang')}");

    update();
  }

  void directionRtl() {
    directionRTL = true;
    update();
  }

  void dirctionLtr() {
    directionRTL = false;
    update();
  }
}
