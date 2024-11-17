import 'package:energy_consumption/core/enums/energy_type.dart';

abstract class EnergyEvent {
  const EnergyEvent();
}

class GetEnergyEvent extends EnergyEvent {
  const GetEnergyEvent({required this.date});

  final String date;
}

class SelectEnergyTypeEvent extends EnergyEvent {
  const SelectEnergyTypeEvent({required this.type});

  final EnergyType type;
}

class SwitchUnitEvent extends EnergyEvent {
  const SwitchUnitEvent({required this.isKiloWatts});

  final bool isKiloWatts;
}

class SelectValueEvent extends EnergyEvent {
  const SelectValueEvent({required this.selectedIndex});

  final int selectedIndex;
}

class SelectDateEvent extends EnergyEvent {
  const SelectDateEvent({required this.selectedDate});

  final DateTime selectedDate;
}
