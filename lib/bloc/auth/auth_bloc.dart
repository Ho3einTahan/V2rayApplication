import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:v2ray/di/di.dart';
import 'package:v2ray/repository/authentication_repository.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthLoginEvent>((event, emit) async {
      final IAuthRepository _repository = locator.get();

      var either = await _repository.login(event.phoneNumber, event.macAddress);

      either.fold((message) => emit(AuthErrorState(message: message)),
          (message) => emit(AuthResponseState(message: message)));
    });
  }
}
