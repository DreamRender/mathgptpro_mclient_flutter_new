import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

///用来查看已选择的照片的详情页
class NetworkImageDetailPage extends StatefulWidget {
  ///照片列表
  final List<String> imageUrlList;

  ///初始位置
  final int initPosition;

  const NetworkImageDetailPage(
      {Key? key, required this.imageUrlList, required this.initPosition})
      : super(key: key);

  @override
  _NetworkImageDetailPageState createState() => _NetworkImageDetailPageState();
}

class _NetworkImageDetailPageState extends State<NetworkImageDetailPage> {
  ///照片列表
  late List<String> imageUrlList = widget.imageUrlList;

  ///初始位置
  late int initPosition = widget.initPosition;

  ///页面控制器
  late PageController pageController =
      PageController(initialPage: initPosition);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: false,
      body: Container(
        constraints: BoxConstraints.expand(
          height: Get.height,
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              bottom: 0,
              right: 0,
              child: PhotoViewGallery.builder(
                  scrollPhysics: const BouncingScrollPhysics(),
                  pageController: pageController,
                  itemCount: imageUrlList.length,
                  enableRotation: false,
                  backgroundDecoration:
                      const BoxDecoration(color: Colors.black),
                  builder: (BuildContext context, int index) {
                    return PhotoViewGalleryPageOptions(
                      imageProvider: CachedNetworkImageProvider(
                        imageUrlList[index],
                      ),
                      //设置一开始的尺寸要比照片小,防止截屏照片遮挡操作栏
                      initialScale: PhotoViewComputedScale.contained * 0.9,
                    );
                  },
                  loadingBuilder: (context, event) {
                    return Center(
                      child: SizedBox(
                        width: 50.w,
                        height: 50.w,
                        child: const CircularProgressIndicator(),
                      ),
                    );
                  }),
            ),
            Positioned(
              //右上角关闭按钮
              left: 10,
              top: MediaQuery.of(context).padding.top,
              child: IconButton(
                icon: const Icon(
                  Icons.close,
                  size: 30,
                  color: Colors.white,
                ),
                onPressed: () {
                  Get.back();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
