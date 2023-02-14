import 'dart:async';

import 'package:another_flushbar/flushbar.dart';
import 'package:clean_api/clean_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:provider/provider.dart' as provider;
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:blabloglucy/application/auth/auth_provider.dart';
import 'package:blabloglucy/application/auth/auth_state.dart';
import 'package:blabloglucy/domain/auth/models/user_info.dart';
import 'package:blabloglucy/presentation/screens/main_screen.dart';
import 'package:blabloglucy/providers/story_provider.dart';
import 'package:blabloglucy/providers/user_provider.dart';
import 'package:blabloglucy/utills/api_network.dart';
import 'package:blabloglucy/utills/constant.dart';
import 'package:blabloglucy/utills/prefs.dart';

import '../login_registration/login_prompt_screen.dart';

// ignore: must_be_immutable
class SplashScreen extends HookConsumerWidget {
  String? isUserCreated;
  SplashScreen({Key? key, this.isUserCreated}) : super(key: key);

  final box = GetStorage();
  var globalKey = GlobalKey();

  @override
  Widget build(BuildContext context, ref) {
    // Get.snackbar("no", _box.read('lang'));
    UserProvider userProvider = provider.Provider.of<UserProvider>(context);
    // TODO
    // ChatProvider _chatProvider = provider.Provider.of<ChatProvider>(context);
    StoryProvider storyProvider = provider.Provider.of<StoryProvider>(context);

    useEffect(() {
      Future.delayed(const Duration(milliseconds: 0), () async {
        // if(isUserCreated!.isNotEmpty){
        //   showflushbar(context, TKeys.account_created.translate(context));
        // }

        ref.read(authProvider.notifier).tryLogin();
        ref.read(authProvider.notifier).getLanguage();
      });

      return null;
    }, []);

    ref.listen<AuthState>(authProvider, (p, c) async {
      if (p?.loading != c.loading && !c.loading) {
        // if (userProvider.authToken != null) {
        Logger.w(
            '${userProvider.authToken}  =================================================================================');
        Logger.d(
            '${c.userInfo}  =================================================================================');
        if (c.userInfo != UserInfo.empty()) {
          io.Socket socket = io.io(
            ApiNetwork.notifications,
          );
          socket.onConnect((_) {
            debugPrint('connect');
            socket.emit('msg', 'test');
          });
          socket.on('event', (data) => debugPrint(data));
          socket.onDisconnect((_) => debugPrint('disconnect'));
          socket.on('fromServer', (_) => debugPrint(_));
          String authToken = await getAuthToken();
          userProvider.changeAuthToken(authToken: authToken);
          userProvider.getUserInfo(context: context);
          // _storyProvider.getStories(
          //   context: context,
          //   pageNumber: 0,
          // );
          userProvider.getNotifications(
            context: context,
            pageNumber: 0,
          );
          userProvider.getTopics(context: context);
          storyProvider.getStoriesbyGroup(context: context);
          // _storyProvider.getMyPublishedStories(context: context);
          // _storyProvider.getMyDraftStories(context: context);
          // _storyProvider.getMyPendingStories(context: context);
          // _storyProvider.getMyRejectedStories(context: context);
          // _chatProvider.getUserChatList(context: context);
          // _userProvider.getFollowingUsers(context: context);
          // _userProvider.getFollowers(context: context);
          // _userProvider.getBlockedUsers(context: context);
          // _userProvider.getHiddenUsers(context: context);
          // ignore: use_build_context_synchronously
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (builder) => MainScreen(),
            ),
          );
        } else {
          io.Socket socket = io.io(
            ApiNetwork.notifications,
          );
          socket.io.options['extraHeaders'] = Constants.authenticatedHeaders(
              context: context, userToken: box.read('userTokenForAuth'));
          socket.onConnect((_) {
            debugPrint('connect');
            socket.emit('msg', 'test');
          });
          socket.on('event', (data) => debugPrint(data));
          socket.onDisconnect((_) => debugPrint('disconnect'));
          socket.on('fromServer', (_) => debugPrint(_));
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              // builder: (builder) => LoginScreen(demo: isUserCreated),
              builder: (builder) => LoginPromptScreen(demo: isUserCreated),
            ),
          );
        }
      }
    });

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            'assets/images/splash.png',
          ),
          fit: BoxFit.fill,
        ),
      ),
      child: const Center(),
    );
  }

  Future showFlushBar(BuildContext context, String title) {
    return Flushbar(
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
      duration: const Duration(milliseconds: 1000),
    ).show(context);
  }
}
