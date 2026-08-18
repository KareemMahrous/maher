import 'package:flutter/material.dart';

class CustomLoading extends StatelessWidget {
  final Color? color;

  const CustomLoading({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator.adaptive(
      strokeWidth: 2.0,
      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
    );
  }
}
