import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:trustvalueapp/src/bloc/pistis_bloc.dart';
import 'package:trustvalueapp/src/bloc/state/pistis_state.dart';

class ProductData extends StatelessWidget {
  const ProductData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<PistisBloc, PistisState>(builder: (context, state) {
        TextEditingController productNameController = TextEditingController();
        TextEditingController productModelController = TextEditingController();
        TextEditingController productBatchController = TextEditingController();
        TextEditingController productSerialNumberController =
            TextEditingController();

        if (state is UploadPistisFields) {
          productNameController.text = state.productName;
          productModelController.text = state.model;
          productBatchController.text = state.batch;
          productSerialNumberController.text = state.serialNumber;
        }

        return Column(
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
                              labelText: AppLocalizations.of(context)!
                                  .productNameLabel),
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
      });
}
