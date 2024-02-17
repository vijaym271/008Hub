// import 'dart:async';
// import 'dart:ui';
// import 'package:bloc/bloc.dart';
// import 'package:dio/dio.dart';
// import 'package:equatable/equatable.dart';
// import 'package:hub008/core/data_state.dart';
// import 'package:hub008/models/base_image.dart';
// import 'package:hub008/models/content.dart';
// import 'package:hub008/repos/super_admin/base_image_repo.dart';
// part 'base_image_event.dart';
// part 'base_image_state.dart';

// class BaseImageBloc extends Bloc<BaseImageEvent, BaseImageState> {
//   final BaseImageRepo _baseImageRepo;
//   BaseImageBloc(this._baseImageRepo) : super(BaseImageInitial()) {
//     on<GetAllBaseImages>(onGetAllBaseImages);
//     on<SelectBaseImage>(onSelectBaseImage);
//     on<AddContent>(onAddContent);
//     on<UpdateContentPosition>(onUpdateContent);
//     on<SetContentEdit>(onSetContentEdit);
//   }

//   @override
//   void onTransition(Transition<BaseImageEvent, BaseImageState> transition) {
//     super.onTransition(transition);
//     print('i am Auth Transition -->$transition');
//   }

//   FutureOr<void> onGetAllBaseImages(
//       GetAllBaseImages event, Emitter<BaseImageState> emit) async {
//     emit(BaseImageLoading());
//     final dataState = await _baseImageRepo.getAllBaseImages();
//     if (dataState is DataSuccess) {
//       emit(BaseImageDone(dataState.data!));
//     }
//     if (dataState is DataFailed) {
//       emit(BaseImageError(dataState.error!));
//     }
//   }

//   FutureOr<void> onSelectBaseImage(
//       SelectBaseImage event, Emitter<BaseImageState> emit) {
//     if (event.selectedBaseImg.baseImg.isNotEmpty) {
//       emit(BaseImageSelected(event.selectedBaseImg));
//     } else {
//       emit(const BaseImageSelected(null));
//     }
//   }

//   FutureOr<void> onAddContent(AddContent event, Emitter<BaseImageState> emit) {
//     emit(ContentAdded(
//         state.selectedBaseImg, [...(state.contents ?? []), event.content]));
//   }

//   FutureOr<void> onUpdateContent(
//       UpdateContentPosition event, Emitter<BaseImageState> emit) {
//     List<Content> contents = List.from(state.contents ?? []);
//     int index = contents.indexWhere((e) => e.id == event.id);
//     Offset position = event.offset;
//     contents[index].top = position.dy;
//     contents[index].left = position.dx;
//     emit(PositionUpdated(state.selectedBaseImg, List.from(contents)));
//   }

//   FutureOr<void> onSetContentEdit(
//       SetContentEdit event, Emitter<BaseImageState> emit) {
//     List<Content> contents = List.from(state.contents ?? []);
//     int index = contents.indexWhere((e) => e.id == event.id);
//     contents[index].isEdit = !contents[index].isEdit;
//     emit(PositionUpdated(state.selectedBaseImg, List.from(contents)));
//   }
// }
