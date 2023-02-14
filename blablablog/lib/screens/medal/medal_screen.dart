import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:provider/provider.dart' as provider;

import '../../Localization/t_keys.dart';
import '../../application/auth/auth_provider.dart';
import '../../presentation/screens/main_screen.dart';
import '../../providers/user_provider.dart';
import '../../utills/counter_function.dart';
import '../../widgets/custom_user_avatar.dart';
import '../karma/karma_screen.dart';
import '../my_screens/my_main_screen.dart';
import '../notifications/notification_screen.dart';
import '../polls/polls_screen.dart';

class MedalScreen extends HookConsumerWidget {
  MedalScreen({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final avatars = [Colors.deepPurpleAccent, Colors.pinkAccent, Colors.black45, Colors.deepOrangeAccent, Colors.lightGreen];

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        titleSpacing: 0,
        leadingWidth: 0,
        title: CustomAppBarTitle(scaffoldKey: _scaffoldKey, index: 0),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            Text(TKeys.top_writers.translate(context), style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16)),
            const SizedBox(height: 12),
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(image: AssetImage('assets/images/top_writer_bg.png'), fit: BoxFit.fitHeight),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 76),
              alignment: Alignment.center,
              child: Column(
                children: avatars
                    .map(
                      (e) => Column(
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 12,
                                backgroundColor: e,
                                child: Image.asset('assets/images/female.png', width: 24, height: 24),
                              ),
                              const SizedBox(width: 5),
                              const Text('Nick Name', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 12)),
                              const SizedBox(width: 8),
                              SvgPicture.asset('assets/images/karma.svg', width: 20, height: 20),
                              const SizedBox(width: 8),
                              const Text('453 Points', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 12)),
                            ],
                          ),
                          const SizedBox(height: 12),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
            const SizedBox(height: 16),
            Text(TKeys.top_supportive.translate(context), style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16)),
            const SizedBox(height: 12),
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(image: AssetImage('assets/images/top_supportive_bg.png'), fit: BoxFit.fitHeight),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 76),
              alignment: Alignment.center,
              child: Column(
                children: avatars
                    .map(
                      (e) => Column(
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 12,
                                backgroundColor: e,
                                child: Image.asset('assets/images/female.png', width: 24, height: 24),
                              ),
                              const SizedBox(width: 5),
                              const Text('Nick Name', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 12)),
                              const SizedBox(width: 8),
                              SvgPicture.asset('assets/images/karma.svg', width: 20, height: 20),
                              const SizedBox(width: 8),
                              const Text('453 Points', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 12)),
                            ],
                          ),
                          const SizedBox(height: 12),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
            const SizedBox(height: 16),
            Text(TKeys.medal_thank_you.translate(context), style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16)),
            SvgPicture.asset('assets/images/MedalPagePicture.svg', height: 150),
          ],
        ),
      ),
    );
  }
}

class CustomAppBarTitle extends HookConsumerWidget {
  const CustomAppBarTitle({required this.scaffoldKey, required this.index, Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey;

  final int index;

  @override
  Widget build(BuildContext context, ref) {
    final state = ref.read(authProvider);
    UserProvider userProvider = provider.Provider.of<UserProvider>(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => MainScreen(),
            ),
            (Route<dynamic> route) => false,
          ),
          child: SvgPicture.asset('assets/images/IconHomeButton.svg', height: 34),
        ),
        const SizedBox(width: 12),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
          decoration: const ShapeDecoration(
            shape: StadiumBorder(),
            color: Color(0xFFF8F9FE),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (builder) => const MyMainScreen(),
                    ),
                  );
                },
                child: CustomUserAvatar(
                  size: 32,
                  imageUrl: state.userInfo.gender == 'Male' ? 'assets/icons/male.png' : 'assets/icons/female.png',
                  userColor: state.userInfo.color,
                ),
              ),
              const SizedBox(width: 12),
              InkWell(
                onTap: () {
                  if (index != 0) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MedalScreen(),
                      ),
                    );
                  }
                },
                child: SvgPicture.asset('assets/images/medal.svg', color: index == 0 ? Colors.black : null),
              ),
              const SizedBox(width: 12),
              InkWell(
                onTap: () {
                  if (index != 1) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PollsScreen(),
                      ),
                    );
                  }
                },
                child: SvgPicture.asset('assets/images/polls.svg', color: index == 1 ? Colors.black : null),
              ),
              const SizedBox(width: 12),
              InkWell(
                onTap: () {
                  if (index != 2) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const KarmaScreen(),
                      ),
                    );
                  }
                },
                child: SvgPicture.asset('assets/images/karma.svg', color: index == 2 ? Colors.black : null),
              ),
              const SizedBox(width: 12),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NotificationScreen(),
                    ),
                  );
                },
                child: Center(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      SvgPicture.asset('assets/icons/notification.svg', color: const Color(0xFF8B8B8B), height: 24),
                      Positioned(
                        bottom: 3,
                        right: -2,
                        child: Container(
                          decoration: BoxDecoration(
                            color: userProvider.unReadNotificationCount != null && userProvider.unReadNotificationCount! > 0
                                ? Colors.lightGreen
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          height: 15,
                          width: 15,
                          child: Center(
                            child: Text(
                              userProvider.unReadNotificationCount != null && userProvider.unReadNotificationCount! > 0
                                  ? CounterFunction.countforInt(int.parse(userProvider.unReadNotificationCount.toString())).toString() ==
                                          'null'
                                      ? '0'
                                      : CounterFunction.countforInt(int.parse(userProvider.unReadNotificationCount.toString())).toString()
                                  : '',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 8,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              InkWell(
                onTap: () {
                  if (!scaffoldKey.currentState!.isDrawerOpen) {
                    scaffoldKey.currentState!.openDrawer();
                  } else {
                    scaffoldKey.currentState!.openDrawer();
                  }
                },
                child: SvgPicture.asset('assets/images/settings.svg'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
