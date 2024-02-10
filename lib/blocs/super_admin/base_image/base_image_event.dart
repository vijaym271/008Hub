import 'package:flutter/material.dart';
import 'package:hub008/models/base_image.dart';
import 'package:hub008/models/content.dart';

abstract class BaseImageEvent {
  const BaseImageEvent();
}

class GetAllBaseImages extends BaseImageEvent {
  const GetAllBaseImages();
}

class SelectBaseImage extends BaseImageEvent {
  const SelectBaseImage(this.selectedBaseImg);
  final BaseImage selectedBaseImg;
}

class AddContent extends BaseImageEvent {
  const AddContent(this.content);
  final Content content;
}

class UpdateContentPosition extends BaseImageEvent {
  const UpdateContentPosition(this.id, this.offset);
  final int id;
  final Offset offset;
}
