class NewSessionInputDto {
  String? inputText;
  String? imgPath;
  String? imgName;
  String? model;

  NewSessionInputDto({this.inputText, this.imgPath, this.imgName, this.model});

  NewSessionInputDto.fromJson(Map<String, dynamic> json) {
    inputText = json['inputText'];
    imgPath = json['imgPath'];
    imgName = json['imgName'];
    model = json['model'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['inputText'] = inputText;
    data['imgPath'] = imgPath;
    data['imgName'] = imgName;
    data['model'] = model;
    return data;
  }
}
