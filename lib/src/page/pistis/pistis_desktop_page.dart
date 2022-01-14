import 'dart:typed_data';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pistiscore/pistiscore.dart';
import 'package:pistiscore/pistiscore_route.dart';
import 'package:trustvalueapp/src/page/pistis/pistis_basic_page.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../bloc/event/pistis_event.dart';
import '../../bloc/pistis_bloc.dart';
import '../../bloc/state/pistis_state.dart';

class PistisDesktopPage extends PistisBasicPage {
  const PistisDesktopPage(String title, AppRouterDelegate appRouterDelegate,
      {required Key? key})
      : super(title, appRouterDelegate, key: key);

  @override
  Widget body(BuildContext context) => BlocBuilder<PistisBloc, PistisState>(
        builder: (context, state) {
          TextEditingController productNameController = TextEditingController();
          TextEditingController productModelController =
              TextEditingController();
          TextEditingController productBatchController =
              TextEditingController();
          TextEditingController productSerialNumberController =
              TextEditingController();
          List<Object> carrousel = [];
          bool isProductSend = false;
          String? qrLink;
          bool isCarrouselOn = false;
          bool carrouselLinkShow = false;

          if (state is PistisInitState) {
            BlocProvider.of<PistisBloc>(context).add(FetchInitialDataEvent());
          } else if (state is UploadPistisFields) {
            productNameController.text = state.productName;
            productModelController.text = state.model;
            productBatchController.text = state.batch;
            productSerialNumberController.text = state.serialNumber;
            isProductSend = state.isProductSend;
            isCarrouselOn = state.isCarrouselOn;
            qrLink = state.qrLink;
            carrousel = state.carrousel;
            carrouselLinkShow = state.carrouselLinkShow;
          } else if (state is PistisStateError) {
            CustomSnackBar().show(context: context, message: state.message);
            BlocProvider.of<PistisBloc>(context).add(PistisEventEmpty());
          }

          return ListView(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: ProductData(
                        productNameController,
                        productModelController,
                        productBatchController,
                        productSerialNumberController),
                  ),
                  Expanded(
                      flex: 1,
                      child: ProductOnPistis(
                          productNameController,
                          productModelController,
                          productBatchController,
                          productSerialNumberController,
                          isProductSend,
                          qrLink,
                          isCarrouselOn,
                          carrousel,
                          carrouselLinkShow)),
                ],
              ),
            ],
          );
        },
      );
}

class ProductData extends StatelessWidget {
  final TextEditingController productNameController;
  final TextEditingController productModelController;
  final TextEditingController productBatchController;
  final TextEditingController productSerialNumberController;

  const ProductData(this.productNameController, this.productModelController,
      this.productBatchController, this.productSerialNumberController,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  margin: const EdgeInsets.only(
                      top: 15, left: 15, right: 15, bottom: 15),
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(border: Border.all()),
                  child: Column(
                    children: [
                      TextField(
                        controller: productNameController,
                        decoration: InputDecoration(
                            labelText:
                                AppLocalizations.of(context)!.productNameLabel),
                      ),
                      TextField(
                        controller: productModelController,
                        readOnly: true,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.black12,
                            labelText: AppLocalizations.of(context)!
                                .productModelLabel),
                      ),
                      TextField(
                        controller: productBatchController,
                        readOnly: true,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.black12,
                            labelText: AppLocalizations.of(context)!
                                .productBatchLabel),
                      ),
                      TextField(
                        controller: productSerialNumberController,
                        readOnly: true,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.black12,
                            labelText: AppLocalizations.of(context)!
                                .productSerialNLabel),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(
                          top: 0, left: 15, right: 15, bottom: 15),
                      padding: const EdgeInsets.all(30),
                      decoration: BoxDecoration(border: Border.all()),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.bomLabel,
                            style: const TextStyle(
                                decoration: TextDecoration.underline),
                          ),
                          Text(AppLocalizations.of(context)!.bom1),
                          Text(AppLocalizations.of(context)!.bom2),
                          Text(AppLocalizations.of(context)!.bom3),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(
                          top: 0, left: 15, right: 15, bottom: 15),
                      padding: const EdgeInsets.all(30),
                      decoration: BoxDecoration(border: Border.all()),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.trackLabel,
                            style: const TextStyle(
                                decoration: TextDecoration.underline),
                          ),
                          Wrap(
                            children: [
                              Text(AppLocalizations.of(context)!.fromLabel),
                              const Text(": "),
                              Text(AppLocalizations.of(context)!.place1),
                              const Text(" "),
                              Text(AppLocalizations.of(context)!.toLabel),
                              const Text(": "),
                              Text(AppLocalizations.of(context)!.place2),
                            ],
                          ),
                          Wrap(
                            children: [
                              Text(AppLocalizations.of(context)!.fromLabel),
                              const Text(": "),
                              Text(AppLocalizations.of(context)!.place2),
                              const Text(" "),
                              Text(AppLocalizations.of(context)!.toLabel),
                              const Text(": "),
                              Text(AppLocalizations.of(context)!.place3),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      );
}

class ProductOnPistis extends StatelessWidget {
  final TextEditingController productNameController;
  final TextEditingController productModelController;
  final TextEditingController productBatchController;
  final TextEditingController productSerialNumberController;
  final bool isProductSend;
  final String? qrLink;
  final bool isCarrouselOn;
  final List<Object> carrousel;
  final bool carrouselLinkShow;

  const ProductOnPistis(
      this.productNameController,
      this.productModelController,
      this.productBatchController,
      this.productSerialNumberController,
      this.isProductSend,
      this.qrLink,
      this.isCarrouselOn,
      this.carrousel,
      this.carrouselLinkShow,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
            child: Column(
              children: [
                Container(
                  height: 250,
                  width: double.infinity,
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(border: Border.all()),
                  child: isProductSend
                      ? CarouselSlider(
                          options: CarouselOptions(
                            height: 400,
                            initialPage: 0,
                            enableInfiniteScroll: true,
                            reverse: false,
                            autoPlay: isCarrouselOn,
                            autoPlayInterval: const Duration(seconds: 3),
                            autoPlayAnimationDuration:
                                const Duration(milliseconds: 800),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enlargeCenterPage: true,
                            onPageChanged: (index, page) => {
                              if (index == 3)
                                {
                                  BlocProvider.of<PistisBloc>(context)
                                      .add(CarrouselEndEvent())
                                }
                              else if (index == 4)
                                {
                                  BlocProvider.of<PistisBloc>(context)
                                      .add(CarrouselResultEvent())
                                }
                            },
                            scrollDirection: Axis.horizontal,
                          ),
                          items: carrousel
                              .map((i) => Builder(
                                    builder: (BuildContext context) =>
                                        _carrouselPageBuilder(context, i),
                                  ))
                              .toList(),
                        )
                      : const Center(
                          child:
                              Text("Envia el producto para empezar la Demo")),
                ),
                Visibility(
                  visible: carrouselLinkShow,
                  child: SelectableText.rich(
                    TextSpan(
                      text: AppLocalizations.of(context)!.scanQR,
                      style: GoogleFonts.montserrat(
                          fontSize: 15, color: Colors.black),
                      children: [
                        TextSpan(
                          text: " ${AppLocalizations.of(context)!.here}",
                          style: GoogleFonts.montserrat(
                            fontSize: 15,
                            color: Colors.blueAccent,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async {
                              var url = qrLink!;
                              if (await canLaunch(url)) {
                                await launch(url);
                              } else {
                                throw 'Could not launch $url';
                              }
                            },
                        ),
                      ],
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: isProductSend
                      ? null
                      : () => BlocProvider.of<PistisBloc>(context)
                              .add(NewProductEvent(
                            productNameController.text,
                            productModelController.text,
                            productBatchController.text,
                            productSerialNumberController.text,
                            AppLocalizations.of(context)!.bom1,
                            AppLocalizations.of(context)!.bom2,
                            AppLocalizations.of(context)!.bom3,
                            AppLocalizations.of(context)!.place1,
                            AppLocalizations.of(context)!.place2,
                            AppLocalizations.of(context)!.place3,
                          )),
                  child:
                      // isProductSend
                      //     ? const CustomProgressIndicator()
                      //     :
                      Text(AppLocalizations.of(context)!.send2Pistis),
                ),
              ],
            ),
          ),
        ],
      );

  Widget _carrouselPageBuilder(BuildContext context, Object i) {
    Widget? widget;

    switch (carrousel.indexOf(i)) {
      // case 1:
      //   break;
      // case 2:
      //   break;
      // case 3:
      //   break;
      case 4:
        widget = Image.memory(
          i as Uint8List,
          frameBuilder: (BuildContext context, Widget child, int? frame,
                  bool wasSynchronouslyLoaded) =>
              wasSynchronouslyLoaded
                  ? child
                  : AnimatedOpacity(
                      child: child,
                      opacity: frame == null ? 0 : 1,
                      duration: const Duration(seconds: 2),
                      curve: Curves.easeOut,
                    ),
          errorBuilder: (BuildContext context, Object exception,
                  StackTrace? stackTrace) =>
              const Text('No se pudo cargar '
                  'la imagen'),
        );
        BlocProvider.of<PistisBloc>(context).add(CarrouselLinkEvent());
        break;

      default:
        widget = Center(
          child: Text(
            'text $i',
            style: const TextStyle(fontSize: 16.0),
          ),
        );
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      decoration: const BoxDecoration(color: Colors.white),
      child: widget,
    );
  }
}
