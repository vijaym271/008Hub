import 'package:drag_drop/pages/base_image_edit/base_image_utils.dart';
import 'package:drag_drop/pages/base_image_edit/content.dart';
import 'package:flutter/material.dart';

// class ChildBaseContent extends StatelessWidget {
//   const ChildBaseContent(
//       {super.key, required this.imgSize, required this.child});
//   final Size imgSize;
//   final BaseImageContent child;

//   @override
//   Widget build(BuildContext context) {
//     return child.copyWith(imgSize: imgSize);
//   }
// }

class BaseImageContent extends StatefulWidget {
  const BaseImageContent(
      {super.key,
      this.imgSize,
      required this.content,
      required this.enableDrag,
      required this.selectedId,
      required this.onSelectItemChanged,
      required this.onContentChanged});
  final Size? imgSize;
  final Content content;
  final int? selectedId;
  final bool enableDrag;
  final ValueChanged<int> onSelectItemChanged;
  final ValueChanged<Content> onContentChanged;

  // BaseImageContent copyWith({Size? imgSize}) {
  //   return BaseImageContent(
  //     key: UniqueKey(), // or use the existing key if key is relevant
  //     imgSize: imgSize,
  //     content: content,
  //   );
  // }

  @override
  State<BaseImageContent> createState() => _BaseImageContentState();
}

class _BaseImageContentState extends State<BaseImageContent> {
  final GlobalKey _textKey = GlobalKey();
  late Size _imgSize;
  late Content content;
  late int? _selectedId;
  late bool _enableDrag;
  double? textWidth;
  double? textHeight;
  FocusNode textNode = FocusNode();

  @override
  void didUpdateWidget(covariant BaseImageContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    textNode.requestFocus();
  }

  void _initMethod() {
    content = widget.content;
    _imgSize = widget.imgSize!;
    _selectedId = widget.selectedId;
    _enableDrag = widget.enableDrag;
  }

  Widget _renderOnlyText(TextStyle textStyle) {
    return Container(
        // width: textWidth != null
        //     ? convertToPr(textWidth!, _imgSize.width)
        //     : null,
        // color: (_selectedId == content.id) ? Colors.red : Colors.white,
        decoration: BoxDecoration(
          border: (_selectedId == content.id)
              ? Border.all(
                  color: Colors.blue,
                  width: 1.0,
                )
              : null,
        ),
        child: LayoutBuilder(builder: (context, constraints) {
          final textPainter = TextPainter(
            text: TextSpan(text: content.text, style: textStyle),
            textDirection: TextDirection.ltr,
            maxLines: 1,
          )..layout(maxWidth: constraints.maxWidth);
          if (_imgSize.width > 0.0) {
            double txtHeight =
                convertToPt(textPainter.size.height, _imgSize.height);
            double txtWidth =
                convertToPt(textPainter.size.width, _imgSize.width);
            if (txtWidth != textWidth) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                setState(() {
                  textWidth = txtWidth;
                  textHeight = txtHeight;
                });
              });
            }
          }
          return Text(content.text!, key: _textKey, style: textStyle);
        }));
  }

  Widget _renderTextInput(TextStyle textStyle) {
    InputDecoration textDecoration = const InputDecoration(
        border: InputBorder.none,
        contentPadding: EdgeInsets.zero,
        isDense: true);
    return Container(
        width: convertToPr(textWidth!, _imgSize.width) * 1.1,
        height: convertToPr(textHeight!, _imgSize.height),
        // color: Colors.blue,
        child: TextFormField(
          initialValue: content.text,
          style: textStyle,
          decoration: textDecoration,
          focusNode: content.isInputSelect! ? textNode : null,
          onChanged: (value) {
            content.text = value;
            widget.onContentChanged(content);
          },
        ));
  }

  Widget _renderTextContent() {
    TextStyle textStyle = TextStyle(
        fontFamily: content.fontFamily,
        height: 1,
        fontSize: content.fontSize! * _imgSize.width,
        color: hexToColor(content.textColor.toString()));
    return Column(
      children: [
        Visibility(
            visible: !content.isInputSelect!,
            maintainState: true,
            child: _renderOnlyText(textStyle)),
        if (textWidth != null && textHeight != null)
          Visibility(
              visible: content.isInputSelect!,
              child: _renderTextInput(textStyle))
      ],
    );
  }

  Widget _renderContent() {
    return _renderTextContent();
  }

  void _handleTap() {
    widget.onSelectItemChanged(content.id);
  }

  void _handlePanUpdate(DragUpdateDetails details) {
    // print('i am 0000 ->$top -->$left');
    // print('i am 1111 ->${textHeight} -->${textWidth}');
    // print('i am 2222 ->${_imgSize.height} -->${_imgSize.width}');
    // print('i am 3333 ->${details.delta.dy} -->${details.delta.dx}');
    if ((textWidth != null && textHeight != null) && _enableDrag) {
      double x = (details.delta.dx + convertToPr(content.left!, _imgSize.width))
          .clamp(0.0, _imgSize.width - (textWidth! * _imgSize.width));
      double y = (details.delta.dy + convertToPr(content.top!, _imgSize.height))
          .clamp(0.0, _imgSize.height - (textHeight! * _imgSize.height));
      content.top = convertToPt(y, _imgSize.height);
      content.left = convertToPt(x, _imgSize.width);
      widget.onContentChanged(content);
    }
  }

  @override
  Widget build(BuildContext context) {
    _initMethod();
    print('i am child -->$content');
    return GestureDetector(
        onTap: _handleTap,
        onPanUpdate: _handlePanUpdate,
        child: _renderContent());
  }
}
