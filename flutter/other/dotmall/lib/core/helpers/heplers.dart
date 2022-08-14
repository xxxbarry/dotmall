// ignore_for_file: public_member_api_docs, sort_constructors_first
// ValidationExceptionMixin
import 'package:dotmall_sdk/dotmall_sdk.dart';

class Matcher {
  // read<Status>
  static T? read<T>(dynamic state) {
    return state is T ? state : null;
  }
}

class ValidationExceptionState {
  final ValidationException exception;
  ValidationExceptionState({
    required this.exception,
  });
}

// add extention to dynamic variable to find type
extension MatcherMixin on Object {
  T? returnAs<T>(dynamic state) {
    return state is T ? state : null;
  }
}

// add extention to String to return null if empty
extension StringExtension on String {
  String? get realValue => isEmpty ? null : this;
  String? clipAt(int? max) => isNotEmpty && max != null && length > max
      ? substring(0, max) + ".."
      : this;
}
