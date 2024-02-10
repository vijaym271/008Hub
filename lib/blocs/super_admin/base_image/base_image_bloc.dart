import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hub008/blocs/super_admin/base_image/base_image_event.dart';
import 'package:hub008/blocs/super_admin/base_image/base_image_state.dart';
import 'package:hub008/core/data_state.dart';
import 'package:hub008/models/content.dart';
import 'package:hub008/repos/super_admin/base_image_repo.dart';

class BaseImageBloc extends Bloc<BaseImageEvent, BaseImageState> {
  final BaseImageRepo _baseImageRepo;
  BaseImageBloc(this._baseImageRepo) : super(const BaseImageLoading()) {
    on<GetAllBaseImages>(onGetAllBaseImages);
    on<SelectBaseImage>(onSelectBaseImage);
    on<AddContent>(onAddContent);
    on<UpdateContentPosition>(onUpdateContentPosition);
  }

  FutureOr<void> onGetAllBaseImages(
      GetAllBaseImages event, Emitter<BaseImageState> emit) async {
    emit(const BaseImageLoading());
    final dataState = await _baseImageRepo.getAllBaseImages();
    if (dataState is DataSuccess) {
      emit(BaseImageDone(dataState.data!));
    }
    if (dataState is DataFailed) {
      emit(BaseImageError(dataState.error!));
    }
  }

  void onSelectBaseImage(SelectBaseImage event, Emitter<BaseImageState> emit) {
    if (event.selectedBaseImg.baseImg.isNotEmpty) {
      emit(BaseImageSelected(event.selectedBaseImg));
    } else {
      emit(const BaseImageSelected(null));
    }
  }

  void onAddContent(AddContent event, Emitter<BaseImageState> emit) {
    List<Content> contents = state.contents ?? [];
    contents.add(event.content);
    emit(ContentAdded(state.selectedBaseImg, contents));
  }

  void onUpdateContentPosition(
      UpdateContentPosition event, Emitter<BaseImageState> emit) {
    List<Content> contents = state.contents ?? [];
    int index = contents.indexWhere((e) => e.id == event.id);
    Offset position = event.offset;
    contents[index].top = position.dy.floorToDouble();
    // contents[index].right = position.dx.floorToDouble() + event.imgSize.width;
    // contents[index].bottom = position.dy.floorToDouble() + event.imgSize.height;
    contents[index].left = position.dx.floorToDouble();
    print('i am rop -->${contents[index].top}');
    print('i am left -->${contents[index].left}');
    emit(ContentAdded(state.selectedBaseImg, contents));
  }
}
