import 'package:energy_consumption/core/extensions/double_formatter.dart';
import 'package:energy_consumption/features/energy/domain/entities/energy_entity.dart';
import 'package:energy_consumption/features/energy/presentation/bloc/energy_bloc.dart';
import 'package:energy_consumption/features/energy/presentation/bloc/energy_state.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/dimens.dart';
import 'graph_line_trouch_data.dart';

class EnergyGraph extends StatelessWidget {
  const EnergyGraph({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EnergyBloc, EnergyState>(
      builder: (context, state) {
        if (state.energy.isEmpty) {
          return const SizedBox();
        }

        final energyList = state.energy[state.selectedType.index].energyList;

        return energyList.isEmpty
            ? const SizedBox()
            : Padding(
                padding: const EdgeInsets.only(
                  left: Dimens.small,
                  right: Dimens.large,
                ),
                child: SizedBox(
                  height: 300,
                  child: LineChart(
                    LineChartData(
                      lineBarsData: [
                        LineChartBarData(
                          spots: List.generate(
                            energyList.length,
                            (index) => FlSpot(
                              index + 1,
                              energyList[index].value.toDouble(),
                            ),
                          ),
                          barWidth: 0.1,
                          isCurved: false,
                          color: Colors.lightBlue,
                          isStrokeCapRound: true,
                          dotData: const FlDotData(show: false),
                          belowBarData: BarAreaData(
                            show: true,
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.lightBlueAccent,
                                Colors.white.withOpacity(0.1),
                              ],
                            ),
                          ),
                        ),
                      ],
                      lineTouchData: GraphLineTouchData(),
                      maxX: energyList.length.toDouble(),
                      minX: 1,
                      maxY: state.energy[state.selectedType.index].maxY,
                      minY: state.energy[state.selectedType.index].minY,
                      gridData: FlGridData(
                        drawVerticalLine: false,
                        getDrawingHorizontalLine: (value) => const FlLine(
                          color: Colors.grey,
                          strokeWidth: 0.4,
                          dashArray: [4, 2],
                        ),
                      ),
                      borderData: FlBorderData(show: false),
                      titlesData: FlTitlesData(
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 30,
                            getTitlesWidget: (value, meta) => _LeftTitles(
                              value: value,
                              meta: meta,
                              minY: state.energy[state.selectedType.index].minY,
                              isKiloWatts: state.isKilowatts,
                            ),
                            interval: 1000,
                          ),
                        ),
                        topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) => _BottomTitles(
                              value: value,
                              meta: meta,
                              energyList: energyList,
                            ),
                            interval: 50,
                          ),
                        ),
                        rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
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

class _LeftTitles extends StatelessWidget {
  const _LeftTitles({
    required this.value,
    required this.meta,
    required this.minY,
    required this.isKiloWatts,
  });

  final double value;
  final TitleMeta meta;
  final double minY;
  final bool isKiloWatts;

  @override
  Widget build(BuildContext context) {
    if (minY == value) {
      return const SizedBox();
    }

    final unit = isKiloWatts ? value.wattsToKilowatts : value;
    var formatted = '${(unit / 1000).round()}k W';

    if (isKiloWatts) {
      formatted = '${unit.round()} kW';
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 2,
      child: Row(
        children: [
          Text(
            formatted,
            style: const TextStyle(
              fontSize: 10,
            ),
          ),
          const SizedBox(width: Dimens.extraSmall)
        ],
      ),
    );
  }
}

class _BottomTitles extends StatelessWidget {
  const _BottomTitles({
    required this.value,
    required this.meta,
    required this.energyList,
  });

  final double value;
  final TitleMeta meta;
  final List<EnergyEntity> energyList;

  @override
  Widget build(BuildContext context) {
    final index = value.toInt() - 1;

    final text = DateFormat.Hm().format(energyList[index].timestamp);
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 2,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 10,
        ),
      ),
    );
  }
}
