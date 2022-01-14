import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:pistiscore/pistiscore_io.dart';

import 'event/home_event.dart';
import 'state/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  int _currentIndex = 0;
  final FactoryService factoryService;

  HomeBloc(this.factoryService) : super(HomeInitState());

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is HomeEventEmpty) {
      yield HomeInitState();
    } else if (event is ChangeTabEvent) {
      try {
        _currentIndex = event.index;
        yield _uploadHomeFields(index: _currentIndex);
        // }
      } catch (error) {
        yield error is HomeStateError
            ? HomeStateError(error.message)
            : HomeStateError('Algo fue mal al cambiar la pestaña!');
      }
    }
  }

  HomeState _uploadHomeFields({required int index}) =>
      UploadHomeFields(index: index);
}
