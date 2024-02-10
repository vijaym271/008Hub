import 'package:flutter/material.dart';

class AppError extends StatefulWidget {
  const AppError({super.key, required this.msg});

  final String msg;

  @override
  State<AppError> createState() => _AppErrorState();
}

class _AppErrorState extends State<AppError> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(widget.msg),
    );
  }
}
