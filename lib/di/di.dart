import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:v2ray/datasource/authentication_datasource.dart';
import 'package:v2ray/datasource/vpn-datasource.dart';
import 'package:v2ray/repository/authentication_repository.dart';
import 'package:v2ray/repository/vpn-repository.dart';

final locator = GetIt.instance;

Future<void> getItInit() async {
  locator.registerSingleton<Dio>(Dio(BaseOptions(baseUrl: 'http://192.168.1.101:3000', connectTimeout: const Duration(seconds: 10), receiveTimeout: const Duration(seconds: 20))));

  locator.registerFactory<IAuthenticationDatasource>(() => AuthenticationRemote());

  locator.registerFactory<IAuthRepository>(() => AuthenticationRepository());

  locator.registerFactory<IVpnDataSource>(() => VpnRemote());

  locator.registerFactory<IVpnRepository>(() => VpnRepository());
}
