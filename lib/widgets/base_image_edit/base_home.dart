import 'package:drag_drop/pages/base_image_edit/base_image_edit.dart';
import 'package:drag_drop/pages/base_image_edit/content.dart';
import 'package:flutter/material.dart';

class BaseHomePage extends StatefulWidget {
  const BaseHomePage({super.key});

  @override
  State<BaseHomePage> createState() => _BaseHomePageState();
}

class _BaseHomePageState extends State<BaseHomePage> {
  List<Map<String, dynamic>> jsonData = [
    {
      "id": 999999,
      "text": "FOOD",
      "top": 0.23,
      "left": 0.318,
      "fontFamily": "Gagalin",
      "fontSize": 0.16,
      "textColor": "#552117",
      "rotateAngle": 0,
      "isText": null,
      "logoImg": null,
      "logoWidth": null,
      "logoHeight": null,
      "width": 0.1,
      "height": 0.1
    },
    {
      "id": 999998,
      "text": "Delicious",
      "top": 0.151,
      "left": 0.303,
      "fontFamily": "FakeSerif",
      "fontSize": 0.15,
      "textColor": "#ff9a16",
      "rotateAngle": 0,
      "isText": null,
      "logoImg": null,
      "logoWidth": null,
      "logoHeight": null,
      "width": 0.1,
      "height": 0.1
    },
    {
      "id": 999997,
      "text": "SUPER",
      "top": 0.132,
      "left": 0.459,
      "fontFamily": "Gagalin",
      "fontSize": 0.06,
      "textColor": "#552117",
      "rotateAngle": 0.98,
      "isText": null,
      "logoImg": null,
      "logoWidth": null,
      "logoHeight": null,
      "width": 0.1,
      "height": 0.1
    },
    {
      "id": 999996,
      "text": "75",
      "top": 0.768,
      "left": 0.632,
      "fontFamily": "Gloss_And_Bloom",
      "fontSize": 0.16,
      "textColor": "#760000",
      "rotateAngle": 0.98,
      "isText": null,
      "logoImg": null,
      "logoWidth": null,
      "logoHeight": null,
      "width": 0.1,
      "height": 0.1
    }
  ];
  late List<Content> defaultContent = [];

  @override
  void initState() {
    super.initState();
    defaultContent = jsonData.map((e) => Content.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Design Base Image')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BaseImageEdit(
            baseBgImage: "assets/images/divan_banner.jpeg",
            contents: defaultContent,
            enableEdit: true,
            enableDrag: true,
            enableRotate: true,
            showAddBtn: true,
            showExportBtn: true,
            showSaveBtn: true,
          ),
        ),
      ),
    );
  }
}
