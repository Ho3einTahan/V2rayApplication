part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class AuthLoginEvent extends AuthEvent {
  String phoneNumber;
  String macAddress;

  AuthLoginEvent({required this.phoneNumber, required this.macAddress});

  @override
  List<Object?> get props => [];
}

class AuthRegisterEvent extends AuthEvent {
  String phoneNumber;
  String macAddress;

  AuthRegisterEvent({required this.phoneNumber, required this.macAddress});

  @override
  List<Object?> get props => [];
}
