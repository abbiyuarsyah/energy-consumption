import 'package:easy_localization/easy_localization.dart';
import 'package:energy_consumption/core/enums/status.dart';
import 'package:energy_consumption/core/extensions/custom_theme_extension.dart';
import 'package:energy_consumption/core/extensions/date_formatter.dart';
import 'package:energy_consumption/features/energy/presentation/bloc/energy_event.dart';
import 'package:energy_consumption/features/energy/presentation/bloc/energy_state.dart';
import 'package:energy_consumption/core/shared_widget/card_container.dart';
import 'package:energy_consumption/core/shared_widget/error_screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/dimens.dart';
import '../../../../core/service_locator/service_locator.dart';
import '../bloc/energy_bloc.dart';
import '../../../../core/shared_widget/date_picker_widget.dart';
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
        backgroundColor: context.cardColor,
        elevation: 0,
        centerTitle: false,
        title: Column(
          children: [
            const SizedBox(height: Dimens.medium),
            Text(
              tr('monitoring'),
              style: TextStyle(
                color: context.textColor,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: context.backgroundColor,
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: BlocBuilder<EnergyBloc, EnergyState>(
            buildWhen: (previous, next) =>
                previous.stateStatus != next.stateStatus,
            builder: (context, state) {
              if (state.stateStatus == StateStatus.loading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state.stateStatus == StateStatus.loaded) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
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
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: context.textColor,
                              ),
                            ),
                            const SizedBox(height: Dimens.extraLarge),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AdvancedSwitch(
                                  controller: _controller,
                                  activeColor: context.switchActiveColor!,
                                  inactiveColor: context.switchInactiveColor!,
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
                      const Flexible(
                        child: CardContainer(
                          isTopRounded: true,
                          child: EnergyDetailWidget(),
                        ),
                      ),
                    ],
                  ),
                );
              } else if (state.stateStatus == StateStatus.failed) {
                return ErrorScreenWidget(
                  message: state.errorMessage,
                  onPressed: () {
                    sl<EnergyBloc>().add(GetEnergyEvent(
                      date: DateTime.now().getStringDate,
                    ));
                  },
                );
              }

              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }

  Future<void> _handleRefresh() async {
    await Future.delayed(const Duration(seconds: 1));
    sl<EnergyBloc>().add(GetEnergyEvent(date: DateTime.now().getStringDate));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
