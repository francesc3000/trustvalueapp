import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pistiscore/pistiscore_io.dart';
import 'package:pistiscore/pistiscore_route.dart';
import 'package:trustvalueapp/src/bloc/pistis_bloc.dart';
import 'package:trustvalueapp/src/route/app_router_delegate_impl.dart';

import 'src/app.dart';
import 'src/bloc/home_bloc.dart';
import 'src/bloc/main_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppRouterDelegate routeService = AppRouterDelegateImpl();
  FactoryService _factoryService = FactoryService(routeService,
      isAndroid: kIsWeb ? false : Platform.isAndroid);
  AuthBloc _authBloc = AuthBloc(_factoryService, autologin: false);

  runApp(MultiBlocProvider(providers: [
    BlocProvider<AuthBloc>(
      create: (context) => _authBloc,
    ),
    BlocProvider<HomeBloc>(
      create: (context) => HomeBloc(_factoryService),
    ),
    BlocProvider<MainBloc>(
      create: (context) => MainBloc(_factoryService),
    ),
    BlocProvider<PistisBloc>(
      create: (context) => PistisBloc(_factoryService),
    ),
  ], child: App(_factoryService.routeService)));
}
