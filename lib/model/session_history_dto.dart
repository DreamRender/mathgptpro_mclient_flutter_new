class SessionHistoryDto {
  int? createdAt;
  int? createdBy;
  int? updatedAt;
  int? updatedBy;
  int? id;
  String? name;
  String? uuid;
  bool? shared;
  bool? updatedFlag;
  String? model;
  String? status;
  String? parsedFirstImg;

  SessionHistoryDto(
      {this.createdAt,
      this.createdBy,
      this.updatedAt,
      this.updatedBy,
      this.id,
      this.name,
      this.uuid,
      this.shared,
      this.updatedFlag,
      this.model,
      this.status,
      this.parsedFirstImg});

  SessionHistoryDto.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    createdBy = json['createdBy'];
    updatedAt = json['updatedAt'];
    updatedBy = json['updatedBy'];
    id = json['id'];
    name = json['name'];
    uuid = json['uuid'];
    shared = json['shared'];
    updatedFlag = json['updatedFlag'];
    model = json['model'];
    status = json['status'];
    parsedFirstImg = json['parsedFirstImg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['createdAt'] = createdAt;
    data['createdBy'] = createdBy;
    data['updatedAt'] = updatedAt;
    data['updatedBy'] = updatedBy;
    data['id'] = id;
    data['name'] = name;
    data['uuid'] = uuid;
    data['shared'] = shared;
    data['updatedFlag'] = updatedFlag;
    data['model'] = model;
    data['status'] = status;
    data['parsedFirstImg'] = parsedFirstImg;
    return data;
  }
}
