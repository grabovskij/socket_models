enum DataType {
  int32(tag: 0x01, offset: 4),
  string(tag: 0x02, offset: 0),
  double32(tag: 0x03, offset: 4);

  final int tag;
  final int offset;

  const DataType({
    required this.tag,
    required this.offset,
  });
}
