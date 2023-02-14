import 'dart:convert';
import 'dart:developer';

import 'package:clean_api/clean_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:blabloglucy/Localization/t_keys.dart';
import 'package:blabloglucy/models/notification.dart';
import 'package:blabloglucy/providers/user_provider.dart';
import 'package:blabloglucy/providers/widget_provider.dart';
import 'package:blabloglucy/utills/constant.dart';
import 'package:blabloglucy/widgets/custom_user_avater.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  int notificationPageNumber = 1;
  bool isAllContentLoaded = false;
  bool isLoaded = false;
  ScrollController? _scrollController;
  var box = GetStorage();
  // TODO
  // Timer? _timer;
  // final int _start = 10;
  List<NotificationModel>? notifications = [];
  @override
  void initState() {
    _scrollController = ScrollController();
    getNotifications();
    unreadNotifications();

    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    userProvider.unReadNotificationCount = 0;

    // _userProvider.getNotifications(context: context);
    _scrollController!.addListener(
      () {
        if (_scrollController!.position.pixels ==
            _scrollController!.position.maxScrollExtent) {
          setState(() {
            notificationPageNumber++;
          });
          getNotifications();
        }
      },
    );

    super.initState();
  }

  void unreadNotifications() async {
    Uri uri = Uri.tryParse('https://api.localhost.com/api/v1/User/ClickBell')!;
    WidgetProvider widgetProvider = Provider.of<WidgetProvider>(
      context,
      listen: false,
    );
    await widgetProvider
        .returnConnection()
        .put(
          uri,
          headers: Constants.authenticatedHeaders(
            context: context,
            userToken: box.read('userTokenForAuth'),
          ),
        )
        .then((value) {});
  }

  void getNotifications() async {
    // 'https://api.localhost.com/api/v1/User/Notifications?page=1&read=true&limit=10'
    Uri uri = Uri.tryParse(
        'https://api.localhost.com/api/v1/User/Notifications?page=$notificationPageNumber&read=true&limit=10')!;
    WidgetProvider widgetProvider = Provider.of<WidgetProvider>(
      context,
      listen: false,
    );
    await widgetProvider
        .returnConnection()
        .get(
          uri,
          headers: Constants.authenticatedHeadersForNotifications(
              context: context,
              userToken: box.read('userTokenForAuth'),
              lang: box.read('lang')),
        )
        .then((value) {
      notificationPageNumber == 0 ? notifications = [] : null;
      notifications ??= [];
      // notificationPageNumber == 0 ? unReadNotificationCount = 0 : null;
      var response = json.decode(value.body);
      Logger.w(response);
      // changeNotificationsCount(response['payload']['unread_notifs_no']);
      if (response['payload']['notifs_on_this_page'] != null &&
          response['payload']['notifs_on_this_page']!.isNotEmpty) {
        // Logger.w('this page lenght is ${response['payload']['notifs_on_this_page'].length} ${notificationPageNumber}  ${box.read('lang')}');
        if (response['payload']['notifs_on_this_page'].length != 0) {
          response['payload']['notifs_on_this_page'].forEach(
            (e) {
              notifications!.add(NotificationModel.fromMap(e));
            },
          );
        }

        isLoaded = true;

        Logger.e(response['payload']['notifs_on_this_page'].length);

        Logger.w(notifications);
      }
      if (response['payload']['notifs_on_this_page'] == null) {
        isAllContentLoaded = true;
      }

      if (response['payload']['notifs_on_this_page'] != null) {
        if (response['payload']['notifs_on_this_page'].length < 4) {
          isAllContentLoaded = true;
        }
      }
    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    log('notification list length${userProvider.notifications!.length}');
    log('page no : $notificationPageNumber');

    Logger.w(
        '${notifications!.length.toString()} ========================================== These are notifications');
    Logger.e(isAllContentLoaded);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        titleSpacing: 0,
        elevation: 0,
        title: Text(
          TKeys.notification_text.translate(context),
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xff19334D),
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color(0xff19334D),
            size: 25,
          ),
        ),
      ),
      body: SafeArea(
        child: isLoaded
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: notifications!.length + 1,
                      itemBuilder: ((context, index) {
                        if (index < notifications!.length) {
                          debugPrint(
                              'Notifications:   ${notifications![index].message}');
                          return CustomNotificationTile(
                            subTitle:
                                //  By OK
                                // RichText(
                                //   text: TextSpan(
                                //     text: "Your Post in ",
                                //     style: GoogleFonts.montserrat(
                                //       color: Colors.black,
                                //       fontSize: 14,
                                //     ),
                                //     children: <TextSpan>[
                                //       TextSpan(
                                //         text:_userProvider
                                //             .notifications![index].storyTitle.toString().replaceAll("<p","").replaceAll("</p", " ")+" " ,
                                //         style: GoogleFonts.montserrat(
                                //           color: Colors.blue,
                                //           fontSize: 14,
                                //           fontWeight: FontWeight.w500,
                                //         ),
                                //       ),
                                //       TextSpan(
                                //         text: _userProvider
                                //             .notifications![index].message.toString().replaceAll("<span class='noti-msg-bkend-type'>", "").replaceAll("</span>", "").replaceAll("Your post in", ""),
                                //         style: TextStyle(
                                //           color: Colors.black,
                                //           fontSize: 14,
                                //         ),
                                //       ),
                                //     ],
                                //   ),
                                // ),
                                GestureDetector(
                              onTap: () {
                                Logger.w(notifications![index].userGender);
                              },
                              child: HtmlWidget(
                                notifications![index].message!,
                              ),
                            ),
                            backgroundImage: (notifications![index]
                                            .notificationType ==
                                        'USER_COMMENTED' ||
                                    notifications![index].notificationType ==
                                        'USER_LIKED')
                                ? notifications![index].userGender == 'Male'
                                    ? 'assets/icons/male.png'
                                    : 'assets/icons/female.png'
                                : notifications![index].notificationType ==
                                        'STORY_REJECTED'
                                    ? 'assets/images/NotificationDeclined.svg'
                                    : notifications![index].notificationType ==
                                            'STORY_PENDING'
                                        ? 'assets/images/NotificationsPending.svg'
                                        : notifications![index]
                                                    .notificationType ==
                                                'STORY_APPROVED'
                                            ? 'assets/images/NotificationApproval.svg'
                                            : 'assets/images/ICONS/New folder/NotificationDeclined.svg',
                            userColor: notifications![index].userColor,
                            title: Text(
                                notifications![index]
                                    .notificationDate!
                                    .toString(),
                                style: const TextStyle(fontSize: 14)),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     Text(notifications![index].storyTitle.toString()=="null" ? "My Story" : notifications![index].storyTitle.toString() ,style: TextStyle(fontSize: 14,color: Colors.blue.shade700,fontWeight: FontWeight.w500),),
                            //
                            //   ],
                            // ),
                          );
                        } else {
                          return !isAllContentLoaded
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    SizedBox(
                                      height: 100,
                                    ),
                                    Center(
                                      child: SpinKitFadingFour(
                                        size: 60,
                                        color: Color(0xff52527a),
                                      ),
                                    ),
                                  ],
                                )
                              : const SizedBox();
                        }
                      }),
                    ),
                  ),
                ],
              )
            : isAllContentLoaded
                ? const SizedBox()
                : const Center(
                    child: SpinKitFadingFour(
                      size: 60,
                      color: Color(0xff52527a),
                    ),
                  ),
      ),
    );
  }
}

class CustomRichText extends StatelessWidget {
  final String? text1;
  final String? text2;
  final String? text3;
  final Color? color;
  final Color? color1;
  final FontWeight? fontWeight;
  const CustomRichText({
    Key? key,
    this.text1,
    this.text2,
    this.text3,
    this.color,
    this.fontWeight,
    this.color1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: text1,
        style: GoogleFonts.montserrat(
          color: Colors.black,
          fontSize: 14,
        ),
        children: <TextSpan>[
          TextSpan(
            text: text2,
            style: GoogleFonts.montserrat(
              color: color,
              fontSize: 14,
              fontWeight: fontWeight,
            ),
          ),
          TextSpan(
            text: text3,
            style: TextStyle(
              color: color1,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

class CustomNotificationTile extends StatelessWidget {
  final String? backgroundImage;
  final Widget? leading;
  final Widget? title;
  final Widget? subTitle;
  final String? userColor;

  const CustomNotificationTile({
    Key? key,
    this.backgroundImage,
    this.leading,
    this.userColor,
    this.title,
    this.subTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      style: ListTileStyle.list,
      leading: CustomUserAvatar2(
        userColor: userColor!,
        imageUrl: backgroundImage!,
      ),
      title: title,
      subtitle: subTitle,
    );
  }
}
