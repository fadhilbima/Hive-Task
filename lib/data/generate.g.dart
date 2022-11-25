// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generate.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveTypeDataAdapter extends TypeAdapter<HiveTypeData> {
  @override
  final int typeId = 1;

  @override
  HiveTypeData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveTypeData(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, HiveTypeData obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.author)
      ..writeByte(2)
      ..write(obj.content);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveTypeDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
