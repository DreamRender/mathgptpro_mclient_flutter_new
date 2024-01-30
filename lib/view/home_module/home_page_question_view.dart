import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:latext/latext.dart';
import 'package:mathgptpro_mclient_flutter/cache/session_cache.dart';
import 'package:mathgptpro_mclient_flutter/component/pull_to_refresh/common_classic_refresh_header.dart';
import 'package:mathgptpro_mclient_flutter/constant/ui_resource.dart';
import 'package:mathgptpro_mclient_flutter/model/session_history_dto.dart';
import 'package:mathgptpro_mclient_flutter/service/session_service.dart';
import 'package:mathgptpro_mclient_flutter/state/controller/session_controller.dart';
import 'package:mathgptpro_mclient_flutter/state/controller/user_controller.dart';
import 'package:mathgptpro_mclient_flutter/utils/latex_utils.dart';
import 'package:mathgptpro_mclient_flutter/utils/toast_utils.dart';
import 'package:mathgptpro_mclient_flutter/view/question_module/question_answer_page.dart';
import 'package:mathgptpro_mclient_flutter/view/question_module/question_more_bottom_sheet.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class HomePageQuestionView extends StatefulWidget {
  const HomePageQuestionView({super.key});

  @override
  State<HomePageQuestionView> createState() => _HomePageQuestionViewState();
}

class _HomePageQuestionViewState extends State<HomePageQuestionView>
    with AutomaticKeepAliveClientMixin {
  final SessionService sessionService = SessionService();

  late RefreshController refreshController;

  final List<Widget> sessionWidgetList = [
    Container(
      margin: EdgeInsets.only(top: 24.w),
      child: const Image(
        image: AssetImage("public/asset/icon/home_page_welcome_image.png"),
      ),
    ),
    Container(
      margin: EdgeInsets.only(top: 24.w, bottom: 8.w),
      alignment: Alignment.centerLeft,
      child: Text(
        'Examples',
        style: TextStyle(
          fontSize: 20,
          color: UiResource.primaryBlack,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  ];

  bool modeSetModalOpen = false;

  List<SessionHistoryDto> sessionList = [];

  // 刷新
  onRefresh() async {
    sessionList = await sessionService.getSessionAll();
    sessionList = sortSessionList(sessionList);

    setState(() {});

    refreshController.refreshCompleted();
  }

  /// 排序
  List<SessionHistoryDto> sortSessionList(List<SessionHistoryDto> sessionList) {
    Map<int, SessionHistoryDto> sessionMap = {};

    List<int> timeList = [];

    List<SessionHistoryDto> result = [];

    for (SessionHistoryDto element in sessionList) {
      sessionMap[element.createdAt ?? 0] = element;
      timeList.add(element.createdAt ?? 0);
    }

    timeList.sort((b, a) => a.compareTo(b));

    for (int time in timeList) {
      result.add(sessionMap[time]!);
    }

    return result;
  }

  /// 历史记录卡片构造
  Widget sessionCardBuilder(
      int sessionId, String content, int time, String uuid) {
    bool isExample = uuid.contains("example");

    content = LatexUtils.convertVersion(content).replaceAll("\n", '');

    return GetBuilder<SessionController>(builder: (contentManageController) {
      if (contentManageController.deletedSessionIdList.contains(sessionId)) {
        return Container();
      } else {
        return GestureDetector(
          onTap: () {
            Get.to(() => QuestionAnswerPage(sessionUuid: uuid));
          },
          onLongPress: () {
            if (isExample) {
              ToastUtils.showInfoToast("不能对例题进行操作哦".tr);
            } else {
              Get.bottomSheet(QuestionMoreBottomSheet(
                sessionId: sessionId,
              ));
            }
          },
          child: Container(
            margin: EdgeInsets.only(top: 8.w),
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
            child: Container(
              padding: EdgeInsets.fromLTRB(15.w, 20.w, 15.w, 18.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LaTexT(
                    laTeXCode: Text(
                      content,
                      style:
                          context.textTheme.bodyMedium!.copyWith(height: 2.5),
                    ),
                    breakDelimiter: '\n',
                  ),
                ],
              ),
            ),
          ),
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();
    sessionList = globalSessionCache.sessionHistoryDtoList;
    sessionList = sortSessionList(sessionList);
    refreshController = RefreshController(initialRefresh: false);
  }

  @override
  void dispose() {
    refreshController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    List<Widget> listViewWidget = [...sessionWidgetList];

    for (SessionHistoryDto element in sessionList) {
      listViewWidget.add(sessionCardBuilder(element.id!,
          element.parsedFirstImg ?? "", element.createdAt!, element.uuid!));
    }

    return Stack(
      children: [
        Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).padding.top,
            ),
            Container(
              height: 48.w,
              width: Get.width,
              padding: EdgeInsets.only(
                  top: 8.w, left: 24.w, right: 24.w, bottom: 8.w),
              child: Row(
                children: [
                  Image(
                      width: 32.w,
                      height: 32.w,
                      image: const AssetImage(
                          "public/asset/icon/home_page_logo_icon.png")),
                  GestureDetector(
                    onTap: () => setState(() {
                      modeSetModalOpen = !modeSetModalOpen;
                    }),
                    child: Container(
                      margin: EdgeInsets.only(left: 20.w),
                      padding: EdgeInsets.only(
                          left: 16.w, right: 8.w, top: 4.w, bottom: 4.w),
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              width: 1, color: Color(0xFFD9D9D9)),
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Free Plan',
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
                  const Spacer(),
                  GetX<UserController>(builder: (userController) {
                    return Row(
                      children: [
                        Image(
                            width: 16.w,
                            height: 16.w,
                            image:
                                const AssetImage("public/asset/icon/coin.png")),
                        Container(
                          margin: EdgeInsets.only(left: 10.w),
                          child: Text(
                            '${userController.proExtraCredit.value + userController.proPlanCredit.value}',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: UiResource.primaryBlack,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 24.w),
                          child: Image(
                              width: 16.w,
                              height: 16.w,
                              image: const AssetImage(
                                  "public/asset/icon/diamond.png")),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10.w),
                          child: Text(
                            '${userController.maxPlanCredit.value + userController.maxExtraCredit.value}',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: UiResource.primaryBlack,
                            ),
                          ),
                        )
                      ],
                    );
                  })
                ],
              ),
            ),
            Expanded(
                child: RefreshConfiguration(
              child: ScrollConfiguration(
                behavior: const ScrollBehavior(),
                child: SmartRefresher(
                    enablePullDown: true,
                    header: const CommonClassicRefreshHeader(),
                    controller: refreshController,
                    onRefresh: onRefresh,
                    child: ListView.builder(
                      itemCount: sessionList.length,
                      padding: EdgeInsets.only(
                          left: 13.w, right: 13.w, bottom: 80.w),
                      itemBuilder: (context, index) => listViewWidget[index],
                    )),
              ),
            ))
          ],
        ),
        modeSetModalOpen
            ? Positioned(
                top: 95.w,
                left: 24.w,
                child: Container(
                  width: 327.w,
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 15.w),
                  decoration: ShapeDecoration(
                    color: const Color(0xFFf9f9f9),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
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
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image(
                              width: 24.w,
                              height: 24.w,
                              image: const AssetImage(
                                  "public/asset/icon/home-page-free-plan-icon.png")),
                          Container(
                            margin: EdgeInsets.only(left: 12.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Free Plan  ✅',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: UiResource.primaryBlack,
                                  ),
                                ),
                                Text(
                                  'Get 10 coins and 2 diamonds for free monthly',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: UiResource.primaryBlack,
                                  ),
                                ),
                                const Text(
                                  'Invite a friend to get more coins',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF2B95EB),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      Container(
                        width: 303.w,
                        height: 0.5.w,
                        margin: EdgeInsets.only(top: 14.w),
                        color: const Color(0xFFDDDDDD),
                      ),
                      SizedBox(
                        height: 14.w,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image(
                              width: 24.w,
                              height: 24.w,
                              image: const AssetImage(
                                  "public/asset/icon/home-page-starter-plan-icon.png")),
                          Container(
                            margin: EdgeInsets.only(left: 12.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Starter Plan',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: UiResource.primaryBlack,
                                  ),
                                ),
                                Text(
                                  'Get 100 coins and 10 diamonds per month',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: UiResource.primaryBlack,
                                  ),
                                ),
                                const Text(
                                  'Upgrade',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF2B95EB),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      Container(
                        width: 303.w,
                        height: 0.5.w,
                        margin: EdgeInsets.only(top: 14.w),
                        color: const Color(0xFFDDDDDD),
                      ),
                      SizedBox(
                        height: 14.w,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image(
                              width: 24.w,
                              height: 24.w,
                              image: const AssetImage(
                                  "public/asset/icon/home-page-premuim-plan-icon.png")),
                          Container(
                            margin: EdgeInsets.only(left: 12.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Premium Plan',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: UiResource.primaryBlack,
                                  ),
                                ),
                                Text(
                                  'Get 3000 coins and 30 diamonds',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: UiResource.primaryBlack,
                                  ),
                                ),
                                const Text(
                                  'Upgrade',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF2B95EB),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ))
            : Container(),
      ],
    );
  }
}
