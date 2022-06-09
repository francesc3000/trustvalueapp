import 'dart:typed_data';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trustvalueapp/src/bloc/event/pistis_event.dart';
import 'package:trustvalueapp/src/bloc/pistis_bloc.dart';
import 'package:trustvalueapp/src/bloc/state/pistis_state.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ProductOnPistis extends StatelessWidget {
  const ProductOnPistis({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<PistisBloc, PistisState>(builder: (context, state) {
        TextEditingController productNameController = TextEditingController();
        TextEditingController productModelController = TextEditingController();
        TextEditingController productBatchController = TextEditingController();
        TextEditingController productSerialNumberController =
            TextEditingController();
        List<Object> carrousel = [];
        bool isProductSend = false;
        String? qrLink;
        bool isCarrouselOn = false;
        bool carrouselLinkShow = false;
        int carrouselIndex = 0;

        if (state is PistisInitState) {
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
        }

        return Column(
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
                                    BlocProvider.of<PistisBloc>(context).add(
                                        CarrouselResultEvent(carrouselIndex))
                                  }
                              },
                              scrollDirection: Axis.horizontal,
                            ),
                            items: carrousel
                                .map((i) => Builder(
                                      builder: (BuildContext context) =>
                                          _carrouselPageBuilder(
                                              context, carrousel, i),
                                    ))
                                .toList(),
                          )
                        : Stack(
                            children: [
                              Align(
                                alignment: Alignment.topCenter,
                                child:
                                    Text(AppLocalizations.of(context)!.slide0),
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
                                if (await canLaunchUrlString(url)) {
                                  await launchUrlString(url);
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
                        ? () => BlocProvider.of<PistisBloc>(context)
                            .add(FetchInitialDataEvent(context))
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
      });

  Widget _carrouselPageBuilder(
      BuildContext context, List<Object> carrousel, Object i) {
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
