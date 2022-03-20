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
import 'package:trustvalueapp/src/page/main/widget/demo_button.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class MainMobilePage extends MainBasicPage {
  const MainMobilePage(String title, AppRouterDelegate appRouterDelegate,
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

    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
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

        return NotificationListener<ScrollNotification>(
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
                  // clipBehavior: Clip.none,
                  children: <Widget>[
                    Positioned(
                      top: -0.25 *
                          _currOffset, // -ve as we want to scroll upwards
                      child: Image.asset(
                        // 'assets/images/768.png',
                        'assets/images/new/launch.png',
                        fit: BoxFit.fitHeight,
                        width: _imageWidth,
                        height: _imgHeight,
                      ),
                    ),
                    Positioned(
                      top: 90 * 0.8 - _currOffset,
                      // left: 50,
                      width: _imageWidth,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RichText(
                          text: TextSpan(
                            text: AppLocalizations.of(context)!.companyName,
                            style: GoogleFonts.montserrat(
                                fontSize: 35,
                                color: const Color.fromRGBO(1, 155, 107, 1)),
                            children: [
                              TextSpan(
                                text: AppLocalizations.of(context)!.whoHelpEnd,
                                style: GoogleFonts.montserrat(
                                    fontSize: 30, color: Colors.white),
                              ),
                            ],
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
                            colors: [
                              Colors.indigo.withOpacity(0),
                              Colors.indigo
                            ],
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
                        SizedBox(height: _imgHeight),
                        Container(
                          // color: Colors.white,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.white, Colors.pinkAccent],
                            ),
                          ),
                          width: _imageWidth,
                          height: _imgHeight,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      AppLocalizations.of(context)!.whoWeAre,
                                      style: GoogleFonts.montserrat(
                                          fontSize: 30,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                // child: Image.asset('assets/images/191.png'),
                                child:
                                    Image.asset('assets/images/new/brain.png'),
                              ),
                            ],
                          ),
                        ),
                        // const SizedBox(
                        //   height: 20.0,
                        //   child: DecoratedBox(
                        //     decoration: BoxDecoration(color: Colors.white),
                        //   ),
                        // ),
                        Container(
                          // color: const Color.fromRGBO(124, 54, 153, 1),
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.pinkAccent, Colors.blue],
                            ),
                          ),
                          width: _imageWidth,
                          height: _imgHeight,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      AppLocalizations.of(context)!.whatWeDo,
                                      style: GoogleFonts.montserrat(
                                          fontSize: 30, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                // child: Image.asset('assets/images/345.png'),
                                child:
                                    Image.asset('assets/images/new/sketch.png'),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                          child: DecoratedBox(
                            decoration: BoxDecoration(color: Colors.blue),
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          width: _imageWidth / 2,
                          height: _imgHeight / 2,
                          child: SizedBox(
                            width: _imageWidth / 2,
                            height: _imgHeight / 2,
                            child: YoutubePlayerControllerProvider(
                              // Provides controller to all the widget below it.
                              controller: _youtubePlayerController,
                              child: const YoutubePlayerIFrame(
                                aspectRatio: 16 / 9,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: ContactData(),
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              // color: Color.fromRGBO(124, 54, 153, 1),
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Positioned(
                  top: 30 * (0.009 * _currOffset),
                  right: 10,
                  child: DemoButton(
                    onPressed: () =>
                        routerDelegate.pushPage(name: "/pistisPage"),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
