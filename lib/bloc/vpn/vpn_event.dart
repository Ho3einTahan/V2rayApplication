part of 'vpn_bloc.dart';

abstract class VpnEvent extends Equatable {
  const VpnEvent();
}

class getServers extends VpnEvent {
  final String token;

  const getServers({required this.token});

  @override
  List<Object?> get props => [token];
}

class getPricing extends VpnEvent {

  final String token;

  const getPricing({required this.token});
  @override
  List<Object?> get props => [];
}
