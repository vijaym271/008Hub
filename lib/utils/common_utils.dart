import 'package:flutter/material.dart';
import 'package:hub008/utils/globals.dart';

void setDeviceDimensions(BuildContext context) {
  deviceWidth = MediaQuery.of(context).size.width.roundToDouble();
  deviceHeight = MediaQuery.of(context).size.height.roundToDouble();
  isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;
}

Color hexToColor(String hexColor) {
  try {
    hexColor = hexColor.replaceAll("#", ""); // Remove the '#' symbol
    return Color(int.parse("0xFF$hexColor"));
  } catch (e) {
    return Colors.black;
  }
}

double convertToPt(double input, double maxValue) {
  if (input == 0.0) return input;
  double minValue = 0.0;
  double result = (input - minValue) / (maxValue - minValue);
  return double.parse(result.toStringAsFixed(3));
}

double convertToPr(double input, double maxValue) {
  if (input == 0.0) return input;
  double minValue = 0.0;
  double result = (input * (maxValue - minValue)) + minValue;
  return double.parse(result.toStringAsFixed(3));
}

Size calculateTextSize({
  required String text,
  required TextStyle style,
  BuildContext? context,
}) {
  final double textScaleFactor = context != null
      ? MediaQuery.of(context).textScaler.scale(10) / 10
      : WidgetsBinding.instance.platformDispatcher.textScaleFactor;

  final TextDirection textDirection =
      context != null ? Directionality.of(context) : TextDirection.ltr;

  final TextPainter textPainter = TextPainter(
    text: TextSpan(text: text, style: style),
    textDirection: textDirection,
    textScaler: TextScaler.linear(textScaleFactor),
  )..layout(minWidth: 0, maxWidth: double.infinity);

  return textPainter.size;
}
