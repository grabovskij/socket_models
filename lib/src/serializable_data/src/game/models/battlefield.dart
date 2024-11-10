part of '../../../serializable_data.dart';

class Battlefield extends SerializableData {
  final int rows;
  final int columns;
  final List<Mark> marks;

  Battlefield({
    required this.rows,
    required this.columns,
    required this.marks,
  });

  factory Battlefield.fromBytes(Uint8List bytes) {
    final BinarySerializer serializer = BinarySerializer.fromUint8List(bytes);
    final messageCodeIndex = serializer.readInt16();
    final rows = serializer.readInt32();
    final columns = serializer.readInt32();
    final marksLength = serializer.readInt32();

    List<Mark> marks = [];

    for (var i = 0; i < marksLength; i++) {
      final markBytesLength = serializer.readInt32();
      final markBytes = serializer.readBytes(markBytesLength);

      marks.add(Mark.fromBytes(markBytes));
    }

    return Battlefield(
      rows: rows,
      columns: columns,
      marks: marks,
    );
  }

  @override
  MessageCode get code {
    return MessageCode.battlefield;
  }

  @override
  List<Object> get props => [];

  @override
  int get bytesLength {
    var count = 0;

    // MessageCode
    count += 2;

    // Row
    count += 4;

    // Columns
    count += 4;

    // Marks length
    count += 4;

    for (final mark in marks) {
      // Model size
      count += 4;
      // Model bytes
      count += mark.bytesLength;
    }

    return count;
  }

  Mark getMark({
    required int x,
    required int y,
  }) {
    final index = (columns - 1) * y + x;

    return marks[index];
  }

  Battlefield changeMark({
    required int x,
    required int y,
    required Mark mark,
  }) {
    final index = (columns - 1) * y + x;
    final marksCopy = [...marks];

    return Battlefield(
      rows: rows,
      columns: columns,
      marks: marksCopy..[index] = mark,
    );
  }

  @override
  Uint8List serialize() {
    final serializer = BinarySerializer(bytesLength);

    // Message code
    serializer.writeInt16(code.index);

    // Rows
    serializer.writeInt32(rows);

    // Columns
    serializer.writeInt32(columns);

    // Marks length
    serializer.writeInt32(marks.length);

    for (final mark in marks) {
      final markBytes = mark.serialize();
      serializer.writeInt32(markBytes.lengthInBytes);
      serializer.writeBytes(markBytes);
    }

    return serializer.toUint8List();
  }

  @override
  String toString() {
    return 'Battlefield(rows: $rows, columns: $columns, marks: $marks)';
  }
}
