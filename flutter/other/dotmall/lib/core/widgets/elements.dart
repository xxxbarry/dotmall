import 'dart:math';

import 'package:flutter/material.dart';

/// [AppLogo] is a widget that displays the app logo.

class AppLogo extends StatelessWidget {
  final double? height;
  final double? width;
  const AppLogo({
    super.key,
    this.height = 50,
    this.width,
  });

  /// [square] factory constructor that creates a square [AppLogo] with the
  /// given [size].
  factory AppLogo.square(double size) => AppLogo(
        height: size,
        width: size,
      );

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/200w/logo_black.png',
      width: double.infinity,
      height: height,
      fit: BoxFit.contain,
    );
  }
}

class SquareProgressIndicator extends StatelessWidget {
  const SquareProgressIndicator({
    this.value,
    this.size = 50,
    this.angle = -30,
    this.transform,
    super.key,
  });

  final double? value;
  final double size;
  final double angle;
  final Matrix4? transform;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angle * (pi / 180),
      child: SizedBox(
        width: size,
        height: size / 2,
        child: Stack(
          children: [
            Positioned(
              child: Transform(
                transform: transform ?? Matrix4.skewX(-0.5),
                child: SizedBox(
                  width: size,
                  child: LinearProgressIndicator(
                    value: value,
                    minHeight: size / 4,
                    color: Theme.of(context).primaryColor,
                    backgroundColor: Colors.transparent,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Transform(
                transform: transform ?? Matrix4.skewX(-0.5),
                child: Transform.scale(
                  scale: -1,
                  // reverse the progress indicator
                  child: SizedBox(
                    width: size,
                    child: LinearProgressIndicator(
                      value: value,
                      minHeight: size / 4,
                      color: Theme.of(context).primaryColor.withOpacity(0.3),
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
