import 'package:flutter/material.dart';
class DraggableWidget extends StatefulWidget {
  @override
  _DraggableWidgetState createState() => _DraggableWidgetState();
}

class _DraggableWidgetState extends State<DraggableWidget> {
  Offset position = const Offset(0.0, 0.0);
  double imgWidth = 0.0;
  double imgHeight = 0.0;
  double txtWidth = 0.2;
  double txtHeight = 0.2;
  GlobalKey _imgKey = GlobalKey();

  void getWidgetDimensions() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      RenderBox renderBox =
          _imgKey.currentContext!.findRenderObject() as RenderBox;
      Future.delayed(const Duration(milliseconds: 100), () {
        setState(() {
          imgWidth = renderBox.size.width.roundToDouble();
          imgHeight = renderBox.size.height.roundToDouble();
        });
      });
    });
  }

  double convertToPt(double input, double maxValue) {
    if (input == 0.0) return input;
    double minValue = 0.0;
    double result = (input - minValue) / (maxValue - minValue);
    return double.parse(result.toStringAsFixed(3));
  }

  double convertToPr(double input, double maxValue) {
    double minValue = 0.0;
    double result = (input * (maxValue - minValue)) + minValue;
    return double.parse(result.toStringAsFixed(3));
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    print('i am position -->$position');
    print('i am txt -->${txtWidth} ${txtHeight}');
//     print('i am img -->$imgWidth $imgHeight');
//     print('i am txt -->${txtWidth * imgWidth} ${txtHeight * imgHeight}');
//     print('i am device -->$screenWidth $screenHeight');
//     print('i am top -->${mapValue(position.dx, imgWidth)}');
//     print('i am left -->${mapValue(position.dx, imgWidth)}');

    return Scaffold(
      appBar: AppBar(title: Text('POC'),),
      body: Stack(
        children: <Widget>[
          Container(
            key: _imgKey,
            width: screenWidth,
            height: 0.7 * screenHeight,
            color: Colors.lightGreen,
            child: LayoutBuilder(builder: (context, constraint) {
              if (constraint.maxWidth.roundToDouble() != imgWidth) {
                getWidgetDimensions();
              }
              return const SizedBox.shrink();
            }),
          ),
          Positioned(
            left: position.dx * imgWidth,
            top: position.dy * imgHeight,
            child: GestureDetector(
              child: Container(
                width: txtWidth * imgWidth,
                height: txtHeight * imgHeight,
                color: Colors.red,
                child: const Center(
                  child: Text('Drag'),
                ),
              ),
              onPanUpdate: (offset) {
                setState(() {
                  double x =
                      (offset.delta.dx + convertToPr(position.dx, imgWidth))
                          .clamp(0.0, imgWidth - (txtWidth * imgWidth));
                  double y =
                      (offset.delta.dy + convertToPr(position.dy, imgHeight))
                          .clamp(0.0, imgHeight - (txtHeight * imgHeight));
                  position =
                      Offset(convertToPt(x, imgWidth), convertToPt(y, imgHeight));
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
