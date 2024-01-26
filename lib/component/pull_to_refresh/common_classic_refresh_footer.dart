import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class CommonClassicRefreshFooter extends StatelessWidget {
  final String noMoreText;

  const CommonClassicRefreshFooter({Key? key, this.noMoreText = "整条街都已经被逛完啦"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomFooter(
      builder: (BuildContext context, LoadStatus? mode) {
        Widget body;

        TextStyle textStyle =
            TextStyle(color: context.textTheme.bodyLarge!.color);

        switch (mode) {
          case LoadStatus.idle:
            body = Text(
              "上拉加载",
              style: textStyle,
            );
            break;
          case LoadStatus.loading:
            body = const CupertinoActivityIndicator();
            break;
          case LoadStatus.failed:
            body = Text(
              "哦不！加载失败了",
              style: textStyle,
            );
            break;
          case LoadStatus.canLoading:
            body = Text(
              "松手吧",
              style: textStyle,
            );
            break;
          case LoadStatus.noMore:
            body = Text(
              noMoreText,
              style: textStyle,
            );
            break;
          default:
            body = Container();
            break;
        }
        return SizedBox(
          height: 50.w,
          child: Center(child: body),
        );
      },
      loadStyle: LoadStyle.HideAlways,
    );
  }
}
