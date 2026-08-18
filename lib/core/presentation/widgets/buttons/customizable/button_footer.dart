part of 'imports_customizable.dart';

class ButtonFooter extends StatelessWidget {
  final String? title;
  final bool isDisabled;
  final VoidCallback? onPressed;

  final List<Widget>? children;

  const ButtonFooter({
    super.key,
    this.title,
    this.isDisabled = false,
    this.onPressed,
    this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 16.toH(context),
        horizontal: 16.toW(context),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.toRad()),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha:0.1),
            blurRadius: 8.toRad(),
            offset: Offset(0, 4.toH(context)),
          ),
        ],
      ),
      child: Row(
        children: children ??
            [
              Expanded(
                child: ButtonDefault(
                  title: title!,
                  // height: 54.toH(),
                  active: isDisabled,
                  onTap: onPressed,
                ),
              ),
            ],
      ),
    );
  }
}
