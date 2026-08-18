import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key, this.size = 16});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: size,
          height: size,
          child: const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xff104631)),
          ),
        ),
      ],
    );
  }
}

class GlobalLoadingIndicator extends StatelessWidget {
  const GlobalLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const LoadingIndicator(size: 64);
  }
}
