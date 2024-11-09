part of '../../serializable_data.dart';

class JoinRequestData extends SerializableData {
  @override
  final MessageCode code = MessageCode.joinRequest;

  final String login;

  final String pass;

  factory JoinRequestData.fromBytes(Uint8List bytes) {
    final BinarySerializer serializer = BinarySerializer.fromUint8List(bytes);

    final messageCodeIndex = serializer.readInt16();

    final login = serializer.readString();
    final pass = serializer.readString();

    return JoinRequestData(
      login: login,
      pass: pass,
    );
  }

  JoinRequestData({
    required this.login,
    required this.pass,
  });

  @override
  List<Object> get props {
    return [
      login,
      pass,
    ];
  }

  @override
  String toString() {
    return 'JoinRequest(login: $login, pass: $pass)';
  }
}
