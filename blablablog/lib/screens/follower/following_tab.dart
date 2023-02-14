import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:blabloglucy/Localization/t_keys.dart';
import 'package:blabloglucy/providers/user_provider.dart';
import 'package:blabloglucy/screens/blocked_users/block_user.dart';
import 'package:blabloglucy/utills/constant.dart';
import 'package:blabloglucy/widgets/custom_user_avatar.dart';

class FollowingTab extends StatefulWidget {
  const FollowingTab({Key? key}) : super(key: key);

  @override
  State<FollowingTab> createState() => _FollowingTabState();
}

class _FollowingTabState extends State<FollowingTab> {
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
              child: userProvider.followingUsers != null &&
                      userProvider.followingUsers!.isNotEmpty
                  ? ListView.builder(
                      itemCount: userProvider.followingUsers!.length,
                      itemBuilder: (context, index) {
                        return Following(
                          name: userProvider.followingUsers![index].name,
                          userColor: userProvider.followingUsers![index].color,
                          imageAddress:
                              userProvider.followingUsers![index].gender ==
                                      'Male'
                                  ? 'assets/icons/male.png'
                                  : 'assets/icons/female.png',
                          userId: userProvider.followingUsers![index].id,
                        );
                      },
                    )
                  : const Center(
                      child: Text(
                        'No Following Users',
                      ),
                    ),
            ),
            // Following(
            //   name: "Alexandra91",
            //   image: "assets/icons/female/6.png",
            // ),
            // SizedBox(
            //   height: 15,
            // ),
            // Following(
            //   name: "Rayan61",
            //   image: "assets/icons/male/7.png",
            // ),
            // SizedBox(
            //   height: 15,
            // ),
            // Following(
            //   name: "Martin896",
            //   image: "assets/icons/male/1.png",
            // ),
            // SizedBox(
            //   height: 15,
            // ),
            // Following(
            //   name: "John1999",
            //   image: "assets/icons/male/3.png",
            // ),
            // SizedBox(
            //   height: 15,
            // ),
            // Following(
            //   name: "Emma567",
            //   image: "assets/icons/female/4.png",
            // ),
            // SizedBox(
            //   height: 15,
            // ),
            // Following(
            //   name: "Kristin121",
            //   image: "assets/icons/female/2.png",
            // ),
            // SizedBox(
            //   height: 15,
            // ),
            // Following(
            //   name: "Jennifer98",
            //   image: "assets/icons/female/1.png",
            // ),
            // SizedBox(
            //   height: 15,
            // ),
            // Following(
            //   name: "Robert21",
            //   image: "assets/icons/male/5.png",
            // ),
            // SizedBox(
            //   height: 15,
            // ),
          ],
        ),
      ),
    );
  }
}

class Following extends StatelessWidget {
  final String? userColor, name, imageAddress;
  final int? userId;
  const Following({
    Key? key,
    this.userColor,
    this.name,
    this.imageAddress,
    this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          // AvatarView(
          //   radius: 20,
          //   borderWidth: 2,
          //   backgroundColor: Colors.blue,
          //   borderColor: fromRGBColor(userColor!),
          //   avatarType: AvatarType.CIRCLE,
          //   imagePath: imageAddress!,
          // ),
          CustomUserAvatar(
            imageUrl: imageAddress!,
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
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            itemBuilder: (context) {
              return <PopupMenuEntry<int>>[
                PopupMenuItem(
                  onTap: () {
                    userProvider.unfollowUser(
                      userId: userId!,
                      context: context,
                    );
                    userProvider.followingUsers!.removeWhere(
                      (element) => element.id == userId,
                    );
                    userProvider.changeFollowingUsers(
                      userProvider.followingUsers,
                    );
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
            child: Container(
              padding: const EdgeInsets.only(right: 25, left: 25),
              height: 36,
              width: 48,
              child: Icon(
                Icons.more_vert,
                color: Constants.vertIconColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
