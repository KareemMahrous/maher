import 'package:flutter/material.dart';

import '../../../helper/extensions/screen_spaces_extension.dart';

/// Creates a Divider with different styles : faded ,semi ,normal
class XDivider extends StatelessWidget {
  final double height;
  final Color? color;
  final double opacity;
  final double horizontalPadding;
  final double verticalPadding;

  const XDivider._({
    this.height = 1.0,
    this.color,
    this.opacity = 1.0,
    this.horizontalPadding = 0.0,
    this.verticalPadding = 0.0,
  });

  /// Normal Divider with opacity = 1
  factory XDivider.normal({
    double height = 1.0,
    Color? color,
    double horizontalPadding = 0.0,
    double verticalPadding = 0.0,
  }) => XDivider._(
    opacity: 1,
    height: height,
    color: color,
    horizontalPadding: horizontalPadding,
    verticalPadding: verticalPadding,
  );

  /// Divider with opacity = 0.5
  factory XDivider.semiFaded({
    double height = 1.0,
    Color? color,
    double horizontalPadding = 0.0,
    double verticalPadding = 0.0,
  }) => XDivider._(
    opacity: 0.5,
    height: height,
    color: color,
    horizontalPadding: horizontalPadding,
    verticalPadding: verticalPadding,
  );

  /// Divider with opacity = 0.1
  factory XDivider.faded({
    double height = 1.0,
    Color? color,
    double horizontalPadding = 0.0,
    double verticalPadding = 0.0,
  }) => XDivider._(
    opacity: 0.5,
    height: height,
    color: color,
    horizontalPadding: horizontalPadding,
    verticalPadding: verticalPadding,
  );

  @override
  Widget build(BuildContext context) => _CustomDivider(
    color: color ?? Colors.grey[300],
    height: height.toH(context),
    key: key,
    opacity: opacity,
    horizontalPadding: horizontalPadding,
    verticalPadding: verticalPadding,
  );
}

class _CustomDivider extends StatelessWidget {
  final double height;
  final Color? color;
  final double opacity;
  final double horizontalPadding;
  final double verticalPadding;
  const _CustomDivider({
    super.key,
    required this.height,
    this.color,
    required this.opacity,
    required this.horizontalPadding,
    required this.verticalPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ),
      child: Opacity(
        opacity: opacity,
        child: Container(width: double.infinity, height: height, color: color),
      ),
    );
  }
}
