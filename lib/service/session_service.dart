import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mathgptpro_mclient_flutter/state/controller/content_manage_controller.dart';
import 'package:mathgptpro_mclient_flutter/constant/session_feedback_enum.dart';
import 'package:mathgptpro_mclient_flutter/model/put_url_response_dto.dart';
import 'package:mathgptpro_mclient_flutter/model/session_dto.dart';
import 'package:mathgptpro_mclient_flutter/model/session_history_dto.dart';
import 'package:mathgptpro_mclient_flutter/model/session_input_dto.dart';
import 'package:mathgptpro_mclient_flutter/model/session_input_response_dto.dart';
import 'package:mathgptpro_mclient_flutter/model/session_output.dart';
import 'package:mathgptpro_mclient_flutter/model/session_output_dto.dart';
import 'package:mathgptpro_mclient_flutter/constant/main_url.dart';
import 'package:mathgptpro_mclient_flutter/utils/dio_utils.dart';

class SessionService {
  final DioUtils _dioUtils = DioUtils();

  /// 获取Session历史
  Future<List<SessionHistoryDto>> getSessionAll() async {
    dio.Response response = await _dioUtils.getAu(MainUrl.sessionHistory);

    List<SessionHistoryDto> list = List<SessionHistoryDto>.from(json
        .decode(response.data)
        .map((model) => SessionHistoryDto.fromJson(model)));

    return list;
  }

  /// 获取Session详情
  Future<SessionDto> getSessionDetail(String uuid) async {
    dio.Response response =
        await _dioUtils.getAu("${MainUrl.sessionDetail}$uuid");

    try {
      SessionDto sessionDto = SessionDto.fromJson(json.decode(response.data));
      return sessionDto;
    } catch (e) {
      return SessionDto();
    }
  }

  ///  record the current usage history.
  Future<void> updateHistory(
      int sessionId, int sessionInputId, String model) async {
    await _dioUtils.postAu(MainUrl.updateHistory, data: {
      "sessionId": sessionId,
      "sessionInputId": sessionInputId,
      "model": model,
    });
  }

  /// 保存Session输入内容
  Future<SessionInputSaveResponseDto> saveSessionInput(
      SessionInputDto sessionInputDto) async {
    dio.Response response = await _dioUtils.postAu(MainUrl.inputSave,
        data: sessionInputDto.toJson());

    SessionInputSaveResponseDto sessionInputSaveResponseDto =
        SessionInputSaveResponseDto.fromJson(json.decode(response.data));

    updateHistory(
      sessionInputSaveResponseDto.sessionId!,
      sessionInputSaveResponseDto.id!,
      sessionInputDto.model!,
    );

    return sessionInputSaveResponseDto;
  }

  /// 保存Session输出
  Future<SessionOutput> saveSessionOutput(
      SessionOutputDto sessionOutputDto) async {
    log(sessionOutputDto.toJson().toString());

    dio.Response response = await _dioUtils.postAu(MainUrl.outputSave,
        data: sessionOutputDto.toJson());

    log(response.data.toString());

    return SessionOutput.fromJson(json.decode(response.data));
  }

  /// 删除Session
  Future<bool> deleteSessionById(int sessionId) async {
    dio.Response response =
        await _dioUtils.deleteAu("${MainUrl.deleteSession}$sessionId");

    bool result = sessionId == int.parse(response.data);

    if (result) {
      ContentManageController contentManageController = Get.find();
      contentManageController.deletedSessionIdList.add(sessionId);
      contentManageController.update();
    }

    return result;
  }

  ///图片上传
  Future<String?> uploadImage(File file, Uint8List compressedUint8List) async {
    dio.Response urlResponse = await _dioUtils
        .getAu(MainUrl.preSignedPutUrl, paramMap: {"fileType": "png"});

    PutUrlResponseDto putUrlResponseDto =
        PutUrlResponseDto.fromJson(json.decode(urlResponse.data));

    String putUrl = putUrlResponseDto.putUrl ?? "";
    String? filePath = putUrlResponseDto.filePath;

    dio.Response response = await _dioUtils.put(putUrl,
        data: compressedUint8List,
        options: Options(headers: {"Content-Type": "image/jpg"}));

    return response.statusCode == 200 ? filePath : null;
  }

  /// 保存FeedBack
  Future<void> feedbackSave(
      int sessionOutputId, SessionFeedbackEnum sessionFeedbackEnum) async {
    dio.Response urlResponse =
        await _dioUtils.postAu(MainUrl.feedbackSave, data: {
      "sessionOutputId": sessionOutputId,
      "feedback":
          EnumToString.convertToString(sessionFeedbackEnum).toUpperCase()
    });

    log(urlResponse.toString());
  }
}
