import 'package:flutter/material.dart';
import 'package:pistiscore/pistiscore_route.dart';
import 'package:trustvalueapp/src/page/pistis/pistis_basic_page.dart';

class PistisMobilePage extends PistisBasicPage {
  const PistisMobilePage(String title, AppRouterDelegate appRouterDelegate,
      {required Key? key})
      : super(title, appRouterDelegate, key: key);

  @override
  PreferredSizeWidget? appBar(BuildContext context, {required String title}) =>
      AppBar(title: Text(title));

  @override
  Widget body(BuildContext context) => const Text("Esto es Pistis page");
}
