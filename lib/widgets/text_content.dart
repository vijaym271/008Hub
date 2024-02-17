import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hub008/blocs/super_admin/base_image/base_image_bloc.dart';
import 'package:hub008/models/content.dart';
import 'package:hub008/utils/common_utils.dart';

class TextContent extends StatefulWidget {
  const TextContent({
    super.key,
    required this.content,
    required this.imgSize,
    required this.onTextSizeChanged,
  });
  final Content content;
  final Function(double?, double?) onTextSizeChanged;
  final Size imgSize;

  @override
  State<TextContent> createState() => _TextContentState();
}

class _TextContentState extends State<TextContent> with WidgetsBindingObserver {
  final GlobalKey _textKey = GlobalKey();
  TextEditingController textEditingController = TextEditingController();
  FocusNode textNode = FocusNode();
  double? textHeight;
  double? textWidth;
  late Size imgSize;
  late Content content;

  @override
  void initState() {
    super.initState();
    content = widget.content;
    imgSize = widget.imgSize;
    Future.delayed(Duration.zero, () {
      textNode.requestFocus();
    });
    // textNode.requestFocus();
    // WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    // WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _updateTextDimensions(Size txtSize) {
    final RenderBox renderBox =
        _textKey.currentContext!.findRenderObject() as RenderBox;
    // Future.delayed(const Duration(milliseconds: 100), () {
    setState(() {
      textHeight =
          convertToPt(renderBox.size.height.toDouble(), imgSize.height);
      textWidth = convertToPt(renderBox.size.width.toDouble(), imgSize.width);
    });
    if (textWidth != txtSize.width) {
      widget.onTextSizeChanged(textHeight, textWidth);
    }
    // });
  }

  FontWeight getFontWeight(String fontWeight) {
    if (fontWeight == 'normal') return FontWeight.normal;
    if (fontWeight == 'bold') return FontWeight.bold;
    return FontWeight.values.firstWhere(
        (e) => e.toString().contains(fontWeight.toString()),
        orElse: () => FontWeight.w400);
  }

  void handleTextChange(String value) {
    content.text = value;
    print('i am content -->${content.toJson()}');
    context.read<BaseImageBloc>().add(UpdateContent(content: content));
  }

  @override
  Widget build(BuildContext context) {
    textEditingController.text = content.text;
    TextStyle textStyle = TextStyle(
        fontFamily: content.font,
        fontWeight: getFontWeight(content.fontWeight),
        height: 0,
        fontSize: content.fontSize * imgSize.width,
        color: hexToColor(content.color.toString()));
    InputDecoration textDecoration = const InputDecoration(
        border: InputBorder.none,
        isDense: true,
        contentPadding: EdgeInsets.zero);
    Size txtSize = Size(content.width, content.height);
    return Builder(
      builder: (context) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (_textKey.currentContext != null && (textWidth != txtSize.width)) {
            _updateTextDimensions(txtSize);
          }
        });
        return Column(
          children: [
            Visibility(
              visible: !content.isTextEdit,
              maintainState: true,
              child: Text(
                key: _textKey,
                content.text,
                style: textStyle,
              ),
            ),
            Visibility(
              visible: content.isTextEdit,
              child: SizedBox(
                width: textWidth != null
                    ? convertToPr(textWidth!, imgSize.width)
                    : (0.1 * imgSize.width),
                // color: Colors.red,
                child: TextFormField(
                    controller: textEditingController,
                    showCursor: false,
                    style: textStyle,
                    strutStyle: StrutStyle.fromTextStyle(textStyle),
                    decoration: textDecoration,
                    focusNode: textNode,
                    onChanged: handleTextChange),
              ),
            ),
          ],
        );
      },
    );
  }
}
