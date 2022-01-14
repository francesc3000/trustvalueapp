import 'package:flutter/gestures.dart';
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
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class MainDesktopPage extends MainBasicPage {
  const MainDesktopPage(String title, AppRouterDelegate appRouterDelegate,
      {Key? key})
      : super(title, appRouterDelegate, key: key);

  @override
  PreferredSizeWidget? appBar(BuildContext context, {required String title}) =>
      AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        actions: [
          ElevatedButton(
              onPressed: () => routerDelegate.pushPage(name: "/pistisPage"),
              child: const Text("Pistis"))
        ],
      );

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
          child: Stack(
            children: <Widget>[
              Positioned(
                top: -0.25 * _currOffset,
                // -ve as we want to scroll upwards
                child: Image.asset(
                  'assets/images/768.png',
                  fit: BoxFit.fitWidth,
                  width: _imageWidth,
                  height: _imgHeight,
                ),
              ),
              Positioned(
                top: 50 * 0.8 - _currOffset,
                left: 50,
                width: _imageWidth / 3,
                child: RichText(
                  text: TextSpan(
                    text: AppLocalizations.of(context)!.companyName,
                    style: GoogleFonts.montserrat(
                        fontSize: 45,
                        color: const Color.fromRGBO(1, 155, 107, 1)),
                    children: [
                      TextSpan(
                        text: AppLocalizations.of(context)!.whoHelpEnd,
                        style: GoogleFonts.montserrat(
                            fontSize: 40, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 50 * 0.8 - _currOffset,
                right: 50,
                child: SizedBox(
                  width: 500,
                  child: YoutubePlayerControllerProvider(
                    // Provides controller to all the widget below it.
                    controller: _youtubePlayerController,
                    child: const YoutubePlayerIFrame(
                      aspectRatio: 16 / 9,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: _imgHeight * 0.8 - _currOffset,
                // IMP otherwise goes on top...
                left: 0.0,
                right: 0.0,
                height: _imgHeight * 0.2,
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
              ListView(
                cacheExtent: 100.0,
                addAutomaticKeepAlives: false,
                controller: _scrollController,
                children: <Widget>[
                  SizedBox(height: _imgHeight), // IMP STEP 1..
                  Container(
                    color: Colors.white,
                    width: _imageWidth,
                    height: _imgHeight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 50.0),
                            child: Text(
                              AppLocalizations.of(context)!.whoWeAre,
                              style: GoogleFonts.montserrat(
                                  fontSize: 40, color: Colors.blueAccent),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Image.asset('assets/images/191.png'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 40.0,
                    child: DecoratedBox(
                      decoration: BoxDecoration(color: Colors.white),
                    ),
                  ),
                  Container(
                    color: const Color.fromRGBO(124, 54, 153, 1),
                    width: _imageWidth,
                    height: _imgHeight,
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
                          child: Image.asset('assets/images/345.png'),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 100, bottom: 50, left: 50.0, right: 10),
                      child: _contactData(context),
                    ),
                  ),
                  const SizedBox(
                    height: 40.0,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(124, 54, 153, 1),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _contactData(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SelectableText.rich(
            TextSpan(
              text: AppLocalizations.of(context)!.sendUs,
              style: GoogleFonts.montserrat(
                  fontSize: 15, color: Colors.blueAccent),
              children: [
                TextSpan(
                  text: AppLocalizations.of(context)!.infoEmail,
                  style: GoogleFonts.montserrat(
                    fontSize: 15,
                    color: const Color.fromRGBO(0, 72, 164, 1),
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () async {
                      final Uri params = Uri(
                        scheme: 'mailto',
                        path: AppLocalizations.of(context)!.infoEmail,
                        query:
                            // 'subject=App Feedback&body=App Version 3.23',
                            'subject=${AppLocalizations.of(context)!.topic}',
                      );

                      var url = params.toString();
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        throw 'Could not launch $url';
                      }
                    },
                ),
              ],
            ),
          ),
          Text(
            "${AppLocalizations.of(context)!.companyName}® 2022",
            style:
                GoogleFonts.montserrat(fontSize: 15, color: Colors.blueAccent),
          ),
        ],
      );
}
