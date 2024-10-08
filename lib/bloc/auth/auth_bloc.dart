import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:v2ray/core/class/MyPrefrences.dart';
import 'package:v2ray/di/di.dart';
import 'package:v2ray/repository/authentication_repository.dart';
import 'package:v2ray/view/widget/loading-dialog.dart';

import '../../core/function/hide-dialog.dart';
import '../vpn/vpn_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthRepository _repository = locator.get();

  AuthBloc() : super(AuthInitial()) {
    on<AuthLoginEvent>((event, emit) async {
      emit(AuthLoadingState());

      // Show loading dialog if it's not already shown
      showLoadingDialog();

      var either = await _repository.login(event.phoneNumber, event.password, event.macAddress);

      either.fold(
        (message) {
          // Hide loading dialog before showing error
          hideDialog();
          showTopSnackBar(Overlay.of(Get.overlayContext!)!, CustomSnackBar.error(message: message));
          emit(AuthErrorState(message: message));
        },
        (message) async {
          // Save token and proceed with fetching VPN servers
          MyPreferences.setUserToken(token: message['token']);
          MyPreferences.setStartServiceDate(startServiceDate: message['startServiceDate']);
          MyPreferences.setEndServiceDate(endServiceDate: message['endServiceDate']);
          MyPreferences.setUserName(userName: message['userName']);
          MyPreferences.setMultiUserDevices(multiUserDevices: message['devices']);

          // Add event to VPN Bloc to fetch servers
          BlocProvider.of<VpnBloc>(Get.context!).add(getServers(token: message['token']));

          // Wait for the servers to be fetched
          final serversState = await BlocProvider.of<VpnBloc>(Get.context!).stream.firstWhere((state) => state is VpnServersFetchedState || state is VpnErrorState);

          if (serversState is VpnServersFetchedState) {
            // Hide loading dialog before navigating
            hideDialog();

            // Navigate to home with the fetched servers
            Get.toNamed('/home', arguments: {'servers': serversState.servers});

            // Save user credentials
            MyPreferences.setIsUserLoggedIn(isLoggedIn: true);
            MyPreferences.setUserPhoneNumber(phoneNumber: event.phoneNumber);
            MyPreferences.setUserPassword(password: event.password);
          } else if (serversState is VpnErrorState) {
            hideDialog();
            showTopSnackBar(Overlay.of(Get.overlayContext!)!, CustomSnackBar.error(message: serversState.errorMessage));
          }
        },
      );
    });
  }
}
