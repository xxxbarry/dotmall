part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {
  const AuthEvent();
}

/// [AuthEmptyEvent]
class AuthEmptyEvent extends AuthEvent {
  const AuthEmptyEvent();
}

/// [AuthLoadingEvent] event is used to indicate that the authentication is loading.
class AuthLoadingEvent extends AuthEvent {
  const AuthLoadingEvent();
}

///AuthLoadingCacheEvent
class AuthLoadingCacheEvent extends AuthLoadingEvent {
  const AuthLoadingCacheEvent();
}

/// AuthCheckingCachedTokenEvent
class AuthCheckingCachedTokenEvent extends AuthEvent {
  const AuthCheckingCachedTokenEvent();
}

/// [AuthResponseEvent] is the event to get token and model
class AuthResponseEvent<T extends Model> extends AuthEvent {
  final AuthResponse<T> response;
  const AuthResponseEvent(this.response);
}

/// [AutErrorEvent]
class AutErrorEvent<T extends Object> extends AuthEvent {
  final T error;
  const AutErrorEvent(this.error);
}

/// [AuthSignEvent] is the event to sign in/up
class AuthSignEvent extends AuthEvent {
  const AuthSignEvent();
}

/// [AuthSigninEvent] is the event that is fired when the user signs in.
class AuthSigninEvent<T extends AuthCredentials> extends AuthSignEvent {
  final T credentials;
  const AuthSigninEvent(this.credentials);
}

/// [AuthSignupEvent] is the event that is fired when the user signs up.
class AuthSigupEvent<T extends AuthCredentials> extends AuthSignEvent {
  final T credentials;
  const AuthSigupEvent(this.credentials);
}

/// [AuthSignResponseEvent] is the event that is fired when the user signs in.
class AuthSignResponseEvent extends AuthSignEvent {
  final AuthResponse response;
  const AuthSignResponseEvent(this.response);
}

/// [AuthSignoutEvent] is the event that is fired when the user signs out.
class AuthSignoutEvent extends AuthSignEvent {
  const AuthSignoutEvent();
}
