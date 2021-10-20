import 'package:flutter/material.dart';

import '../basic_page.dart';

abstract class MainBasicPage extends BasicPage {
  const MainBasicPage(String title, {Key? key}) : super(title, key: key);

  @override
  PreferredSizeWidget? appBar(BuildContext context, {required String title}) {
    return null;
  }

  @override
  Widget? bottomNavigationBar(BuildContext context) {
    return null;
  }

  @override
  Widget? floatingActionButton(BuildContext context) {
    return null;
  }
}
