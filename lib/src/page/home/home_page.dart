import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pistiscore/pistiscore_route.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'home_desktop_page.dart';
import 'home_mobile_page.dart';

class HomePage extends StatelessWidget {
  final AppRouterDelegate routerDelegate;
  const HomePage(this.routerDelegate, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ScreenTypeLayout(
        mobile: OrientationLayoutBuilder(
          portrait: (context) => HomeMobilePage(
            AppLocalizations.of(context)!.appTitle,
            routerDelegate,
            key: key,
          ),
        ),
        tablet: OrientationLayoutBuilder(
          portrait: (context) => HomeMobilePage(
            AppLocalizations.of(context)!.appTitle,
            routerDelegate,
            key: key,
          ),
        ),
        desktop: OrientationLayoutBuilder(
          portrait: (context) => HomeDesktopPage(
            AppLocalizations.of(context)!.appTitle,
            routerDelegate,
            key: key,
          ),
        ),
      );
}
