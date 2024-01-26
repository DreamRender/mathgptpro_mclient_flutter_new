import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

///通用网络图片组件
///除了NetworkImageDetailPage的特殊情况外
///其他所有网络图片均须使用本组件实现
class CommonNetworkImage extends StatelessWidget {
  final BoxFit fit;

  final String url;

  final String? cacheKey;

  const CommonNetworkImage(
      {super.key, required this.url, this.fit = BoxFit.fill, this.cacheKey});

  @override
  Widget build(BuildContext context) {
    //修改的时候需要一并注意NetworkImageDetailPage的修改
    return FadeInImage(
      fit: fit,
      fadeInCurve: Curves.easeIn,
      placeholder: const AssetImage("public/asset/icon/loading.png"),
      placeholderFit: BoxFit.scaleDown,
      fadeInDuration: const Duration(milliseconds: 100),
      image: CachedNetworkImageProvider(url, cacheKey: cacheKey),
      imageErrorBuilder: (context, error, stackTrace) {
        return const CircularProgressIndicator();
      },
    );
  }
}
