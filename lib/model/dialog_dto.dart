class DialogDto {
  String? model;
  List<SingleDialogDto>? singleDialogDtoList;

  DialogDto({this.model, this.singleDialogDtoList});

  DialogDto.fromJson(Map<String, dynamic> json) {
    model = json['model'];
    if (json['dialog'] != null) {
      singleDialogDtoList = <SingleDialogDto>[];
      json['dialog'].forEach((v) {
        singleDialogDtoList!.add(SingleDialogDto.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['model'] = model;
    if (singleDialogDtoList != null) {
      data['dialog'] = singleDialogDtoList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SingleDialogDto {
  Input? input;
  Output? output;

  SingleDialogDto({this.input, this.output});

  SingleDialogDto.fromJson(Map<String, dynamic> json) {
    input = json['input'] != null ? Input.fromJson(json['input']) : null;
    output = json['output'] != null ? Output.fromJson(json['output']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (input != null) {
      data['input'] = input?.toJson();
    }
    if (output != null) {
      data['output'] = output?.toJson();
    }
    return data;
  }
}

class Input {
  int? id;
  String? inputText;
  String? imgUrl;
  String? imgPath;
  String? parsedText;

  Input({this.id, this.inputText, this.imgUrl, this.imgPath, this.parsedText});

  Input.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    inputText = json['inputText'];
    imgUrl = json['imgUrl'];
    imgPath = json['imgPath'];
    parsedText = json['parsedText'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['inputText'] = inputText;
    data['imgUrl'] = imgUrl;
    data['imgPath'] = imgPath;
    data['parsedText'] = parsedText;
    return data;
  }
}

class Output {
  int? id;
  String? outputText;
  String? aborted;

  Output({this.id, this.outputText, this.aborted});

  Output.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    outputText = json['outputText'];
    aborted = json['aborted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['outputText'] = outputText;
    data['aborted'] = aborted;
    return data;
  }
}
