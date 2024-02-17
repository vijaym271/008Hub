import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:hub008/core/data_state.dart';
import 'package:hub008/models/base_image.dart';
import 'package:hub008/models/content.dart';
import 'package:hub008/repos/super_admin/base_image_repo.dart';
part 'base_image_event.dart';
part 'base_image_state.dart';

class BaseImageBloc extends Bloc<BaseImageEvent, BaseImageState> {
  final BaseImageRepo _baseImageRepo;
  BaseImageBloc(this._baseImageRepo) : super(const BaseImageState()) {
    on<GetAllBaseImages>(onGetAllBaseImages);
    on<SelectBaseImage>(onSelectBaseImage);
    on<AddContent>(onAddContent);
    on<UpdateContent>(onUpdateContent);
    on<UpdateAllContent>(onUpdateAllContent);
  }

  // @override
  // void onTransition(Transition<BaseImageEvent, BaseImageState> transition) {
  //   super.onTransition(transition);
  //   print('i am Auth Transition -->$transition');
  // }

  FutureOr<void> onGetAllBaseImages(
      GetAllBaseImages event, Emitter<BaseImageState> emit) async {
    emit(state.copyWith(isLoading: true, isInitial: false, contents: []));
    final dataState = await _baseImageRepo.getAllBaseImages();
    if (dataState is DataSuccess) {
      emit(state.copyWith(isLoading: false, baseImages: dataState.data!));
    }
    if (dataState is DataFailed) {
      emit(state.copyWith(isError: dataState.error!));
    }
  }

  FutureOr<void> onSelectBaseImage(
      SelectBaseImage event, Emitter<BaseImageState> emit) {
    if (event.selectedBaseImg.baseImg.isNotEmpty) {
      emit(
          state.copyWith(selectedBaseImg: event.selectedBaseImg, contents: []));
    } else {
      emit(state.copyWith(selectedBaseImg: null));
    }
  }

  FutureOr<void> onAddContent(AddContent event, Emitter<BaseImageState> emit) {
    emit(state.copyWith(contents: [...state.contents, event.content]));
  }

  FutureOr<void> onUpdateContent(
      UpdateContent event, Emitter<BaseImageState> emit) {
    emit(state.copyWith(isLoading: true));
    List<Content> contents = [...state.contents];
    int index = contents.indexWhere((e) => e.id == event.content.id);
    contents[index] = event.content;
    emit(state.copyWith(isLoading: false, contents: contents));
  }

  FutureOr<void> onUpdateAllContent(
      UpdateAllContent event, Emitter<BaseImageState> emit) {
    emit(state.copyWith(isLoading: true));
    List<Content> contents = [...state.contents];
    if (event.clearAllFocus == true) {
      contents = contents.map((e) {
        e.isTextEdit = false;
        return e;
      }).toList();
    }
    emit(state.copyWith(isLoading: false, contents: contents));
  }
}
