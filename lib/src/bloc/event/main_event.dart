abstract class MainEvent{
}

class MainEventEmpty extends MainEvent{
  @override
  String toString() => 'Empty Event';
}

class FetchInitialDataEvent extends MainEvent {
  @override
  String toString() => 'FetchInitialData Event';
}