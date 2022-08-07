import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CTextFormField extends TextFormField {
  CTextFormField({
    super.key,
  });
}

class COutlineInputBorder extends InputBorder {
  const COutlineInputBorder({
    super.borderSide = const BorderSide(),
    this.borderRadius = const BorderRadius.all(Radius.circular(12.0)),
    this.gapPadding = 0,
  })  : assert(borderRadius != null),
        assert(gapPadding != null && gapPadding >= 0.0);

  static bool _cornersAreCircular(BorderRadius borderRadius) {
    return borderRadius.topLeft.x == borderRadius.topLeft.y &&
        borderRadius.bottomLeft.x == borderRadius.bottomLeft.y &&
        borderRadius.topRight.x == borderRadius.topRight.y &&
        borderRadius.bottomRight.x == borderRadius.bottomRight.y;
  }

  final double gapPadding;

  final BorderRadius borderRadius;

  @override
  bool get isOutline => true;

  @override
  COutlineInputBorder copyWith({
    BorderSide? borderSide,
    BorderRadius? borderRadius,
    double? gapPadding,
  }) {
    return COutlineInputBorder(
      borderSide: borderSide ?? this.borderSide,
      borderRadius: borderRadius ?? this.borderRadius,
      gapPadding: gapPadding ?? this.gapPadding,
    );
  }

  @override
  EdgeInsetsGeometry get dimensions {
    return EdgeInsets.all(borderSide.width);
  }

  @override
  COutlineInputBorder scale(double t) {
    return COutlineInputBorder(
      borderSide: borderSide.scale(t),
      borderRadius: borderRadius * t,
      gapPadding: gapPadding * t,
    );
  }

  @override
  ShapeBorder? lerpFrom(ShapeBorder? a, double t) {
    if (a is COutlineInputBorder) {
      final COutlineInputBorder outline = a;
      return COutlineInputBorder(
        borderRadius: BorderRadius.lerp(outline.borderRadius, borderRadius, t)!,
        borderSide: BorderSide.lerp(outline.borderSide, borderSide, t),
        gapPadding: outline.gapPadding,
      );
    }
    return super.lerpFrom(a, t);
  }

  @override
  ShapeBorder? lerpTo(ShapeBorder? b, double t) {
    if (b is COutlineInputBorder) {
      final COutlineInputBorder outline = b;
      return COutlineInputBorder(
        borderRadius: BorderRadius.lerp(borderRadius, outline.borderRadius, t)!,
        borderSide: BorderSide.lerp(borderSide, outline.borderSide, t),
        gapPadding: outline.gapPadding,
      );
    }
    return super.lerpTo(b, t);
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path()
      ..addRRect(borderRadius
          .resolve(textDirection)
          .toRRect(rect)
          .deflate(borderSide.width));
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return Path()..addRRect(borderRadius.resolve(textDirection).toRRect(rect));
  }

  Path _gapBorderPath(
      Canvas canvas, RRect center, double start, double extent) {
    double start = 0;
    final RRect scaledRRect = center.scaleRadii();

    final Rect tlCorner = Rect.fromLTWH(
      scaledRRect.left,
      scaledRRect.top,
      scaledRRect.tlRadiusX * 2.0,
      scaledRRect.tlRadiusY * 2.0,
    );
    final Rect trCorner = Rect.fromLTWH(
      scaledRRect.right - scaledRRect.trRadiusX * 2.0,
      scaledRRect.top,
      scaledRRect.trRadiusX * 2.0,
      scaledRRect.trRadiusY * 2.0,
    );
    final Rect brCorner = Rect.fromLTWH(
      scaledRRect.right - scaledRRect.brRadiusX * 2.0,
      scaledRRect.bottom - scaledRRect.brRadiusY * 2.0,
      scaledRRect.brRadiusX * 2.0,
      scaledRRect.brRadiusY * 2.0,
    );
    final Rect blCorner = Rect.fromLTWH(
      scaledRRect.left,
      scaledRRect.bottom - scaledRRect.blRadiusY * 2.0,
      scaledRRect.blRadiusX * 2.0,
      scaledRRect.blRadiusX * 2.0,
    );

    const double cornerArcSweep = math.pi / 2.0;
    final double tlCornerArcSweep = math.acos(
      clampDouble(1 - start / scaledRRect.tlRadiusX, 0.0, 1.0),
    );

    final Path path = Path()..addArc(tlCorner, math.pi, tlCornerArcSweep);

    if (start > scaledRRect.tlRadiusX) {
      path.lineTo(scaledRRect.left + start, scaledRRect.top);
    }

    const double trCornerArcStart = (3 * math.pi) / 2.0;
    const double trCornerArcSweep = cornerArcSweep;
    if (start + extent < scaledRRect.width - scaledRRect.trRadiusX) {
      path.moveTo(scaledRRect.left + start + extent, scaledRRect.top);
      path.lineTo(scaledRRect.right - scaledRRect.trRadiusX, scaledRRect.top);
      path.addArc(trCorner, trCornerArcStart, trCornerArcSweep);
    } else if (start + extent < scaledRRect.width) {
      final double dx = scaledRRect.width - (start + extent);
      final double sweep = math.asin(
        clampDouble(1 - dx / scaledRRect.trRadiusX, 0.0, 1.0),
      );
      path.addArc(trCorner, trCornerArcStart + sweep, trCornerArcSweep - sweep);
    }

    return path
      ..moveTo(scaledRRect.right, scaledRRect.top + scaledRRect.trRadiusY)
      ..lineTo(scaledRRect.right, scaledRRect.bottom - scaledRRect.brRadiusY)
      ..addArc(brCorner, 0.0, cornerArcSweep)
      ..lineTo(scaledRRect.left + scaledRRect.blRadiusX, scaledRRect.bottom)
      ..addArc(blCorner, math.pi / 2.0, cornerArcSweep)
      ..lineTo(scaledRRect.left, scaledRRect.top + scaledRRect.tlRadiusY);
  }

  @override
  void paint(
    Canvas canvas,
    Rect rect, {
    double? gapStart,
    double gapExtent = 0.0,
    double gapPercentage = 0.0,
    TextDirection? textDirection,
  }) {
    assert(gapExtent != null);
    assert(gapPercentage >= 0.0 && gapPercentage <= 1.0);
    assert(_cornersAreCircular(borderRadius));

    // final Paint paint = borderSide.toPaint();
    final Paint paint = BorderSide(color: Colors.red).toPaint();
    final RRect outer = borderRadius.toRRect(rect);
    final RRect center = outer.deflate(borderSide.width / 2.0);
    if (gapStart == null || gapExtent <= 0.0 || gapPercentage == 0.0) {
      canvas.drawRRect(center, paint);
    } else {
      final double extent =
          lerpDouble(0.0, gapExtent + gapPadding * 2.0, gapPercentage)!;
      switch (textDirection!) {
        case TextDirection.rtl:
          final Path path = _gapBorderPath(canvas, center,
              math.max(0.0, gapStart + gapPadding - extent), extent);
          canvas.drawPath(path, paint);
          break;

        case TextDirection.ltr:
          final Path path = _gapBorderPath(
              canvas, center, math.max(0.0, gapStart - gapPadding), extent);
          canvas.drawPath(path, paint);
          break;
      }
    }
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is COutlineInputBorder &&
        other.borderSide == borderSide &&
        other.borderRadius == borderRadius &&
        other.gapPadding == gapPadding;
  }

  @override
  int get hashCode => Object.hash(borderSide, borderRadius, gapPadding);
}

class FormElementBox extends StatelessWidget {
  final Widget child;
  final double padding;
  const FormElementBox({Key? key, required this.child, this.padding = 5})
      : super(key: key);
  const FormElementBox.parent(
      {Key? key, required this.child, this.padding = 15})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(padding),
      child: child,
    );
  }
}

class FormValidators {
  static final RegExp emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );
  static final RegExp phoneRegExp = RegExp(
    r'^[0-9]{10}$',
  );
  // password must be at least 8 characters.
  static final RegExp passwordRegExp = RegExp(
    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$',
  );

  static String? email(String? email, {bool required = true}) {
    if (email == null || email.isEmpty) {
      return required ? 'البريد الالكتروني مطلوب' : null;
    }
    return emailRegExp.hasMatch(email)
        ? null
        : 'يرجى إدخال عنوان بريد إلكتروني صالح';
  }

  static String? phone(String? phone, {bool required = true}) {
    if (phone == null || phone.isEmpty) {
      return required ? 'رقم الهاتف مطلوب' : null;
    }
    return phoneRegExp.hasMatch(phone) ? null : 'يرجى إدخال رقم هاتف صالح';
  }

  static String? password(String? password, {bool required = true}) {
    if (password == null || password.isEmpty) {
      return required ? 'كلمة المرور مطلوبة' : null;
    }
    return phoneRegExp.hasMatch(password)
        ? null
        : 'كلمة المرور يجب ان تتكون من 8 حروف على الأقل';
  }
}

class CustomFormInput extends StatelessWidget {
  const CustomFormInput({
    super.key,
    this.formKey,
    this.autoValidate = true,
    this.obscureText = false,
    this.height = 40,
    this.borderRadius,
    this.prefix,
    this.suffix,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.validator,
    this.controller,
    this.onChanged,
    required this.labelText,
  });
  final bool autoValidate;
  final bool obscureText;
  final GlobalKey<FormState>? formKey;
  final double height;
  final String labelText;
  final Widget? prefix;
  final Widget? suffix;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final void Function(String)? onChanged;

  final BorderRadius? borderRadius;

  static final _defaultBorderRadius = BorderRadius.circular(10);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: height,
      child: ClipRRect(
        borderRadius: borderRadius ?? _defaultBorderRadius,
        child: TextFormField(
          obscureText: obscureText,
          onChanged: ((value) {
            if (formKey != null && autoValidate) {
              formKey!.currentState!.validate();
            }
            if (onChanged != null) {
              onChanged!(value);
            }
          }),
          controller: controller,
          validator: validator,
          keyboardType: keyboardType,
          style: const TextStyle(fontSize: 16, height: 1.5),
          decoration: InputDecoration(
            errorStyle: const TextStyle(fontSize: 12, height: 0.8),
            errorBorder: OutlineInputBorder(
              borderRadius: _defaultBorderRadius,
              borderSide: const BorderSide(color: Colors.red),
            ),
            border: InputBorder.none,
            isDense: true,
            floatingLabelStyle: TextStyle(
              fontSize: 13,
              height: 1.6,
              color: Colors.grey.withOpacity(0.8),
            ),
            filled: true,
            contentPadding: const EdgeInsets.all(0),
            labelText: labelText,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            prefix: prefix,
            suffix: suffix,
          ),
        ),
      ),
    );
  }
}
