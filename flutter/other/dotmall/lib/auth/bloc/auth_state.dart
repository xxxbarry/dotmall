part of 'auth_bloc.dart';

@immutable
abstract class AuthState {
  const AuthState();
}

class AuthInitial extends AuthState {}

/// Empty
class AuthEmptyState extends AuthState {}

/// [AuthLoadingState] is the state that is used when the authentication is loading.
class AuthLoadingState extends AuthState {}

/// [AuthResponseState] is the state that is used when the authentication is loaded.
class AuthResponseState extends AuthState {
  final AuthResponse response;
  const AuthResponseState(this.response);
}

/// [AuthErrorState] is the state that is used when the authentication has an error.
class AuthErrorState<T extends Object> extends AuthState {
  final T error;
  const AuthErrorState(this.error);
}

/// [AuthValidationExceptionState] is the state that is used when the authentication has an error.
class AuthValidationExceptionState extends AuthState implements AuthErrorState {
  final ValidationException exception;
  const AuthValidationExceptionState(this.exception);

  @override
  String get error => exception.message.toString();

  static AuthValidationExceptionState? of(AuthState state) {
    if (state is AuthValidationExceptionState) {
      return state;
    }
    return null;
  }
}

/// [AuthLoadingCacheState] is the state that is used when the authentication is loading from cache.
class AuthLoadingCacheState extends AuthState {}

/// [AuthCheckingCachedTokenState] is the state that is used when the authentication is checking cached token.
class AuthCheckingCachedTokenState extends AuthState {}

/// [AuthCacheLoadingState] is the state that is used when the authentication is loading from cache.
class AuthCacheLoadingState extends AuthLoadingState {}

/// [AuthNetworkLoadingState] is the state that is used when the authentication is loading from network.
class AuthNetworkLoadingState extends AuthLoadingState {}

/// [AuthLoadedState] is the state that is used when the authentication is loaded.
class AuthLoadedState extends AuthState {
  final AuthResponse response;
  const AuthLoadedState(this.response);
}
