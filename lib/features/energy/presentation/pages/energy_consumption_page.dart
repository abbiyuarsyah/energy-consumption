import 'package:easy_localization/easy_localization.dart';
import 'package:energy_consumption/core/enums/state_status.dart';
import 'package:energy_consumption/features/energy/presentation/bloc/energy_event.dart';
import 'package:energy_consumption/features/energy/presentation/bloc/energy_state.dart';
import 'package:energy_consumption/features/energy/presentation/widgets/card_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/dimens.dart';
import '../../../../core/service_locator/service_locator.dart';
import '../bloc/energy_bloc.dart';
import '../widgets/date_picker_widget.dart';
import '../widgets/energy_detail_widget.dart';
import '../widgets/energy_graph_widget.dart';
import '../widgets/energy_tab_widget.dart';

class EnergyConsumptionPage extends StatefulWidget {
  const EnergyConsumptionPage({super.key});

  @override
  State<EnergyConsumptionPage> createState() => _EnergyConsumptionPageState();
}

class _EnergyConsumptionPageState extends State<EnergyConsumptionPage> {
  final _controller = ValueNotifier<bool>(true);

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      sl<EnergyBloc>().add(SwitchUnitEvent(isKiloWatts: _controller.value));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: Column(
          children: [
            const SizedBox(height: Dimens.medium),
            Text(
              tr('monitoring'),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.grey[200],
      body: BlocBuilder<EnergyBloc, EnergyState>(
        buildWhen: (previous, next) => previous.stateStatus != next.stateStatus,
        builder: (context, state) {
          if (state.stateStatus == StateStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.stateStatus == StateStatus.loaded) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CardContainer(
                  isBottomRounded: true,
                  child: EnergyTab(),
                ),
                const SizedBox(height: Dimens.large),
                CardContainer(
                  isTopRounded: true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tr('you_energy_consumption'),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: Dimens.extraLarge),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AdvancedSwitch(
                            controller: _controller,
                            activeColor: Colors.blue.shade900,
                            inactiveColor: Colors.blue.shade500,
                            activeChild: Text(tr('kilowatts')),
                            inactiveChild: Text(
                              tr('watts'),
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(Dimens.large),
                            ),
                            width: 120.0,
                            height: 30.0,
                            enabled: true,
                            disabledOpacity: 0.5,
                          ),
                          const DatePickerWidget(),
                        ],
                      ),
                      const SizedBox(height: Dimens.xxLarge),
                      const EnergyGraph(),
                      const SizedBox(height: Dimens.large),
                    ],
                  ),
                ),
                const SizedBox(height: Dimens.large),
                const Expanded(
                  child: CardContainer(
                    isTopRounded: true,
                    child: EnergyDetailWidget(),
                  ),
                ),
              ],
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
