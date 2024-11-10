import 'dart:typed_data';

import 'package:models/src/api/binary_serializer.dart';
import 'package:models/src/message_codes.dart';
import 'package:models/src/mixins/binary_serializable_mixin.dart';
import 'package:models/src/serializable_data/src/game/enums/mark_type.dart';

part 'src/connection/join_request.dart';

part 'src/connection/join_success_response.dart';

// Game entities
part 'src/game/models/player.dart';

part 'src/game/models/mark.dart';

part 'src/game/models/battlefield.dart';

part 'src/game/models/game_snapshot.dart';

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
      MessageCode.player => Player.fromBytes(bytes),
      MessageCode.mark => Mark.fromBytes(bytes),
      MessageCode.battlefield => Battlefield.fromBytes(bytes),
      MessageCode.gameSnapshot => GameSnapshot.fromBytes(bytes),
    };
  }
}
