import 'package:flutter/material.dart';
import 'package:pistiscore/pistiscore_route.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:trustvalueapp/src/page/pistis/pistis_desktop_page.dart';
import 'package:trustvalueapp/src/page/pistis/pistis_mobile_page.dart';

class PistisPage extends StatelessWidget {
  final String title;
  final AppRouterDelegate appRouterDelegate;
  const PistisPage(this.title, this.appRouterDelegate, {Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) => ScreenTypeLayout(
        mobile: OrientationLayoutBuilder(
          portrait: (context) =>
              PistisMobilePage(title, appRouterDelegate, key: key),
        ),
        tablet: OrientationLayoutBuilder(
          portrait: (context) =>
              PistisMobilePage(title, appRouterDelegate, key: key),
          landscape: (context) =>
              PistisDesktopPage(title, appRouterDelegate, key: key),
        ),
        desktop: OrientationLayoutBuilder(
          portrait: (context) =>
              PistisMobilePage(title, appRouterDelegate, key: key),
          landscape: (context) =>
              PistisDesktopPage(title, appRouterDelegate, key: key),
        ),
        // desktop: UnderConstructionPage(),
      );
}
