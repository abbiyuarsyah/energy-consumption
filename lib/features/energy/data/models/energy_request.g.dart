// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'energy_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EnergyRequest _$EnergyRequestFromJson(Map<String, dynamic> json) =>
    EnergyRequest(
      date: json['date'] as String,
      type: json['type'] as String,
    );

Map<String, dynamic> _$EnergyRequestToJson(EnergyRequest instance) =>
    <String, dynamic>{
      'date': instance.date,
      'type': instance.type,
    };
