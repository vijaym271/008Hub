import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hub008/blocs/common/login/login_bloc.dart';
import 'package:hub008/config/environment.dart';
import 'package:hub008/providers/common/login/login_service.dart';
import 'package:hub008/repos/common/login_repo.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  sl.registerSingleton<Dio>(Dio(BaseOptions(baseUrl: Environment.baseUrl)));
  sl.registerSingleton<LoginService>(LoginService(sl()));
  sl.registerSingleton<LoginRepo>(LoginRepo(sl()));
  sl.registerSingleton<LoginBloc>(LoginBloc(sl()));
}
