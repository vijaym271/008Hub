import 'package:flutter/material.dart';
import 'package:hub008/utils/globals.dart';

void setDeviceDimensions(BuildContext context) {
  deviceWidth = MediaQuery.of(context).size.width;
  deviceHeight = MediaQuery.of(context).size.height;
}
