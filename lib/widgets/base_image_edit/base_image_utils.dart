import 'package:flutter/material.dart';

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
