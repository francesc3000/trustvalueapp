import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:trustvalueapp/src/bloc/event/pistis_event.dart';
import 'package:trustvalueapp/src/bloc/pistis_bloc.dart';
import 'package:trustvalueapp/src/bloc/state/pistis_state.dart';

class ServiceData extends StatelessWidget {
  const ServiceData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<PistisBloc, PistisState>(builder: (context, state) {
        TextEditingController serviceNameController = TextEditingController();
        TextEditingController serviceAmountController = TextEditingController();
        DateTime _today = DateTime.now();
        double _serviceAmount = 0.0;
        bool _isLoading = false;

        if (state is FetchInitialDataEvent) {
          _isLoading = true;
        } else if (state is UploadPistisFields) {
          _isLoading = false;
          serviceNameController.text = state.serviceName;
          serviceAmountController.text = state.serviceAmount.toString();
          _serviceAmount = state.serviceAmount;

          serviceNameController.selection = TextSelection.fromPosition(
              TextPosition(offset: serviceNameController.text.length));
          serviceAmountController.selection = TextSelection.fromPosition(
              TextPosition(offset: serviceAmountController.text.length));
        }

        if (_isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(
                        top: 15, left: 15, right: 15, bottom: 15),
                    padding: const EdgeInsets.all(30),
                    decoration: BoxDecoration(border: Border.all()),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: serviceNameController,
                          decoration: InputDecoration(
                              labelText: AppLocalizations.of(context)!
                                  .serviceNameLabel),
                          onChanged: (name) =>
                              BlocProvider.of<PistisBloc>(context)
                                  .add(ServiceNameChangeEvent(name)),
                        ),
                        Row(
                          children: [
                            Flexible(
                              flex: 3,
                              child: TextField(
                                controller: serviceAmountController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    labelText: AppLocalizations.of(context)!
                                        .serviceAmountLabel),
                                onChanged: (number) =>
                                    BlocProvider.of<PistisBloc>(context).add(
                                        ServiceAmountChangeEvent(
                                            double.parse(number))),
                              ),
                            ),
                            const Flexible(
                              flex: 1,
                              child: Text("€"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
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
                        Text(
                          AppLocalizations.of(context)!
                              .serviceTrack1(_today, _serviceAmount),
                        ),
                        const Center(child: Icon(FontAwesomeIcons.arrowDown)),
                        Text(
                          AppLocalizations.of(context)!.serviceTrack2(
                              _today.add(const Duration(days: 3)),
                              _serviceAmount * 0.7),
                        ),
                        const Center(child: Icon(FontAwesomeIcons.arrowDown)),
                        Text(
                          AppLocalizations.of(context)!.serviceTrack3(
                              _today.add(const Duration(days: 5)),
                              _serviceAmount * 0.3),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      });
}
