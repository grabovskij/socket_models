import 'package:models/src/api/data_type.dart';

extension DataTypeExtension on Object {
  DataType get type {
    final object = this;

    if (object is int) {
      return DataType.int32;
    }

    if (object is String) {
      return DataType.string;
    }

    if (object is double) {
      return DataType.double32;
    }

    throw Exception('Unsupported type');
  }
}
