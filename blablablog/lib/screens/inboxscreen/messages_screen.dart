import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:blabloglucy/Localization/t_keys.dart';
import 'package:blabloglucy/models/chat.dart';
import 'package:blabloglucy/providers/chat_provider.dart';
import 'package:blabloglucy/providers/user_provider.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({
    Key? key,
    required this.messages,
  }) : super(key: key);

  final List<SingleMessage>? messages;

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    ChatProvider chatProvider = Provider.of<ChatProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        title: Text(
          chatProvider.userChats![0].otherProfile!.userId !=
                  userProvider.userInfo!.id
              ? chatProvider.userChats![0].otherProfile!.nickName!
              : chatProvider.userChats![0].myProfile!.nickName!,
          style: GoogleFonts.montserrat(color: Colors.black),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: messages!.length,
                // reverse: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: messages![index].myProfileId ==
                              userProvider.userInfo!.id
                          ? Alignment.topRight
                          : Alignment.topLeft,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              offset: const Offset(0, 3),
                              blurRadius: 6,
                            ),
                          ],
                        ),
                        child: Card(
                          elevation: 0,
                          child: Text(
                            messages![index].message!,
                            style: GoogleFonts.montserrat(
                                fontSize: 14, fontWeight: FontWeight.w300),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            //

            // ListTile(
            //   leading: Image.asset(
            //     'assets/images/man.png',
            //     height: 35,
            //     fit: BoxFit.cover,
            //   ),
            //   title: Row(
            //     children: [
            //       Text(
            //         '5LikeUser',
            //         style: GoogleFonts.montserrat(
            //             fontSize: 14, fontWeight: FontWeight.bold),
            //       ),
            //       const SizedBox(
            //         width: 4,
            //       ),
            //       Text(
            //         '10.30.2019',
            //         style: GoogleFonts.montserrat(fontSize: 14),
            //       ),
            //     ],
            //   ),
            // ),
            // const SizedBox(
            //   height: 20,
            // ),
            // Padding(
            //   padding: const EdgeInsetsDirectional.only(end: 130, start: 35),
            //   child: Container(
            //     padding: const EdgeInsets.symmetric(horizontal: 10),
            //     decoration: BoxDecoration(
            //       color: Colors.white,
            //       boxShadow: [
            //         BoxShadow(
            //           color: Colors.grey.withOpacity(0.5),
            //           offset: const Offset(0, 3),
            //           blurRadius: 6,
            //         ),
            //       ],
            //     ),
            //     child: Card(
            //       elevation: 0,
            //       child: ListTile(
            //         title: Text(
            //           'Hi how are you?',
            //           style: GoogleFonts.montserrat(
            //               fontSize: 14, fontWeight: FontWeight.w300),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            // const SizedBox(
            //   height: 20,
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(
            //     right: 30,
            //   ),
            //   child: Align(
            //     alignment: AlignmentDirectional.topEnd,
            //     child: Text(
            //       '30.10.2019 Me',
            //       style: GoogleFonts.montserrat(fontSize: 14),
            //     ),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 100, top: 20, right: 30),
            //   child: Container(
            //     decoration: BoxDecoration(
            //       color: const Color(0xffffafafa),
            //       boxShadow: [
            //         BoxShadow(
            //           color: Colors.grey.withOpacity(0.5),
            //           offset: const Offset(0, 3),
            //           blurRadius: 6,
            //         ),
            //       ],
            //     ),
            //     child: Card(
            //       color: const Color(0xffffafafa),
            //       elevation: 0,
            //       child: ListTile(
            //         title: Text(
            //           'Hi',
            //           style: GoogleFonts.montserrat(fontSize: 14),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            // const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 4, left: 4, right: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: const Color(0xfffFAFAFA),
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(
                                hintText: TKeys.message_text.translate(context),
                                border: InputBorder.none,
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xfffFAFAFA),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              TKeys.Send_text.translate(context),
                              style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 16,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
