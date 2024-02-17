import 'package:flutter/material.dart';

void appDialog({
  required BuildContext context,
  String? title = '',
  Widget? content,
}) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: title!.isEmpty ? null : Text(title),
          content: content,
        );
      });
}
