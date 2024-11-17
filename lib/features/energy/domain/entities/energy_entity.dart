class EnergyEntity {
  const EnergyEntity({required this.timestamp, required this.value});

  final DateTime timestamp;
  final int value;

  factory EnergyEntity.init() {
    return EnergyEntity(timestamp: DateTime.now(), value: 0);
  }
}
