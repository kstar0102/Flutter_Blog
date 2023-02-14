import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:blabloglucy/Localization/t_keys.dart';
import 'package:blabloglucy/providers/user_provider.dart';
import 'package:blabloglucy/screens/blocked_users/block_user.dart';
import 'package:blabloglucy/utills/constant.dart';
import 'package:blabloglucy/widgets/custom_user_avatar.dart';

class FollowerTab extends StatefulWidget {
  const FollowerTab({Key? key}) : super(key: key);

  @override
  State<FollowerTab> createState() => _FollowerTabState();
}

class _FollowerTabState extends State<FollowerTab> {
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: userProvider.followers != null &&
                      userProvider.followers!.isNotEmpty
                  ? ListView.builder(
                      itemBuilder: (context, index) {
                        return Followers(
                          name: userProvider.followers![index].name,
                          userColor: userProvider.followers![index].color,
                          image: userProvider.followers![index].gender == 'Male'
                              ? 'assets/icons/male.png'
                              : 'assets/icons/female.png',
                          userId: userProvider.followers![index].id,
                        );
                      },
                    )
                  : const Center(
                      child: Text(
                        'No Followers',
                      ),
                    ),
            ),
            // Followers(
            //   name: "Kristin121",
            //   image: "assets/icons/female/2.png",
            // ),
            // SizedBox(
            //   height: 15,
            // ),
            // Followers(
            //   name: "Jennifer98",
            //   image: "assets/icons/female/1.png",
            // ),
            // SizedBox(
            //   height: 15,
            // ),
            // Followers(
            //   name: "Martin896",
            //   image: "assets/icons/male/1.png",
            // ),
            // SizedBox(
            //   height: 15,
            // ),
            // Followers(
            //   name: "John1999",
            //   image: "assets/icons/male/3.png",
            // ),
            // SizedBox(
            //   height: 15,
            // ),
            // Followers(
            //   name: "Emma567",
            //   image: "assets/icons/female/4.png",
            // ),
            // SizedBox(
            //   height: 15,
            // ),
            // Followers(
            //   name: "Robert21",
            //   image: "assets/icons/male/5.png",
            // ),
            // SizedBox(
            //   height: 15,
            // ),
            // Followers(
            //   name: "Alexandra91",
            //   image: "assets/icons/female/6.png",
            // ),
            // SizedBox(
            //   height: 15,
            // ),
            // Followers(
            //   name: "Rayan61",
            //   image: "assets/icons/male/7.png",
            // ),
          ],
        ),
      ),
    );
  }
}

class Followers extends StatelessWidget {
  final String? image, name, userColor;
  final int? userId;
  const Followers({
    Key? key,
    this.image,
    this.name,
    this.userColor,
    this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 5,
      ),
      child: Row(
        children: [
          // AvatarView(
          //   radius: 20,
          //   borderWidth: 2,
          //   backgroundColor: Colors.blue,
          //   borderColor: fromRGBColor(
          //     userColor!,
          //   ),
          //   avatarType: AvatarType.CIRCLE,
          //   imagePath: image!,
          // ),
          CustomUserAvatar(
            imageUrl: image!,
            userColor: userColor!,
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 10),
            child: Text(
              name!,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: Constants.fontFamilyName,
              ),
            ),
          ),
          const Spacer(),
          PopupMenuButton<int>(
            child: Container(
              padding: const EdgeInsets.only(right: 25, left: 25),
              height: 36,
              width: 48,
              child: Icon(
                Icons.more_vert,
                color: Constants.vertIconColor,
              ),
            ),
            itemBuilder: (context) {
              return <PopupMenuEntry<int>>[
                PopupMenuItem(
                  onTap: () {
                    userProvider.unfollowUser(
                      context: context,
                      userId: userId!,
                    );
                    userProvider.followers!.removeWhere(
                      (element) => element.id == userId,
                    );
                    userProvider.changeFollowers(userProvider.followers);
                  },
                  value: 0,
                  child: Text(TKeys.remove_follower.translate(context)),
                ),
                PopupMenuItem(
                  value: 2,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlockedUser(
                            userId: userId.toString(),
                          ),
                        ),
                      );
                    },
                    child: Text(
                      TKeys.report_block.translate(context),
                    ),
                  ),
                ),
              ];
            },
          ),
        ],
      ),
    );
  }
}
