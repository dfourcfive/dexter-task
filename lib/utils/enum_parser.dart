import 'package:collection/collection.dart' show IterableExtension;
import 'package:flutter/foundation.dart';

String? enumToString(Object? obj) {
  if (obj == null) {
    return null;
  }

  return describeEnum(obj);
}

// only to be used internally by amplify-flutter library
T? enumFromString<T>(String? key, List<T> values) => values.firstWhereOrNull((v) => key == enumToString(v));

/// check whether an dynamic type [value] is an enum
bool isEnum(dynamic value) {
  final split = value.toString().split('.');
  return split.length > 1 && split[0] == value.runtimeType.toString();
}
