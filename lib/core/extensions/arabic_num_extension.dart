library;

/// depends on Localization service localization
class _ArabicNumbers {


  // --------------------------------- Arabic --------------------------------

  static String convert(Object value) {
    assert(
    value is int || value is String,
    "The value object must be of type 'int' or 'String'.",
    );

    if (value is int) {
      return _toArabicNumbers(value.toString());
    } else {
      return _toArabicNumbers(value as String);
    }
  }

  static String _toArabicNumbers(String value) {
    return value
        .replaceAll('0', '٠')
        .replaceAll('1', '١')
        .replaceAll('2', '٢')
        .replaceAll('3', '٣')
        .replaceAll('4', '٤')
        .replaceAll('5', '٥')
        .replaceAll('6', '٦')
        .replaceAll('7', '٧')
        .replaceAll('8', '٨')
        .replaceAll('9', '٩');
  }


  // --------------------------------- Adaptive --------------------------------

  static String adaptiveConvert(Object value) {
    assert(
    value is int || value is String,
    "The value object must be of type 'int' or 'String'.",
    );

    if (value is int) {
      return _toAdaptiveNumbers(value.toString());
    } else {
      return _toAdaptiveNumbers(value as String);
    }
  }
  static String _toAdaptiveNumbers(String value) {

    if (0==0){
      return value
          .replaceAll('0', '٠')
          .replaceAll('1', '١')
          .replaceAll('2', '٢')
          .replaceAll('3', '٣')
          .replaceAll('4', '٤')
          .replaceAll('5', '٥')
          .replaceAll('6', '٦')
          .replaceAll('7', '٧')
          .replaceAll('8', '٨')
          .replaceAll('9', '٩');
    }
    else {
      return value;
    }
  }
}

extension  IntConveter on int {
  /// Converts English numbers to the Arabic numbers format
  ///
  ///
  /// Example:
  /// ```dart
  /// final arabicNumbers = 0123456789.toArabicNumbers;
  /// // result: ٠١٢٣٤٥٦٧٨٩
  /// ```
  String get arN {
    return _ArabicNumbers.convert(this);
  }
  /// returns arabic or english numbers depending on locale [ar] or [en]
  String get adN {
    return _ArabicNumbers.adaptiveConvert(this);
  }

}
extension StringConverter on String {
  /// Converts English numbers to the Arabic numbers format
  ///
  ///
  /// Example:
  /// ```dart
  /// final arabicNumbers = '0123456789'.toArabicNumbers;
  /// // result: ٠١٢٣٤٥٦٧٨٩
  /// ```
  String get arN {
    return _ArabicNumbers.convert(this);
  }
  String get adN {
    return _ArabicNumbers.adaptiveConvert(this);
  }
}