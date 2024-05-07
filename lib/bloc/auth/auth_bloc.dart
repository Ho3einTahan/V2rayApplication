import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:v2ray/core/class/model/MyPrefrences.dart';
import 'package:v2ray/di/di.dart';
import 'package:v2ray/repository/authentication_repository.dart';
import 'package:v2ray/view/screen/home-screen.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthLoginEvent>((event, emit) async {
      emit(AuthLoadingState());

      final IAuthRepository _repository = locator.get();

      var either = await _repository.login(event.phoneNumber, event.macAddress);

      either.fold(
        // if error
        (message) {
          Get.snackbar(
            '',
            '',
            colorText: Colors.white,
            titleText: Center(
                child: Text(message,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w700))),
            backgroundColor: Colors.lightBlue,
          );
          emit(AuthErrorState(message: message));
        },
        // if ok
        (message) async {
          emit(AuthResponseState());
          bool isLogin = await MyPreferences.readUserIsLogin();

          List<String> configServer = [];
          configServer = message['address'].toString().split(',');

          Get.offUntil(
            MaterialPageRoute(
              builder: (context) => HomeScreen(serverConfig: configServer),
            ),
            (route) => false,
          );

          Get.snackbar(
            '',
            '',
            colorText: Colors.white,
            titleText: Center(
                child: Text(message['message'],
                    style: const TextStyle(fontWeight: FontWeight.w700))),
            backgroundColor: Colors.lightBlue,
          );
          MyPreferences.writeUserIsLogin(isLogin: true);
          MyPreferences.writePhoneNumberUser(phoneNumber: event.phoneNumber);
        },
      );
    });
  }
}
