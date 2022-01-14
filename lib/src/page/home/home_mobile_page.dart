import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pistiscore/pistiscore_route.dart';
import 'package:trustvalueapp/src/bloc/home_bloc.dart';
import 'package:trustvalueapp/src/bloc/state/home_state.dart';
import 'package:trustvalueapp/src/page/main/main_page.dart';

import 'home_basic_page.dart';

class HomeMobilePage extends HomeBasicPage {
  const HomeMobilePage(String title, AppRouterDelegate routerDelegate,
      {Key? key})
      : super(title, routerDelegate, key: key);

  @override
  Widget body(BuildContext context) => BlocBuilder<HomeBloc, HomeState>(
        builder: (BuildContext context, state) {

      if (state is HomeInitState) {
      } else if (state is UploadHomeFields) {
      }
      return MainPage("", routerDelegate);
    });
}
