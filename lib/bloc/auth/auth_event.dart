part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class AuthLoginEvent extends AuthEvent {
  final String phoneNumber;
  final String password;
  final String macAddress;

  const AuthLoginEvent({required this.phoneNumber, required this.password, required this.macAddress});

  @override
  List<Object?> get props => [phoneNumber, password, macAddress];
}