import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hub008/blocs/super_admin/base_image/base_image_bloc.dart';
import 'package:hub008/blocs/super_admin/base_image/base_image_event.dart';
import 'package:hub008/blocs/super_admin/base_image/base_image_state.dart';
import 'package:hub008/config/constants.dart';
import 'package:hub008/models/base_image.dart';
import 'package:hub008/models/content.dart';
import 'package:hub008/pages/super_admin/base_image_page.dart';
import 'package:hub008/widgets/design_img.dart';

class DesignPage extends StatefulWidget {
  const DesignPage({super.key});

  @override
  State<DesignPage> createState() => _DesignPageState();
}

class _DesignPageState extends State<DesignPage> {
  bool isExpanded = false;

  Widget _renderBrowseBtn() {
    return Center(
      child: ElevatedButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const BaseImagePage()));
          },
          child: const Text(Constants.browseImg)),
    );
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

  Widget _renderSelectedImg(BaseImage imageData) {
    return Column(
      children: [
        const DesignImage(),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [_renderBrowseBtn()],
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
      appBar: AppBar(title: const Text(Constants.designPage)),
      body: BlocBuilder<BaseImageBloc, BaseImageState>(
        builder: (context, state) {
          if ((state is BaseImageSelected &&
                  state.selectedBaseImg!.baseImg.isNotEmpty) ||
              state is ContentAdded) {
            BaseImage imageData = state.selectedBaseImg!;
            return SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _renderSelectedImg(imageData)),
            );
          }
          return _renderBrowseBtn();
        },
      ),
      floatingActionButton: BlocBuilder<BaseImageBloc, BaseImageState>(
        builder: (context, state) {
          if ((state is BaseImageSelected &&
                  state.selectedBaseImg!.baseImg.isNotEmpty) ||
              state is ContentAdded) {
            return _renderFloatingBtn();
          }
          return const SizedBox();
        },
      ),
    );
  }
}
