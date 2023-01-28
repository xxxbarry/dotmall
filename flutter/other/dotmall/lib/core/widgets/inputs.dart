import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CTextFormField extends TextFormField {
  CTextFormField({
    super.key,
  });
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
  // phone number without country code, can be 0 + 9 digits or just 9 digits
  static final RegExp phoneRegExp = RegExp(r'^(\d{9}|\d{10})$');

  // password must be >= 6 characters and <= 20 characters
  static final RegExp passwordRegExp = RegExp(
    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{5,20}$',
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
    return password.length >= 6 && password.length <= 20
        ? null
        : 'كلمة المرور يجب ان تتكون من 6 حروف على الأقل';
  }
}

class CustomFormInput extends StatelessWidget {
  final String? errorText;
  const CustomFormInput(
      {super.key,
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
      this.labelText,
      this.hintText,
      this.errorText,
      this.enabled = true,
      this.focusNode});
  final FocusNode? focusNode;
  final bool autoValidate;
  final bool enabled;
  final bool obscureText;
  final GlobalKey<FormState>? formKey;
  final double height;
  final String? labelText;
  final String? hintText;
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
    return ClipRRect(
      borderRadius: borderRadius ?? _defaultBorderRadius,
      child: TextFormField(
        focusNode: focusNode,
        enabled: enabled,
        enableSuggestions: true,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        obscureText: obscureText,
        onChanged: ((value) {
          if (onChanged != null) {
            onChanged!(value);
          }
        }),
        controller: controller,
        validator: validator,
        keyboardType: keyboardType,
        style: const TextStyle(fontSize: 16, height: 1),
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
            hintText: hintText,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            prefix: prefix,
            suffix: suffix,
            errorText: this.errorText),
      ),
    );
  }
}
