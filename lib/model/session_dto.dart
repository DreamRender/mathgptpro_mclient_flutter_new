class SessionDto {
  int? id;
  String? name;
  String? uuid;
  bool? shared;
  String? model;
  List<SessionInputs>? sessionInputs;
  List<SessionOutputs>? sessionOutputs;
  String? parseStatus;

  SessionDto(
      {this.id,
      this.name,
      this.uuid,
      this.shared,
      this.model,
      this.sessionInputs,
      this.sessionOutputs,
      this.parseStatus});

  SessionDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    uuid = json['uuid'];
    shared = json['shared'];
    model = json['model'];
    if (json['sessionInputs'] != null) {
      sessionInputs = <SessionInputs>[];
      json['sessionInputs'].forEach((v) {
        sessionInputs!.add(SessionInputs.fromJson(v));
      });
    }
    if (json['sessionOutputs'] != null) {
      sessionOutputs = <SessionOutputs>[];
      json['sessionOutputs'].forEach((v) {
        sessionOutputs!.add(SessionOutputs.fromJson(v));
      });
    }
    parseStatus = json['parseStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['uuid'] = uuid;
    data['shared'] = shared;
    data['model'] = model;
    if (sessionInputs != null) {
      data['sessionInputs'] = sessionInputs!.map((v) => v.toJson()).toList();
    }
    if (sessionOutputs != null) {
      data['sessionOutputs'] = sessionOutputs!.map((v) => v.toJson()).toList();
    }
    data['parseStatus'] = parseStatus;
    return data;
  }
}

class SessionInputs {
  int? createdAt;
  int? createdBy;
  int? updatedAt;
  int? updatedBy;
  int? id;
  int? sessionId;
  String? inputText;
  String? imgPath;
  String? imgUrl;
  String? status;
  String? parsedText;

  SessionInputs(
      {this.createdAt,
      this.createdBy,
      this.updatedAt,
      this.updatedBy,
      this.id,
      this.sessionId,
      this.inputText,
      this.imgPath,
      this.imgUrl,
      this.status,
      this.parsedText});

  SessionInputs.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    createdBy = json['createdBy'];
    updatedAt = json['updatedAt'];
    updatedBy = json['updatedBy'];
    id = json['id'];
    sessionId = json['sessionId'];
    inputText = json['inputText'];
    imgPath = json['imgPath'];
    imgUrl = json['imgUrl'];
    status = json['status'];
    parsedText = json['parsedText'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['createdAt'] = createdAt;
    data['createdBy'] = createdBy;
    data['updatedAt'] = updatedAt;
    data['updatedBy'] = updatedBy;
    data['id'] = id;
    data['sessionId'] = sessionId;
    data['inputText'] = inputText;
    data['imgPath'] = imgPath;
    data['imgUrl'] = imgUrl;
    data['status'] = status;
    data['parsedText'] = parsedText;
    return data;
  }
}

class SessionOutputs {
  int? id;
  int? sessionId;
  int? sessionInputId;
  String? outputText;
  String? status;
  String? compressedText;
  int? tokenCount;
  OutputFeedback? outputFeedback;

  SessionOutputs(
      {this.id,
      this.sessionId,
      this.sessionInputId,
      this.outputText,
      this.status,
      this.compressedText,
      this.tokenCount,
      this.outputFeedback});

  SessionOutputs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sessionId = json['sessionId'];
    sessionInputId = json['sessionInputId'];
    outputText = json['outputText'];
    status = json['status'];
    compressedText = json['compressedText'];
    tokenCount = json['tokenCount'];
    outputFeedback = json['outputFeedback'] != null
        ? OutputFeedback.fromJson(json['outputFeedback'])
        : null;
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
    if (outputFeedback != null) {
      data['outputFeedback'] = outputFeedback!.toJson();
    }
    return data;
  }
}

class OutputFeedback {
  int? createdAt;
  int? createdBy;
  int? updatedAt;
  int? updatedBy;
  int? id;
  int? sessionOutputId;
  String? feedback;
  String? feedbackText;

  OutputFeedback(
      {this.createdAt,
      this.createdBy,
      this.updatedAt,
      this.updatedBy,
      this.id,
      this.sessionOutputId,
      this.feedback,
      this.feedbackText});

  OutputFeedback.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    createdBy = json['createdBy'];
    updatedAt = json['updatedAt'];
    updatedBy = json['updatedBy'];
    id = json['id'];
    sessionOutputId = json['sessionOutputId'];
    feedback = json['feedback'];
    feedbackText = json['feedbackText'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['createdAt'] = createdAt;
    data['createdBy'] = createdBy;
    data['updatedAt'] = updatedAt;
    data['updatedBy'] = updatedBy;
    data['id'] = id;
    data['sessionOutputId'] = sessionOutputId;
    data['feedback'] = feedback;
    data['feedbackText'] = feedbackText;
    return data;
  }
}
