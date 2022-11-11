// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repost.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RepostAdapter extends TypeAdapter<Repost> {
  @override
  final int typeId = 3;

  @override
  Repost read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Repost(
      repostDate: fields[0] as DateTime,
      assignedToUser: (fields[1] as HiveList).castHiveList(),
      relatedPost: (fields[2] as HiveList).castHiveList(),
    );
  }

  @override
  void write(BinaryWriter writer, Repost obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.repostDate)
      ..writeByte(1)
      ..write(obj.assignedToUser)
      ..writeByte(2)
      ..write(obj.relatedPost);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RepostAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
