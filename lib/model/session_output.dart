class SessionOutput {
  int? id;
  int? sessionId;
  int? sessionInputId;
  String? outputText;
  String? status;
  String? compressedText;
  int? tokenCount;
  String? outputFeedback;

  SessionOutput(
      {this.id,
      this.sessionId,
      this.sessionInputId,
      this.outputText,
      this.status,
      this.compressedText,
      this.tokenCount,
      this.outputFeedback});

  SessionOutput.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sessionId = json['sessionId'];
    sessionInputId = json['sessionInputId'];
    outputText = json['outputText'];
    status = json['status'];
    compressedText = json['compressedText'];
    tokenCount = json['tokenCount'];
    outputFeedback = json['outputFeedback'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['sessionId'] = sessionId;
    data['sessionInputId'] = sessionInputId;
    data['outputText'] = outputText;
    data['status'] = status;
    data['compressedText'] = compressedText;
    data['tokenCount'] = tokenCount;
    data['outputFeedback'] = outputFeedback;
    return data;
  }
}
