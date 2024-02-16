import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:latext/latext.dart';
import 'package:mathgptpro_mclient_flutter/constant/session_feedback_enum.dart';
import 'package:mathgptpro_mclient_flutter/constant/ui_resource.dart';
import 'package:mathgptpro_mclient_flutter/service/session_service.dart';
import 'package:mathgptpro_mclient_flutter/state/controller/dialog_controller.dart';
import 'package:mathgptpro_mclient_flutter/utils/latex_utils.dart';
import 'package:mathgptpro_mclient_flutter/utils/toast_utils.dart';

class DialogReceiveCard extends StatefulWidget {
  final String outputText;
  final int outputId;
  final bool showControlPanel;

  const DialogReceiveCard(this.outputText, this.outputId, this.showControlPanel,
      {super.key});

  @override
  State<DialogReceiveCard> createState() => _DialogReceiveCardState();
}

class _DialogReceiveCardState extends State<DialogReceiveCard> {
  final SessionService sessionService = SessionService();

  final DialogController dialogController = Get.find();

  late String outputText = widget.outputText;

  late int outputId = widget.outputId;

  late bool showControlPanel = widget.showControlPanel;

  bool copy = false;

  @override
  Widget build(BuildContext context) {
    List<Widget> returnWidgetList = [];

    Widget widget = Container(
      margin: EdgeInsets.only(top: 22.w),
      child: Stack(
        children: [
          Container(
            width: Get.width,
            margin: EdgeInsets.only(top: 10.w),
            padding: EdgeInsets.symmetric(vertical: 32.w, horizontal: 16.w),
            decoration: ShapeDecoration(
              color: const Color(0xFF0053A6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              shadows: const [
                BoxShadow(
                  color: Color(0x260054A7),
                  blurRadius: 10,
                  offset: Offset(0, 0),
                  spreadRadius: 0,
                )
              ],
            ),
            child: LaTexT(
              laTeXCode: Text(
                LatexUtils.convertVersion(outputText),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
              breakDelimiter: '\n',
            ),
          ),
          Positioned(
              top: 0,
              child: Container(
                width: 32.w,
                height: 32.w,
                decoration: const BoxDecoration(
                    color: Colors.white, shape: BoxShape.circle),
                padding: EdgeInsets.all(5.w),
                child: const Image(
                  image: AssetImage("public/asset/logo/mathgptpro_icon.png"),
                ),
              )),
        ],
      ),
    );
    returnWidgetList.add(widget);

    if (showControlPanel) {
      Widget controlPanel =
          GetBuilder<DialogController>(builder: (dialogController) {
        return Container(
          margin: EdgeInsets.only(top: 8.w, bottom: 22.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //ThumbUpButton
              GestureDetector(
                onTap: () {
                  if (dialogController.thumbUpDialogIdList.contains(outputId)) {
                    return;
                  }

                  dialogController.thumbUpDialogIdListAdd(outputId);

                  sessionService.feedbackSave(
                      outputId, SessionFeedbackEnum.good);
                  ToastUtils.showSystemToast("Thanks for feedback!");
                },
                child: Container(
                  padding: EdgeInsets.all(8.w),
                  margin: EdgeInsets.only(left: 8.w),
                  decoration: ShapeDecoration(
                    color:
                        dialogController.thumbUpDialogIdList.contains(outputId)
                            ? UiResource.primaryBlue
                            : null,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                          width: 1.w, color: const Color(0xFF9DCAFF)),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: Image(
                      height: 12.w,
                      width: 12.w,
                      color: dialogController.thumbUpDialogIdList
                              .contains(outputId)
                          ? Colors.white
                          : null,
                      image: const AssetImage(
                          "public/asset/icon/icon_thumbup.png")),
                ),
              ),
              //ThumbDownButton
              GestureDetector(
                onTap: () {
                  if (dialogController.thumbDownDialogIdList
                      .contains(outputId)) {
                    return;
                  }
                  dialogController.thumbDownDialogIdListAdd(outputId);

                  sessionService.feedbackSave(
                      outputId, SessionFeedbackEnum.bad);
                  ToastUtils.showSystemToast("Thanks for feedback!");
                },
                child: Container(
                  padding: EdgeInsets.all(8.w),
                  margin: EdgeInsets.only(left: 8.w),
                  decoration: ShapeDecoration(
                    color: dialogController.thumbDownDialogIdList
                            .contains(outputId)
                        ? UiResource.primaryBlue
                        : null,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                          width: 1.w, color: const Color(0xFF9DCAFF)),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: Image(
                      height: 12.w,
                      width: 12.w,
                      color: dialogController.thumbDownDialogIdList
                              .contains(outputId)
                          ? Colors.white
                          : null,
                      image: const AssetImage(
                          "public/asset/icon/icon_thumbdown.png")),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () async {
                  //从剪贴板复制
                  await FlutterClipboard.copy(outputText).then((value) async {
                    setState(() {
                      copy = true;
                    });
                    await Future.delayed(const Duration(seconds: 3));
                    setState(() {
                      copy = false;
                    });
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(8.w),
                  margin: EdgeInsets.only(left: 8.w),
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                          width: 1.w, color: const Color(0xFF9DCAFF)),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: Row(
                    children: [
                      Image(
                          height: 12.w,
                          width: 12.w,
                          color: Colors.black,
                          image: AssetImage(copy
                              ? "public/asset/icon/check.png"
                              : "public/asset/icon/question_page_copy_icon.png")),
                      SizedBox(
                        width: 8.w,
                      ),
                      Text(
                        copy ? 'Copied' : 'Copy latex',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: UiResource.primaryBlack,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      });
      returnWidgetList.add(controlPanel);
    }

    return Column(children: returnWidgetList);
  }
}
