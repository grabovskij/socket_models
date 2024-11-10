part of '../../../serializable_data.dart';

class Mark extends SerializableData {
  final MarkType markType;
  final int playerId;

  Mark({
    required this.markType,
    required this.playerId,
  });

  factory Mark.fromBytes(Uint8List bytes) {
    final BinarySerializer serializer = BinarySerializer.fromUint8List(bytes);

    final messageCodeIndex = serializer.readInt16();

    final markTypeIndex = serializer.readInt32();
    final playerId = serializer.readInt32();

    return Mark(
      markType: MarkType.values[markTypeIndex],
      playerId: playerId,
    );
  }

  @override
  MessageCode get code {
    return MessageCode.mark;
  }

  @override
  List<Object> get props {
    return [
      markType.index,
      playerId,
    ];
  }

  @override
  String toString() {
    return 'Mark(markType: $markType, playerId: $playerId)';
  }
}
