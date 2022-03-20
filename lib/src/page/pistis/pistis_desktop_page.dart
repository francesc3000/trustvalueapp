import 'dart:typed_data';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
          int carrouselIndex = 0;

          if (state is PistisInitState) {
            carrousel = _buildCarrousel(context);
            BlocProvider.of<PistisBloc>(context).add(FetchInitialDataEvent(
                carrousel, AppLocalizations.of(context)!.productName));
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
            carrouselIndex = state.carrouselIndex;
          } else if (state is PistisStateError) {
            CustomSnackBar().show(context: context, message: state.message);
            BlocProvider.of<PistisBloc>(context).add(PistisEventEmpty());
          }

          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.white, Colors.blue],
              ),
            ),
            child: ListView(
              children: [
                _demoLabel(context),
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
                            carrouselLinkShow,
                            carrouselIndex)),
                  ],
                ),
              ],
            ),
          );
        },
      );

  List<Object> _buildCarrousel(BuildContext context) {
    List<Object> carrousel = [];
    carrousel.add(AppLocalizations.of(context)!.slide1);
    carrousel.add(AppLocalizations.of(context)!.slide2);
    carrousel.add(AppLocalizations.of(context)!.slide3);
    carrousel.add(AppLocalizations.of(context)!.slide4);

    return carrousel;
  }

  Widget _demoLabel(context) => Padding(
        padding: const EdgeInsets.only(top: 18.0, left: 20),
        child: Text.rich(
          TextSpan(
            text: "${AppLocalizations.of(context)!.pistisDemoTitle}\n",
            style: const TextStyle(fontSize: 30),
            children: [
              TextSpan(
                  text: "${AppLocalizations.of(context)!.pistisDemoDesc1} ",
                  style: const TextStyle(fontSize: 20),
                  children: [
                    TextSpan(
                      text: AppLocalizations.of(context)!.pistis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                    TextSpan(
                      text:
                          ", ${AppLocalizations.of(context)!.pistisDemoDesc2} ",
                    ),
                    TextSpan(
                      text: "${AppLocalizations.of(context)!.blockchain}.\n",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                  ]),
              TextSpan(
                  text: "${AppLocalizations.of(context)!.pistisDemoDesc3}.",
                  style: const TextStyle(
                    fontSize: 20,
                  ))
            ],
          ),
        ),
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
                      TextFormField(
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
                                fontSize: 18,
                                decoration: TextDecoration.underline),
                          ),
                          Text(
                            "- ${AppLocalizations.of(context)!.bom1}",
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            "- ${AppLocalizations.of(context)!.bom2}",
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            "- ${AppLocalizations.of(context)!.bom3}",
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
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
                                fontSize: 18,
                                decoration: TextDecoration.underline),
                          ),
                          Wrap(
                            children: [
                              Text(
                                AppLocalizations.of(context)!.fromLabel,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              const Text(": "),
                              Text(
                                AppLocalizations.of(context)!.place1,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              const Text(" "),
                              Text(
                                AppLocalizations.of(context)!.toLabel,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              const Text(": "),
                              Text(
                                AppLocalizations.of(context)!.place2,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          Wrap(
                            children: [
                              Text(
                                AppLocalizations.of(context)!.fromLabel,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              const Text(
                                ": ",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                AppLocalizations.of(context)!.place2,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              const Text(
                                " ",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                AppLocalizations.of(context)!.toLabel,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              const Text(
                                ": ",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                AppLocalizations.of(context)!.place3,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
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
  final int carrouselIndex;

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
      this.carrouselIndex,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
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
                            initialPage: carrouselIndex,
                            enableInfiniteScroll: true,
                            reverse: false,
                            autoPlay: isCarrouselOn,
                            autoPlayInterval: const Duration(seconds: 5),
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
                                      .add(CarrouselResultEvent(carrouselIndex))
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
                      : Stack(
                          children: [
                            Align(
                              alignment: Alignment.topCenter,
                              child: Text(AppLocalizations.of(context)!.slide0),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: ConstrainedBox(
                                constraints: const BoxConstraints.expand(
                                    width: double.infinity,
                                    height: double.infinity),
                                child: Image.asset(
                                  "assets/images/astronauta.png",
                                ),
                              ),
                              // child: FittedBox(
                              //   fit: BoxFit.contain,
                              //   child: Image.asset(
                              //     "assets/images/astronauta.png",
                              //   ),
                              // ),
                            ),
                            const Align(
                              alignment: Alignment.bottomCenter,
                              child: Icon(
                                FontAwesomeIcons.arrowDown,
                                size: 50,
                              ),
                            ),
                          ],
                        ),
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
                  onPressed: carrouselLinkShow
                      ? () {
                          List<Object> newCarrousel = _buildCarrousel(context);
                          BlocProvider.of<PistisBloc>(context).add(
                              FetchInitialDataEvent(newCarrousel,
                                  AppLocalizations.of(context)!.productName));
                        }
                      : isProductSend
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
                  child: carrouselLinkShow
                      ? Text(AppLocalizations.of(context)!.refreshPistis)
                      : Text(AppLocalizations.of(context)!.send2Pistis),
                ),
              ],
            ),
          ),
        ],
      );

  List<Object> _buildCarrousel(BuildContext context) {
    List<Object> carrousel = [];
    carrousel.add(AppLocalizations.of(context)!.slide1);
    carrousel.add(AppLocalizations.of(context)!.slide2);
    carrousel.add(AppLocalizations.of(context)!.slide3);
    carrousel.add(AppLocalizations.of(context)!.slide4);

    return carrousel;
  }

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
              const Text('No se pudo cargar la imagen'),
        );
        BlocProvider.of<PistisBloc>(context).add(CarrouselLinkEvent());
        break;
      default:
        widget = Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '$i',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 17.0),
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
