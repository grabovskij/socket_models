import 'dart:typed_data';

import 'package:models/src/api/binary_serializer.dart';
import 'package:models/src/message_codes.dart';
import 'package:models/src/mixins/binary_serializable_mixin.dart';

part 'src/connection/join_request.dart';
part 'src/connection/join_success_response.dart';

sealed class SerializableData with BinarySerializableMixin {
  static SerializableData fromBytes(Uint8List bytes) {
    final serializer = BinarySerializer.fromUint8List(bytes);
    final typeIndex = serializer.readInt16();
    final MessageCode typeMessageData;

    try {
      typeMessageData = MessageCode.values[typeIndex];
    } on Object {
      throw Exception('Unsupported type for deserialization.');
    }

    return switch (typeMessageData) {
      MessageCode.joinRequest => JoinRequestData.fromBytes(bytes),
      MessageCode.successJoinResponse => JoinSuccessResponseData.fromBytes(bytes),
    };
  }
}
