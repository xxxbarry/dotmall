import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dotmall_sdk/dotmall_sdk.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

import '../repositories/repositories.dart';
import 'auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  // repository
  AuthRepository<Users> repository =
      AuthRepository<Users>(collection: Users(Manager(Configs())));
  final AuthCacheRepository cachRepository = AuthCacheRepository();

  AuthBloc() : super(AuthEmptyState()) {
    on<AuthSigninEvent>(_onAuthSignin);
    on<AuthSignResponseEvent>(_onAuthSignResponse);
    on<AuthEmptyEvent>(_onAuthEmpty);
    on<AuthLoadingCacheEvent>(_onAuthLoadingCache);
    on<AuthCheckingCachedTokenEvent>(_onAuthCheckingCachedToken);
    on<AuthLoadingEvent>(_onAuthLoading);
    on<AuthResponseEvent>(_onAuthResponse);
    on<AutErrorEvent>(_onAuthError);
  }

  FutureOr<void> _onAuthError(
      AutErrorEvent event, Emitter<AuthState> emit) async {
    emit(AuthErrorState(event.error));
  }

  /// [_onAuthSignin] is the event that is fired when the user signs in.
  FutureOr<void> _onAuthSignin(
      AuthSigninEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    try {
      var response = await repository.collection
          .signin(event.credentials as UserAuthCredentials);
      add(AuthResponseEvent(response));
    } on ValidationException catch (e) {
      emit(AuthValidationExceptionState(e));
    } catch (e) {
      add(AutErrorEvent(e));
    }
  }

  /// [_onAuthSignResponse] is the event that is fired when the user signs in.
  FutureOr<void> _onAuthSignResponse(
      AuthSignResponseEvent event, Emitter<AuthState> emit) async {
    // cache the token using hive
    Hive.box('auth').put('token', event.response.token.toJson());
    emit(AuthResponseState(event.response));
  }

  // empty event
  FutureOr<void> _onAuthEmpty(AuthEmptyEvent event, Emitter<AuthState> emit) {
    emit(AuthEmptyState());
  }

  FutureOr<void> _onAuthLoadingCache(
      AuthLoadingCacheEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingCacheState());
    Token? token = await cachRepository.readToken();
    if (token != null) {
      repository.collection.manager.token = token;
      add(AuthCheckingCachedTokenEvent());
    } else {
      add(AuthEmptyEvent());
    }
  }

  FutureOr<void> _onAuthCheckingCachedToken(
      AuthCheckingCachedTokenEvent event, Emitter<AuthState> emit) async {
    emit(AuthCheckingCachedTokenState());
    var token = repository.collection.manager.token;
    if (token != null) {
      try {
        var authModel = await repository.collection.auth();
        add(AuthResponseEvent(AuthResponse(token: token, model: authModel)));
      } catch (e) {
        repository.collection.manager.token = null;
        add(AuthSignoutEvent());
      }
    } else {
      add(AuthSignoutEvent());
    }
  }

  FutureOr<void> _onAuthLoading(
      AuthLoadingEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
  }

  FutureOr<void> _onAuthResponse(
      AuthResponseEvent<Model> event, Emitter<AuthState> emit) {
    emit(AuthResponseState(event.response));
  }
}
