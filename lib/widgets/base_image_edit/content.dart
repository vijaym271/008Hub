class Content {
  Content({
    required this.id,
    this.text = "Text",
    this.top = 0.0,
    this.left = 0.0,
    this.fontFamily = "normal",
    this.fontSize = 0.1,
    this.textColor = "#000000",
    this.rotateAngle = 0.0,
    this.isText,
    this.logoImg,
    this.logoWidth,
    this.logoHeight,
    this.isTextEdit = false,
    this.width = 0.1,
    this.height = 0.1,
    this.isSelect = false,
    this.isInputSelect = false,
  });
  late int id;
  String? text;
  double? top;
  double? left;
  String? fontFamily;
  double? fontSize;
  String? textColor;
  double? rotateAngle;
  bool? isText;
  String? logoImg;
  double? logoWidth;
  double? logoHeight;
  bool? isTextEdit;
  double? width;
  double? height;
  bool? isSelect;
  bool? isInputSelect;

  Content.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
    top = json['top'];
    left = json['left'];
    fontFamily = json['fontFamily'];
    fontSize = json['fontSize'];
    textColor = json['textColor'];
    rotateAngle = double.parse(json['rotateAngle'].toString());
    isText = json['isText'];
    logoImg = json['logoImg'];
    logoWidth = json['logoWidth'];
    logoHeight = json['logoHeight'];
    isTextEdit = json['isTextEdit'] ?? false;
    width = json['width'];
    height = json['height'];
    isSelect = json['isSelect'] ?? false;
    isInputSelect = json['isInputSelect'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['text'] = text;
    data['top'] = top;
    data['left'] = left;
    data['fontFamily'] = fontFamily;
    data['fontSize'] = fontSize;
    data['textColor'] = textColor;
    data['rotateAngle'] = rotateAngle;
    data['isText'] = isText;
    data['logoImg'] = logoImg;
    data['logoWidth'] = logoWidth;
    data['logoHeight'] = logoHeight;
    data['width'] = width;
    data['height'] = height;
    return data;
  }

  Content clone() {
    return Content(
      id: id,
      text: text,
      top: top,
      left: left,
      fontFamily: fontFamily,
      fontSize: fontSize,
      textColor: textColor,
      rotateAngle: rotateAngle,
      isText: isText,
      logoImg: logoImg,
      logoWidth: logoWidth,
      logoHeight: logoWidth,
      isTextEdit: isTextEdit,
      width: width,
      height: height,
      isSelect: isSelect,
      isInputSelect: isInputSelect,
    );
  }
}
