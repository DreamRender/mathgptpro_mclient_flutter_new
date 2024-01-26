import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  final String url;

  const WebViewPage({Key? key, required this.url}) : super(key: key);

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late String url = widget.url;

  WebViewController webViewController = WebViewController();

  /// 加载是否完成
  bool isLoadingComplete = false;

  @override
  void initState() {
    super.initState();

    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(url))
      ..setNavigationDelegate(NavigationDelegate(onPageFinished: (String url) {
        log('web view onPageFinished: $url');
        setState(() {
          isLoadingComplete = true;
        });
      }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                  child: WebViewWidget(
                controller: webViewController,
              ))
            ],
          ),
          isLoadingComplete
              ? Container()
              : Positioned(
                  top: 15.w,
                  left: 22.w,
                  child: SizedBox(
                    height: 15.w,
                    width: 15.w,
                    child: const CircularProgressIndicator(
                        color: Color(0xFF339AF0)),
                  ))
        ],
      ),
    );
  }
}
