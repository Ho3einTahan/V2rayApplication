import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:v2ray/core/function/handle-dio-error.dart';
import 'package:v2ray/di/di.dart';

import '../core/constants/const.dart';
import '../core/constants/routes.dart';
import '../utils/api_exceptions.dart';

abstract class IAuthenticationDatasource {
  Future<Either<ApiException, Map<String, dynamic>>> login(String phoneNumber, String password, String macAddress);
}

class AuthenticationRemote implements IAuthenticationDatasource {
  final Dio _dio = locator.get();

  @override
  Future<Either<ApiException, Map<String, dynamic>>> login(String phoneNumber, String password, String macAddress) async {
    try {
      var response = await _dio.post(Const.login, data: {'phoneNumber': phoneNumber, 'password': password, 'macAddress': macAddress});
      return right(response.data);
    } catch (e) {
      return left(handleDioError(e));
    }
  }
}
