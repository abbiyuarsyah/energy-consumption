import 'package:energy_consumption/core/enums/energy_type.dart';
import 'package:energy_consumption/features/energy/domain/entities/energy_entity.dart';
import 'package:equatable/equatable.dart';

class EnergyState extends Equatable {
  const EnergyState({
    required this.solar,
    required this.house,
    required this.battery,
    required this.minY,
    required this.maxY,
    required this.selectedType,
    required this.isWatts,
  });

  final List<EnergyEntity> solar;
  final List<EnergyEntity> house;
  final List<EnergyEntity> battery;
  final double minY;
  final double maxY;
  final EnergyType selectedType;
  final bool isWatts;

  EnergyState copyWith({
    List<EnergyEntity>? solar,
    List<EnergyEntity>? house,
    List<EnergyEntity>? battery,
    double? minY,
    double? maxY,
    double? interval,
    EnergyType? selectedType,
    bool? isWatts,
  }) {
    return EnergyState(
      solar: solar ?? this.solar,
      house: house ?? this.house,
      battery: battery ?? this.battery,
      minY: minY ?? this.minY,
      maxY: maxY ?? this.maxY,
      selectedType: selectedType ?? this.selectedType,
      isWatts: isWatts ?? this.isWatts,
    );
  }

  @override
  List<Object?> get props => [
        solar,
        house,
        battery,
        minY,
        maxY,
        selectedType,
        isWatts,
      ];
}
