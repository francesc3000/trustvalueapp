import 'dart:math';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pistiscore/pistiscore.dart';
import 'package:pistiscore/pistiscore_io.dart';
import 'package:trustvalueapp/src/bloc/state/pistis_state.dart';

import 'event/pistis_event.dart';

class PistisBloc extends Bloc<PistisEvent, PistisState> {
  final FactoryService factoryService;
  String productName = "";
  String model = "";
  String batch = "";
  String serialNumber = "";
  bool isProductSend = false;
  bool isServiceSend = false;
  Product? product;
  String? qrLink;
  List<Object> carrousel = [];
  bool isCarrouselOn = false;
  bool carrouselLinkShow = false;
  int carrouselIndex = 0;
  String serviceName = "";
  double serviceAmount = 0.0;

  static const _chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  final Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  PistisBloc(this.factoryService) : super(PistisInitState()) {
    on<PistisEventEmpty>(_pistisEventEmpty);
    on<FetchInitialDataEvent>(_fetchInitialDataEvent);
    on<NewProductEvent>(_newProductEvent);
    on<CarrouselEndEvent>(_carrouselEndEvent);
    on<CarrouselResultEvent>(_carrouselResultEvent);
    on<CarrouselLinkEvent>(_carrouselLinkEvent);
    on<ServiceNameChangeEvent>(_serviceNameChangeEvent);
    on<ServiceAmountChangeEvent>(_serviceAmountChangeEvent);
    on<NewServiceEvent>(_newServiceEvent);
  }

  void _pistisEventEmpty(PistisEventEmpty event, Emitter emit) {
    product = null;
    qrLink = null;
    isProductSend = false;
    isCarrouselOn = false;
    carrouselLinkShow = false;
    carrouselIndex = 0;
    emit(_uploadPistisFields());
  }

  void _fetchInitialDataEvent(FetchInitialDataEvent event, Emitter emit) {
    product = null;
    qrLink = null;
    isProductSend = false;
    isCarrouselOn = false;
    carrouselLinkShow = false;
    carrouselIndex = 0;
    productName = AppLocalizations.of(event.context)!.productName;
    model = "M${_rnd.nextInt(10000)}${getRandomString(2)}"
        "${_rnd.nextInt(100)}";

    batch = "B${_rnd.nextInt(10000)}";

    serialNumber = "SN${_rnd.nextInt(100000)}${getRandomString(1)}"
        "${_rnd.nextInt(1)}";

    carrousel = _buildCarrousel(event.context);

    serviceName = "Sam";
    serviceAmount = 100;

    emit(_uploadPistisFields());
  }

  List<Object> _buildCarrousel(BuildContext context) {
    List<Object> carrousel = [];
    carrousel.add(AppLocalizations.of(context)!.slide1);
    carrousel.add(AppLocalizations.of(context)!.slide2);
    carrousel.add(AppLocalizations.of(context)!.slide3);
    carrousel.add(AppLocalizations.of(context)!.slide4);

    return carrousel;
  }

  void _newProductEvent(NewProductEvent event, Emitter emit) async {
    try {
      List<Feature> features = [];
      List<Certificate> certificates = [];
      List<Trace> traces = [];
      productName = event.name;
      model = event.model;
      batch = event.batch;
      serialNumber = event.serialNumber;

      //Addresses
      Address bom1Address = Address(
        id: 10,
        name: "Guns&Powder Inc. Street",
        latitude: 39.414089,
        longitude: -76.386516,
      );

      Address bom2Address = Address(
        id: 11,
        name: "calle Pavio irmãos",
        latitude: 40.718809,
        longitude: -6.903553,
      );

      Address place1Address = Address(
        id: 12,
        name: event.place1,
        latitude: 41.406514,
        longitude: 2.172617,
      );

      Address place2Address = Address(
        id: 13,
        name: event.place2,
        latitude: 37.385266,
        longitude: -5.993926,
      );

      Address place3Address = Address(
        id: 14,
        name: event.place3,
        latitude: 38.708110,
        longitude: -9.137445,
      );

      Place featurePlace1 = Place(
          id: -1,
          name: "Fundación Alegria",
          description: "Traemos la alegria al mundo",
          address: bom1Address);

      Place featurePlace2 = Place(
          id: -1,
          name: "Fundación Eco",
          description: "Traemos el eco del mundo",
          address: bom2Address);

      Place tracePlace1Address = Place(
          id: -1,
          name: "Fundación Ya",
          description: "Traemos el ya del mundo",
          address: place1Address);

      Place tracePlace2Address = Place(
          id: -1,
          name: "Fundación Viento",
          description: "Traemos el viento del mundo",
          address: place2Address);

      Place tracePlace3Address = Place(
          id: -1,
          name: "Fundación Arriba",
          description: "Traemos el arriba del mundo",
          address: place3Address);

      //Features
      Feature feature1 = Feature(
          id: -1,
          name: event.bom1,
          date: DateTime.now().subtract(const Duration(days: 365)),
          place: featurePlace1);

      Feature feature2 = Feature(
          id: -2,
          name: event.bom2,
          date: DateTime.now().subtract(const Duration(days: 165)),
          place: featurePlace2);

      Feature feature3 = Feature(
          id: -3,
          name: event.bom3,
          date: DateTime.now().subtract(const Duration(days: 465)),
          place: featurePlace1);

      features.add(feature1);
      features.add(feature3);
      features.add(feature2);

      //Certificates
      Certificate certificate1 = Certificate(-1, ISO.iso99887,
          DateTime.now().subtract(const Duration(days: 1465)));
      Certificate certificate2 = Certificate(-1, ISO.iso98551,
          DateTime.now().subtract(const Duration(days: 1465)));

      certificates.add(certificate1);
      certificates.add(certificate2);

      //Traces
      Trace trace1 = Trace(
          id: -1,
          inputDate: DateTime.now().subtract(const Duration(days: 10)),
          outputDate: DateTime.now().subtract(const Duration(days: 9)),
          place: tracePlace1Address);

      Trace trace2 = Trace(
          id: -2,
          inputDate: DateTime.now().subtract(const Duration(days: 8)),
          outputDate: DateTime.now().subtract(const Duration(days: 1)),
          place: tracePlace2Address);

      Trace trace3 = Trace(
          id: -3,
          inputDate: DateTime.now().subtract(const Duration(days: 8)),
          // outputDate: DateTime.now().subtract(const Duration(days: 2)),
          outputDate: null,
          place: tracePlace3Address);

      traces.add(trace1);
      traces.add(trace2);
      traces.add(trace3);

      product = Product(
        id: -1,
        name: productName,
        model: event.model,
        batch: event.batch,
        serialNumber: event.serialNumber,
        consumeUntil: DateTime.now(),
        features: features,
        certificates: certificates,
        traces: traces,
      );

      isProductSend = true;
      isCarrouselOn = true;
      // yield _uploadPistisFields();

      await factoryService.authService
          .loginWithUsernameAndPassword("webTest", "1234");
      product =
          await factoryService.productService.saveAndPublishProduct(product!);

      emit(_uploadPistisFields());
    } catch (error) {
      isProductSend = false;
      emit(error is PistisStateError
          ? PistisStateError(error.message)
          : PistisStateError(
              'Algo fue mal al enviar el producto. Disculpe las molestias'));
    }
  }

  void _carrouselEndEvent(CarrouselEndEvent event, Emitter emit) async {
    try {
      if (isCarrouselOn) {
        qrLink =
            await factoryService.productService.getQRCodeString(product!.id);
        Uint8List qrImage =
            await factoryService.productService.getQRCode(product!.id);
        carrousel.add(qrImage);
        carrouselIndex = 5;
        emit(_uploadPistisFields());
      }
    } catch (error) {
      // carrouselIndex = 3;
      // yield _uploadPistisFields();
    }
  }

  void _carrouselResultEvent(CarrouselResultEvent event, Emitter emit) {
    carrouselIndex = event.carrouselIndex;
    isCarrouselOn = false;
    emit(_uploadPistisFields());
  }

  void _carrouselLinkEvent(CarrouselLinkEvent event, Emitter emit) {
    carrouselIndex = 4;
    carrouselLinkShow = true;
    emit(_uploadPistisFields());
  }

  void _serviceNameChangeEvent(ServiceNameChangeEvent event, Emitter emit) {
    serviceName = event.name;
    // emit(_uploadPistisFields());
  }

  void _serviceAmountChangeEvent(ServiceAmountChangeEvent event, Emitter emit) {
    serviceAmount = event.amount;
    emit(_uploadPistisFields());
  }

  void _newServiceEvent(NewServiceEvent event, Emitter emit) async{
    try {
      List<Certificate> certificates = [];
      List<Trace> traces = [];

      //Place
      Place tracePlace1Address = Place(
          id: -1,
          name: "Fundación Ya",
          description: "Traemos el ya del mundo",
          address: Address(
            id: 13,
            name: "Calle de la Alegria 123, Barcelona Spain",
            latitude: 20,
            longitude: 30,
          ),
      );

      //Certificates
      Certificate certificate1 = Certificate(-1, ISO.iso99887,
          DateTime.now().subtract(const Duration(days: 1465)));
      Certificate certificate2 = Certificate(-1, ISO.iso98551,
          DateTime.now().subtract(const Duration(days: 1465)));

      certificates.add(certificate1);
      certificates.add(certificate2);

      //Traces
      Trace trace1 = Trace(
          id: -1,
          inputDate: DateTime.now().subtract(const Duration(days: 10)),
          outputDate: DateTime.now().subtract(const Duration(days: 9)),
          place: tracePlace1Address);

      traces.add(trace1);

      Service service = Service(
        id: -1,
        name: serviceName,
        amount: serviceAmount,
        currency: "EUR",
        certificates: certificates,
        traces: traces,
      );

      isServiceSend = true;
      isCarrouselOn = true;
      // yield _uploadPistisFields();

      await factoryService.authService
          // .loginWithUsernameAndPassword("webTest", "1234");
          .loginWithUsernameAndPassword("francesc3000", "1234");
      service =
          await factoryService.serviceService.saveAndPublishService(service);

      // emit(_uploadPistisFields());
    } catch (error) {
      isServiceSend = false;
      emit(error is PistisStateError
          ? PistisStateError(error.message)
          : PistisStateError(
          'Algo fue mal al enviar el donativo. Disculpe las molestias'));
    }
  }

  PistisState _uploadPistisFields() => UploadPistisFields(
        productName: productName,
        model: model,
        batch: batch,
        serialNumber: serialNumber,
        isProductSend: isProductSend,
        isServiceSend: isServiceSend,
        qrLink: qrLink,
        carrousel: carrousel,
        isCarrouselOn: isCarrouselOn,
        carrouselLinkShow: carrouselLinkShow,
        carrouselIndex: carrouselIndex,
        serviceName: serviceName,
        serviceAmount: serviceAmount,
      );
}
