abstract class PistisState {}

class PistisInitState extends PistisState {
  @override
  String toString() => 'PistisInitState';
}

class UploadPistisFields extends PistisState {
  final String productName;
  final String model;
  final String batch;
  final String serialNumber;
  final bool isProductSend;
  final String? qrLink;
  final List<Object> carrousel;
  final bool isCarrouselOn;
  final bool carrouselLinkShow;
  final int carrouselIndex;

  UploadPistisFields(
      {required this.productName,
      required this.model,
      required this.batch,
      required this.serialNumber,
      required this.isProductSend,
      required this.qrLink,
      required this.carrousel,
      required this.isCarrouselOn,
      required this.carrouselLinkShow,
      required this.carrouselIndex});
  @override
  String toString() => 'UploadPistisFields State';
}

class PistisStateError extends PistisState {
  final String message;

  PistisStateError(this.message);

  @override
  String toString() => 'PistisStateError';
}
