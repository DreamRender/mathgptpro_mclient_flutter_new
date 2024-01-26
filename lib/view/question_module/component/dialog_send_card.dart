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

  @override
  Widget build(BuildContext context) {
    List<Widget> returnWidgetList = [];

    Widget contentWidget;

    if (imgUrl == null) {
      contentWidget = Container(
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
        child: LaTexT(
          laTeXCode: Text(
            LatexUtils.convertVersion(inputText),
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
          breakDelimiter: '\n',
        ),
      );
    } else {
      contentWidget = Container(
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
            GestureDetector(
              onTap: () {
                Get.to(() => NetworkImageDetailPage(
                    imageUrlList: [imgUrl!], initPosition: 0));
              },
              child: CommonNetworkImage(
                url: imgUrl!,
                cacheKey: imgPath,
              ),
            ),
            SizedBox(
              height: inputText == "" ? 0 : 8.w,
            ),
            inputText == ""
                ? Container()
                : LaTexT(
                    laTeXCode: Text(
                      LatexUtils.convertVersion(inputText),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                    breakDelimiter: '\n',
                  )
          ],
        ),
      );
    }

    Widget controlPanel = Container(
      margin: EdgeInsets.only(top: 8.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
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
                    image: const AssetImage(
                        "public/asset/icon/question_page_latex_icon.png")),
                SizedBox(
                  width: 8.w,
                ),
                Text(
                  'Show latex',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: UiResource.primaryBlack,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            width: 8.w,
          ),
          Container(
            padding: EdgeInsets.all(8.w),
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
                    image: const AssetImage(
                        "public/asset/icon/question_page_copy_icon.png")),
                SizedBox(
                  width: 8.w,
                ),
                Text(
                  'Copy latex',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: UiResource.primaryBlack,
                  ),
                )
              ],
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
