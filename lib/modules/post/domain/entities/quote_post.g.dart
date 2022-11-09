// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quote_post.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuotePostAdapter extends TypeAdapter<QuotePost> {
  @override
  final int typeId = 4;

  @override
  QuotePost read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QuotePost(
      quotePostDate: fields[0] as String,
      assignedToUser: (fields[1] as HiveList).castHiveList(),
      comment: fields[2] as String,
      relatedPost: (fields[3] as HiveList).castHiveList(),
    );
  }

  @override
  void write(BinaryWriter writer, QuotePost obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.quotePostDate)
      ..writeByte(1)
      ..write(obj.assignedToUser)
      ..writeByte(2)
      ..write(obj.comment)
      ..writeByte(3)
      ..write(obj.relatedPost);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuotePostAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
