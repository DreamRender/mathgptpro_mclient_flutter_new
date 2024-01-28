import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:latext/latext.dart';
import 'package:mathgptpro_mclient_flutter/component/image/common_network_image.dart';
import 'package:mathgptpro_mclient_flutter/constant/ui_resource.dart';
import 'package:mathgptpro_mclient_flutter/utils/latex_utils.dart';
import 'package:mathgptpro_mclient_flutter/view/common_module/network_image_detail_page.dart';

class DialogSendCard extends StatefulWidget {
  final String inputText;
  final String parsedText;
  final String? imgUrl;
  final String? imgPath;

  const DialogSendCard(
      this.inputText, this.parsedText, this.imgUrl, this.imgPath,
      {super.key});

  @override
  State<DialogSendCard> createState() => _DialogSendCardState();
}

class _DialogSendCardState extends State<DialogSendCard> {
  late String inputText = widget.inputText;
  late String parsedText = widget.parsedText;
  late String? imgUrl = widget.imgUrl;
  late String? imgPath = widget.imgPath;

  bool copy = false;
  bool showLatex = false;

  /// 获取文字显示信息
  Widget getTextWidget() {
    String showText = "";
    if (inputText == "" && showLatex == false) {
      return Container();
    } else if (inputText == "" && showLatex == true) {
      showText = parsedText;
    } else if (inputText != "" && showLatex == false) {
      showText = inputText;
    } else if (inputText != "" && showLatex == true) {
      showText = "$inputText $parsedText";
    }

    return Column(
      children: [
        SizedBox(
          height: 8.w,
        ),
        LaTexT(
          laTeXCode: Text(
            LatexUtils.convertVersion(showText),
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
          breakDelimiter: '\n',
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> returnWidgetList = [];

    Widget contentWidget = Container(
      width: Get.width,
      margin: EdgeInsets.only(top: 8.w),
      padding: EdgeInsets.symmetric(vertical: 18.w, horizontal: 16.w),
      decoration: ShapeDecoration(
        color: const Color(0xFFFDFCFF),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x140054A7),
            blurRadius: 7,
            offset: Offset(0, 0),
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          imgUrl == null
              ? Container()
              : GestureDetector(
                  onTap: () {
                    Get.to(() => NetworkImageDetailPage(
                        imageUrlList: [imgUrl!], initPosition: 0));
                  },
                  child: CommonNetworkImage(
                    url: imgUrl!,
                    cacheKey: imgPath,
                  ),
                ),
          getTextWidget()
        ],
      ),
    );

    Widget controlPanel = Container(
      margin: EdgeInsets.only(top: 8.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          imgUrl == null
              ? Container()
              : GestureDetector(
                  onTap: () {
                    setState(() {
                      showLatex = !showLatex;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(8.w),
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
                            image: const AssetImage(
                                "public/asset/icon/question_page_latex_icon.png")),
                        SizedBox(
                          width: 8.w,
                        ),
                        Text(
                          showLatex ? 'Hide latex' : 'Show latex',
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
          SizedBox(
            width: 8.w,
          ),
          GestureDetector(
            onTap: () async {
              //从剪贴板复制
              await FlutterClipboard.copy("$inputText $parsedText")
                  .then((value) async {
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
                  side: BorderSide(width: 1.w, color: const Color(0xFF9DCAFF)),
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

    returnWidgetList.add(contentWidget);
    returnWidgetList.add(controlPanel);

    return Column(children: returnWidgetList);
  }
}
