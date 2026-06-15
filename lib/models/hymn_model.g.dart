// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hymn_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HymnModelAdapter extends TypeAdapter<HymnModel> {
  @override
  final int typeId = 0;

  @override
  HymnModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HymnModel(
      id: fields[0] as String,
      title: fields[1] as String,
      lyrics: fields[2] as String,
      sr: fields[3] as int?,
      year: fields[4] as int?,
      page: fields[5] as int?,
      key: fields[6] as String?,
      tempo: fields[7] as int?,
      style: fields[8] as String?,
      dedicated: fields[9] as String?,
      majMin: fields[10] as String?,
      chords: fields[11] as String?,
      createdAt: fields[12] as DateTime?,
      updatedAt: fields[13] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, HymnModel obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.lyrics)
      ..writeByte(3)
      ..write(obj.sr)
      ..writeByte(4)
      ..write(obj.year)
      ..writeByte(5)
      ..write(obj.page)
      ..writeByte(6)
      ..write(obj.key)
      ..writeByte(7)
      ..write(obj.tempo)
      ..writeByte(8)
      ..write(obj.style)
      ..writeByte(9)
      ..write(obj.dedicated)
      ..writeByte(10)
      ..write(obj.majMin)
      ..writeByte(11)
      ..write(obj.chords)
      ..writeByte(12)
      ..write(obj.createdAt)
      ..writeByte(13)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HymnModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
