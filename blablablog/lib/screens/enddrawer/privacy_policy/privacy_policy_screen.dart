import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:blabloglucy/Localization/t_keys.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            title: Text(
              TKeys.Privacy_policy.translate(context),
              style: GoogleFonts.montserrat(
                  fontSize: 14,
                  color: const Color(0xff19334D),
                  fontWeight: FontWeight.w800),
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Text(
                  TKeys.Privacy_Policy_desc.translate(context),
                  style: GoogleFonts.montserrat(fontSize: 16),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Text(
                  TKeys.Disclaimer.translate(context),
                  style: GoogleFonts.montserrat(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Text(
                  TKeys.Disclaimer_lineI.translate(context),
                  style: GoogleFonts.montserrat(fontSize: 16),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Text(
                  TKeys.Disclaimer_lineII.translate(context),
                  style: GoogleFonts.montserrat(fontSize: 16),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Text(
                  TKeys.collect_about.translate(context),
                  style: GoogleFonts.montserrat(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Text(
                  TKeys.collect_about_informationI.translate(context),
                  style: GoogleFonts.montserrat(fontSize: 16),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Text(
                  TKeys.collect_about_informationII.translate(context),
                  style: GoogleFonts.montserrat(fontSize: 16),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Text(
                  TKeys.we_dont_collect.translate(context),
                  style: GoogleFonts.montserrat(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              CircleDotText(
                text: TKeys.We_dont_collect_GPS.translate(context),
              ),
              CircleDotText(
                text: TKeys.We_dont_collect_traffic.translate(context),
              ),
              Container(
                margin: const EdgeInsetsDirectional.only(
                  start: 43,
                ),
                child: Text(
                  TKeys.We_dont_collect_trafficII.translate(context),
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                  ),
                ),
              ),
              CircleDotText(
                text: TKeys.We_dont_collect_storage.translate(context),
              ),
              const SizedBox(
                height: 15,
              ),
              HeadingText(
                text: TKeys.What_we_Share.translate(context),
              ),
              const SizedBox(
                height: 15,
              ),
              DescriptionText(
                text: TKeys.posted_in_blabloglucy.translate(context),
              ),
              DescriptionText(
                text: TKeys.want_to_use_nickname.translate(context),
              ),
              const SizedBox(
                height: 15,
              ),
              HeadingText(
                text: TKeys.Privacy_olicy_title.translate(context),
              ),
              const SizedBox(
                height: 15,
              ),
              DescriptionText(
                text: TKeys.disclosure_of_Personal_Info.translate(context),
              ),
              DescriptionText(
                text: TKeys.use_our_Service.translate(context),
              ),
              DescriptionText(
                text: TKeys.improving_the_Service.translate(context),
              ),
              DescriptionText(
                text: TKeys.described_Privacy.translate(context),
              ),
              DescriptionText(
                text: TKeys.accessible_in_our_Terms.translate(context),
              ),
              const SizedBox(
                height: 15,
              ),
              HeadingText(
                text: TKeys.info_Collection.translate(context),
              ),
              const SizedBox(
                height: 15,
              ),
              DescriptionText(
                text: TKeys.Log_Data.translate(context),
              ),
              DescriptionText(
                text: TKeys.Log_Data_def.translate(context),
              ),
              DescriptionText(
                text: TKeys.Internet_Protocol.translate(context),
              ),
              DescriptionText(
                text: TKeys.other_statistics.translate(context),
              ),
              DescriptionText(
                text: TKeys.Cookies.translate(context),
              ),
              DescriptionText(
                text: TKeys.cookies_improve_our_Service.translate(context),
              ),
              const SizedBox(
                height: 15,
              ),
              HeadingText(
                text: TKeys.Security.translate(context),
              ),
              const SizedBox(height: 15),
              DescriptionText(
                text: TKeys.We_value_your_trust.translate(context),
              ),
              DescriptionText(
                text: TKeys.But_remember_that_no_method.translate(context),
              ),
              const SizedBox(
                height: 15,
              ),
              HeadingText(
                text: TKeys.Changes_to_Policy.translate(context),
              ),
              const SizedBox(
                height: 15,
              ),
              DescriptionText(
                text: TKeys.update_our_Privacy.translate(context),
              ),
              DescriptionText(
                text: TKeys.advise_you_to_review_page.translate(context),
              ),
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

class HeadingText extends StatelessWidget {
  final String? text;
  const HeadingText({
    Key? key,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Text(
        text!,
        style:
            GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class DescriptionText extends StatelessWidget {
  final String? text;
  const DescriptionText({
    Key? key,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Text(
        text!,
        style: GoogleFonts.montserrat(fontSize: 16),
      ),
    );
  }
}

class CircleDotText extends StatelessWidget {
  final String? text;
  const CircleDotText({
    Key? key,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: const EdgeInsetsDirectional.only(
            start: 25,
            top: 10,
            bottom: 10,
          ),
          height: 10,
          width: 10,
          decoration: const BoxDecoration(
            color: Color(0xfff6C50AA),
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          text!,
          style: GoogleFonts.montserrat(
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}

class CustomText extends StatelessWidget {
  final String? text;
  final Color? color;
  final FontWeight? fontWeight;

  const CustomText({
    Key? key,
    this.text,
    this.color,
    this.fontWeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Column(
        children: [
          Text(
            text!,
            style: GoogleFonts.montserrat(
              color: color,
              fontSize: 16,
              fontWeight: fontWeight,
              letterSpacing: 1,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}
