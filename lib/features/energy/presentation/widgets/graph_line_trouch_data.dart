import 'package:energy_consumption/core/extensions/double_formatter.dart';
import 'package:energy_consumption/features/energy/presentation/bloc/energy_event.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/dimens.dart';
import '../../../../core/service_locator/service_locator.dart';
import '../bloc/energy_bloc.dart';

class GraphLineTouchData extends LineTouchData {
  GraphLineTouchData(this.isKilowatt)
      : super(
          touchCallback: (event, result) {
            final index = result?.lineBarSpots?.first.spotIndex;
            if (index == null) {
              return;
            }

            sl<EnergyBloc>().add(SelectValueEvent(selectedIndex: index));
          },
          getTouchedSpotIndicator: (LineChartBarData data, List<int> spots) {
            return spots.map(
              (index) {
                return TouchedSpotIndicatorData(
                  FlLine(color: Colors.grey.withOpacity(0.4)),
                  FlDotData(
                    show: true,
                    getDotPainter: (_, __, ___, ____) => FlDotCirclePainter(
                      radius: Dimens.small,
                      strokeWidth: Dimens.extraSmall,
                      strokeColor: Colors.white,
                      color: Colors.lightBlue.shade200,
                    ),
                  ),
                );
              },
            ).toList();
          },
          touchTooltipData: LineTouchTooltipData(
            tooltipRoundedRadius: 8,
            getTooltipItems: (List<LineBarSpot> lineBarsSpot) {
              return lineBarsSpot.map((lineBarSpot) {
                final lineSpot = isKilowatt
                    ? lineBarSpot.y.wattsToKilowatts.toStringAsFixed(2)
                    : (lineBarSpot.y.toInt()).toString();

                return LineTooltipItem(
                  lineSpot,
                  const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                );
              }).toList();
            },
          ),
        );

  final bool isKilowatt;
}
