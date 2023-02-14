import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:blabloglucy/providers/user_provider.dart';
import 'package:blabloglucy/utills/functions/from_rgb_color.dart';

class HiddenUsers extends StatefulWidget {
  const HiddenUsers({Key? key}) : super(key: key);

  @override
  State<HiddenUsers> createState() => _HiddenUsersState();
}

class _HiddenUsersState extends State<HiddenUsers> {
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        title: const Text(
          'Hidden Users',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        // foregroundColor: const Color(0xff121556),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: userProvider.hiddenUsers != null &&
                      userProvider.hiddenUsers!.isNotEmpty
                  ? ListView.builder(
                      itemCount: userProvider.hiddenUsers!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 20,
                              ),
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: fromRGBColor(
                                  userProvider.hiddenUsers![index].color,
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(
                                userProvider.hiddenUsers![index].name,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    )
                  : const Center(
                      child: Text(
                        'No Hidden Users',
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
