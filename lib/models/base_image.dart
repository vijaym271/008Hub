class BaseImage {
  BaseImage({
    required this.id,
    required this.baseImg,
    required this.baseImgSample,
    required this.title,
    required this.desc,
  });
  late final int id;
  late final String baseImg;
  late final String baseImgSample;
  late final String title;
  late final String desc;

  BaseImage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    baseImg = json['baseImg'];
    baseImgSample = json['baseImgSample'];
    title = json['title'];
    desc = json['desc'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['baseImg'] = baseImg;
    data['baseImgSample'] = baseImgSample;
    data['title'] = title;
    data['desc'] = desc;
    return data;
  }
}
