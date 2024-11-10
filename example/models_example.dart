import 'package:models/models.dart';
import 'package:models/src/serializable_data/src/game/enums/mark_type.dart';

void main() {
  final gameSnapshot1 = GameSnapshot(
    players: [
      Player(id: 0, login: 'Leonid'),
      Player(id: 1, login: 'ASasdas'),
    ],
    activePlayer: Player(id: 0, login: 'Leonid'),
    battlefield: Battlefield(
      rows: 2,
      columns: 2,
      marks: [
        Mark(markType: MarkType.none, playerId: 123),
        Mark(markType: MarkType.x, playerId: 312),
        Mark(markType: MarkType.o, playerId: 123),
        Mark(markType: MarkType.none, playerId: 312),
      ],
    ),
  );

  final bytes = gameSnapshot1.serialize();

  print('Bytes: ${bytes.lengthInBytes}');

  final gameSnapshot2 = GameSnapshot.fromBytes(bytes);

  print(gameSnapshot2);
  print(gameSnapshot2);
}
