import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:blabloglucy/Localization/t_keys.dart';
import 'package:blabloglucy/providers/chat_provider.dart';
import 'package:blabloglucy/providers/user_provider.dart';
import 'package:blabloglucy/widgets/custom_user_avatar.dart';

import 'messages_screen.dart';

class UserChatsScreen extends StatelessWidget {
  const UserChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    ChatProvider chatProvider = Provider.of<ChatProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          TKeys.inbox_text.translate(context),
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w800,
            fontSize: 14,
            color: const Color(0xff19334D),
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color(0xff19334D),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                child: ListView.builder(
                  itemCount: chatProvider.userChats!.length,
                  itemBuilder: ((context, index) {
                    return Card(
                      color: Colors.white,
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MessagesScreen(
                                messages:
                                    chatProvider.userChats![index].messages,
                              ),
                            ),
                          );
                        },
                        leading: CustomUserAvatar(
                          imageUrl: chatProvider.userChats![index].otherProfile!
                                          .userId !=
                                      null &&
                                  chatProvider.userChats![index].otherProfile!
                                          .userId !=
                                      userProvider.userInfo!.id
                              ? chatProvider.userChats![index].otherProfile!
                                          .userGender ==
                                      1
                                  ? 'assets/icons/male.png'
                                  : 'assets/icons/female.png'
                              : chatProvider.userChats![index].myProfile!
                                          .userGender ==
                                      1
                                  ? 'assets/icons/male.png'
                                  : 'assets/icons/female.png',
                          userColor: chatProvider.userChats![index]
                                          .otherProfile!.userId !=
                                      null &&
                                  chatProvider.userChats![index].otherProfile!
                                          .userId !=
                                      userProvider.userInfo!.id
                              ? chatProvider
                                  .userChats![index].otherProfile!.color!.color!
                              : chatProvider
                                  .userChats![index].myProfile!.color!.color!,
                        ),
                        title: Row(
                          children: [
                            Text(
                              chatProvider.userChats![index].otherProfile!
                                              .userId !=
                                          null &&
                                      chatProvider.userChats![index]
                                              .otherProfile!.userId !=
                                          userProvider.userInfo!.id
                                  ? chatProvider
                                      .userChats![index].otherProfile!.nickName!
                                  : chatProvider
                                      .userChats![index].myProfile!.nickName!,
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w500, fontSize: 14),
                            ),
                            const SizedBox(
                              width: 2,
                            ),
                            Text(
                              chatProvider
                                  .userChats![index].messages![0].createdAt!,
                              style: GoogleFonts.montserrat(
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                        trailing: PopupMenuButton<int>(
                          iconSize: 35,
                          key: key,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                          ),
                          itemBuilder: (context) {
                            return <PopupMenuEntry<int>>[
                              PopupMenuItem(
                                onTap: () {
                                  chatProvider.deleteSingleChat(
                                    context: context,
                                    chatId: chatProvider.userChats![index]
                                                .otherProfile!.userId !=
                                            userProvider.userInfo!.id
                                        ? chatProvider.userChats![index]
                                            .otherProfile!.userId!
                                            .toString()
                                        : chatProvider.userChats![index]
                                            .myProfile!.userId!
                                            .toString(),
                                  );
                                  chatProvider.userChats!.removeAt(index);
                                  chatProvider.changeUserChats(
                                    userChats: chatProvider.userChats!,
                                  );
                                },
                                child: Text(TKeys.delete_conversion.translate(
                                  context,
                                )),
                              ),
                              PopupMenuItem(
                                onTap: () {
                                  userProvider.reportUser(
                                    context: context,
                                    userId: chatProvider.userChats![index]
                                                .otherProfile!.userId !=
                                            userProvider.userInfo!.id
                                        ? chatProvider.userChats![index]
                                            .otherProfile!.userId!
                                        : chatProvider.userChats![index]
                                            .myProfile!.userId!,
                                  );
                                },
                                child:
                                    Text(TKeys.report_User.translate(context)),
                              ),
                              PopupMenuItem(
                                onTap: () {
                                  userProvider.blockUser(
                                    context: context,
                                    userId: chatProvider.userChats![index]
                                                .otherProfile!.userId !=
                                            userProvider.userInfo!.id
                                        ? chatProvider.userChats![index]
                                            .otherProfile!.userId!
                                        : chatProvider.userChats![index]
                                            .myProfile!.userId!,
                                  );
                                },
                                child: Text(
                                  TKeys.block_User.translate(
                                    context,
                                  ),
                                ),
                              ),
                            ];
                          },
                        ),
                        subtitle: Text(
                          chatProvider.userChats![index].messages![0].message!,
                          style: GoogleFonts.montserrat(fontSize: 14),
                        ),
                      ),
                    );
                  }),
                )),
          ),
        ],
      ),
    );
  }
}
