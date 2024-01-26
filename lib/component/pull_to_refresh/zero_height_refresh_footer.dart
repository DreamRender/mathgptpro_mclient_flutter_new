import 'package:flutter/material.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class ZeroHeightRefreshFooter extends StatelessWidget {
  const ZeroHeightRefreshFooter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomFooter(
      builder: (BuildContext context, LoadStatus? mode) {
        return Container();
      },
      loadStyle: LoadStyle.HideAlways,
    );
  }
}
