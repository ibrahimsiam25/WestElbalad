// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_informations_entites.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserInformationsEntityAdapter
    extends TypeAdapter<UserInformationsEntity> {
  @override
  final int typeId = 0;

  @override
  UserInformationsEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserInformationsEntity(
      name: fields[0] as String,
      email: fields[1] as String,
      uId: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UserInformationsEntity obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.uId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserInformationsEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
