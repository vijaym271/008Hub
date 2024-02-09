import 'package:dio/dio.dart';
import 'package:hub008/config/environment.dart';
import 'package:hub008/models/user.dart';
import 'package:retrofit/retrofit.dart';
part 'login_service.g.dart';

@RestApi(baseUrl: Environment.baseUrl)
abstract class LoginService {
  factory LoginService(Dio dio, {String baseUrl}) = _LoginService;

  @GET('/posts')
  Future<HttpResponse<User>> login();
}
