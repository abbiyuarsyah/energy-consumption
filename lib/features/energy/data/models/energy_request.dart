import 'package:json_annotation/json_annotation.dart';

import '../../../../core/enums/energy_type.dart';

part 'energy_request.g.dart';

@JsonSerializable()
class EnergyRequest {
  const EnergyRequest({required this.date, required this.type});

  final String date;
  final EnergyType type;

  Map<String, dynamic> toJson() => _$EnergyRequestToJson(this);
}
