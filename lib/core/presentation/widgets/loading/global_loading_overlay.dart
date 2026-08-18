import 'package:flutter/material.dart';

import '../../../helper/extensions/context.dart';
import 'loading_indicator.dart';

class GlobalLoadingOverlay extends StatelessWidget {
  const GlobalLoadingOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    // This allows the user to use the cancel button or the edge swipe gesture
    // to dismiss the global loading and pop from the current screen
    return GestureDetector(
      onHorizontalDragStart: (details) {
        const sensitivity = 20;

        if (details.localPosition.dx < sensitivity) {
          context.showLoading(when: false);
        }
      },
      child: Container(
        color: Colors.transparent,
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const GlobalLoadingIndicator(),
              const SizedBox(height: 20),
              _VisibilityTextButton(
                text: 'Cancel',
                onPressed: () {
                  context.showLoading(when: false);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _VisibilityTextButton extends StatefulWidget {
  const _VisibilityTextButton({required this.text, required this.onPressed});

  final String text;
  final VoidCallback onPressed;

  @override
  State<_VisibilityTextButton> createState() => _VisibilityTextButtonState();
}

class _VisibilityTextButtonState extends State<_VisibilityTextButton> {
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 10), () {
      if (mounted) {
        setState(() => _isVisible = true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: _isVisible ? widget.onPressed : null,
      child: Visibility(
        visible: _isVisible,
        child: Text(
          widget.text,
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
