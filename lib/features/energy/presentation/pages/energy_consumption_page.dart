import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/dimens.dart';
import '../widgets/energy_graph.dart';
import '../widgets/energy_tab.dart';

class EnergyConsumptionPage extends StatelessWidget {
  const EnergyConsumptionPage({super.key});

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
            const SizedBox(height: Dimens.xxLarge),
            const EnergyGraph(),
          ],
        ),
      ),
    );
  }
}
