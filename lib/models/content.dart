class Content {
  Content({
    required this.id,
    required this.isText,
    this.text = "Text",
    this.top,
    this.right,
    this.bottom,
    this.left,
    this.font = "",
    this.fontSize = 10.0,
    this.color = "#000000",
    this.rotate,
    this.logoImg,
    this.logoWidth = 10.0,
    this.logoHeight = 10.0,
  });
  late int id;
  late bool isText;
  late String text;
  late double? top;
  late double? right;
  late double? bottom;
  late double? left;
  late String font;
  late double fontSize;
  late String color;
  late double? rotate;
  late String? logoImg;
  late double logoWidth;
  late double logoHeight;

  Content.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isText = json['isText'];
    text = json['text'];
    top = json['top'];
    right = json['right'];
    bottom = json['bottom'];
    left = json['left'];
    font = json['font'];
    fontSize = json['fontSize'];
    color = json['color'];
    rotate = json['rotate'];
    logoImg = json['logoImg'];
    logoWidth = json['logoWidth'];
    logoHeight = json['logoHeight'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['isText'] = isText;
    data['text'] = text;
    data['top'] = top;
    data['right'] = right;
    data['bottom'] = bottom;
    data['left'] = left;
    data['font'] = font;
    data['fontSize'] = fontSize;
    data['color'] = color;
    data['rotate'] = rotate;
    data['logoImg'] = logoImg;
    data['logoWidth'] = logoWidth;
    data['logoHeight'] = logoHeight;
    return data;
  }
}
