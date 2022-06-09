import 'package:flutter/cupertino.dart';

abstract class PistisEvent {}

class PistisEventEmpty extends PistisEvent {
  @override
  String toString() => 'Empty Event';
}

class FetchInitialDataEvent extends PistisEvent {
  final BuildContext context;

  FetchInitialDataEvent(this.context);
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

class NewServiceEvent extends PistisEvent {
  final BuildContext context;

  NewServiceEvent(this.context);
  @override
  String toString() => 'NewService Event';
}

class CarrouselEndEvent extends PistisEvent {
  @override
  String toString() => 'CarrouselEnd Event';
}

class CarrouselResultEvent extends PistisEvent {
  final int carrouselIndex;

  CarrouselResultEvent(this.carrouselIndex);
  @override
  String toString() => 'CarrouselResult Event';
}

class CarrouselLinkEvent extends PistisEvent {
  @override
  String toString() => 'CarrouselLink Event';
}

class ServiceNameChangeEvent extends PistisEvent {
  final String name;

  ServiceNameChangeEvent(this.name);
  @override
  String toString() => 'ServiceNameChange Event';
}

class ServiceAmountChangeEvent extends PistisEvent {
  final double amount;

  ServiceAmountChangeEvent(this.amount);
  @override
  String toString() => 'ServiceNameChange Event';
}