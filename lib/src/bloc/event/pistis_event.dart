abstract class PistisEvent {}

class PistisEventEmpty extends PistisEvent {
  @override
  String toString() => 'Empty Event';
}

class FetchInitialDataEvent extends PistisEvent {
  @override
  String toString() => 'FetchInitialData Event';
}

class NewProductEvent extends PistisEvent {
  final String name;
  final String model;
  final String batch;
  final String serialNumber;
  final String bom1;
  final String bom2;
  final String bom3;
  final String place1;
  final String place2;
  final String place3;

  NewProductEvent(this.name, this.model, this.batch, this.serialNumber,
      this.bom1, this.bom2, this.bom3, this.place1, this.place2, this.place3);

  @override
  String toString() => 'NewProduct Event';
}

class CarrouselEndEvent extends PistisEvent {
  @override
  String toString() => 'CarrouselEnd Event';
}

class CarrouselResultEvent extends PistisEvent {
  @override
  String toString() => 'CarrouselResult Event';
}

class CarrouselLinkEvent extends PistisEvent {
  @override
  String toString() => 'CarrouselLink Event';
}