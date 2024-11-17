// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'energy_local_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EnergyLocalModelAdapter extends TypeAdapter<EnergyLocalModel> {
  @override
  final int typeId = 1;

  @override
  EnergyLocalModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EnergyLocalModel(
      id: fields[0] as int,
      timestamp: fields[1] as DateTime,
      value: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, EnergyLocalModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.timestamp)
      ..writeByte(2)
      ..write(obj.value);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EnergyLocalModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
