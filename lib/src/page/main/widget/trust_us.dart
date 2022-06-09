import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher_string.dart';

class TrustUs extends StatelessWidget {
  const TrustUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Wrap(
        alignment: WrapAlignment.spaceAround,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.trustUs,
                style: GoogleFonts.montserrat(
                    fontSize: 35, color: Colors.blueAccent),
              ),
              // const SizedBox(
              //   height: 10,
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _trustUsCompany(
                    "assets/images/apoyo_dravet.png",
                    "Apoyo Dravet",
                    "https://apoyodravet.eu",
                    Colors.white,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _trustUsCompany(
                    "assets/images/sanitamqr.png",
                    "SanitamQR",
                    "https://sanitamqr.com/",
                    Colors.black,
                  ),
                ],
              ),
            ],
          ),
        ],
      );

  Widget _trustUsCompany(
          String image, String name, String website, Color backgroundColor) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          children: [
            ElevatedButton(
              child: Image.asset(
                image,
                width: 100,
                height: 100,
              ),
              style: ButtonStyle(
                // shape: MaterialStateProperty.all<CircleBorder>(
                //   const CircleBorder(),
                // ),
                minimumSize: MaterialStateProperty.all<Size>(
                  const Size(120, 120),
                ),
                elevation: MaterialStateProperty.all<double>(20),
                shadowColor: MaterialStateProperty.all<Color>(Colors.black12),
                backgroundColor:
                    MaterialStateProperty.all<Color>(backgroundColor),
              ),
              onPressed: () => launchUrlString(website),
            ),
            Text(
              name,
              style: GoogleFonts.montserrat(
                  fontSize: 18, color: Colors.blueAccent),
            ),
          ],
        ),
      );
}
