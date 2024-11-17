import 'package:energy_consumption/core/enums/energy_type.dart';

abstract class EnergyEvent {
  const EnergyEvent();
}

class GetEnergyEvent extends EnergyEvent {
  const GetEnergyEvent({required this.date, required this.type});

  final String date;
  final EnergyType type;
}

class SelectEnergyTypeEvent extends EnergyEvent {
  const SelectEnergyTypeEvent({required this.type});

  final EnergyType type;
}
