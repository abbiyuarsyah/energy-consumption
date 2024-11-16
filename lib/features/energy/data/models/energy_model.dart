import 'package:json_annotation/json_annotation.dart';
part 'energy_model.g.dart';

@JsonSerializable()
class EnergyModel {
  const EnergyModel(this.timestamp, this.value);

  final DateTime? timestamp;
  final int? value;

  factory EnergyModel.fromJson(Map<String, dynamic> json) =>
      _$EnergyModelFromJson(json);

  Map<String, dynamic> toJson() => _$EnergyModelToJson(this);
}
