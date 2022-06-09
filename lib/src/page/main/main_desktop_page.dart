import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pistiscore/pistiscore.dart';
import 'package:pistiscore/pistiscore_route.dart';
import 'package:trustvalueapp/src/bloc/event/main_event.dart';
import 'package:trustvalueapp/src/bloc/main_bloc.dart';
import 'package:trustvalueapp/src/bloc/state/main_state.dart';
import 'package:trustvalueapp/src/page/main/main_basic_page.dart';
import 'package:trustvalueapp/src/page/main/widget/contact_data.dart';
import 'package:trustvalueapp/src/page/main/widget/screen_button.dart';
import 'package:trustvalueapp/src/page/main/widget/trust_us.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class MainDesktopPage extends MainBasicPage {
  const MainDesktopPage(String title, AppRouterDelegate appRouterDelegate,
      {Key? key})
      : super(title, appRouterDelegate, key: key);

  @override
  Widget body(BuildContext context) {
    double _imgHeight = MediaQuery.of(context).size.height;
    double _imageWidth = MediaQuery.of(context).size.width;
    late ScrollController _scrollController;
    late YoutubePlayerController _youtubePlayerController;
    double _currOffset = 0.0;
    bool _loading = false;
    bool Function(ScrollNotification)? _handleScrollNotification;

    return BlocBuilder<MainBloc, MainState>(builder: (context, state) {
      if (state is MainInitState) {
        _loading = true;
        BlocProvider.of<MainBloc>(context).add(FetchInitialDataEvent());
      } else if (state is UploadMainFields) {
        _loading = false;
        _scrollController = state.scrollController;
        _youtubePlayerController = state.youtubePlayerController;
        _currOffset = state.currOffset;
        _handleScrollNotification = state.handleScrollNotification;
      } else if (state is MainStateError) {
        CustomSnackBar().show(context: context, message: state.message);
      }

      if (_loading) {
        return const CustomProgressIndicator();
      }
      return Scaffold(
        body: NotificationListener<ScrollNotification>(
          onNotification: _handleScrollNotification,
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.blue, Colors.white],
              ),
            ),
            child: Stack(
              children: [
                Stack(
                  children: <Widget>[
                    _firstScreen(context, _imageWidth, _imgHeight, _currOffset),
                    _secondScreen(context, _imageWidth, _imgHeight, _currOffset,
                        _scrollController, _youtubePlayerController),
                  ],
                ),
                _buttonsScreen(context, _currOffset),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _firstScreen(BuildContext context, double imageWidth, double imgHeight,
          double currOffset) =>
      Stack(
        children: [
          Positioned(
            top: -0.25 * currOffset,
            // -ve as we want to scroll upwards
            child: Image.asset(
              // 'assets/images/768.png',
              'assets/images/red.png',
              fit: BoxFit.fitWidth,
              width: imageWidth,
              height: imgHeight,
            ),
          ),
          Positioned(
            top: 150 * 0.8 - currOffset,
            left: 50,
            width: imageWidth / 3,
            child: RichText(
              text: TextSpan(
                text: AppLocalizations.of(context)!.companyName,
                style: GoogleFonts.montserrat(
                    fontSize: 45, color: const Color.fromRGBO(36, 44, 83, 1)),
                children: [
                  TextSpan(
                    text: AppLocalizations.of(context)!.whoHelpEnd,
                    style: GoogleFonts.montserrat(
                        fontSize: 40,
                        color: const Color.fromRGBO(63, 83, 36, 1)),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: imgHeight * 0.8 - currOffset,
            // IMP otherwise goes on top...
            left: 0.0,
            right: 0.0,
            height: imgHeight * 0.2,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const <double>[0, 1],
                  colors: [Colors.indigo.withOpacity(0), Colors.indigo],
                ),
              ),
              child: const SizedBox(width: double.infinity),
            ),
          ),
        ],
      );

  Widget _secondScreen(
          BuildContext context,
          double imageWidth,
          double imgHeight,
          double currOffset,
          ScrollController scrollController,
          YoutubePlayerController youtubePlayerController) =>
      ListView(
        cacheExtent: 100.0,
        addAutomaticKeepAlives: false,
        controller: scrollController,
        children: <Widget>[
          SizedBox(height: imgHeight), // IMP STEP 1..
          Container(
            // color: const Color.fromRGBO(124, 54, 153, 1),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.indigo, Colors.blue],
              ),
            ),
            width: imageWidth,
            height: imgHeight,
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(50.0),
                          child: Text(
                            AppLocalizations.of(context)!.whatWeDo,
                            style: GoogleFonts.montserrat(
                                fontSize: 40, color: Colors.white),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        // child: Image.asset('assets/images/345.png'),
                        child: Image.asset('assets/images/sketch.png'),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: 500,
                    width: 500,
                    child: YoutubePlayerControllerProvider(
                      // Provides controller to all the widget below it.
                      controller: youtubePlayerController,
                      child: const YoutubePlayerIFrame(
                        aspectRatio: 16 / 9,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.blue, Colors.pinkAccent],
              ),
            ),
            width: imageWidth,
            height: imgHeight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 50.0),
                    child: Text(
                      AppLocalizations.of(context)!.whoWeAre,
                      style: GoogleFonts.montserrat(
                          fontSize: 40, color: Colors.white),
                    ),
                  ),
                ),
                Expanded(
                  // child: Image.asset('assets/images/191.png'),
                  child: Image.asset('assets/images/brain.png'),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: TrustUs(),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: const Padding(
              padding:
                  EdgeInsets.only(top: 100, bottom: 50, left: 50.0, right: 10),
              child: ContactData(),
            ),
          ),
          const SizedBox(
            height: 40.0,
            child: DecoratedBox(
              decoration: BoxDecoration(
                // color: Color.fromRGBO(124, 54, 153, 1),
                color: Colors.white,
              ),
            ),
          ),
        ],
      );

  Widget _buttonsScreen(BuildContext context, double currOffset) => Stack(
        children: [
          // Positioned(
          //   top: 550 * 0.8 - currOffset,
          //   left: 50,
          //   child: ScreenButton(
          //     "Demo",
          //     onPressed: () => routerDelegate.pushPage(name: "/pistisPage"),
          //     height: 50,
          //     width: 150,
          //   ),
          // ),
          Positioned(
            top: 550 * 0.8 - currOffset,
            left: 200,
            child: ScreenButton(
              "Contactar",
              onPressed: () async {
                Uri params = Uri(
                  scheme: 'mailto',
                  path: AppLocalizations.of(context)!.infoEmail,
                  query:
                      // 'subject=App Feedback&body=App Version 3.23',
                      'subject=${AppLocalizations.of(context)!.topic}',
                );

                var url = params.toString();
                if (await canLaunchUrlString(url)) {
                  await launchUrlString(url);
                } else {
                  throw 'Could not launch $url';
                }
              },
              height: 50,
              width: 150,
            ),
          ),
        ],
      );
}
