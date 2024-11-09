part of '../../serializable_data.dart';

class JoinSuccessResponseData extends SerializableData {
  @override
  final MessageCode code = MessageCode.successJoinResponse;

  final int connectionId;
  final String login;

  factory JoinSuccessResponseData.fromBytes(Uint8List bytes) {
    final BinarySerializer serializer = BinarySerializer.fromUint8List(bytes);

    final messageCodeIndex = serializer.readInt16();

    final id = serializer.readInt32();
    final login = serializer.readString();

    return JoinSuccessResponseData(
      connectionId: id,
      login: login,
    );
  }

  JoinSuccessResponseData({
    required this.connectionId,
    required this.login,
  });

  @override
  List<Object> get props {
    return [
      connectionId,
      login,
    ];
  }

  @override
  String toString() {
    return 'JoinSuccessResponseData(id: $connectionId, login: $login)';
  }
}
