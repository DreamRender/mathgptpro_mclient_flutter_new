class SessionOutputDto {
  int? sessionId;
  int? sessionInputId;
  String? outputText;
  String? status;
  int? tokenCount;

  SessionOutputDto(
      {this.sessionId,
      this.sessionInputId,
      this.outputText,
      this.status,
      this.tokenCount});

  SessionOutputDto.fromJson(Map<String, dynamic> json) {
    sessionId = json['sessionId'];
    sessionInputId = json['sessionInputId'];
    outputText = json['outputText'];
    status = json['status'];
    tokenCount = json['tokenCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sessionId'] = sessionId;
    data['sessionInputId'] = sessionInputId;
    data['outputText'] = outputText;
    data['status'] = status;
    data['tokenCount'] = tokenCount;
    return data;
  }
}
