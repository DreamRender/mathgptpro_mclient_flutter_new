class SessionInputDto {
  int? sessionId;
  int? sessionInputId;
  String? inputText;
  String? imgPath;
  String? imgName;
  String? model;

  SessionInputDto(
      {this.sessionId,
      this.sessionInputId,
      this.inputText,
      this.imgPath,
      this.imgName,
      this.model});

  SessionInputDto.fromJson(Map<String, dynamic> json) {
    sessionId = json['sessionId'];
    sessionInputId = json['sessionInputId'];
    inputText = json['inputText'];
    imgPath = json['imgPath'];
    imgName = json['imgName'];
    model = json['model'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sessionId'] = sessionId;
    data['sessionInputId'] = sessionInputId;
    data['inputText'] = inputText;
    data['imgPath'] = imgPath;
    data['imgName'] = imgName;
    data['model'] = model;
    return data;
  }
}
