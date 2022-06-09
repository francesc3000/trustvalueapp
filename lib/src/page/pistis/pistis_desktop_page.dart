import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pistiscore/pistiscore.dart';
import 'package:pistiscore/pistiscore_route.dart';
import 'package:trustvalueapp/src/page/pistis/pistis_basic_page.dart';
import 'package:trustvalueapp/src/page/pistis/widget/demo_label_widget.dart';
import 'package:trustvalueapp/src/page/pistis/widget/service_data.dart';
import 'package:trustvalueapp/src/page/pistis/widget/service_on_pistis.dart';

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
          if (state is PistisInitState) {
            BlocProvider.of<PistisBloc>(context)
                .add(FetchInitialDataEvent(context));
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
                demoLabelWidget(context),
                Row(
                  children: const [
                    Expanded(
                      flex: 2,
                      child: ServiceData(),
                    ),
                    Expanded(flex: 1, child: ServiceOnPistis()),
                  ],
                ),
              ],
            ),
          );
        },
      );
}
