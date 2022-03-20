import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../widget/social_media_buttons.dart';

class ContactData extends StatelessWidget {
  const ContactData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String currentYear = DateTime.now().year.toString();
    return Wrap(
      alignment: WrapAlignment.end,
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              AppLocalizations.of(context)!.sendUs,
              style: GoogleFonts.montserrat(
                  fontSize: 15, color: Colors.blueAccent),
            ),
            const SocialMediaButtons(),
          ],
        ),
        Text(
          "${AppLocalizations.of(context)!.companyName}® $currentYear",
          style: GoogleFonts.montserrat(fontSize: 15, color: Colors.blueAccent),
        ),
      ],
    );
  }
}
