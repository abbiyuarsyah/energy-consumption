import 'package:hive/hive.dart';

part 'energy_local_model.g.dart';

@HiveType(typeId: 1)
class EnergyLocalModel {
  const EnergyLocalModel({
    required this.id,
    required this.timestamp,
    required this.value,
    required this.type,
  });

  static const String boxName = 'EnergyLocalModel';

  @HiveField(0)
  final String id;

  @HiveField(1)
  final DateTime timestamp;

  @HiveField(2)
  final int value;

  @HiveField(3)
  final String type;

  factory EnergyLocalModel.empty() {
    return EnergyLocalModel(
      id: '',
      timestamp: DateTime.now(),
      value: 0,
      type: '',
    );
  }
}
