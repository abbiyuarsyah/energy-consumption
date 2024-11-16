// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'energy_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EnergyModel _$EnergyModelFromJson(Map<String, dynamic> json) => EnergyModel(
      json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String),
      (json['value'] as num?)?.toInt(),
    );

Map<String, dynamic> _$EnergyModelToJson(EnergyModel instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp?.toIso8601String(),
      'value': instance.value,
    };
