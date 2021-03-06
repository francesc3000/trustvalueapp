import 'package:flutter/material.dart';
import 'package:pistiscore/pistiscore_route.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'main_desktop_page.dart';
import 'main_mobile_page.dart';

class MainPage extends StatelessWidget {
  final String title;
  final AppRouterDelegate appRouterDelegate;
  const MainPage(this.title, this.appRouterDelegate, {Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) => ScreenTypeLayout(
        mobile: OrientationLayoutBuilder(
          portrait: (context) =>
              MainMobilePage(title, appRouterDelegate, key: key),
        ),
        tablet: OrientationLayoutBuilder(
          portrait: (context) =>
              MainMobilePage(title, appRouterDelegate, key: key),
          landscape: (context) =>
              MainDesktopPage(title, appRouterDelegate, key: key),
        ),
        desktop: OrientationLayoutBuilder(
          portrait: (context) =>
              MainMobilePage(title, appRouterDelegate, key: key),
          landscape: (context) =>
              MainDesktopPage(title, appRouterDelegate, key: key),
        ),
        // desktop: UnderConstructionPage(),
      );
}
