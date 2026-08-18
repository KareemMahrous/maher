part of 'imports_text_options.dart';

/// returns in debug mode

Map<String, String> get _langMap => {};

String customTextLabel({required String label, required bool isUpperCase}) {
  final String labelText =
      isUpperCase ? label.toUpperCase().toTr() : label.toTr();
  if (_langMap.isEmpty && kDebugMode) {
    return labelText.replaceAll("_", "");
  } else {
    return labelText;
  }
}
