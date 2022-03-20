import 'package:flutter/material.dart';
import 'package:pistiscore/pistiscore.dart';
import 'package:pistiscore/pistiscore_route.dart';
import 'package:trustvalueapp/src/widget/social_media_buttons.dart';

abstract class PistisBasicPage extends BasicPage {
  const PistisBasicPage(String title, AppRouterDelegate appRouterDelegate,
      {Key? key})
      : super(title, appRouterDelegate, key: key);

  @override
  PreferredSizeWidget? appBar(BuildContext context, {required String title}) =>
      AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        actions: const [SocialMediaButtons()],);

  @override
  Widget? drawerMenu(BuildContext context) => null;

  @override
  Widget? bottomNavigationBar(BuildContext context) => null;

  @override
  Widget? floatingActionButton(BuildContext context) => null;
}
