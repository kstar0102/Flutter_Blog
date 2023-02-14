import 'package:flutter/material.dart';
import 'package:blabloglucy/Localization/t_keys.dart';

import '../../presentation/screens/main_screen.dart';
import '../medal/medal_screen.dart';

class KarmaScreen extends StatefulWidget {
  const KarmaScreen({Key? key}) : super(key: key);

  @override
  State<KarmaScreen> createState() => _KarmaScreenState();
}

class _KarmaScreenState extends State<KarmaScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        titleSpacing: 0,
        leadingWidth: 0,
        title: CustomAppBarTitle(scaffoldKey: _scaffoldKey, index: 2),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(
              top: 75,
            ),
            width: double.infinity,
          ),
          Text(
            TKeys.our_way.translate(context),
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Text(
              TKeys.write_nice_comment.translate(context),
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Text(
            TKeys.your_credit.translate(context),
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Text(
              TKeys.you_can_redeem.translate(context),
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 150,
          ),
          Text(
            TKeys.comming_soon.translate(context),
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
