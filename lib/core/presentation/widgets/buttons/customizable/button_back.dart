part of 'imports_customizable.dart';
/// Confirmed

class ButtonBack extends StatelessWidget {
  final Color? color;

  const ButtonBack({super.key, this.color});


  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsetsDirectional.only(
        start: 5.toW(context),
      ),
      splashRadius: AppSizes.iconRad.toRad(),
      onPressed: () {
        context.goBack();
      },
      icon: Icon(
        Icons.arrow_back_ios,
        color: color,
        size: AppSizes.iconRad.toRad(),
      ),
    );
  }
}
