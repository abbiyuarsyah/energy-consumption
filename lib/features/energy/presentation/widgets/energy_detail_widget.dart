import 'package:easy_localization/easy_localization.dart';
import 'package:energy_consumption/core/extensions/double_formatter.dart';
import 'package:energy_consumption/features/energy/presentation/bloc/energy_bloc.dart';
import 'package:energy_consumption/features/energy/presentation/bloc/energy_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/dimens.dart';

class EnergyDetailWidget extends StatelessWidget {
  const EnergyDetailWidget({super.key});

  @override
  Widget build(Object context) {
    return BlocBuilder<EnergyBloc, EnergyState>(
      builder: (context, state) {
        final kilowattValue =
            (state.selectedEnergyEntity.value.toDouble().wattsToKilowatts)
                .toStringAsFixed(2);
        final wattValue = '${state.selectedEnergyEntity.value}';

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tr('time'),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: Dimens.small),
                  Text(
                    DateFormat.Hm()
                        .format(state.selectedEnergyEntity.timestamp),
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            const VerticalDivider(color: Colors.grey, thickness: 1),
            SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    state.isKiloWatts ? tr('kilowatts') : tr('watts'),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: Dimens.small),
                  Text(
                    state.isKiloWatts ? kilowattValue : wattValue,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
