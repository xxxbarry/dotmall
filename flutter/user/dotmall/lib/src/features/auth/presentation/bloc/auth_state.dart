part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState({this.auth});

  final Auth? auth;

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}
