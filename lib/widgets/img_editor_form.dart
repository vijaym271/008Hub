import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hub008/blocs/super_admin/base/base_image_bloc.dart';
import 'package:hub008/blocs/super_admin/base_image/base_image_bloc.dart';
import 'package:hub008/models/content.dart';
import 'package:hub008/utils/globals.dart';
import 'package:hub008/widgets/app_loader.dart';
import 'package:screenshot/screenshot.dart';

class ImgEditorForm extends StatefulWidget {
  const ImgEditorForm({super.key, required this.contentId});
  final int contentId;
  @override
  State<ImgEditorForm> createState() => _ImgEditorFormState();
}

class _ImgEditorFormState extends State<ImgEditorForm>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late Content content;
  File? image;
  int? idToEdit;
  double previousScreenWidth = 0.0;
  double widgetWidth = 0.0;
  double widgetHeight = 0.0;
  TextEditingController mainTextController = TextEditingController();
  TextEditingController fontSizeTextController = TextEditingController();
  TextEditingController topTextController = TextEditingController();
  TextEditingController rightTextController = TextEditingController();
  TextEditingController bottomTextController = TextEditingController();
  TextEditingController leftTextController = TextEditingController();
  TextEditingController colorTextController = TextEditingController();
  TextEditingController rotateTextController = TextEditingController();
  String fontWeight = '';
  String fontFamily = '';

  List<String> fontList = [
    'Default',
    'Gagalin',
    'Fontjek',
    'FakeSerif',
    'Warpaint',
    'Gloss_And_Bloom',
    'Roboto',
    'Arial',
    'Helvetica',
    'Courier New',
    'Times New Roman',
  ];

  List<String> weightList = [
    "normal",
    "bold",
    "w100",
    "w200",
    "w300",
    "w400",
    "w500",
    "w600",
    "w700",
    "w800",
    "w900",
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      value: 0.5,
    );
  }

  void loadData(Content content) {
    mainTextController.text = content.text;
    fontSizeTextController.text = content.fontSize.toString();
    topTextController.text = content.top.toString();
    leftTextController.text = content.left.toString();
    colorTextController.text = content.color;
    rotateTextController.text = content.rotate.toString();
  }

  void _clearcontent() {
    mainTextController.clear();
    fontSizeTextController.clear();
    topTextController.clear();
    bottomTextController.clear();
    colorTextController.clear();
    rotateTextController.clear();
  }

  void _handleFieldChange(key, value) {
    formKey.currentState?.validate();
    Map<String, dynamic> data = content.toJson();
    data = {...data, key: value};
    context.read<BaseImageBloc>().add(UpdateContent(
          content: Content.fromJson({...data}),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18.0),
      child: GestureDetector(
        onVerticalDragUpdate: (details) {
          double newValue =
              _controller.value - details.primaryDelta! / deviceHeight;
          newValue = newValue.clamp(0.5, 1.0);
          _controller.value = newValue;
        },
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return BlocBuilder<BaseImageBloc, BaseImageState>(
              builder: (context, state) {
                if (state.isLoading == true) return const AppLoader();
                if (state.contents.isEmpty) return Container();
                Content selectedContent =
                    state.contents.firstWhere((e) => e.id == widget.contentId);
                loadData(selectedContent);
                content = selectedContent;
                return Form(
                  key: formKey,
                  child: SizedBox(
                    height: deviceHeight * _controller.value,
                    child: ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        const SizedBox(height: 14.0),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                  controller: mainTextController,
                                  decoration: const InputDecoration(
                                      labelText: 'Main Text'),
                                  validator: (value) {
                                    if (value == null) return null;
                                    if (value.trim().isEmpty) {
                                      return "Text shouldn't be empty";
                                    }
                                    return null;
                                  },
                                  onChanged: (text) {
                                    if (text.trim().length > 1) {
                                      _handleFieldChange(
                                          'text', mainTextController.text);
                                    }
                                  }),
                            ),
                            const SizedBox(width: 10.0),
                            Expanded(
                              child: DropdownButtonFormField<String>(
                                value: content.fontWeight,
                                onChanged: (text) =>
                                    _handleFieldChange('fontWeight', text),
                                items: weightList
                                    .map<DropdownMenuItem<String>>((e) {
                                  return DropdownMenuItem<String>(
                                    value: e,
                                    child: Text(e),
                                  );
                                }).toList(),
                                decoration: const InputDecoration(
                                    labelText: 'Font Weight'),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14.0),
                        Row(
                          children: [
                            Expanded(
                              child: DropdownButtonFormField<String>(
                                value: content.font,
                                isExpanded: true,
                                onChanged: (text) =>
                                    _handleFieldChange('font', text),
                                items:
                                    fontList.map<DropdownMenuItem<String>>((e) {
                                  return DropdownMenuItem<String>(
                                    value: e,
                                    child: Text(
                                      e,
                                      style: const TextStyle(
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                  );
                                }).toList(),
                                decoration: const InputDecoration(
                                    labelText: 'Font Family'),
                              ),
                            ),
                            const SizedBox(width: 10.0),
                            Expanded(
                                child: TextFormField(
                                    controller: fontSizeTextController,
                                    decoration: const InputDecoration(
                                        labelText: 'Font Size'),
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                            decimal: true),
                                    onChanged: (text) {
                                      double size = text.isNotEmpty
                                          ? double.parse(text)
                                          : 0.0;
                                      if (size > 0.0 && size <= 1.0) {
                                        _handleFieldChange(
                                            'fontSize',
                                            fontSizeTextController
                                                    .text.isNotEmpty
                                                ? double.parse(
                                                    fontSizeTextController.text)
                                                : 0.1);
                                      }
                                    })),
                          ],
                        ),
                        const SizedBox(height: 14.0),
                        Row(
                          children: [
                            Expanded(
                                child: TextFormField(
                              controller: topTextController,
                              decoration:
                                  const InputDecoration(labelText: 'Top'),
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      decimal: true),
                              onChanged: (text) => _handleFieldChange(
                                  'top',
                                  topTextController.text.isEmpty
                                      ? null
                                      : double.parse(topTextController.text)),
                            )),
                            const SizedBox(width: 10.0),
                            Expanded(
                                child: TextFormField(
                              controller: leftTextController,
                              decoration:
                                  const InputDecoration(labelText: 'Left'),
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      decimal: true),
                              onChanged: (text) => _handleFieldChange(
                                  'left',
                                  leftTextController.text.isEmpty
                                      ? null
                                      : double.parse(leftTextController.text)),
                            )),
                          ],
                        ),
                        const SizedBox(height: 14.0),
                        Row(
                          children: [
                            Expanded(
                                child: TextFormField(
                              controller: colorTextController,
                              decoration: const InputDecoration(
                                  labelText: 'Text Color'),
                              validator: (value) {
                                if (value == null || value.isEmpty) return null;
                                if (value.contains('#') && value.length > 7) {
                                  return "Color length not exceed 7";
                                }
                                if (!value.contains('#') && value.length > 6) {
                                  return "Color length not exceed 6";
                                }
                                return null;
                              },
                              onChanged: (text) => _handleFieldChange(
                                  'textColor',
                                  colorTextController.text.isEmpty
                                      ? null
                                      : colorTextController.text),
                            )),
                            const SizedBox(width: 10.0),
                            Expanded(
                                child: TextFormField(
                              controller: rotateTextController,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      decimal: true),
                              decoration:
                                  const InputDecoration(labelText: 'Rotate'),
                              validator: (value) {
                                if (value == null || value.isEmpty) return null;
                                if (double.parse(value) > 1.0 ||
                                    double.parse(value) < 0.0) {
                                  return "Value should between 0 to 1";
                                }
                                return null;
                              },
                              onChanged: (text) => _handleFieldChange(
                                  'rotate',
                                  rotateTextController.text.isEmpty
                                      ? null
                                      : double.parse(
                                          rotateTextController.text)),
                            )),
                          ],
                        ),
                        // const SizedBox(height: 20.0),
                        // ElevatedButton(
                        //     onPressed: () {
                        //       if (formKey.currentState!.validate()) {
                        //         setState(() {
                        //           // allChanges.add(content);
                        //           idToEdit = null;
                        //         });
                        //         _clearcontent();
                        //       }
                        //     },
                        //     child: Text(idToEdit != null
                        //         ? 'Update Changes'
                        //         : 'Add Changes')),
                        // const SizedBox(height: 20.0),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
