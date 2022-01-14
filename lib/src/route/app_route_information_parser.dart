import 'package:flutter/material.dart';
import 'package:pistiscore/pistiscore_route.dart';

class AppRouteInformationParserImpl extends AppRouteInformationParser {
  @override
  String restoreArguments(RouteSettings routeSettings) {
    if (routeSettings.name != '/product') return '';
    return '?signature=${(routeSettings.arguments
    as Map)['signature'].toString()}';
  }
}
