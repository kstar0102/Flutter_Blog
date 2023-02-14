import 'package:blabloglucy/providers/reply_provider.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:clean_api/clean_api.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:provider/provider.dart' as provider;
import 'package:blabloglucy/Localization/localization_service.dart';
import 'package:blabloglucy/bloc/connectivity.dart';
import 'package:blabloglucy/providers/chat_provider.dart';
import 'package:blabloglucy/providers/story_provider.dart';
import 'package:blabloglucy/providers/user_provider.dart';
import 'package:blabloglucy/providers/widget_provider.dart';
import 'package:blabloglucy/screens/splash/splash_screen.dart';
import 'package:blabloglucy/utills/constant.dart';

import 'screens/blocked_users/block_user.dart';

void main() async {
  await GetStorage.init();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent));
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  /*SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // transparent status bar
      statusBarIconBrightness: Brightness.dark // dark text for status bar
      ));*/
  CleanApi.instance.setup(
    baseUrl: 'https://api.taillz.com/api/v1/',
  );
  Constants.blocClass = BlocClass(true);

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final localizationController = Get.put(LocalizationController());

  Color primaryColor = const Color(0xffff0000);

  Color scaffoldColor = const Color(0xffff0000);

  Color backgroundColor = const Color(0xffff0000);

  Color dialogBackgroundColor = const Color(0xffff0000);
  final box = GetStorage();
  // final prefs = await SharedPreferences.getInstance();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: Constants.blocClass!.stream,
        builder: (context, snapshot) {
          return GetBuilder<LocalizationController>(
              init: localizationController,
              builder: (LocalizationController controller) {
                return provider.MultiProvider(
                  providers: [
                    provider.ChangeNotifierProvider<UserProvider>(
                      create: (_) => UserProvider(),
                    ),
                    provider.ChangeNotifierProvider<StoryProvider>(
                      create: (_) => StoryProvider(),
                    ),
                    provider.ChangeNotifierProvider<ChatProvider>(
                      create: (_) => ChatProvider(),
                    ),
                    provider.ChangeNotifierProvider<WidgetProvider>(
                      create: (_) => WidgetProvider(),
                    ),
                    provider.ChangeNotifierProvider<ReplyProvider>(
                      create: (_) => ReplyProvider(),
                    ),
                  ],
                  child: Builder(builder: (context) {
                    return MaterialApp(
                      navigatorObservers: [
                        BotToastNavigatorObserver(),
                      ],
                      builder: BotToastInit(),
                      locale:
                          // prefs.getString('action'),
                          // controller.currentLanguage != ''
                          //     ? Locale(controller.currentLanguage, '')
                          //     :
                          Locale(box.read('lang') ?? 'en', ''),
                      // locale: controller.currentLanguage != ''
                      //     ? Locale(controller.currentLanguage, '')
                      //     : null,
                      localeResolutionCallback:
                          LocalizationService.localeResolutionCallBack,
                      supportedLocales: LocalizationService.supportedLocales,
                      localizationsDelegates:
                          // const[
                          //   GlobalMaterialLocalizations.delegate,
                          //   GlobalCupertinoLocalizations.delegate,
                          //   GlobalWidgetsLocalizations.delegate,
                          //   // LocalizationService.localizationsDelegate,
                          // ],
                          LocalizationService.localizationsDelegate,

                      debugShowCheckedModeBanner: false,
                      title: 'blabloglucy',
                      routes: {
                        'blockuser': (_) => const BlockedUser(
                              userId: '',
                            ),
                      },
                      theme: ThemeData(
                          fontFamily: GoogleFonts.montserrat().fontFamily,
                          scaffoldBackgroundColor: Colors.white),
                      home: SplashScreen(),
                      // home: _app(),
                    );
                  }),
                );
              });
        });
  }
}

const MaterialColor kPrimaryColor = MaterialColor(
  0xFF0E7AC7,
  <int, Color>{
    50: Color(0xFFFFFFFF),
    100: Color(0xFFFFFFFF),
    200: Color(0xFFFFFFFF),
    300: Color(0xFFFFFFFF),
    400: Color(0xFFFFFFFF),
    500: Color(0xFFFFFFFF),
    600: Color(0xFFFFFFFF),
    700: Color(0xFFFFFFFF),
    800: Color(0xFFFFFFFF),
    900: Color(0xFFFFFFFF),
  },
);
