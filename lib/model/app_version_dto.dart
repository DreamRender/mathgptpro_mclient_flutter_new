class AppVersionDto {
  bool? currentVersionAvailable;
  bool? currentVersionTestMode;
  String? latestVersion;
  String? androidDownloadUrl;
  String? iosAppId;
  String? updateMessage;

  AppVersionDto(
      {this.currentVersionAvailable,
      this.currentVersionTestMode,
      this.latestVersion,
      this.androidDownloadUrl,
      this.iosAppId,
      this.updateMessage});

  AppVersionDto.fromJson(Map<String, dynamic> json) {
    currentVersionAvailable = json['currentVersionAvailable'];
    currentVersionTestMode = json['currentVersionTestMode'];
    latestVersion = json['latestVersion'];
    androidDownloadUrl = json['androidDownloadUrl'];
    iosAppId = json['iosAppId'];
    updateMessage = json['updateMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['currentVersionAvailable'] = currentVersionAvailable;
    data['currentVersionTestMode'] = currentVersionTestMode;
    data['latestVersion'] = latestVersion;
    data['androidDownloadUrl'] = androidDownloadUrl;
    data['iosAppId'] = iosAppId;
    data['updateMessage'] = updateMessage;
    return data;
  }
}
