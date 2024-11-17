import 'package:hive/hive.dart';

part 'energy_local_model.g.dart';

@HiveType(typeId: 1)
class EnergyLocalModel {
  const EnergyLocalModel({
    required this.id,
    required this.timestamp,
    required this.value,
  });

  static const String boxName = 'EnergyLocalModel';

  @HiveField(0)
  final int id;

  @HiveField(1)
  final DateTime timestamp;

  @HiveField(2)
  final int value;

  factory EnergyLocalModel.empty() {
    return EnergyLocalModel(
      id: 0,
      timestamp: DateTime.now(),
      value: 0,
    );
  }
}
