part of 'imports_text.dart';

class CustomRichText extends StatelessWidget {
  final String label;
  final Color? color;
  final Color? backgroundColor;
  final double? fontSize;
  final bool isBold;
  final bool textShadow;
  final bool isUpperCase;
  final EdgeInsetsGeometry? padding;
  final bool isOverFlow;
  final int? maxLines;
  final double? textHeight;
  final CustomTextDecoration decoration;
  final String? fontFamily;
  final TextAlign textAlign;
  final FW fontWeight;

  const CustomRichText(
    this.label, {
    super.key,
    this.color,
    this.fontSize = 14,
    this.fontWeight = FW.regular,
    this.isBold = false,
    this.isOverFlow = false,
    this.isUpperCase = false,
    this.padding,
    this.maxLines,
    this.decoration = CustomTextDecoration.none,
    this.textHeight,
    this.fontFamily,
    this.textAlign = TextAlign.center,
    this.textShadow = false,
    this.backgroundColor,
  });

  /// Build Subtitle text

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: RichText(
        textAlign: textAlign,
        overflow: isOverFlow ? TextOverflow.ellipsis : TextOverflow.clip,
        maxLines: maxLines,
        text: TextSpan(
          text: isUpperCase ? label.toUpperCase().toTr() : label.toTr(),
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: color,
            backgroundColor: backgroundColor,
            fontSize: (fontSize ?? 16).toFS(context),
            fontWeight:
                isBold ? customTextFw(FW.bold) : customTextFw(fontWeight),
            decoration: customTextDecoration(decoration),
            //TextDecoration.combine(decorations),
            height: textHeight,
            fontFamily: fontFamily ?? fontFamily,
            shadows:
                textShadow
                    ? [
                      const Shadow(
                        blurRadius: 0.8,
                        color: Colors.black,
                        offset: Offset(1, 1),
                      ),
                    ]
                    : null,
          ),
          children: [
            const TextSpan(text: ' '),
            TextSpan(
              text: '*',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.red,
                backgroundColor: backgroundColor,
                fontSize: (fontSize ?? 16).toFS(context),
                fontWeight:
                    isBold ? customTextFw(FW.bold) : customTextFw(fontWeight),
                decoration: customTextDecoration(decoration),
                //TextDecoration.combine(decorations),
                height: textHeight,

                fontFamily: fontFamily ?? fontFamily,
                shadows:
                    textShadow
                        ? [
                          const Shadow(
                            blurRadius: 0.8,
                            color: Colors.black,
                            offset: Offset(1, 1),
                          ),
                        ]
                        : null,
              ),
            ),
          ],
        ),
      ),
      // text(
      //   isUpperCase ? label.toUpperCase().toTr() : label.toTr(),
      //   textScaleFactor: 1,
      //   style: Theme.of(context).textTheme.bodyText2?.copyWith(
      //     color: color,
      //     backgroundColor: backgroundColor,
      //     fontSize: (fontSize ?? 16).sp,
      //     fontWeight: isBold ?
      // CustomTextFw(FW.bold) : CustomTextFw(fontWeight),
      //     decoration: CustomTextTextDecoration(decoration),
      //     //TextDecoration.combine(decorations),
      //     height: textHeight,
      //
      //     fontFamily: fontFamily ?? fontFamily,
      //     shadows: textShadow
      //         ? [
      //       const Shadow(
      //         blurRadius: 0.8,
      //         color: Colors.black,
      //         offset: Offset(1, 1),
      //       )
      //     ]
      //         : null,
      //   ),
      //   textAlign: textAlign,
      //   overflow: isOverFlow ? TextOverflow.ellipsis : null,
      //   maxLines: maxLines,
      // ),
    );
  }
}
