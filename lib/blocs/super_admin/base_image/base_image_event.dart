part of 'base_image_bloc.dart';

sealed class BaseImageEvent extends Equatable {
  const BaseImageEvent();

  @override
  List<Object> get props => [];
}

class GetAllBaseImages extends BaseImageEvent {}

class SelectBaseImage extends BaseImageEvent {
  const SelectBaseImage(this.selectedBaseImg);
  final BaseImage selectedBaseImg;
}

class AddContent extends BaseImageEvent {
  const AddContent(this.content);
  final Content content;
}

class Loading extends BaseImageEvent {
  const Loading();
}

class UpdateContent extends BaseImageEvent {
  const UpdateContent({required this.content});
  final Content content;
}

class UpdateAllContent extends BaseImageEvent {
  const UpdateAllContent({this.clearAllFocus});
  final bool? clearAllFocus;
}
