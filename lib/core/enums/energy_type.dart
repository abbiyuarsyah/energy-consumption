import 'package:easy_localization/easy_localization.dart';

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
}
