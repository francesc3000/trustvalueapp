abstract class HomeState {}

class HomeInitState extends HomeState {
  @override
  String toString() => 'HomeInitState';
}

class UploadHomeFields extends HomeState {
  final int index;
  
  UploadHomeFields({required this.index});

  @override
  String toString() => 'UploadHomeFields State';
}

class HomeStateError extends HomeState {
  final String message;

  HomeStateError(this.message);

  @override
  String toString() => 'HomeStateError';
}