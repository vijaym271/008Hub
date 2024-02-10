import 'package:flutter/material.dart';
import 'package:hub008/utils/globals.dart';

void setDeviceDimensions(BuildContext context) {
  deviceWidth = MediaQuery.of(context).size.width;
  deviceHeight = MediaQuery.of(context).size.height;
}

Color hexToColor(String hexColor) {
  try {
    hexColor = hexColor.replaceAll("#", ""); // Remove the '#' symbol
    return Color(int.parse("0xFF$hexColor"));
  } catch (e) {
    return Colors.black;
  }
}
