import 'dart:convert';
import 'dart:typed_data';

class BinarySerializer {
  ByteData byteData;
  int _offset = 0;

  BinarySerializer(int length) : byteData = ByteData(length);

  BinarySerializer.fromUint8List(Uint8List uint8List) : byteData = ByteData.sublistView(uint8List);

  void writeBytes(Uint8List bytes) {
    for (final byte in bytes) {
      byteData.setUint8(_offset, byte);
      _offset += 1;
    }
  }

  Uint8List readBytes(int length) {
    Uint8List data = Uint8List(length);

    for (var i = 0; i < length; i++) {
      data[i] = (byteData.getUint8(_offset));
      _offset += 1;
    }

    return data.buffer.asUint8List();
  }

  void writeInt8(int value) {
    byteData.setInt8(_offset, value);
    _offset += 1;
  }

  int readInt8() {
    final value = byteData.getInt8(_offset);
    _offset += 1;
    return value;
  }

  void writeUnt8(int value) {
    byteData.setUint8(_offset, value);
    _offset += 1;
  }

  int readUnt8() {
    final value = byteData.getUint8(_offset);
    _offset += 1;
    return value;
  }

  void writeInt16(int value, [Endian endian = Endian.little]) {
    byteData.setInt16(_offset, value, endian);
    _offset += 2;
  }

  int readInt16([Endian endian = Endian.little]) {
    final value = byteData.getInt16(_offset, endian);
    _offset += 2;
    return value;
  }

  void writeInt32(int value, [Endian endian = Endian.little]) {
    byteData.setInt32(_offset, value, endian);
    _offset += 4;
  }

  int readInt32([Endian endian = Endian.little]) {
    final value = byteData.getInt32(_offset, endian);
    _offset += 4;
    return value;
  }

  void writeFloat32(double value, [Endian endian = Endian.little]) {
    byteData.setFloat32(_offset, value, endian);
    _offset += 4;
  }

  double readFloat32([Endian endian = Endian.little]) {
    final value = byteData.getFloat32(_offset, endian);
    _offset += 4;
    return value;
  }

  void writeString(String value) {
    final encoded = utf8.encode(value);
    writeInt32(encoded.length); // Записываем длину строки
    byteData.buffer.asUint8List().setRange(_offset, _offset + encoded.length, encoded);
    _offset += encoded.length;
  }

  String readString() {
    final length = readInt32(); // Читаем длину строки
    final stringBytes = byteData.buffer.asUint8List(_offset, length);
    _offset += length;
    return utf8.decode(stringBytes);
  }

  Uint8List toUint8List() => byteData.buffer.asUint8List();
}
