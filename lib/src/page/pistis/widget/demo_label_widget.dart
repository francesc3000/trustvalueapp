import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Widget demoLabelWidget(context) => Padding(
  padding: const EdgeInsets.only(top: 18.0, left: 20),
  child: Text.rich(
    TextSpan(
      text: "${AppLocalizations.of(context)!.pistisDemoTitle}\n",
      style: const TextStyle(fontSize: 30),
      children: [
        TextSpan(
            text: "${AppLocalizations.of(context)!.pistisDemoDesc1} ",
            style: const TextStyle(fontSize: 20),
            children: [
              TextSpan(
                text: AppLocalizations.of(context)!.pistis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              TextSpan(
                text:
                ", ${AppLocalizations.of(context)!.pistisDemoDesc2} ",
              ),
              // TextSpan(
              //   text: "${AppLocalizations.of(context)!.blockchain}.\n",
              //   style: const TextStyle(
              //     fontWeight: FontWeight.bold,
              //     fontSize: 25,
              //   ),
              // ),
            ]),
        TextSpan(
            text: "${AppLocalizations.of(context)!.pistisDemoDesc3}.",
            style: const TextStyle(
              fontSize: 20,
            ))
      ],
    ),
  ),
);