import 'package:easy_localization/easy_localization.dart';
import 'package:energy_consumption/core/enums/status.dart';
import 'package:energy_consumption/core/extensions/double_formatter.dart';
import 'package:energy_consumption/features/energy/presentation/bloc/energy_bloc.dart';
import 'package:energy_consumption/features/energy/presentation/bloc/energy_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/dimens.dart';
import '../../../../core/service_locator/service_locator.dart';
import '../bloc/energy_event.dart';

class EnergyDetailWidget extends StatelessWidget {
  const EnergyDetailWidget({super.key});

  @override
  Widget build(Object context) {
    return BlocConsumer<EnergyBloc, EnergyState>(
      listenWhen: (previous, next) => previous != next,
      listener: (context, state) {
        if (state.clearCacheStatus == ClearCacheStatus.succeed) {
          showSuccessMessage(context, false, "Operation was successful!");
        } else if (state.clearCacheStatus == ClearCacheStatus.failed) {
          showSuccessMessage(context, true, "Failed");
        }
      },
      builder: (context, state) {
        final kilowattValue =
            (state.selectedEnergyEntity.value.toDouble().wattsToKilowatts)
                .toStringAsFixed(2);
        final wattValue = '${state.selectedEnergyEntity.value}';

        return Column(
          children: [
            Row(
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
                        state.isKilowatts ? tr('kilowatts') : tr('watts'),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: Dimens.small),
                      Text(
                        state.isKilowatts ? kilowattValue : wattValue,
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
            ),
            const Expanded(child: SizedBox()),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 40,
              child: TextButton(
                onPressed: () {
                  sl<EnergyBloc>().add(const ClearCacheEvent());
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Dimens.extraLarge),
                  ),
                ),
                child: Text(
                  tr('clear_cache'),
                  style: const TextStyle(fontSize: 16.0),
                ),
              ),
            ),
            const SizedBox(height: Dimens.extraLarge)
          ],
        );
      },
    );
  }

  void showSuccessMessage(
    BuildContext context,
    bool isFailed,
    String message,
  ) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: isFailed ? Colors.red : Colors.green,
      duration: const Duration(seconds: 3),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
