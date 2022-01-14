import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pistiscore/pistiscore_io.dart';
import 'package:trustvalueapp/src/bloc/event/main_event.dart';
import 'package:trustvalueapp/src/bloc/state/main_state.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final FactoryService factoryService;
  final ScrollController _scrollController = ScrollController();
  late YoutubePlayerController _youtubePlayerController;
  double _currOffset = 0.0;

  MainBloc(this.factoryService) : super(MainInitState());

  @override
  Stream<MainState> mapEventToState(MainEvent event) async* {
    if (event is MainEventEmpty) {
      yield _uploadMainFields();
    } else if (event is FetchInitialDataEvent) {
      try {
        _youtubePlayerController = YoutubePlayerController(
          initialVideoId: 'MRMPofkN3pM',
          params: const YoutubePlayerParams(
            autoPlay: false,
            enableCaption: false,
            showControls: false,
            showFullscreenButton: true,
            desktopMode: false,
            privacyEnhanced: true,
            useHybridComposition: true,
            showVideoAnnotations: false,
          ),
        );
        _youtubePlayerController.onEnterFullscreen = () {
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.landscapeLeft,
            DeviceOrientation.landscapeRight,
          ]);
        };
        yield _uploadMainFields();
        // }
      } catch (error) {
        yield error is MainStateError
            ? MainStateError(error.message)
            : MainStateError('Algo fue mal al cambiar la pestaña!');
      }
    }
  }

  MainState _uploadMainFields() =>
      UploadMainFields(_scrollController, _youtubePlayerController, _currOffset
          , _handleScrollNotification);

  @override
  Future<void> close() {
    _scrollController.dispose();
    _youtubePlayerController.close();
    return super.close();
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      // print('>>>>>Scroll ${notification.scrollDelta}');
      _currOffset = notification.metrics.pixels;
    }

    add(MainEventEmpty());
        return false;
    }
}
