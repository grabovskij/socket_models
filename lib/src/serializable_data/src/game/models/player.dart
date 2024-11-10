part of '../../../serializable_data.dart';

class Player extends SerializableData {
  final int id;
  final String login;

  Player({
    required this.id,
    required this.login,
  });

  factory Player.fromBytes(Uint8List bytes) {
    final BinarySerializer serializer = BinarySerializer.fromUint8List(bytes);

    final messageCodeIndex = serializer.readInt16();

    final id = serializer.readInt32();
    final login = serializer.readString();

    return Player(
      id: id,
      login: login,
    );
  }

  @override
  MessageCode get code {
    return MessageCode.player;
  }

  @override
  List<Object> get props {
    return [
      id,
      login,
    ];
  }

  @override
  String toString() {
    return 'Player(id: $id, login: $login)';
  }
}
