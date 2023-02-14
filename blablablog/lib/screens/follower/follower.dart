import 'package:flutter/material.dart';
import 'package:blabloglucy/Localization/t_keys.dart';
import 'package:blabloglucy/presentation/screens/main_screen.dart';

import 'follower_tab.dart';
import 'following_tab.dart';

class Follower extends StatefulWidget {
  const Follower({Key? key}) : super(key: key);

  @override
  State<Follower> createState() => _FollowerState();
}

class _FollowerState extends State<Follower> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MainScreen(),
                ),
              );
            },
          ),
          foregroundColor: const Color(0xff121556),
          backgroundColor: Colors.white,
          elevation: 0,
          bottom: TabBar(
            indicator: const BoxDecoration(),
            labelStyle: const TextStyle(
              fontWeight: FontWeight.w900,
            ),
            // unselectedLabelStyle: TextStyle(fontFamily: 'Family Name',),
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.normal,
            ),
            labelColor: const Color(0xff121556),
            unselectedLabelColor: const Color(0xff121556),
            tabs: [
              Tab(
                text: TKeys.following.translate(context),
              ),
              Tab(
                text: TKeys.Followers_text.translate(context),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            FollowingTab(),
            FollowerTab(),
          ],
        ),
      ),
    );
  }
}
