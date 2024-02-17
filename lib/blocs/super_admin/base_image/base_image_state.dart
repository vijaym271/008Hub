part of 'base_image_bloc.dart';

class BaseImageState extends Equatable {
  final bool? isInitial;
  final bool? isLoading;
  final List<BaseImage>? baseImages;
  final BaseImage? selectedBaseImg;
  final List<Content> contents;
  final DioException? isError;
  const BaseImageState(
      {this.isInitial = true,
      this.isLoading,
      this.baseImages,
      this.selectedBaseImg,
      this.contents = const [],
      this.isError});

  BaseImageState copyWith(
      {bool? isInitial,
      bool? isLoading,
      List<BaseImage>? baseImages,
      BaseImage? selectedBaseImg,
      List<Content>? contents,
      DioException? isError}) {
    return BaseImageState(
      isInitial: isInitial ?? this.isInitial,
      isLoading: isLoading ?? this.isLoading,
      baseImages: baseImages ?? this.baseImages,
      selectedBaseImg: selectedBaseImg ?? this.selectedBaseImg,
      contents: contents ?? this.contents,
      isError: isError ?? this.isError,
    );
  }

  @override
  List<Object?> get props =>
      [isLoading, baseImages, selectedBaseImg, contents, isError];
}
