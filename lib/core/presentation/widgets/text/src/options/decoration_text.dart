part of 'imports_text_options.dart';

TextDecoration  customTextDecoration(CustomTextDecoration decoration) {
  switch (decoration) {
    case CustomTextDecoration.none:
      return TextDecoration.none;
    case CustomTextDecoration.lineThrough:
      return TextDecoration.lineThrough;
    case CustomTextDecoration.underLine:
      return TextDecoration.underline;
    case CustomTextDecoration.overLine:
      return TextDecoration.overline;

  }
}
