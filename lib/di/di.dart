import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:v2ray/datasource/authentication_datasource.dart';
import 'package:v2ray/repository/authentication_repository.dart';

final locator = GetIt.instance;

Future<void> getItInit() async {
  locator.registerSingleton<Dio>(
      Dio(BaseOptions(baseUrl: 'http://192.168.1.104:3000')));

  locator
      .registerFactory<IAuthenticationDatasource>(() => AuthenticationRemote());

  locator.registerFactory<IAuthRepository>(() => AuthenticationRepository());
}