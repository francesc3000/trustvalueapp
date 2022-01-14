import 'package:flutter/material.dart';
import 'package:pistiscore/pistiscore_route.dart';

import 'unknown_basic_page.dart';

class UnknownDesktopPage extends UnknownBasicPage {
  const UnknownDesktopPage(AppRouterDelegate routerDelegate, {Key? key})
      : super(routerDelegate, key: key);

  @override
  Widget body(BuildContext context) =>
      const Scaffold(body: Text("Error. Pagina no encontrada"));
}
