import 'package:flutter/material.dart';
import 'package:pistiscore/pistiscore.dart';
import 'package:pistiscore/pistiscore_route.dart';

abstract class UnknownBasicPage extends BasicPage {
  const UnknownBasicPage(AppRouterDelegate routerDelegate, {Key? key})
      : super("", routerDelegate, key: key);

  @override
  PreferredSizeWidget? appBar(BuildContext context, {String? title}) {
    if (PlatformDiscover.isWeb()) {
      // return AppBar(
      //   title: Container(
      //     // color: Color.fromRGBO(177, 237, 100, 93),
      //     alignment: Alignment.centerLeft,
      //     child: Text(
      //       title,
      //       style: TextStyle(color:
      //       Theme.of(context).primaryColor, fontSize: 58),
      //     ),
      //   ),
      //   elevation: 0.0,
      //   backgroundColor: Color.fromRGBO(153, 148, 86, 60 ),
      //   actions: [
      //     IconButton(
      //       icon: const Icon(FontAwesomeIcons.userCircle),
      //       tooltip: AppLocalizations.of(context).userTooltip,
      //       onPressed: () {
      //         BlocProvider.of<HomeBloc>(context)
      //         .add(Navigate2UserPageEvent());
      //       },
      //     ),
      //   ],
      // );
    } else {
      // return AppBar(
      //   leading: ClipRRect(
      //         borderRadius: BorderRadius.circular(100),
      //         child: Container(
      //           decoration: BoxDecoration(
      //             image: DecorationImage(
      //               image: AssetImage('assets/race/logoYocorro.png'),
      //             ),
      //             borderRadius: BorderRadius.all(Radius.circular(10)),
      //           ),
      //           height: 50,
      //           width: 50,
      //         ),
      //       ),
      //   title: Text(title),
      //   actions: [
      //     IconButton(
      //       icon: Icon(FontAwesomeIcons.userCircle),
      //       tooltip: AppLocalizations.of(context).userTooltip,
      //       onPressed: () {
      //         BlocProvider.of<HomeBloc>(context)
      //         .add(Navigate2UserPageEvent());
      //       },
      //     ),
      //   ],
      // );
    }

    return null;
  }

  @override
  Widget? drawerMenu(BuildContext context) => null;

  @override
  Widget? bottomNavigationBar(BuildContext context) => null;

  @override
  Widget? floatingActionButton(BuildContext context) => null;
}
