import 'package:flutter/material.dart';
import 'package:pistiscore/pistiscore_route.dart';
import 'package:trustvalueapp/src/page/home/home_page.dart';
import 'package:trustvalueapp/src/page/pistis/pistis_page.dart';
import 'package:trustvalueapp/src/page/unknown/unknown_page.dart';

class AppRouterDelegateImpl extends AppRouterDelegate {
  @override
  MaterialPage createPage(RouteSettings routeSettings) {
    late Widget child;

    switch (routeSettings.name) {
      case '/':
        child = HomePage(this);
        break;
      case '/pistisPage':
        child = PistisPage("Pistis", this);
        break;
      default:
        child = UnknownPage(this);
    }
    return MaterialPage(
      child: child,
      key: Key(routeSettings.toString()) as LocalKey,
      name: routeSettings.name,
      arguments: routeSettings.arguments,
    );
  }
}
