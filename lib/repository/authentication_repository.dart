import 'package:dartz/dartz.dart';
import 'package:v2ray/datasource/authentication_datasource.dart';
import 'package:v2ray/di/di.dart';

import '../utils/api_exceptions.dart';

abstract class IAuthRepository {
  Future<Either<String, Map<String, dynamic>>> login(String phoneNumber, String password, String macAddress);
}

class AuthenticationRepository implements IAuthRepository {
  final IAuthenticationDatasource _datasource = locator.get();

  @override
  Future<Either<String, Map<String, dynamic>>> login(String phoneNumber, String password, String macAddress) async {
    Either<ApiException, Map<String, dynamic>> response = await _datasource.login(phoneNumber, password, macAddress);
    return response.fold((l) => left(l.message!), (r) => right(r));
  }
}
