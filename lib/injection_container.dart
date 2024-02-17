import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:hub008/blocs/common/login/login_bloc.dart';
import 'package:hub008/blocs/super_admin/base_image/base_image_bloc.dart';
import 'package:hub008/providers/common/login/login_service.dart';
import 'package:hub008/providers/super_admin/base_image/base_image_service.dart';
import 'package:hub008/repos/common/login_repo.dart';
import 'package:hub008/repos/super_admin/base_image_repo.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  sl.registerSingleton<Dio>(Dio(BaseOptions(baseUrl: dotenv.get('BASE_URL'))));
  sl.registerSingleton<LoginService>(LoginService(sl()));
  sl.registerSingleton<LoginRepo>(LoginRepo(sl()));
  sl.registerSingleton<LoginBloc>(LoginBloc(sl()));

  sl.registerSingleton<BaseImageService>(BaseImageService(sl()));
  sl.registerSingleton<BaseImageRepo>(BaseImageRepo(sl()));
  sl.registerSingleton<BaseImageBloc>(BaseImageBloc(sl()));
}
