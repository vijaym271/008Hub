class Content {
  Content({
    required this.id,
    required this.isText,
    this.text = "Text",
    this.top = 0.0,
    this.left = 0.0,
    this.right,
    this.bottom,
    this.font = "Default",
    this.fontSize = 0.1,
    this.fontWeight = "normal",
    this.color = "#000000",
    this.rotate = 0.0,
    this.logoImg,
    this.width = 0.1,
    this.height = 0.1,
    this.isEdit = false,
    this.isTextEdit = false,
  });
  late int id;
  late bool isText;
  late String text;
  late double top;
  late double left;
  late double? right;
  late double? bottom;
  late String font;
  late double fontSize;
  late String fontWeight;
  late String color;
  late double rotate;
  late String? logoImg;
  late double width;
  late double height;
  late bool isEdit;
  late bool isTextEdit;

  Content.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isText = json['isText'];
    text = json['text'];
    top = json['top'];
    left = json['left'];
    right = json['right'];
    bottom = json['bottom'];
    font = json['font'];
    fontSize = json['fontSize'];
    fontWeight = json['fontWeight'];
    color = json['color'];
    rotate = json['rotate'];
    logoImg = json['logoImg'];
    width = json['width'];
    height = json['height'];
    isEdit = json['isEdit'];
    isTextEdit = json['isTextEdit'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['isText'] = isText;
    data['text'] = text;
    data['top'] = top;
    data['left'] = left;
    data['right'] = right;
    data['bottom'] = bottom;
    data['font'] = font;
    data['fontSize'] = fontSize;
    data['fontWeight'] = fontWeight;
    data['color'] = color;
    data['rotate'] = rotate;
    data['logoImg'] = logoImg;
    data['width'] = width;
    data['height'] = height;
    data['isEdit'] = isEdit;
    data['isTextEdit'] = isTextEdit;
    return data;
  }
}
