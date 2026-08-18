part of 'imports_text_options.dart';

FontWeight customTextFw(FW fw) {
  FontWeight fontWeight;
  switch (fw) {
    case FW.heavy:
      fontWeight = FontWeight.w900;
    case FW.bold:
      fontWeight = FontWeight.bold;
    case FW.semiBold:
      fontWeight = FontWeight.w700;
    case FW.normal:
      fontWeight = FontWeight.normal;
    case FW.medium:
      fontWeight = FontWeight.w500;
    case FW.regular:
      fontWeight = FontWeight.w400;
    case FW.light:
      fontWeight = FontWeight.w300;
    case FW.extraLight:
      fontWeight = FontWeight.w200;
    case FW.thin:
      fontWeight = FontWeight.w100;
    case FW.demi:
      fontWeight = FontWeight.w400;
    case FW.extraBold:
      fontWeight = FontWeight.w900;
  }
  return fontWeight;
}
