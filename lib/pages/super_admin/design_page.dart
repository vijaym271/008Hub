import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hub008/blocs/super_admin/base_image/base_image_bloc.dart';
import 'package:hub008/config/constants.dart';
import 'package:hub008/models/base_image.dart';
import 'package:hub008/models/content.dart';
import 'package:hub008/pages/super_admin/base_image_page.dart';
import 'package:hub008/widgets/app_dialog.dart';
import 'package:hub008/widgets/app_loader.dart';
import 'package:hub008/widgets/design_img.dart';
import 'package:hub008/widgets/poc.dart';

class DesignPage extends StatefulWidget {
  const DesignPage({super.key});

  @override
  State<DesignPage> createState() => _DesignPageState();
}

class _DesignPageState extends State<DesignPage> {
  bool isExpanded = false;

  void alertDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Alert'),
            content: const Text('Current changes will be discard'),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel')),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const BaseImagePage()));
                  },
                  child: const Text('Ok'))
            ],
          );
        });
  }

  Widget _renderBrowseBtn(BaseImageState state) {
    return ElevatedButton(
        onPressed: () {
          if (state.contents.isNotEmpty) {
            alertDialog();
          } else {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const BaseImagePage()));
          }
        },
        child: const Text(Constants.browseImg));
  }

  Widget _renderSaveBtn() {
    return ElevatedButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const BaseImagePage()));
        },
        child: const Text(Constants.saveImage));
  }

  // Widget _renderSampleImg(BaseImage imageData) {
  //   return Positioned(
  //     bottom: 10.0,
  //     child: ClipRRect(
  //       borderRadius: BorderRadius.circular(10.0),
  //       child: Image.asset(
  //         imageData.baseImgSample,
  //         fit: BoxFit.fill,
  //         width: 200,
  //         height: 200,
  //       ),
  //     ),
  //   );
  // }

  Widget _renderSelectedImg(BaseImage imageData, BaseImageState state) {
    return Column(
      children: [
        const DesignImage(),
        const SizedBox(height: 6.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _renderSaveBtn(),
            _renderBrowseBtn(state),
          ],
        )
      ],
    );
  }

  Widget _renderFloatingBtn() {
    Random random = Random();
    int id = random.nextInt(900000) + 100000;
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Visibility(
          visible: isExpanded,
          child: Column(
            children: [
              FloatingActionButton(
                onPressed: () {
                  context
                      .read<BaseImageBloc>()
                      .add(AddContent(Content(id: id, isText: true)));
                  setState(() => isExpanded = false);
                },
                tooltip: Constants.insertText,
                child: const Icon(Icons.text_fields),
              ),
              const SizedBox(height: 16.0),
              FloatingActionButton(
                onPressed: () {
                  context
                      .read<BaseImageBloc>()
                      .add(AddContent(Content(id: id, isText: false)));
                  setState(() => isExpanded = false);
                },
                tooltip: Constants.insertImage,
                child: const Icon(Icons.image),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16.0),
        FloatingActionButton(
          onPressed: () {
            setState(() => isExpanded = !isExpanded);
          },
          child: isExpanded ? const Icon(Icons.close) : const Icon(Icons.add),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Constants.designPage),
      ),
      body: BlocBuilder<BaseImageBloc, BaseImageState>(
        builder: (context, state) {
          if (state.isLoading == true) return const AppLoader();
          if (state.selectedBaseImg != null) {
            BaseImage imageData = state.selectedBaseImg!;
            return SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _renderSelectedImg(imageData, state)),
            );
          }
          return Center(child: _renderBrowseBtn(state));
        },
      ),
      floatingActionButton: BlocBuilder<BaseImageBloc, BaseImageState>(
        builder: (context, state) {
          if (state.selectedBaseImg != null) return _renderFloatingBtn();
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
