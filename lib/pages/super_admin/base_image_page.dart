import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hub008/blocs/super_admin/base_image/base_image_bloc.dart';
import 'package:hub008/config/constants.dart';
import 'package:hub008/models/base_image.dart';
import 'package:hub008/widgets/app_error.dart';
import 'package:hub008/widgets/app_loader.dart';

class BaseImagePage extends StatefulWidget {
  const BaseImagePage({super.key});

  @override
  State<BaseImagePage> createState() => _BaseImagePageState();
}

class _BaseImagePageState extends State<BaseImagePage> {
  @override
  void initState() {
    super.initState();
    context.read<BaseImageBloc>().add(GetAllBaseImages());
  }

  void _handleImgSelect(BaseImage imageData) {
    context.read<BaseImageBloc>().add(SelectBaseImage(imageData));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(Constants.baseImage)),
      body: BlocBuilder<BaseImageBloc, BaseImageState>(
        builder: (context, state) {
          if (state.isInitial == true) return const SizedBox.shrink();
          if (state.isLoading == true) return const AppLoader();
          if (state.isError != null) {
            return AppError(msg: state.isError!.message ?? 'Api Error');
          }
          List<BaseImage> imageList = state.baseImages ?? [];
          return GridView.builder(
            padding: const EdgeInsets.symmetric(vertical: 14.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 0.0,
              mainAxisSpacing: 8.0,
            ),
            itemCount: imageList.length,
            itemBuilder: (context, index) {
              BaseImage imageData = imageList[index];
              return GestureDetector(
                onTap: () => _handleImgSelect(imageData),
                child: Column(
                  children: [
                    Flexible(
                      child: Image.asset(
                        imageData.baseImg,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Text(
                      imageData.title,
                      style: const TextStyle(fontSize: 16.0),
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
