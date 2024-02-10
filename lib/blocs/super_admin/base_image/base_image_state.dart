import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:hub008/models/base_image.dart';
import 'package:hub008/models/content.dart';

abstract class BaseImageState extends Equatable {
  final List<BaseImage>? baseImages;
  final BaseImage? selectedBaseImg;
  final List<Content>? contents;
  final DioException? error;
  const BaseImageState(
      {this.baseImages, this.selectedBaseImg, this.contents, this.error});

  @override
  List<Object?> get props => [baseImages, selectedBaseImg, contents, error];
}

class BaseImageLoading extends BaseImageState {
  const BaseImageLoading();
}

class BaseImageDone extends BaseImageState {
  const BaseImageDone(List<BaseImage> baseImages)
      : super(baseImages: baseImages);
}

class BaseImageSelected extends BaseImageState {
  const BaseImageSelected(BaseImage? selectedBaseImg)
      : super(selectedBaseImg: selectedBaseImg);
}

class ContentAdded extends BaseImageState {
  const ContentAdded(BaseImage? selectedBaseImg, List<Content>? contents)
      : super(selectedBaseImg: selectedBaseImg, contents: contents);
}

class BaseImageError extends BaseImageState {
  const BaseImageError(DioException error) : super(error: error);
}
