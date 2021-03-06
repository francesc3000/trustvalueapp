import 'package:flutter/material.dart';
import 'package:pistiscore/pistiscore.dart';
import 'package:pistiscore/pistiscore_route.dart';

abstract class MainBasicPage extends BasicPage {
  const MainBasicPage(String title, AppRouterDelegate appRouterDelegate,
      {Key? key})
      : super(title, appRouterDelegate, key: key);

  @override
  PreferredSizeWidget? appBar(BuildContext context, {required String title}) =>
      null;

  @override
  Widget? drawerMenu(BuildContext context) => null;

  @override
  Widget? bottomNavigationBar(BuildContext context) => null;

  @override
  Widget? floatingActionButton(BuildContext context) => null;
}
