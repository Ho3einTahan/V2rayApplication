import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:v2ray/di/di.dart';

import '../utils/api_exceptions.dart';

abstract class IAuthenticationDatasource {
  Future<Map<String, dynamic>> login(String phoneNumber, String macAddress);
}

class AuthenticationRemote implements IAuthenticationDatasource {
  final Dio _dio = locator.get();

  @override
  Future<Map<String, dynamic>> login(
      String phoneNumber, String macAddress) async {
    try {
      var response = await _dio.post('/users/login',
          data: {'phoneNumber': phoneNumber, 'macAddress': macAddress});
      return response.data;
    } on DioException catch (ex) {
      if (ex.error is SocketException) {
        throw ApiException(code: 0, message: 'اتصال به اینترنت برقرار نیست');
      } else {
        throw ApiException(
            code: ex.response!.statusCode,
            message: ex.response!.data['message'] ?? ex.error);
      }
    } catch (e) {
      throw ErrorDescription('خطای نامشخص');
    }
  }
}
