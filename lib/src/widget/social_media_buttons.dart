import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialMediaButtons extends StatelessWidget {
  const SocialMediaButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ButtonBar(
      children: [
        IconButton(
          onPressed: () => _onMailToPressed(context),
          icon: const Icon(FontAwesomeIcons.solidEnvelope),
          tooltip: AppLocalizations.of(context)!.infoEmail,
        ),
        Visibility(
          visible: false,
          child: IconButton(
            onPressed: _onTwitterPressed,
            icon: const Icon(FontAwesomeIcons.twitter),
          ),
        ),
        IconButton(
          onPressed: _onLinkedinPressed,
          icon: const Icon(FontAwesomeIcons.linkedinIn),
        ),
        IconButton(
          onPressed: _onMediumPressed,
          icon: const Icon(FontAwesomeIcons.medium),
        ),
      ],
    );
  void _onMailToPressed(BuildContext context) async {
    Uri params = Uri(
      scheme: 'mailto',
      path: AppLocalizations.of(context)!.infoEmail,
      query:
      // 'subject=App Feedback&body=App Version 3.23',
      'subject=${AppLocalizations.of(context)!.topic}',
    );

    var url = params.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _onTwitterPressed() async{
    var url = "https://twitter.com/trustvalue_io";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _onLinkedinPressed() async{
    var url = "https://www.linkedin.com/company/trustvalue/";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _onMediumPressed() async{
    var url = "https://trustvalue.medium.com/";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}