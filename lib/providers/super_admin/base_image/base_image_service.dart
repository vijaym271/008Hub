import 'package:dio/dio.dart';
import 'package:hub008/config/environment.dart';
import 'package:hub008/models/base_image.dart';
import 'package:retrofit/retrofit.dart';
part 'base_image_service.g.dart';

@RestApi(baseUrl: Environment.baseUrl)
abstract class BaseImageService {
  factory BaseImageService(Dio dio, {String baseUrl}) = _BaseImageService;

  @GET('/posts')
  Future<HttpResponse<List<BaseImage>>> getAllBaseImages();
}
