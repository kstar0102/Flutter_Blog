import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:blabloglucy/Localization/t_keys.dart';
import 'package:blabloglucy/screens/enddrawer/privacy_policy/privacy_policy_screen.dart';

class TermsOfUseScreen extends StatelessWidget {
  const TermsOfUseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            title: Text(
              TKeys.Terms_of_use_title.translate(context),
              style: GoogleFonts.montserrat(
                fontSize: 16,
                color: const Color(0xff19334D),
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.white,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                size: 25,
                color: Color(0xff19334D),
              ),
            ),
          ),
        ],
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 15,
              ),
              DescriptionText(
                text: TKeys.Terms_desc1.translate(context),
              ),
              DescriptionText(
                text: TKeys.Terms_desc2.translate(context),
              ),
              DescriptionText(
                text: TKeys.Terms_desc3.translate(context),
              ),
              DescriptionText(
                text: TKeys.Terms_desc4.translate(context),
              ),
              DescriptionText(
                text: TKeys.Terms_desc5.translate(context),
              ),
              DescriptionText(
                text: TKeys.Terms_desc6.translate(context),
              ),
              DescriptionText(
                text: TKeys.Terms_desc7.translate(context),
              ),
              const SizedBox(
                height: 15,
              ),
              HeadingText(
                text: TKeys.blabloglucy_heading.translate(context),
              ),
              const SizedBox(
                height: 15,
              ),
              DescriptionText(
                text: TKeys.blabloglucydef1.translate(context),
              ),
              DescriptionText(
                text: TKeys.blabloglucydef2.translate(context),
              ),
              DescriptionText(
                text: TKeys.blabloglucydef3.translate(context),
              ),
              DescriptionText(
                text: TKeys.blabloglucydef4.translate(context),
              ),
              DescriptionText(
                text: TKeys.blabloglucydef5.translate(context),
              ),
              DescriptionText(
                text: TKeys.blabloglucydef6.translate(context),
              ),
              DescriptionText(
                text: TKeys.blabloglucydef7.translate(context),
              ),
              DescriptionText(
                text: TKeys.blabloglucydef8.translate(context),
              ),
              DescriptionText(
                text: TKeys.blabloglucydef9.translate(context),
              ),
              DescriptionText(
                text: TKeys.blabloglucydef10.translate(context),
              ),
              DescriptionText(
                text: TKeys.blabloglucydef11.translate(context),
              ),
              DescriptionText(
                text: TKeys.blabloglucydef12.translate(context),
              ),
              DescriptionText(
                text: TKeys.blabloglucydef13.translate(context),
              ),
              DescriptionText(
                text: TKeys.blabloglucydef14.translate(context),
              ),
              DescriptionText(
                text: TKeys.blabloglucydef15.translate(context),
              ),
              DescriptionText(
                text: TKeys.blabloglucydef16.translate(context),
              ),
              DescriptionText(
                text: TKeys.blabloglucydef17.translate(context),
              ),
              const SizedBox(
                height: 15,
              ),
              HeadingText(
                text: TKeys.Whosallowed.translate(context),
              ),
              const SizedBox(
                height: 15,
              ),
              DescriptionText(
                text: TKeys.Whosallowed1.translate(context),
              ),
              DescriptionText(
                text: TKeys.Whosallowed2.translate(context),
              ),
              DescriptionText(
                text: TKeys.Whosallowed3.translate(context),
              ),
              DescriptionText(
                text: TKeys.Whosallowed4.translate(context),
              ),
              DescriptionText(
                text: TKeys.Whosallowed5.translate(context),
              ),
              DescriptionText(
                text: TKeys.Whosallowed6.translate(context),
              ),
              const SizedBox(
                height: 15,
              ),
              HeadingText(text: TKeys.acknowledge_and_agree.translate(context)),
              const SizedBox(
                height: 15,
              ),
              DescriptionText(text: TKeys.blablogactivity1.translate(context)),
              DescriptionText(text: TKeys.blablogactivity2.translate(context)),
              DescriptionText(text: TKeys.blablogactivity3.translate(context)),
              DescriptionText(text: TKeys.blablogactivity4.translate(context)),
              DescriptionText(text: TKeys.blablogactivity5.translate(context)),
              DescriptionText(text: TKeys.blablogactivity6.translate(context)),
              DescriptionText(text: TKeys.blablogactivity7.translate(context)),
              DescriptionText(text: TKeys.blablogactivity8.translate(context)),
              const SizedBox(
                height: 15,
              ),
              HeadingText(text: TKeys.responsibility.translate(context)),
              const SizedBox(
                height: 15,
              ),
              DescriptionText(text: TKeys.responsibility1.translate(context)),
              DescriptionText(text: TKeys.responsibility2.translate(context)),
              DescriptionText(text: TKeys.responsibility3.translate(context)),
              DescriptionText(text: TKeys.responsibility4.translate(context)),
              DescriptionText(text: TKeys.responsibility5.translate(context)),
              DescriptionText(text: TKeys.responsibility6.translate(context)),
              DescriptionText(text: TKeys.responsibility7.translate(context)),
              DescriptionText(text: TKeys.responsibility8.translate(context)),
              DescriptionText(text: TKeys.responsibility9.translate(context)),
              DescriptionText(text: TKeys.responsibility10.translate(context)),
              DescriptionText(text: TKeys.responsibility11.translate(context)),
              DescriptionText(text: TKeys.responsibility12.translate(context)),
              DescriptionText(text: TKeys.responsibility13.translate(context)),
              const SizedBox(
                height: 15,
              ),
              HeadingText(text: TKeys.Mobile_Features.translate(context)),
              const SizedBox(height: 15),
              DescriptionText(text: TKeys.Mobile_Features1.translate(context)),
              DescriptionText(text: TKeys.Mobile_Features2.translate(context)),
              DescriptionText(text: TKeys.Mobile_Features3.translate(context)),
              const SizedBox(
                height: 15,
              ),
              HeadingText(
                  text: TKeys.Terminating_and_shutting_acc.translate(context)),
              const SizedBox(
                height: 15,
              ),
              DescriptionText(text: TKeys.Terminating_desc1.translate(context)),
              DescriptionText(text: TKeys.Terminating_desc2.translate(context)),
              DescriptionText(text: TKeys.Terminating_desc3.translate(context)),
              const SizedBox(
                height: 15,
              ),
              HeadingText(text: TKeys.Feedback.translate(context)),
              const SizedBox(
                height: 15,
              ),
              DescriptionText(text: TKeys.Feedback1.translate(context)),
              DescriptionText(text: TKeys.Feedback2.translate(context)),
              const SizedBox(
                height: 15,
              ),
              HeadingText(text: TKeys.Trademarks.translate(context)),
              const SizedBox(
                height: 15,
              ),
              DescriptionText(text: TKeys.Trademarks1.translate(context)),
              DescriptionText(text: TKeys.Trademarks2.translate(context)),
              DescriptionText(text: TKeys.Trademarks3.translate(context)),
              const SizedBox(
                height: 15,
              ),
              HeadingText(
                  text: TKeys.Privacy_updates_time_to_time.translate(context)),
              const SizedBox(
                height: 15,
              ),
              DescriptionText(
                  text: TKeys.Privacy_updates_time_to_time1.translate(context)),
              DescriptionText(
                  text: TKeys.Privacy_updates_time_to_time2.translate(context)),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
