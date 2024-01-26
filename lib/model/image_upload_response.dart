class ImageUploadResponse {
  String? tempS3FilePath;
  String? imgFileName;

  ImageUploadResponse({this.tempS3FilePath, this.imgFileName});

  ImageUploadResponse.fromJson(Map<String, dynamic> json) {
    tempS3FilePath = json['tempS3FilePath'];
    imgFileName = json['imgFileName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tempS3FilePath'] = tempS3FilePath;
    data['imgFileName'] = imgFileName;
    return data;
  }
}
