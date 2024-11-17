import 'package:easy_localization/easy_localization.dart';
import 'package:energy_consumption/features/energy/presentation/bloc/energy_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import '../../../../core/constants/dimens.dart';
import '../../../../core/service_locator/service_locator.dart';
import '../bloc/energy_bloc.dart';
import '../widgets/energy_graph.dart';
import '../widgets/energy_tab.dart';

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
      sl<EnergyBloc>().add(SwitchUnitEvent(isWatts: _controller.value));
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
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(Dimens.large),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const EnergyTab(),
            const SizedBox(height: Dimens.large),
            Text(
              tr('you_energy_consumption'),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: Dimens.large),
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
            const SizedBox(height: Dimens.xxLarge),
            const EnergyGraph(),
          ],
        ),
      ),
    );
  }
}
