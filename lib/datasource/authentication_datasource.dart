import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:v2ray/di/di.dart';

import '../utils/api_exceptions.dart';

abstract class IAuthenticationDatasource {
  Future<void> register(String phoneNumber, String macAddress);

  Future<void> login(String phoneNumber, String macAddress);
}

class AuthenticationRemote implements IAuthenticationDatasource {
  final Dio _dio = locator.get();

  @override
  Future<void> login(String phoneNumber, String macAddress) async {
    try {
      await _dio.post('',
          data: {'phoneNumber': phoneNumber, 'macAddress': macAddress});
    } on DioException catch (ex) {
      throw ApiException(
          code: ex.response!.statusCode, message: ex.response!.data['message']);
    } catch (e) {
      throw ErrorDescription('خطای نامشخص');
    }
  }

  @override
  Future<void> register(String phoneNumber, String macAddress) async {
    try {
      await _dio.post('',
          data: {'phoneNumber': phoneNumber, 'macAddress': macAddress});
    } on DioException catch (ex) {
      throw ApiException(
          code: ex.response!.statusCode, message: ex.response!.data['message']);
    } catch (e) {
      throw ErrorDescription('خطای نامشخص');
    }
  }
}
