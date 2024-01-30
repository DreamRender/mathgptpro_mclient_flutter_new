class UserInfo {
  String? firstName;
  String? lastName;
  int? eduId;
  String? language;
  bool? showExample;
  bool? termAccepted;

  UserInfo(
      {this.firstName,
      this.lastName,
      this.eduId,
      this.language,
      this.showExample,
      this.termAccepted});

  UserInfo.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    eduId = json['eduId'];
    language = json['language'];
    showExample = json['showExample'];
    termAccepted = json['termAccepted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['eduId'] = eduId;
    data['language'] = language;
    data['showExample'] = showExample;
    data['termAccepted'] = termAccepted;
    return data;
  }
}
