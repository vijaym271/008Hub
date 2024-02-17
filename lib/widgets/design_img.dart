import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hub008/blocs/super_admin/base_image/base_image_bloc.dart';
import 'package:hub008/models/base_image.dart';
import 'package:hub008/models/content.dart';
import 'package:hub008/utils/common_utils.dart';
import 'package:hub008/utils/globals.dart';
import 'package:hub008/widgets/app_loader.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hub008/widgets/img_editor_form.dart';
import 'package:hub008/widgets/text_content.dart';

class DesignImage extends StatefulWidget {
  const DesignImage({super.key});
  @override
  State<DesignImage> createState() => _DesignImageState();
}

class _DesignImageState extends State<DesignImage> {
  GlobalKey imgKey = GlobalKey();
  double imgWidth = 0.0;
  double imgHeight = 0.0;

  void getWidgetDimensions() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      RenderBox renderBox =
          imgKey.currentContext!.findRenderObject() as RenderBox;
      Future.delayed(const Duration(milliseconds: 100), () {
        setState(() {
          imgWidth = renderBox.size.width.roundToDouble();
          imgHeight = renderBox.size.height.roundToDouble();
        });
      });
    });
  }

  Widget _renderImagePicker(String baseImg) {
    return Container(
      key: imgKey,
      child: LayoutBuilder(builder: (context, constraint) {
        if (constraint.maxWidth.roundToDouble() != imgWidth) {
          getWidgetDimensions();
        }
        return ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Image.asset(
            baseImg,
            fit: BoxFit.fill,
          ),
        );
      }),
    );
  }

  Widget renderSvgWidget(Content data) {
    if (!data.logoImg.toString().contains('.svg')) {
      return Image.asset(
        data.logoImg ?? '',
        fit: BoxFit.fill,
        width: (imgWidth * data.width),
        height: (imgHeight * data.height),
      );
    }
    return SvgPicture.asset(
      data.logoImg ?? 'assets/logos/Likya.svg',
      width: (imgWidth * data.width),
      height: (imgHeight * data.height),
    );
  }

  void handleTap(Content data) {
    data.isTextEdit = true;
    context.read<BaseImageBloc>().add(UpdateContent(content: data));
  }

  void handleDoubleTap(Content data) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        enableDrag: true,
        builder: (context) {
          return ImgEditorForm(contentId: data.id);
        });
  }

  void handlePanUpdate(DragUpdateDetails details, Content data) {
    removeFocus();
    double top = data.top;
    double left = data.left;
    double width = data.width;
    double height = data.height;
    double x = (details.delta.dx + convertToPr(left, imgWidth))
        .clamp(0.0, imgWidth - (width * imgWidth));
    double y = (details.delta.dy + convertToPr(top, imgHeight))
        .clamp(0.0, imgHeight - (height * imgHeight));
    data.top = convertToPt(y, imgHeight);
    data.left = convertToPt(x, imgWidth);
    context.read<BaseImageBloc>().add(UpdateContent(content: data));
  }

  Positioned renderPositionedWidget(Content data, BaseImageState state) {
    double top = data.top;
    double left = data.left;
    print('i am texttoedit -->${data.isTextEdit}');
    return Positioned(
        left: left * imgWidth,
        top: top * imgHeight,
        child: GestureDetector(
          child: Transform.rotate(
            angle: data.rotate * 3.1415927,
            child: data.isText == false
                ? renderSvgWidget(data)
                : TextContent(
                    key: GlobalKey(debugLabel: data.id.toString()),
                    content: data,
                    imgSize: Size(imgWidth, imgHeight),
                    onTextSizeChanged: (textHeight, textWidth) {
                      data.width = textWidth!;
                      data.height = textHeight!;
                      context
                          .read<BaseImageBloc>()
                          .add(UpdateContent(content: data));
                    }),
          ),
          onTap: () => handleTap(data),
          // onDoubleTap: () => handleDoubleTap(data),
          onPanUpdate: (details) => handlePanUpdate(details, data),
        ));
  }

  List<Positioned> _renderAllChanges(
      List<Content> contents, BaseImageState state) {
    return contents.map((e) {
      return renderPositionedWidget(e, state);
    }).toList();
  }

  void removeFocus() {
    if (isKeyboardVisible) {
      context
          .read<BaseImageBloc>()
          .add(const UpdateAllContent(clearAllFocus: true));
      FocusScope.of(context).requestFocus(FocusNode());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BaseImageBloc, BaseImageState>(
      builder: (context, state) {
        if (state.isInitial == true) return const SizedBox.shrink();
        if (state.isLoading == true) return const AppLoader();
        BaseImage? imageData = state.selectedBaseImg;
        if (imageData == null) {
          return const SizedBox();
        }
        List<Content> contents = state.contents;
        return InteractiveViewer(
          child: Stack(
            children: <Widget>[
              GestureDetector(
                  onTap: removeFocus,
                  child: _renderImagePicker(imageData.baseImg)),
              if (contents.isNotEmpty) ..._renderAllChanges(contents, state),
            ],
          ),
        );
      },
    );
  }
}
