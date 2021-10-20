import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'main_desktop_page.dart';
import 'main_mobile_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
        mobile: OrientationLayoutBuilder(
          portrait: (context) => MainMobilePage(key: key),
        ),
        tablet:  OrientationLayoutBuilder(
          portrait: (context) => MainMobilePage(key: key),
          landscape: (context) => MainDesktopPage(key: key),
        ),
        desktop: OrientationLayoutBuilder(
          portrait: (context) => MainMobilePage(key: key),
          landscape: (context) => MainDesktopPage(key: key),
        ),
        // desktop: UnderConstructionPage(),
      );
  }
}