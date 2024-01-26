class SessionInputSaveResponseDto {
  int? id;
  int? sessionId;
  String? inputText;
  String? imgPath;
  String? sessionUuid;
  String? status;
  String? parsedText;
  String? imgUrl;

  SessionInputSaveResponseDto(
      {this.id,
      this.sessionId,
      this.inputText,
      this.imgPath,
      this.sessionUuid,
      this.status,
      this.parsedText,
      this.imgUrl});

  SessionInputSaveResponseDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sessionId = json['sessionId'];
    inputText = json['inputText'];
    imgPath = json['imgPath'];
    sessionUuid = json['sessionUuid'];
    status = json['status'];
    parsedText = json['parsedText'];
    imgUrl = json['imgUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['sessionId'] = sessionId;
    data['inputText'] = inputText;
    data['imgPath'] = imgPath;
    data['sessionUuid'] = sessionUuid;
    data['status'] = status;
    data['parsedText'] = parsedText;
    data['imgUrl'] = imgUrl;
    return data;
  }
}
