import 'package:flutter/material.dart';

class GradientBox extends StatelessWidget {
  const GradientBox({
    Key? key,
    required this.child,
    required this.gradient,
    this.enabled = true,
    this.blendMode = BlendMode.srcIn,
  }) : super(key: key);

  final Widget child;
  final Gradient gradient;
  final bool enabled;
  final BlendMode blendMode;

  @override
  Widget build(BuildContext context) {
    return enabled
        ? ShaderMask(
            blendMode: BlendMode.srcIn,
            shaderCallback: (bounds) => gradient.createShader(
              Rect.fromLTWH(0, 0, bounds.width, bounds.height),
            ),
            child: child,
          )
        : child;
  }
}

class CGradientBox extends StatelessWidget {
  const CGradientBox({
    Key? key,
    required this.child,
    this.enabled = true,
    this.blendMode = BlendMode.srcIn,
  }) : super(key: key);
  final Widget child;
  final bool enabled;
  final BlendMode blendMode;

  static Gradient gradient = const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color.fromARGB(255, 121, 39, 176),
      Color.fromARGB(255, 226, 11, 137),
    ],
  );
  static Color color = Colors.orange;
  @override
  Widget build(BuildContext context) {
    return GradientBox(
      blendMode: blendMode,
      enabled: enabled,
      gradient: gradient,
      child: child,
    );
  }
}
