// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_task.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveTaskAdapter extends TypeAdapter<HiveTask> {
  @override
  final int typeId = 1;

  @override
  HiveTask read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveTask(
      fields[0] as String,
      fields[1] as String,
      fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, HiveTask obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.desc)
      ..writeByte(2)
      ..write(obj.isCompleted);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveTaskAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}