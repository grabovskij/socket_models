part of '../../../serializable_data.dart';

class GameSnapshot extends SerializableData {
  final List<Player> players;
  final Battlefield battlefield;
  final Player activePlayer;

  GameSnapshot({
    required this.players,
    required this.battlefield,
    required this.activePlayer,
  });

  factory GameSnapshot.fromBytes(Uint8List bytes) {
    final BinarySerializer serializer = BinarySerializer.fromUint8List(bytes);
    final messageCodeIndex = serializer.readInt16();
    final playersLength = serializer.readInt32();

    List<Player> players = [];

    for (var i = 0; i < playersLength; i++) {
      final playerBytesLength = serializer.readInt32();
      final playerBytes = serializer.readBytes(playerBytesLength);
      final player = Player.fromBytes(playerBytes);

      players.add(player);
    }

    // Battlefield
    final battlefieldBytesLength = serializer.readInt32();
    final battlefieldBytes = serializer.readBytes(battlefieldBytesLength);
    final battlefield = Battlefield.fromBytes(battlefieldBytes);

    // Active player
    final activePlayerBytesLength = serializer.readInt32();
    final activePlayerBytes = serializer.readBytes(activePlayerBytesLength);
    final activePlayer = Player.fromBytes(activePlayerBytes);

    return GameSnapshot(
      players: players,
      battlefield: battlefield,
      activePlayer: activePlayer,
    );
  }

  @override
  MessageCode get code => MessageCode.gameSnapshot;

  @override
  List<Object> get props => [];

  @override
  int get bytesLength {
    var count = 0;

    // MessageCode
    count += 2;

    // Players Length
    count += 4;

    for (final player in players) {
      // Model size
      count += 4;
      // Model bytes
      count += player.bytesLength;
    }

    // Battlefield bytes length
    count += 4;

    // Battlefield bytes
    count += battlefield.bytesLength;

    // Active player bytes length
    count += 4;

    // Active player bytes
    count += activePlayer.bytesLength;

    return count;
  }

  @override
  Uint8List serialize() {
    final serializer = BinarySerializer(bytesLength);

    // Message code
    serializer.writeInt16(code.index);

    // Players length
    serializer.writeInt32(players.length);

    for (final player in players) {
      final playerBytes = player.serialize();
      serializer.writeInt32(playerBytes.lengthInBytes);
      serializer.writeBytes(playerBytes);
    }

    final battlefieldBytes = battlefield.serialize();

    // Battlefield bytes length
    serializer.writeInt32(battlefieldBytes.length);
    serializer.writeBytes(battlefieldBytes);

    // Active player
    final activePlayerBytes = activePlayer.serialize();
    serializer.writeInt32(activePlayerBytes.lengthInBytes);
    serializer.writeBytes(activePlayerBytes);

    return serializer.toUint8List();
  }

  @override
  String toString() {
    return 'GameSnapshot(activePlayer: $activePlayer, players: $players, battlefield: $battlefield)';
  }
}
