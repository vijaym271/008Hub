import 'dart:math';
import 'package:drag_drop/pages/base_image_edit/base_image_content.dart';
import 'package:drag_drop/pages/base_image_edit/content.dart';
import 'package:drag_drop/widgets/toast_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:screenshot/screenshot.dart';

class BaseImageEdit extends StatefulWidget {
  const BaseImageEdit({
    super.key,
    required this.baseBgImage,
    this.contents = const <Content>[],
    this.isNetworkImage = false,
    this.isEditable = true,
  });

  final String baseBgImage;
  final List<Content> contents;
  final bool isNetworkImage;
  final bool isEditable;

  @override
  State<BaseImageEdit> createState() => _BaseImageEditState();
}

class _BaseImageEditState extends State<BaseImageEdit> {
  late String _baseBgImage;
  late List<Content> contents;
  late bool _isEditable;
  Size imgSize = const Size(0.0, 0.0);
  final _baseImgKey = GlobalKey();
  final _screenshotController = ScreenshotController();
  double rotateAngle = 0.0;
  int? selectedId;
  int? selectedInputId;

  @override
  void initState() {
    super.initState();
    _baseBgImage = widget.baseBgImage;
    contents = List.from(widget.contents);
    _isEditable = widget.isEditable;
  }

  void _getWidgetDimensions() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      RenderBox renderBox =
          _baseImgKey.currentContext!.findRenderObject() as RenderBox;
      Future.delayed(const Duration(milliseconds: 100), () {
        setState(() {
          imgSize = Size(renderBox.size.width.roundToDouble(),
              renderBox.size.height.roundToDouble());
        });
      });
    });
  }

  Widget _renderImagePicker() {
    if (_baseBgImage.isEmpty) return const SizedBox.shrink();
    return LayoutBuilder(builder: (context, constraints) {
      if ((constraints.maxWidth.roundToDouble()) != imgSize.width) {
        _getWidgetDimensions();
      }
      return ClipRRect(
        key: _baseImgKey,
        borderRadius: BorderRadius.circular(10.0),
        child: Image.asset(
          _baseBgImage,
          fit: BoxFit.fill,
        ),
      );
    });
  }

  Future<void> _captureAndSaveScreenshot() async {
    try {
      final imageBytes = await _screenshotController.capture();
      if (imageBytes != null) {
        final result = await ImageGallerySaver.saveImage(imageBytes);
        showToast(msg: 'Image Downloaded');
      }
    } catch (e) {
      showToast(msg: e.toString());
    }
  }

  void _handleContentChange(Content updatedContent) {
    int index = contents.indexWhere((e) => e.id == updatedContent.id);
    contents[index] = updatedContent;
    setState(() {});
  }

  void _clearAllFocus() {
    FocusScope.of(context).requestFocus(FocusNode());
    contents = contents.map((e) {
      e.isSelect = false;
      e.isInputSelect = false;
      return e;
    }).toList();
    selectedId = null;
    setState(() {});
  }

  void _handleSelectItemChanged(int id) {
    contents = contents.map((e) {
      if ((selectedId == id) && (e.id == id)) {
        e.isInputSelect = true;
      } else {
        e.isInputSelect = false;
      }
      return e;
    }).toList();
    selectedId = id;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Screenshot(
            controller: _screenshotController,
            child: AbsorbPointer(
              absorbing: !_isEditable,
              child: GestureDetector(
                onTap: _clearAllFocus,
                child: Stack(
                  children: [
                    _renderImagePicker(),
                    if (contents.isNotEmpty)
                      ...contents.map((e) => Positioned(
                            top: e.top! * imgSize.height,
                            left: e.left! * imgSize.width,
                            child: BaseImageContent(
                              content: e,
                              imgSize: imgSize,
                              selectedId: selectedId,
                              onSelectItemChanged: _handleSelectItemChanged,
                              onContentChanged: _handleContentChange,
                            ),
                          )),
                  ],
                ),
              ),
            )),
        const SizedBox(height: 10.0),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                  onPressed: () {
                    Map<String, dynamic> data = {
                      "baseBgImage": _baseBgImage,
                      "contents": [
                        ...contents.map((e) =>
                            {"text": e.text, "top": e.top, "left": e.left})
                      ]
                    };
                    print('export json -->${data}');
                  },
                  child: const Text('Save')),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: ElevatedButton(
                  onPressed: _captureAndSaveScreenshot,
                  child: const Text('Export')),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      Random random = Random();
                      int id = random.nextInt(900000) + 100000;
                      contents.add(
                        Content(id: id, text: "Text"),
                      );
                    });
                  },
                  child: const Text('Add')),
            ),
          ],
        )
      ],
    );
  }
}
