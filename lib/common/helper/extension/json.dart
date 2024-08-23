extension JsonX on Map<String, dynamic> {
  String? tryParseString(String key) {
    return this[key] as String?;
  }

  String parseString(String key) {
    return tryParseString(key) ?? '';
  }

  int? tryParseInt(String key) {
    return this[key] as int?;
  }

  int parseInt(String key) {
    return tryParseInt(key) ?? 0;
  }

  double? tryParseDouble(String key) {
     final value = this[key];
     if (value is double) {
    return value;
      } else if (value is int) {
    return value.toDouble();
      } else if (value is String) {
    return double.tryParse(value);
        } else {
       return null;
       }
  }

  double parseDouble(String key) {
    return tryParseDouble(key) ?? 0.0;
  }

  bool? tryParseBool(String key) {
    return this[key] as bool?;
  }

  bool parseBool(String key) {
    return tryParseBool(key) ?? false;
  }

  DateTime? tryParseDateTime(String key) {
    return DateTime.tryParse(parseString(key));
  }

  DateTime parseDateTime(String key) {
    return tryParseDateTime(key) ?? DateTime.fromMicrosecondsSinceEpoch(0);
  }
}
