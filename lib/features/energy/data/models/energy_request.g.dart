// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'energy_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EnergyRequest _$EnergyRequestFromJson(Map<String, dynamic> json) =>
    EnergyRequest(
      date: json['date'] as String,
      type: $enumDecode(_$EnergyTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$EnergyRequestToJson(EnergyRequest instance) =>
    <String, dynamic>{
      'date': instance.date,
      'type': _$EnergyTypeEnumMap[instance.type]!,
    };

const _$EnergyTypeEnumMap = {
  EnergyType.solar: 'solar',
  EnergyType.house: 'house',
  EnergyType.battery: 'battery',
};
