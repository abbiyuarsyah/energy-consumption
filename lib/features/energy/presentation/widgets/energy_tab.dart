import 'package:energy_consumption/core/enums/energy_type.dart';
import 'package:energy_consumption/features/energy/presentation/bloc/energy_bloc.dart';
import 'package:energy_consumption/features/energy/presentation/bloc/energy_event.dart';
import 'package:energy_consumption/features/energy/presentation/bloc/energy_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/dimens.dart';
import '../../../../core/service_locator/service_locator.dart';

class EnergyTab extends StatelessWidget {
  const EnergyTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EnergyBloc, EnergyState>(
      builder: (context, state) {
        return Wrap(
          spacing: Dimens.medium,
          children: List.generate(
            EnergyType.values.length,
            (index) => GestureDetector(
              onTap: () {
                sl.get<EnergyBloc>().add(
                      SelectEnergyTypeEvent(type: EnergyType.values[index]),
                    );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: Dimens.large,
                  vertical: Dimens.medium,
                ),
                decoration: BoxDecoration(
                  color: state.selectedType.index == index
                      ? Colors.lightBlueAccent
                      : Colors.white,
                  borderRadius: BorderRadius.circular(Dimens.large),
                  border: Border.all(
                    color: state.selectedType.index == index
                        ? Colors.lightBlueAccent
                        : Colors.grey,
                    width: 1.5,
                  ),
                ),
                child: Text(
                  EnergyType.values[index].getEnergyString,
                  style: TextStyle(
                    color: state.selectedType.index == index
                        ? Colors.white
                        : Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
