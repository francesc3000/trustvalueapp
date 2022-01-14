import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
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
  late Product product;
  String? qrLink;
  List<Object> carrousel = [];
  bool isCarrouselOn = false;
  bool carrouselLinkShow = false;

  PistisBloc(this.factoryService) : super(PistisInitState());

  static const _chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  final Random _rnd = Random();

  String getRandomString(int length) =>
      String.fromCharCodes(Iterable.generate(length,
              (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  @override
  Stream<PistisState> mapEventToState(PistisEvent event) async* {
    if (event is PistisEventEmpty) {
      isProductSend = false;
      isCarrouselOn = false;
      carrouselLinkShow = false;
      yield _uploadPistisFields();
    } else if (event is FetchInitialDataEvent) {
      productName = "Pistis";
      model =
          "M${_rnd.nextInt(10000)}${getRandomString(2)}"
          "${_rnd.nextInt(100)}";

      batch = "B${_rnd.nextInt(10000)}";

      serialNumber =
          "SN${_rnd.nextInt(100000)}${getRandomString(1)}"
          "${_rnd.nextInt(1)}";

      carrousel.add("Se ha enviado el producto a Pistis y se esta incorporando a la Blockchain");
      carrousel.add("Esto quiere decir que la información de su producto permanecerá inalterable para siempre");
      carrousel.add("Esto da al confianza a sus clientes que el producto que tienen entre manos es original y confiable");
      carrousel.add("Algo más");

      yield _uploadPistisFields();
    } else if (event is NewProductEvent) {
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
          name: "Guns&Powder Inc.",
          latitude: 39.414089,
          longitude: -76.386516,
          city: "GunPowder",
        );

        Address bom2Address = Address(
          id: 11,
          name: "Pavio irmãos",
          latitude: 40.718809,
          longitude: -6.903553,
          city: "Almeida",
        );

        Address place1Address = Address(
          id: 12,
          name: event.place1,
          latitude: 41.406514,
          longitude: 2.172617,
          city: "Barcelona",
        );

        Address place2Address = Address(
          id: 13,
          name: event.place2,
          latitude: 37.385266,
          longitude: -5.993926,
          city: "Sevilla",
        );

        Address place3Address = Address(
          id: 14,
          name: event.place3,
          latitude: 38.708110,
          longitude: -9.137445,
          city: "Lisboa",
        );

        //Features
        Feature feature1 = Feature(
            id: -1,
            name: event.bom1,
            date: DateTime.now().subtract(const Duration(days: 365)),
            address: bom1Address);

        Feature feature2 = Feature(
            id: -2,
            name: event.bom2,
            date: DateTime.now().subtract(const Duration(days: 165)),
            address: bom2Address);

        Feature feature3 = Feature(
            id: -3,
            name: event.bom3,
            date: DateTime.now().subtract(const Duration(days: 465)),
            address: bom2Address);

        features.add(feature1);
        features.add(feature2);
        features.add(feature3);

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
            address: place1Address);

        Trace trace2 = Trace(
            id: -2,
            inputDate: DateTime.now().subtract(const Duration(days: 8)),
            outputDate: DateTime.now().subtract(const Duration(days: 1)),
            address: place2Address);

        Trace trace3 = Trace(
            id: -3,
            inputDate: DateTime.now().subtract(const Duration(days: 8)),
            outputDate: null,
            address: place3Address);

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
        yield _uploadPistisFields();

        await factoryService.authService
            .loginWithUsernameAndPassword("test", "1234");
        product =
            await factoryService.productService.saveAndPublishProduct(product);

        yield _uploadPistisFields();
      } catch (error) {
        isProductSend = false;
        yield error is PistisStateError
            ? PistisStateError(error.message)
            : PistisStateError(
                'Algo fue mal al enviar el producto. Disculpe las molestias');
      }
    } else if (event is CarrouselEndEvent) {
      try {
        if (isCarrouselOn){
          qrLink =
          await factoryService.productService
              .getProductQRCodeString(product.id);
          Uint8List qrImage =
          await factoryService.productService.getProductQRCode(product.id);
          carrousel.add(qrImage);
          yield _uploadPistisFields();
        }
      } catch (error) {
        yield error is PistisStateError
            ? PistisStateError(error.message)
            : PistisStateError('Algo fue mal!');
      }
    } else if (event is CarrouselResultEvent) {
      isCarrouselOn = false;
      yield _uploadPistisFields();
    } else if (event is CarrouselLinkEvent) {
      carrouselLinkShow = true;
      yield _uploadPistisFields();
    }
  }

  PistisState _uploadPistisFields() => UploadPistisFields(
      productName: productName,
      model: model,
      batch: batch,
      serialNumber: serialNumber,
      isProductSend: isProductSend,
      qrLink: qrLink,
      carrousel: carrousel,
      isCarrouselOn: isCarrouselOn,
      carrouselLinkShow: carrouselLinkShow,
  );
}
