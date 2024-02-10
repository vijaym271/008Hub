// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_image_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _BaseImageService implements BaseImageService {
  _BaseImageService(
    this._dio, {
    this.baseUrl,
  });

  final Dio _dio;

  String? baseUrl;

  List<Map<String, dynamic>> localData = [
    {
      "id": 1,
      "baseImg": "assets/images/pongal_banner.jpeg",
      "baseImgSample": "assets/images/pongal_banner_sample.jpeg",
      "title": "Pongal banner",
      "desc": "abc"
    },
    {
      "id": 2,
      "baseImg": "assets/images/divan_banner.jpeg",
      "baseImgSample": "assets/images/divan_banner_sample.jpeg",
      "title": "Divan banner",
      "desc": "abc"
    },
    {
      "id": 3,
      "baseImg": "assets/images/divan1.jpeg",
      "baseImgSample": "assets/images/divan1_sample.jpeg",
      "title": "Divan1",
      "desc": "abc"
    },
    {
      "id": 3,
      "baseImg": "assets/images/divan.jpeg",
      "baseImgSample": "assets/images/divan_sample.jpeg",
      "title": "Divan",
      "desc": "abc"
    }
  ];

  @override
  Future<HttpResponse<List<BaseImage>>> getAllBaseImages() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<List<dynamic>>(
        _setStreamType<HttpResponse<List<BaseImage>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/posts',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    // var value = _result.data!
    //     .map((dynamic i) => BaseImage.fromJson(i as Map<String, dynamic>))
    //     .toList();
    var value = localData
        .map((dynamic i) => BaseImage.fromJson(i as Map<String, dynamic>))
        .toList();
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(
    String dioBaseUrl,
    String? baseUrl,
  ) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}
