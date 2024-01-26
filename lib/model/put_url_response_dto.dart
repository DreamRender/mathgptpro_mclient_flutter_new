class PutUrlResponseDto {
  String? putUrl;
  String? filePath;

  PutUrlResponseDto({this.putUrl, this.filePath});

  PutUrlResponseDto.fromJson(Map<String, dynamic> json) {
    putUrl = json['putUrl'];
    filePath = json['filePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['putUrl'] = putUrl;
    data['filePath'] = filePath;
    return data;
  }
}
