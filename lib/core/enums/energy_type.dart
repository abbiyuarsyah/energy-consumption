import 'package:easy_localization/easy_localization.dart';
import 'package:energy_consumption/features/energy/domain/entities/energy_entity.dart';

import '../../features/energy/presentation/bloc/energy_state.dart';

enum EnergyType {
  solar,
  house,
  battery;

  String get getEnergyString {
    switch (this) {
      case EnergyType.solar:
        return tr('solar');
      case EnergyType.house:
        return tr('house');
      case EnergyType.battery:
        return tr('battery');
      default:
        return '';
    }
  }

  List<EnergyEntity> getData(EnergyState energyState) {
    switch (this) {
      case EnergyType.solar:
        return energyState.solar;
      case EnergyType.house:
        return energyState.house;
      case EnergyType.battery:
        return energyState.battery;
      default:
        return [];
    }
  }
}
