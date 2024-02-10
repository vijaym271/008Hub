import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hub008/blocs/super_admin/base_image/base_image_bloc.dart';
import 'package:hub008/blocs/super_admin/base_image/base_image_event.dart';
import 'package:hub008/blocs/super_admin/base_image/base_image_state.dart';
import 'package:hub008/models/base_image.dart';
import 'package:hub008/models/content.dart';
import 'package:hub008/utils/common_utils.dart';
import 'package:screenshot/screenshot.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DesignImage extends StatefulWidget {
  const DesignImage({super.key});

  @override
  State<DesignImage> createState() => _DesignImageState();
}

class _DesignImageState extends State<DesignImage> {
  double _scaleFactor = 1.0;
  double imgWidth = 0.0;
  double imgHeight = 0.0;
  final GlobalKey _stackKey = GlobalKey();
  final GlobalKey _myWidgetKey = GlobalKey();
  final _screenshotController = ScreenshotController();

  void _getWidgetDimensions() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      RenderBox renderBox =
          _myWidgetKey.currentContext!.findRenderObject() as RenderBox;
      Future.delayed(const Duration(milliseconds: 100), () {
        setState(() {
          imgWidth = renderBox.size.width.roundToDouble();
          imgHeight = renderBox.size.height.roundToDouble();
        });
      });
    });
  }

  // Future<void> _captureAndSaveScreenshot(BuildContext context) async {
  //   try {
  //     final imageBytes = await _screenshotController.capture();
  //     if (imageBytes != null) {
  //       final result = await ImageGallerySaver.saveImage(imageBytes);
  //       print('i am result -->$result');
  //     }
  //   } catch (e) {}
  // }

  Widget _renderImagePicker(String imgUrl) {
    return ClipRRect(
      key: _myWidgetKey,
      borderRadius: BorderRadius.circular(10.0),
      child: Image.asset(
        imgUrl,
        fit: BoxFit.fill,
        // width: 500,
        // height: 500,
      ),
    );
  }

  Widget renderSvgWidget(Content data) {
    if (!data.logoImg.toString().contains('.svg')) {
      return Image.asset(
        data.logoImg ?? '',
        fit: BoxFit.fill,
        width:
            data.logoWidth != null ? (imgWidth * data.logoWidth!) / 100 : 25.0,
        height: data.logoHeight != null
            ? (imgHeight * data.logoHeight!) / 100
            : 25.0,
      );
    }
    return SvgPicture.asset(
      data.logoImg ?? 'assets/logos/Likya.svg',
      width: data.logoWidth != null ? (imgWidth * data.logoWidth!) / 100 : 25.0,
      height:
          data.logoHeight != null ? (imgHeight * data.logoHeight!) / 100 : 25.0,
    );
  }

// Offset(8.0, 88.0)
//  Size(813.1, 813.1)
// Size(376.7, 376.7)
  Positioned renderPositionedWidget(Content data) {
    print('i am here -->${imgWidth} ${imgHeight}');
    print('i am here 11-->${data.top} ${data.left}');
    return Positioned(
        top: data.top != null ? (data.top ?? 0.0) : 0.0,
        left: data.left != null ? (data.left ?? 0.0) : 0.0,
        // top: data.top != null ? (data.top! * imgHeight) / 100 : null,
        // left: data.left != null ? (data.left! * imgWidth) / 100 : null,
        // right: data.right != null ? (data.right! * imgWidth) / 100 : null,
        // bottom: data.bottom != null ? (data.bottom! * imgHeight) / 100 : null,
        child: GestureDetector(
          onPanUpdate: (details) {
            final RenderBox? box =
                _myWidgetKey.currentContext?.findRenderObject() as RenderBox?;
            final Offset? position = box?.localToGlobal(Offset.zero);
            // if (position != null) {
            double x = (data.left ?? 0.0) + details.delta.dx;
            double y = (data.top ?? 0.0) + details.delta.dy;
            x = x.clamp(0.0, imgWidth - 80.0);
            y = y.clamp(0.0, imgHeight - 50.0);
            context
                .read<BaseImageBloc>()
                .add(UpdateContentPosition(data.id, Offset(x, y)));
            setState(() {});
            // }
          },
          child: Transform.rotate(
            angle: data.rotate != null ? data.rotate! * 3.1415927 : 0.0,
            child: data.isText == false
                ? renderSvgWidget(data)
                : Text(
                    data.text,
                    style: TextStyle(
                        fontFamily: data.font,
                        fontSize: ((data.fontSize) * imgWidth) / 100,
                        color: hexToColor(data.color.toString())),
                  ),
          ),
        ));
    // return Positioned(
    //     top: data.top,
    //     left: data.left,
    //     // top: data.top != null ? (data.top! * imgHeight) / 100 : null,
    //     // left: data.left != null ? (data.left! * imgWidth) / 100 : null,
    //     // right: data.right != null ? (data.right! * imgWidth) / 100 : null,
    //     // bottom: data.bottom != null ? (data.bottom! * imgHeight) / 100 : null,
    //     child: Draggable(
    //       maxSimultaneousDrags: 1,
    //       feedback: Transform.scale(scale: 0.8, child: Text(data.text)),
    //       onDragEnd: (details) {
    //         final RenderBox? box =
    //             _myWidgetKey.currentContext?.findRenderObject() as RenderBox?;
    //         final Offset? position = box?.localToGlobal(Offset.zero);
    //         if (position != null) {
    //           double x = (details.offset.dx - position.dx) / _scaleFactor;
    //           double y = (details.offset.dy - position.dy) / _scaleFactor;
    //           x = x.clamp(0.0, imgWidth - 80.0);
    //           y = y.clamp(0.0, imgHeight - 50.0);
    //           context
    //               .read<BaseImageBloc>()
    //               .add(UpdateContentPosition(data.id, Offset(x, y)));
    //           setState(() {});
    //         }
    //       },
    //       child: Transform.rotate(
    //         angle: data.rotate != null ? data.rotate! * 3.1415927 : 0.0,
    //         child: data.isText == false
    //             ? renderSvgWidget(data)
    //             : Text(
    //                 data.text,
    //                 style: TextStyle(
    //                     fontFamily: data.font,
    //                     fontSize: ((data.fontSize) * imgWidth) / 100,
    //                     color: hexToColor(data.color.toString())),
    //               ),
    //       ),
    //     ));
  }

  List<Positioned> _renderAllChanges(List<Content> contents) {
    return contents.map((e) {
      return renderPositionedWidget(e);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BaseImageBloc, BaseImageState>(
      builder: (context, state) {
        if (state is BaseImageSelected || state is ContentAdded) {
          BaseImage? imageData = state.selectedBaseImg;
          if (imageData == null) {
            return const SizedBox();
          }
          List<Content> contents = state.contents ?? [];
          return Column(
            children: [
              LayoutBuilder(
                builder: (context, constraints) {
                  if ((constraints.maxWidth.roundToDouble()) != imgWidth) {
                    _getWidgetDimensions();
                  }
                  return Screenshot(
                    controller: _screenshotController,
                    child: InteractiveViewer(
                      onInteractionUpdate: (details) {
                        _scaleFactor =
                            (_scaleFactor * details.scale).clamp(1.0, 2.5);
                      },
                      child: Stack(
                        key: _stackKey,
                        children: [
                          _renderImagePicker(imageData.baseImg),
                          if (contents.isNotEmpty)
                            ..._renderAllChanges(contents),
                        ],
                      ),
                    ),
                  );
                },
              ),
              // const SizedBox(height: 10.0),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     TextButton(
              //         onPressed: () {
              //           _captureAndSaveScreenshot(context);
              //         },
              //         child: const Text('Export Image')),
              //   ],
              // ),
              const SizedBox(height: 10.0),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }
}
