import 'package:hub008/core/data_state.dart';
import 'package:hub008/models/user.dart';
import 'package:hub008/providers/common/login/login_service.dart';
import 'package:dio/dio.dart';
import 'dart:io';

class LoginRepo {
  final LoginService _loginService;
  const LoginRepo(this._loginService);

  Future<DataState<User>> login() async {
    try {
      final httpResponse = await _loginService.login();
      print('i am 222 -->$httpResponse');
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions));
      }
    } on DioException catch (e) {
      print('i am error -->${e.error}');
      return DataFailed(e);
    }
  }
}
