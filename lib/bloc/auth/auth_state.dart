part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthLoadingState extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthResponseState extends AuthState {
  String message;

  AuthResponseState({required this.message});

  @override
  List<Object?> get props => [];
}

class AuthErrorState extends AuthState {
  String message;

  AuthErrorState({required this.message});

  @override
  List<Object?> get props => [];
}
