import 'package:bloc/bloc.dart';
import 'package:pistiscore/pistiscore_io.dart';

import 'event/home_event.dart';
import 'state/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  int _currentIndex = 0;
  final FactoryService factoryService;

  HomeBloc(this.factoryService) : super(HomeInitState()) {
    on<HomeEventEmpty>((event, emit) => emit(_uploadHomeFields()));
    on<ChangeTabEvent>(_changeTabEvent);
  }

  void _changeTabEvent(ChangeTabEvent event, Emitter emit) {
    try {
      _currentIndex = event.index;
      emit(_uploadHomeFields());
    } catch (error) {
      emit(error is HomeStateError
    ? HomeStateError(error.message)
        : HomeStateError('Algo fue mal al cambiar la pestaña!'));
  }
  }

  HomeState _uploadHomeFields() =>
      UploadHomeFields(index: _currentIndex);
}
