import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:v2ray/datasource/authentication_datasource.dart';
import 'package:v2ray/di/di.dart';

import '../utils/api_exceptions.dart';

abstract class IAuthRepository {
  Future<Either<String, String>> register(
      String phoneNumber, String macAddress);

  Future<Either<String, String>> login(String phoneNumber, String macAddress);
}

class AuthenticationRepository implements IAuthRepository {
  final IAuthenticationDatasource _datasource = locator.get();

  @override
  Future<Either<String, String>> login(
      String phoneNumber, String macAddress) async {
    try {
      await _datasource.login(phoneNumber, macAddress);
      return right('ورود موفقیت آمیز بود');
    } on ApiException catch (ex) {
      return left(ex.message ?? 'خطایی رخ داد');
    } catch (e) {
      return left(e.toString() ?? 'خطایی رخ داد');
    }
  }

  @override
  Future<Either<String, String>> register(
      String phoneNumber, String macAddress) async {
    try {
      await _datasource.login(phoneNumber, macAddress);
      return right('ثبت نام موفقیت آمیز بود');
    } on ApiException catch (ex) {
      return left(ex.message ?? 'خطایی رخ داد');
    } catch (e) {
      return left(e.toString());
    }
  }
}
