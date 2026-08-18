part of 'imports_text.dart';

class CustomText extends StatelessWidget {
  //<editor-fold desc="Constructor Properties">
  final String label;
  final Color? color;
  final Color? backgroundColor;
  final double? fontSize;
  final double? letterSpacing;
  final bool isBold;
  final bool textShadow;
  final bool isUpperCase;
  final EdgeInsetsGeometry? padding;
  final bool isOverFlow;
  final int? maxLines;
  final double? textHeight;
  final CustomTextDecoration decoration;
  final String? fontFamily;
  final TextAlign? textAlign;
  final FW fontWeight;
  final bool isFontResponsive;
  final bool? isSoftWrap;

  const CustomText(
    this.label, {
    super.key,
    this.color,
    this.isSoftWrap,
    this.fontSize = 16,
    this.fontWeight = FW.regular,
    this.isBold = false,
    this.isOverFlow = false,
    this.isUpperCase = false,
    this.padding,
    this.maxLines,
    this.decoration = CustomTextDecoration.none,
    this.textHeight,
    this.fontFamily,
    this.textAlign,
    this.textShadow = false,
    this.backgroundColor,
    this.letterSpacing,
    this.isFontResponsive = false,
  });

  //</editor-fold>
  //<editor-fold desc="Subtitle text">
  /// Build Subtitle text
  factory CustomText.subtitle(
    String label, {
    required BuildContext context,
    Key? key,
    Color? color,
    Color? backgroundColor,
    bool isUpperCase = false,
    bool isBold = false,
    CustomTextDecoration decoration = CustomTextDecoration.none,
    double fontSize = 14.0,
    int? maxLines,
    bool isOverFlow = false,
    EdgeInsetsGeometry padding = EdgeInsets.zero,
    TextAlign? textAlign,
    FW fontWeight = FW.regular,
    bool isFontResponsive = true,
  }) => CustomText(
    label,
    decoration: decoration,
    key: key,
    isUpperCase: isUpperCase,
    backgroundColor: backgroundColor,
    // color: color ?? AppColors.get.lightText,
    color: color ?? context.color.descriptionColorDark,
    fontSize: fontSize,
    fontWeight: fontWeight,
    isOverFlow: isOverFlow,
    isBold: isBold,
    padding: padding,
    textAlign: textAlign,
    maxLines: maxLines,
    isFontResponsive: isFontResponsive,
  );

  //</editor-fold>
  //<editor-fold desc="Light text">

  factory CustomText.light(
    String label, {
    required BuildContext context,
    Key? key,
    Color? color,
    Color? backgroundColor,
    bool isUpperCase = false,
    bool isBold = false,
    CustomTextDecoration decoration = CustomTextDecoration.none,
    double fontSize = 12.0,
    int? maxLines,
    bool isOverFlow = false,
    EdgeInsetsGeometry padding = EdgeInsets.zero,
    TextAlign? textAlign,
    FW fontWeight = FW.light,
    bool isFontResponsive = false,
  }) => CustomText(
    label,
    decoration: decoration,
    key: key,
    isUpperCase: isUpperCase,
    backgroundColor: backgroundColor,
    color: color ?? context.color.descriptionColorDark,
    fontSize: fontSize,
    fontWeight: fontWeight,
    isOverFlow: isOverFlow,
    isBold: isBold,
    padding: padding,
    textAlign: textAlign,
    maxLines: maxLines,
    isFontResponsive: isFontResponsive,
  );

  //</editor-fold>
  //<editor-fold desc="Header text">
  /// Build Header text
  factory CustomText.header(
    String label, {
    required BuildContext context,
    Key? key,
    double fontSize = 25.0,
    FW fontWeight = FW.semiBold,
    Color? color,
    Color? backgroundColor,
    bool isUpperCase = false,
    bool isBold = false,
    CustomTextDecoration decoration = CustomTextDecoration.none,
    int? maxLines,
    bool isOverFlow = false,
    EdgeInsetsGeometry padding = EdgeInsets.zero,
    TextAlign? textAlign,
    bool isFontResponsive = true,
  }) => CustomText(
    label,
    decoration: decoration,
    key: key,
    isUpperCase: isUpperCase,
    // color: color ?? AppColors.get.primary,
    color: color ?? context.color.primaryColor,
    backgroundColor: backgroundColor,
    fontSize: fontSize,
    fontWeight: fontWeight,
    isOverFlow: isOverFlow,
    isBold: isBold,
    padding: padding,
    textAlign: textAlign,
    maxLines: maxLines,
    isFontResponsive: isFontResponsive,
  );

  //</editor-fold>

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Text(
        label,
        // customTextLabel(label: label, isUpperCase: isUpperCase),
        softWrap: isSoftWrap,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: color,
          backgroundColor: backgroundColor,
          // fontSize: (AppLayout.isPortrait(context: context)?(fontSize ?? 16):(fontSize ?? 16)/1.8).toFS(context),
          //TODO: We need to remove factor number under this todo
          fontSize:
              ((fontSize ?? 16).toFS(
                context,
                isResponsive: isFontResponsive,
              ))! *
              1.1,
          fontWeight: customTextFw(fontWeight),
          decoration: customTextDecoration(decoration),
          //TextDecoration.combine(decorations),
          height: textHeight,
          letterSpacing: letterSpacing,
          // fontFamily: fontFamily ?? AppInfoKeys.fontFamily,
          fontFamily: fontFamily,
          shadows:
              textShadow
                  ? [
                    Shadow(
                      blurRadius: 0.8.toRad(),
                      color: Colors.black,
                      offset: const Offset(1, 1),
                    ),
                  ]
                  : null,
        ),
        textAlign: textAlign,
        overflow: isOverFlow ? TextOverflow.ellipsis : null,
        maxLines: maxLines,
      ),
    );
  }
}
