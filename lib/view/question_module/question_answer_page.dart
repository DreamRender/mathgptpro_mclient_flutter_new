import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mathgptpro_mclient_flutter/action/user_action.dart';
import 'package:mathgptpro_mclient_flutter/component/ui_behavior/refocus_component.dart';
import 'package:mathgptpro_mclient_flutter/constant/main_url.dart';
import 'package:mathgptpro_mclient_flutter/constant/session_model_enum.dart';
import 'package:mathgptpro_mclient_flutter/constant/ui_resource.dart';
import 'package:mathgptpro_mclient_flutter/model/balance_info.dart';
import 'package:mathgptpro_mclient_flutter/model/dialog_dto.dart';
import 'package:mathgptpro_mclient_flutter/model/session_dto.dart';
import 'package:mathgptpro_mclient_flutter/model/session_input_dto.dart';
import 'package:mathgptpro_mclient_flutter/model/session_input_response_dto.dart';
import 'package:mathgptpro_mclient_flutter/model/session_output_dto.dart';
import 'package:mathgptpro_mclient_flutter/service/session_service.dart';
import 'package:mathgptpro_mclient_flutter/service/user_service.dart';
import 'package:mathgptpro_mclient_flutter/state/controller/question_image_controller.dart';
import 'package:mathgptpro_mclient_flutter/state/controller/user_controller.dart';
import 'package:mathgptpro_mclient_flutter/utils/dio_utils.dart';
import 'package:mathgptpro_mclient_flutter/utils/image_select_utils.dart';
import 'package:mathgptpro_mclient_flutter/utils/toast_utils.dart';
import 'package:mathgptpro_mclient_flutter/view/question_module/component/dialog_receive_card.dart';
import 'package:mathgptpro_mclient_flutter/view/question_module/component/dialog_send_card.dart';

class QuestionAnswerPage extends StatefulWidget {
  const QuestionAnswerPage({super.key, required this.sessionUuid});

  final String? sessionUuid;

  @override
  State<QuestionAnswerPage> createState() => _QuestionAnswerPageState();
}

class _QuestionAnswerPageState extends State<QuestionAnswerPage>
    with TickerProviderStateMixin {
  final TextEditingController _contentEditController = TextEditingController();

  final ScrollController _scrollController = ScrollController();

  final ContentController _contentController = Get.put(ContentController());

  final UserController userController = Get.find();

  final QuestionImageController questionImageController = Get.find();

  final SessionService _sessionService = SessionService();

  final UserService userService = UserService();

  final UserAction userAction = UserAction();

  final DioUtils _dioUtils = DioUtils();

  SessionDto? sessionDto;

  bool modeSetModalOpen = false;

  bool onSaveSessionInput = false;

  bool onSessionDataLoading = false;

  bool onGenerateAnswer = false;

  bool aborted = false;

  bool exampleMode = false;

  String outputFinalContent = "";

  int outputFinalToken = 0;

  /// 获取Session数据
  Future<SessionDto> _getSessionData(String sessionUuid) async {
    SessionDto result;
    result = await _sessionService.getSessionDetail(sessionUuid);

    //检查照片是否被OCR识别结束
    if (result.sessionInputs!.last.imgUrl != null) {
      while (result.sessionInputs!.last.parsedText == null) {
        result = await _sessionService.getSessionDetail(sessionUuid);
      }
    }

    return result;
  }

  /// 保存输入数据
  /// 返回Session Uuid
  Future<String> _saveSessionInput(SessionInputDto sessionInputDto) async {
    setState(() {
      onSaveSessionInput = true;
    });

    //保存Input
    SessionInputSaveResponseDto sessionInputSaveResponseDto =
        await _sessionService.saveSessionInput(sessionInputDto);

    setState(() {
      onSaveSessionInput = false;
    });

    return sessionInputSaveResponseDto.sessionUuid ?? "";
  }

  /// 保存输出数据
  Future<void> _saveSessionOutput() async {
    if (sessionDto == null) {
      return;
    }

    List<SingleDialogDto> singleDialogDtoList =
        _contentController.singleDialogDtoList;

    int onProcessSessionInputId = singleDialogDtoList.last.input!.id!;

    SessionOutputDto sessionOutputDto = SessionOutputDto(
        sessionId: sessionDto?.id,
        sessionInputId: onProcessSessionInputId,
        outputText: outputFinalContent,
        tokenCount: outputFinalToken);

    if (aborted) {
      sessionOutputDto.status = "ABORTED";
    }

    await _sessionService.saveSessionOutput(sessionOutputDto);
  }

  /// 更新Session信息
  Future<void> updateSessionData(String sessionUuid) async {
    setState(() {
      onSessionDataLoading = true;
    });

    //重新更新一下SessionDto
    sessionDto = await _getSessionData(sessionUuid);

    List<SingleDialogDto> singleDialogDtoList =
        _getSingleDialogDtoList(sessionDto!);

    //更新一下UI数据
    _contentController.singleDialogDtoList = singleDialogDtoList;
    _contentController.update();

    setState(() {
      onSessionDataLoading = false;
    });
  }

  /// 加载数据
  Future<void> _loadOutputData(
      List<SingleDialogDto> singleDialogDtoList) async {
    if (sessionDto == null) {
      return;
    }

    //1.保证有提问 2.如果有回答了，就不再提交
    if (singleDialogDtoList.last.input == null ||
        (singleDialogDtoList.last.output ?? Output()).outputText != null) {
      return;
    }

    setState(() {
      onGenerateAnswer = true;
    });

    /// 使用_contentController内的model，因为可能会切换
    String model =
        EnumToString.convertToString(_contentController.model).toUpperCase();

    DialogDto dialogDto =
        DialogDto(model: model, singleDialogDtoList: singleDialogDtoList);

    // 更新额度信息
    BalanceInfo balanceInfo = await userService.updateUserBalanceHistory(model);

    await userAction.updateUserBalance(balanceInfo: balanceInfo);

    // 获取JWT
    String? userToken = await _dioUtils.getUserTokenWithUpdateUserInfo();

    dio.Response<dio.ResponseBody> rs = await Dio(BaseOptions(
            connectTimeout: const Duration(minutes: 5),
            receiveTimeout: const Duration(minutes: 5),
            sendTimeout: const Duration(minutes: 5)))
        .post<dio.ResponseBody>(
      MainUrl.flask, data: dialogDto,
      options: Options(headers: {
        "Authorization": "Bearer $userToken",
        "Content-Type": "application/json",
      }, responseType: ResponseType.stream), // set responseType to `stream`
    );

    late StreamSubscription<Uint8List> subscription;

    subscription = rs.data!.stream.listen((event) async {
      //解答被终止
      if (aborted) {
        //第一步Cancel Stream
        subscription.cancel();

        //第二步更新状态
        setState(() {
          //复位
          aborted = false;
          onGenerateAnswer = false;
        });

        //第三步执行数据
        await _saveSessionOutput();

        await updateSessionData(sessionDto!.uuid!);

        return;
      }

      List<int> unit8List = event;
      String message = String.fromCharCodes(unit8List);

      List<String> rawSplit = message.split(String.fromCharCode(29));

      //计数
      String rawCount = rawSplit[1];
      String count = rawCount.split(String.fromCharCode(30))[0];
      outputFinalToken = int.parse(count);

      //内容
      String content = rawSplit[0].substring(1, rawSplit[0].length - 1);

      List<String> matches = [];
      RegExp exp = RegExp(r'(\\u[0-9a-fA-F]{4})');
      Iterable<Match> matchesIterator = exp.allMatches(content);

      for (Match match in matchesIterator) {
        String matchesString = match.group(0)!;
        matches.add(matchesString);
      }

      for (String element in matches) {
        element = element.replaceAll(r"\u", "");
        element = String.fromCharCode(int.parse(element, radix: 16));
        content = content.replaceFirst(exp, element);
      }

      //将服务器输出的双\转义字符，保存为单\转义字符
      //将服务器输出的\n字符，保存为换行
      content = content.replaceAll(r"\\", r'\').replaceAll(r"\n", '\n');

      List<SingleDialogDto> singleDialogDtoList =
          dialogDto.singleDialogDtoList ?? [];

      SingleDialogDto changeDialog = singleDialogDtoList.last;

      //如果是null说明是第一句话，如果不是null，说明是流更新
      if (changeDialog.output == null) {
        changeDialog.output = Output(outputText: content);
      } else {
        changeDialog.output = Output(
            outputText: (changeDialog.output!.outputText ?? "") + content);
      }

      //更新最终结果文字
      outputFinalContent = changeDialog.output!.outputText ?? "";

      singleDialogDtoList.last = changeDialog;

      _contentController.singleDialogDtoList = singleDialogDtoList;

      _contentController.update();

      _listViewScrollToBottom();
    }, onDone: () async {
      await _saveSessionOutput();
      await updateSessionData(sessionDto!.uuid!);

      setState(() {
        onGenerateAnswer = false;
      });
    }, onError: (Object object, StackTrace stackTrace) {
      ToastUtils.showErrorToast("Error");
      log("错误：", stackTrace: stackTrace);
      setState(() {
        onGenerateAnswer = false;
      });
    }, cancelOnError: true);
  }

  /// 获得数据
  List<SingleDialogDto> _getSingleDialogDtoList(SessionDto sessionDto) {
    List<SingleDialogDto> singleDialogDtoList = [];

    List<int> sessionInputTimeList = [];

    Map<int, SessionInputs> sessionInputTimeMap = {};

    for (int i = 0; i < (sessionDto.sessionInputs ?? []).length; i++) {
      SessionInputs? sessionInputs = (sessionDto.sessionInputs ?? [])[i];
      sessionInputTimeList.add(sessionInputs.createdAt!);
      sessionInputTimeMap[sessionInputs.createdAt!] = sessionInputs;
    }

    //从小到大排序
    sessionInputTimeList.sort();

    //根据时间进行排序
    for (int time in sessionInputTimeList) {
      SessionInputs sessionInputs = sessionInputTimeMap[time]!;
      int sessionInputId = sessionInputs.id!;

      Output? output;

      for (SessionOutputs element in (sessionDto.sessionOutputs ?? [])) {
        if (element.sessionInputId == sessionInputId) {
          output = Output(id: element.id, outputText: element.outputText);
        }
      }

      SingleDialogDto singleDialogDto = SingleDialogDto(
          input: Input(
              id: sessionInputs.id,
              inputText: sessionInputs.inputText,
              imgUrl: sessionInputs.imgUrl,
              imgPath: sessionInputs.imgPath,
              parsedText: sessionInputs.parsedText),
          output: output);

      singleDialogDtoList.add(singleDialogDto);
    }

    return singleDialogDtoList;
  }

  ///判断是否额度可用
  bool isBalanceAvailable() {
    switch (_contentController.model) {
      case SessionModelEnum.max:
        return userController.maxExtraCredit > 0 ||
            userController.maxPlanCredit > 0;
      case SessionModelEnum.pro:
        return userController.proExtraCredit > 0 ||
            userController.proPlanCredit > 0;
    }
  }

  /// 判断是否正在加载
  isLoading() {
    return onSaveSessionInput || onSessionDataLoading || onGenerateAnswer;
  }

  /// 取消焦点
  unfocusFromKeyboard() {
    FocusScope.of(Get.context!).unfocus();
  }

  /// 提交回答
  onInputSubmit() async {
    unfocusFromKeyboard();

    String value = _contentEditController.text;

    File? file = questionImageController.croppedImage;
    Uint8List? uint8list = questionImageController.uint8list;

    //不允许发送空内容
    if (value.isEmpty && uint8list == null) {
      ToastUtils.showSystemToast("请先输入内容或上传图片".tr);
      return;
    }

    if (!isBalanceAvailable()) {
      ToastUtils.showSystemToast("模型额度不足".tr);
      return;
    }

    //清空已输入的数据
    _contentEditController.clear();
    questionImageController.empty();

    String? filePath;
    String? fileName;

    if (file != null && uint8list != null) {
      filePath = await _sessionService.uploadImage(file, uint8list);
      fileName = filePath!.split('/').last;
    }

    //sessionId后有？判定，会自动赋值null
    SessionInputDto sessionInputDto = SessionInputDto(
        sessionId: sessionDto?.id,
        model: EnumToString.convertToString(_contentController.model)
            .toUpperCase(),
        inputText: value,
        imgPath: filePath,
        imgName: fileName);

    String sessionUuid = await _saveSessionInput(sessionInputDto);

    await updateSessionData(sessionUuid);

    _listViewScrollToBottom();

    await _loadOutputData(_contentController.singleDialogDtoList);
  }

  /// Dialog组件
  Widget getDialogGroup(SingleDialogDto singleDialogDto) {
    List<Widget> columnWidgetList = [];

    if (singleDialogDto.input != null) {
      columnWidgetList.add(DialogSendCard(
        singleDialogDto.input!.inputText ?? "",
        singleDialogDto.input!.parsedText ?? "",
        singleDialogDto.input!.imgUrl,
        singleDialogDto.input!.imgPath,
      ));
    }

    if (singleDialogDto.output != null) {
      columnWidgetList.add(DialogReceiveCard(
        singleDialogDto.output!.outputText ?? "",
        singleDialogDto.output!.id ?? 0,
        true,
        key: Key(singleDialogDto.output!.outputText ?? ""),
      ));
    }

    return Column(
      children: columnWidgetList,
    );
  }

  /// 输入框
  Widget getInputTextField() {
    return Container(
      width: Get.width,
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 24.w),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 7.w),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: Color(0xFFA6AAAE)),
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        child: TextField(
          minLines: 1,
          maxLines: 5,
          autofocus: false,
          enabled: !isLoading(),
          controller: _contentEditController,
          keyboardType: TextInputType.multiline,
          textInputAction: TextInputAction.newline,
          textAlignVertical: TextAlignVertical.center,
          style: TextStyle(
            color: context.textTheme.bodyMedium!.color,
            fontSize: 16,
            fontWeight: FontWeight.normal,
          ),
          decoration: InputDecoration(
            isDense: true,
            hintText: "Ask your question here",
            hintStyle: TextStyle(
              fontSize: 16,
              color: context.textTheme.bodyLarge!.color,
            ),
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            counterText: "",
            suffixIconConstraints: BoxConstraints(maxHeight: 14.w),
            suffixIcon: GestureDetector(
              onTap: isLoading() ? unfocusFromKeyboard : onInputSubmit,
              child: isLoading()
                  ? SizedBox(
                      width: 15.w,
                      height: 15.w,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : Icon(
                      Icons.send,
                      color: UiResource.primaryBlue,
                    ),
            ),
          ),
        ),
      ),
    );
  }

  /// 图片选择器
  Widget getImageSelectGroup() {
    return Container(
      width: Get.width,
      color: context.theme.scaffoldBackgroundColor,
      padding: EdgeInsets.fromLTRB(24.w, 8.w, 24.w, 8.w),
      child: GetBuilder<QuestionImageController>(
        builder: (imageCropController) {
          if (imageCropController.croppedImage == null) {
            return Row(
              children: [
                GestureDetector(
                  onTap: isLoading()
                      ? null
                      : () {
                          ImageSelectUtils.galleryImageSelect(false);
                        },
                  child: Container(
                    width: 160.w,
                    padding:
                        EdgeInsets.symmetric(vertical: 13.w, horizontal: 18.w),
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image(
                            width: 27.w,
                            height: 21.w,
                            image: const AssetImage(
                                "public/asset/icon/question_page_gallery_icon.png")),
                        SizedBox(
                          height: 10.w,
                        ),
                        const Text(
                          'Choose an image',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF339AF0),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: isLoading()
                      ? null
                      : () {
                          ImageSelectUtils.cameraImageSelect(false);
                        },
                  child: Container(
                    width: 160.w,
                    padding:
                        EdgeInsets.symmetric(vertical: 13.w, horizontal: 18.w),
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image(
                            width: 27.w,
                            height: 21.w,
                            image: const AssetImage(
                                "public/asset/icon/question_page_camera_icon.png")),
                        SizedBox(
                          height: 10.w,
                        ),
                        const Text(
                          'Take a photo ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF339AF0),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Container(
              padding: EdgeInsets.fromLTRB(20.w, 0.w, 20.w, 21.w),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 1, color: Color(0xFFA6AAAE)),
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 30.w),
                    child: Center(
                      child: Image(
                          height: 160.w,
                          image: FileImage(imageCropController.croppedImage!)),
                    ),
                  ),
                  Positioned(
                      top: 10.w,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          questionImageController.empty();
                        },
                        child: const Icon(
                          Icons.close,
                          color: Colors.black,
                        ),
                      ))
                ],
              ),
            );
          }
        },
      ),
    );
  }

  /// 获得Balance组件
  Widget getBalanceInfoWidget(SessionModelEnum sessionModelEnum) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => setState(() {
            modeSetModalOpen = !modeSetModalOpen;
          }),
          child: Container(
            margin: EdgeInsets.only(left: 8.w),
            padding:
                EdgeInsets.only(left: 16.w, right: 8.w, top: 4.w, bottom: 4.w),
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: const BorderSide(width: 1, color: Color(0xFFD9D9D9)),
                borderRadius: BorderRadius.circular(30.r),
              ),
            ),
            child: Row(
              children: [
                Text(
                  sessionModelEnum == SessionModelEnum.max ? 'Max' : 'Pro',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: UiResource.primaryBlack,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 3.w),
                  child: Icon(Icons.keyboard_arrow_down_outlined,
                      color: UiResource.primaryBlack),
                )
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 16.w),
          child: Image(
              width: 16.w,
              height: 16.w,
              image: AssetImage(sessionModelEnum == SessionModelEnum.max
                  ? "public/asset/icon/diamond.png"
                  : "public/asset/icon/coin.png")),
        ),
        Container(
          margin: EdgeInsets.only(left: 10.w),
          child: GetX<UserController>(builder: (userController) {
            String value = "";
            if (sessionModelEnum == SessionModelEnum.max) {
              value = (userController.maxExtraCredit.value +
                      userController.maxPlanCredit.value)
                  .toString();
            } else {
              value = (userController.proExtraCredit.value +
                      userController.proPlanCredit.value)
                  .toString();
            }
            return Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: UiResource.primaryBlack,
              ),
            );
          }),
        ),
      ],
    );
  }

  /// 停止组件
  Widget getStopButton() {
    return GestureDetector(
      onTap: () {
        setState(() {
          aborted = true;
        });
      },
      child: Container(
        margin: EdgeInsets.only(right: 24.w, bottom: 8.w),
        padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 8.w),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          shadows: const [
            BoxShadow(
              color: Color(0x260054A7),
              blurRadius: 10,
              offset: Offset(0, 0),
              spreadRadius: 0,
            )
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
                height: 12.w,
                width: 12.w,
                image: const AssetImage("public/asset/icon/stop.png")),
            SizedBox(
              width: 8.w,
            ),
            Text(
              'Stop',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w400,
                color: UiResource.primaryBlack,
              ),
            )
          ],
        ),
      ),
    );
  }

  /// 模式选择器
  Widget getModeSetModal(SessionModelEnum sessionModelEnum) {
    return Positioned(
        top: 85.w,
        left: 64.w,
        child: Container(
          width: 225.w,
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 15.w),
          decoration: ShapeDecoration(
            color: const Color(0xFFF8F8F8),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            shadows: const [
              BoxShadow(
                color: Color(0x26000000),
                blurRadius: 6,
                offset: Offset(0, 2),
                spreadRadius: 2,
              ),
              BoxShadow(
                color: Color(0x4C000000),
                blurRadius: 2,
                offset: Offset(0, 1),
                spreadRadius: 0,
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  _contentController.model = SessionModelEnum.pro;
                  _contentController.update();
                },
                child: Container(
                  width: Get.width,
                  //如果不加color的话，width会不起作用
                  color: Colors.transparent,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Pro${sessionModelEnum == SessionModelEnum.pro ? "  ✅" : ""}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: UiResource.primaryBlack,
                        ),
                      ),
                      Text(
                        'For everyday task',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: UiResource.primaryBlack,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: Get.width,
                height: 0.5.w,
                margin: EdgeInsets.only(top: 14.w),
                color: const Color(0xFFDDDDDD),
              ),
              SizedBox(
                height: 14.w,
              ),
              GestureDetector(
                onTap: () {
                  _contentController.model = SessionModelEnum.max;
                  _contentController.update();
                },
                child: Container(
                  width: Get.width,
                  //如果不加color的话，width会不起作用
                  color: Colors.transparent,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Max${sessionModelEnum == SessionModelEnum.max ? "  ✅" : ""}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: UiResource.primaryBlack,
                        ),
                      ),
                      Text(
                        'For complex problem solving',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: UiResource.primaryBlack,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  /// 下方输入框
  Widget getBottomSheet() {
    return exampleMode
        ? Positioned(
            left: 24.w,
            bottom: 10.w,
            child: Container(
              height: 40.w,
              width: 327.w,
              decoration: ShapeDecoration(
                color: UiResource.primaryBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100.r),
                ),
              ),
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10.w),
                  child: const Text(
                    'Start Your New Chat',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ))
        : Positioned(
            left: 0.w,
            bottom: 0,
            child: Container(
              width: Get.width,
              color: Colors.transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  onGenerateAnswer ? getStopButton() : getImageSelectGroup(),
                  getInputTextField()
                ],
              ),
            ));
  }

  /// 滑动ListView到最底部
  void _listViewScrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 50),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void initState() {
    super.initState();

    //判断是否为例题
    exampleMode = (sessionDto?.uuid ?? "").contains("example");

    //渲染完成后，对内容进行加载
    Future.delayed(Duration.zero).then((value) async {
      if (widget.sessionUuid == null) {
        return;
      }

      await updateSessionData(widget.sessionUuid!);

      _listViewScrollToBottom();
    });
  }

  @override
  void dispose() {
    questionImageController.empty();
    _contentEditController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefocusComponent(
        child: GetBuilder<ContentController>(builder: (contentController) {
          List<Widget> dialogCardList = [];

          List<SingleDialogDto> singleDialogDtoList =
              _contentController.singleDialogDtoList;

          for (SingleDialogDto singleDialogDto in singleDialogDtoList) {
            dialogCardList.add(getDialogGroup(singleDialogDto));
          }

          return Stack(
            children: [
              dialogCardList.isEmpty
                  ? Align(
                      alignment: Alignment.center,
                      child: Image(
                          height: 97.w,
                          width: 97.w,
                          image: const AssetImage(
                              "public/asset/icon/question_page_logo_icon.png")))
                  : Container(),
              Column(
                children: [
                  SizedBox(
                    height: ScreenUtil().statusBarHeight,
                  ),
                  Container(
                    height: 48.w,
                    width: Get.width,
                    padding: EdgeInsets.only(
                        top: 8.w, left: 24.w, right: 24.w, bottom: 8.w),
                    child: Row(
                      children: [
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: Icon(
                                Icons.keyboard_arrow_left,
                                color: UiResource.primaryBlack,
                                size: 36,
                              ),
                            ),
                            getBalanceInfoWidget(contentController.model)
                          ],
                        ),
                        const Spacer(),
                        exampleMode
                            ? Container()
                            : Image(
                                width: 24.w,
                                height: 24.w,
                                color: UiResource.primaryBlack,
                                image: const AssetImage(
                                    "public/asset/icon/question_page_bookmark.png")),
                        SizedBox(
                          width: exampleMode ? 0 : 24.w,
                        ),
                        Image(
                            width: 24.w,
                            height: 24.w,
                            color: exampleMode ? null : UiResource.primaryBlack,
                            image: const AssetImage(
                                "public/asset/icon/chat_page_chat_icon.png")),
                      ],
                    ),
                  ),
                  isLoading()
                      ? Container(
                          color: UiResource.primaryPurple,
                          padding: EdgeInsets.symmetric(vertical: 10.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 10.w,
                                height: 10.w,
                                child: const CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              const Text(
                                "Processing...",
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                        )
                      : Container(),
                  Expanded(
                      child: ListView.builder(
                    controller: _scrollController,
                    padding: EdgeInsets.fromLTRB(24.w, 24.w, 24.w, 156.w),
                    itemCount: dialogCardList.length,
                    itemBuilder: (context, index) => dialogCardList[index],
                  ))
                ],
              ),
              getBottomSheet(),
              modeSetModalOpen
                  ? getModeSetModal(contentController.model)
                  : Container()
            ],
          );
        }),
      ),
    );
  }
}

class ContentController extends GetxController {
  SessionModelEnum model = SessionModelEnum.pro;
  List<SingleDialogDto> singleDialogDtoList = [];
}
