import 'package:flutter/cupertino.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

abstract class MainState {}

class MainInitState extends MainState {
  @override
  String toString() => 'MainInitState';
}

class UploadMainFields extends MainState {
  final ScrollController scrollController;
  final YoutubePlayerController youtubePlayerController;
  final double currOffset;
  final bool Function(ScrollNotification)? handleScrollNotification;

  UploadMainFields(this.scrollController, this.youtubePlayerController,
      this.currOffset, this.handleScrollNotification);
  @override
  String toString() => 'UploadMainFields State';
}

class MainStateError extends MainState {
  final String message;

  MainStateError(this.message);

  @override
  String toString() => 'MainStateError';
}
