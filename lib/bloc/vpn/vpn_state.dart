part of 'vpn_bloc.dart';

abstract class VpnState extends Equatable {
  const VpnState();
}

class VpnInitialState extends VpnState {
  @override
  List<Object> get props => [];
}

class VpnFetchingServersState extends VpnState {
  @override
  List<Object?> get props => [];
}

class VpnServersFetchedState extends VpnState {
  final List<Servers> servers;

  const VpnServersFetchedState(this.servers);

  @override
  List<Object?> get props => [servers];
}

class VpnFetchingPricingState extends VpnState {
  @override
  List<Object?> get props => [];
}

class VpnPricingFetchedState extends VpnState {
  final List<Pricing> pricing;

  const VpnPricingFetchedState(this.pricing);

  @override
  List<Object?> get props => [pricing];
}

class VpnErrorState extends VpnState {
  final String errorMessage;

  const VpnErrorState(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
