import 'package:hub008/core/data_state.dart';
import 'package:hub008/models/base_image.dart';
import 'package:dio/dio.dart';
import 'dart:io';
import 'package:hub008/providers/super_admin/base_image/base_image_service.dart';

class BaseImageRepo {
  final BaseImageService _baseImageService;
  const BaseImageRepo(this._baseImageService);

  Future<DataState<List<BaseImage>>> getAllBaseImages() async {
    try {
      final httpResponse = await _baseImageService.getAllBaseImages();
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
