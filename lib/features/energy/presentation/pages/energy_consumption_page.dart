import 'package:energy_consumption/core/enums/energy_type.dart';
import 'package:energy_consumption/features/energy/presentation/bloc/energy_bloc.dart';
import 'package:energy_consumption/features/energy/presentation/bloc/energy_event.dart';
import 'package:flutter/material.dart';

import '../../../../core/service_locator/service_locator.dart';

class EnergyConsumptionPage extends StatelessWidget {
  const EnergyConsumptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: Container(
        child: TextButton(
            onPressed: () {
              sl.get<EnergyBloc>().add(
                    GetEnergyEvent(
                      date: '2024-10-01',
                      type: EnergyType.solar,
                    ),
                  );
            },
            child: Text('test')),
      ),
    );
  }
}
