import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:v2ray/core/class/model/pricing.dart';
import 'package:v2ray/core/class/model/servers.dart';
import 'package:v2ray/di/di.dart';
import 'package:v2ray/repository/vpn-repository.dart';

import '../../view/widget/loading-dialog.dart';

part 'vpn_event.dart';
part 'vpn_state.dart';

class VpnBloc extends Bloc<VpnEvent, VpnState> {
  VpnBloc() : super(VpnInitialState()) {
    final IVpnRepository vpnRepository = locator.get();

    on<getServers>((event, emit) async {
      emit(VpnFetchingServersState());
      Either<String, List<Servers>> servers = await vpnRepository.getServers(event.token);
      servers.fold((l) => emit(VpnErrorState(l)), (sr) => emit(VpnServersFetchedState(sr)));
    });

    on<getPricing>((event, emit) async {
      emit(VpnFetchingPricingState());
      // Show loading dialog if it's not already shown
      showLoadingDialog();
      Either<String, List<Pricing>> pricing = await vpnRepository.getPricing(event.token);
      Get.back();
      pricing.fold((l) {
        showTopSnackBar(Overlay.of(Get.overlayContext!)!, CustomSnackBar.error(message: l));
        emit(VpnErrorState(l));
      }, (pr) {
        print(pr);
        emit(VpnPricingFetchedState(pr));
      });
    });
  }
}
