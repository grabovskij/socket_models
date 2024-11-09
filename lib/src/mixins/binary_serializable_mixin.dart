import 'dart:convert';
import 'dart:typed_data';

import 'package:models/src/api/binary_serializer.dart';
import 'package:models/src/api/data_type.dart';
import 'package:models/src/extensions/data_type_extension.dart';
import 'package:models/src/message_codes.dart';

/// Вспомогательные методы для сериализации и десериализации
mixin BinarySerializableMixin {
  MessageCode get code;

  List<Object> get props;

  int get bytesLength {
    var count = 0;

    // MessageCode
    count += 2;

    for (final prop in props) {
      count += switch (prop.type) {
        DataType.int32 => DataType.int32.offset,
        DataType.string => 4 + utf8.encode((prop as String)).length,
        DataType.double32 => DataType.double32.offset,
      };
    }

    return count;
  }

  Uint8List serialize() {
    final serializer = BinarySerializer(bytesLength);

    serializer.writeInt16(code.index);

    for (final prop in props) {
      switch (prop.type) {
        case DataType.int32:
          serializer.writeInt32(prop as int);
          break;
        case DataType.string:
          serializer.writeString(prop as String);
          break;
        case DataType.double32:
          serializer.writeFloat32(prop as double);
          break;
      }
    }

    return serializer.toUint8List();
  }

  void writeString(BinarySerializer serializer, String value) {
    serializer.writeString(value);
  }

  String readString(BinarySerializer serializer) {
    return serializer.readString();
  }

  void writeInt32(BinarySerializer serializer, int value) {
    serializer.writeInt32(value);
  }

  int readInt32(BinarySerializer serializer) {
    return serializer.readInt32();
  }
}
