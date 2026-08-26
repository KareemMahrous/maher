import 'dart:math' as math;

import 'package:flutter/material.dart';

class SoundIndicator extends StatefulWidget {
  const SoundIndicator({super.key});

  @override
  State<SoundIndicator> createState() => _SoundIndicatorState();
}

class _SoundIndicatorState extends State<SoundIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 76,
      height: 54,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: List.generate(7, (index) {
              final phase = (_controller.value * math.pi * 2) + index * 0.75;
              final heightFactor = 0.35 + (math.sin(phase).abs() * 0.65);

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: Align(
                  alignment: Alignment.center,
                  child: FractionallySizedBox(
                    heightFactor: heightFactor,
                    child: const DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                      ),
                      child: SizedBox(width: 5),
                    ),
                  ),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}
