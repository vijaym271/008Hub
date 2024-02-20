import 'package:drag_drop/pages/base_image_edit/base_image_content.dart';
import 'package:drag_drop/pages/base_image_edit/base_image_edit.dart';
import 'package:drag_drop/pages/base_image_edit/content.dart';
import 'package:flutter/material.dart';

class BaseHomePage extends StatefulWidget {
  const BaseHomePage({super.key});

  @override
  State<BaseHomePage> createState() => _BaseHomePageState();
}

class _BaseHomePageState extends State<BaseHomePage> {
  List<BaseImageContent> contents = [];
  List<Content> defaultContent = [
    Content(
        id: 999999,
        text: "FOOD",
        top: 0.228,
        left: 0.28,
        fontFamily: "Gagalin",
        fontSize: 0.16,
        textColor: "#552117"),
    Content(
        id: 999998,
        text: "Delicious",
        top: 0.17,
        left: 0.28,
        fontFamily: "FakeSerif",
        fontSize: 0.15,
        textColor: "#ff9a16"),
    Content(
        id: 999997,
        text: "SUPER",
        top: 0.158,
        left: 0.45,
        fontFamily: "Gagalin",
        fontSize: 0.06,
        textColor: "#552117",
        rotateAngle: 0.98),
    Content(
        id: 999996,
        text: "75",
        top: 0.77,
        left: 0.60,
        fontFamily: "Gloss_And_Bloom",
        fontSize: 0.16,
        textColor: "#760000",
        rotateAngle: 0.98),
  ];
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
          ),
        ),
      ),
    );
  }
}
