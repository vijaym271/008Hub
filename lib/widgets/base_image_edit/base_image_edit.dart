import 'dart:convert';
import 'dart:math';
import 'package:drag_drop/pages/base_image_edit/base_image_content.dart';
import 'package:drag_drop/pages/base_image_edit/content.dart';
import 'package:drag_drop/widgets/toast_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:screenshot/screenshot.dart';

class BaseImageEdit extends StatefulWidget {
  const BaseImageEdit(
      {super.key,
      required this.baseBgImage,
      this.contents = const <Content>[],
      this.enableDrag = false,
      this.isNetworkImage = false,
      this.enableEdit = false,
      this.enableRotate = false,
      this.showAddBtn = false,
      this.showExportBtn = false,
      this.showSaveBtn = false,
      this.onSaved});

  final String baseBgImage;
  final List<Content> contents;
  final bool enableDrag;
  final bool isNetworkImage;
  final bool enableEdit;
  final bool enableRotate;
  final bool showAddBtn;
  final bool showExportBtn;
  final bool showSaveBtn;
  final ValueChanged<Map<String, dynamic>>? onSaved;

  @override
  State<BaseImageEdit> createState() => _BaseImageEditState();
}

class _BaseImageEditState extends State<BaseImageEdit> {
  late String _baseBgImage;
  late List<Content> _contents;
  late bool _enableEdit;
  late bool _enableDrag;
  late bool _enableRotate;
  late bool _showAddBtn;
  late bool _showExportBtn;
  late bool _showSaveBtn;
  Size imgSize = const Size(0.0, 0.0);
  final _baseImgKey = GlobalKey();
  final _screenshotController = ScreenshotController();
  double rotateAngle = 0.0.toDouble();
  int? selectedId;
  int? selectedInputId;
  List<Content> deepCloneContent = [];

  @override
  void initState() {
    super.initState();
    deepCloneContent =
        widget.contents.map((content) => content.clone()).toList();
  }

  void _initMethod() {
    _baseBgImage = widget.baseBgImage;
    _contents = widget.contents;
    _enableEdit = widget.enableEdit;
    _enableDrag = widget.enableDrag;
    _enableRotate = widget.enableRotate;
    _showAddBtn = widget.showAddBtn;
    _showExportBtn = widget.showExportBtn;
    _showSaveBtn = widget.showSaveBtn;
    //replace same text with it is empty
    if (_contents.any((e) => e.text!.isEmpty)) {
      bool isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;
      if (!isKeyboardVisible) {
        int index = _contents.indexWhere((item) =>
            item.id == _contents.firstWhere((e) => e.text!.isEmpty).id);
        _contents[index].text = deepCloneContent[index].text;
      }
    }
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
    int index = _contents.indexWhere((e) => e.id == updatedContent.id);
    _contents[index] = updatedContent;
    setState(() {});
  }

  void _clearAllFocus() {
    FocusScope.of(context).requestFocus(FocusNode());
    _contents = _contents.map((e) {
      e.isSelect = false;
      e.isInputSelect = false;
      return e;
    }).toList();
    selectedId = null;
    setState(() {});
  }

  void _handleSelectItemChanged(int id) {
    _contents = _contents.map((e) {
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

  List<Positioned> _renderContents() {
    return _contents
        .map((e) => Positioned(
              key: Key(e.id.toString()),
              top: e.top! * imgSize.height,
              left: e.left! * imgSize.width,
              child: RotationTransition(
                turns: AlwaysStoppedAnimation(e.rotateAngle!),
                child: Column(
                  children: [
                    BaseImageContent(
                      content: e,
                      imgSize: imgSize,
                      enableDrag: _enableDrag,
                      selectedId: selectedId,
                      onSelectItemChanged: _handleSelectItemChanged,
                      onContentChanged: _handleContentChange,
                    ),
                    Visibility(
                      visible: (selectedId == e.id) && _enableRotate,
                      child: GestureDetector(
                          onPanUpdate: (details) {
                            e.rotateAngle =
                                e.rotateAngle! - details.delta.dx / 180;
                            setState(() {});
                          },
                          child: const Icon(Icons.rotate_right)),
                    )
                  ],
                ),
              ),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    print('i am parent -->');
    _initMethod();
    return Column(
      children: [
        Screenshot(
            controller: _screenshotController,
            child: AbsorbPointer(
              absorbing: !_enableEdit,
              child: GestureDetector(
                onTap: _clearAllFocus,
                child: Stack(
                  children: [
                    _renderImagePicker(),
                    if (_contents.isNotEmpty) ..._renderContents()
                  ],
                ),
              ),
            )),
        const SizedBox(height: 10.0),
        Wrap(
          spacing: 10.0,
          runSpacing: 5.0,
          children: [
            if (_showSaveBtn)
              SizedBox(
                width: 100,
                child: ElevatedButton(
                    onPressed: () {
                      Map<String, dynamic> data = {
                        "baseBgImage": _baseBgImage,
                        "contents": _contents
                            .map((e) => jsonEncode(e.toJson()))
                            .toList()
                      };
                      print('export json -->${data}');
                      if (widget.onSaved != null) widget.onSaved!(data);
                    },
                    child: const Text('Save')),
              ),
            if (_showExportBtn)
              SizedBox(
                width: 100,
                child: ElevatedButton(
                    onPressed: _captureAndSaveScreenshot,
                    child: const Text('Export')),
              ),
            if (_showAddBtn)
              SizedBox(
                width: 100,
                child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        Random random = Random();
                        int id = random.nextInt(900000) + 100000;
                        _contents.add(
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
