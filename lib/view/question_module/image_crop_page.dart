import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:crop_image/crop_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:mathgptpro_mclient_flutter/component/dialog/loading_dialog.dart';
import 'package:mathgptpro_mclient_flutter/state/controller/question_image_controller.dart';
import 'package:mathgptpro_mclient_flutter/view/question_module/question_answer_page.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

///图像剪切页
class ImageCropPage extends StatefulWidget {
  const ImageCropPage(
      {Key? key,
      required this.rawImage,
      required this.isRedirectToQuestionPage})
      : super(key: key);

  ///待处理的照片
  final File rawImage;

  ///导航至ContentPage
  final bool isRedirectToQuestionPage;

  @override
  _ImageCropPageState createState() => _ImageCropPageState();
}

class _ImageCropPageState extends State<ImageCropPage> {
  /// 待处理的照片
  late File rawImage = widget.rawImage;

  /// 后续导航的页面
  late bool isRedirectToQuestionPage = widget.isRedirectToQuestionPage;

  final QuestionImageController imageCropController = Get.find();

  final cropImageController = CropController(
    defaultCrop: const Rect.fromLTRB(0.1, 0.1, 0.9, 0.9),
  );

  Widget _buildButtons() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              cropImageController.rotation = CropRotation.up;
              cropImageController.crop =
                  const Rect.fromLTRB(0.1, 0.1, 0.9, 0.9);
              cropImageController.aspectRatio = 1.0;
            },
          ),
          IconButton(
            icon: const Icon(Icons.rotate_90_degrees_ccw_outlined),
            onPressed: () async => cropImageController.rotateLeft(),
          ),
          IconButton(
            icon: const Icon(Icons.rotate_90_degrees_cw_outlined),
            onPressed: () async => cropImageController.rotateRight(),
          ),
          TextButton(
            onPressed: _finished,
            child: Text('完成'.tr),
          ),
        ],
      );

  Future<void> _finished() async {
    Get.dialog(const LoadingDialog(), barrierDismissible: false);

    var croppedBitmap = await cropImageController.croppedBitmap();
    ByteData croppedByteData =
        (await croppedBitmap.toByteData(format: ImageByteFormat.png))!;
    ByteBuffer croppedByteBuffer = croppedByteData.buffer;

    String tempPath = (await getTemporaryDirectory()).path;
    String filePath = '$tempPath/${const Uuid().v4()}.png';

    File file = await File(filePath).writeAsBytes(croppedByteBuffer.asUint8List(
        croppedByteData.offsetInBytes, croppedByteData.lengthInBytes));

    Uint8List? uint8list;

    //获取以Bytes为单位的大小
    int fileSizeInBytes = await file.length();
    //获取以MB为单位的大小
    double fileSizeInMb = fileSizeInBytes / 1048576;

    if (fileSizeInMb <= 0.5) {
      log('文件压缩前大小$fileSizeInMb MB');
      uint8list = await FlutterImageCompress.compressWithFile(
          file.absolute.path,
          format: CompressFormat.png,
          quality: 90);
    } else if (fileSizeInMb > 0.5 && fileSizeInMb < 1) {
      log('文件压缩前大小$fileSizeInMb MB');
      uint8list = await FlutterImageCompress.compressWithFile(
          file.absolute.path,
          format: CompressFormat.png,
          quality: 70);
    } else {
      log('文件压缩前大小$fileSizeInMb MB');
      uint8list = await FlutterImageCompress.compressWithFile(
          file.absolute.path,
          format: CompressFormat.png,
          quality: 50);
    }

    imageCropController.croppedImage = file;
    imageCropController.uint8list = uint8list;
    imageCropController.update();

    if (isRedirectToQuestionPage) {
      //关闭Dialog
      Get.back();
      Get.off(() => const QuestionAnswerPage(sessionUuid: null),
          preventDuplicates: false);
    } else {
      //关闭Dialog并返回页面
      Get.back(closeOverlays: true);
    }
  }

  @override
  void dispose() {
    cropImageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: CropImage(
          controller: cropImageController,
          gridInnerColor: Colors.transparent,
          image: Image.file(widget.rawImage),
          touchSize: 50,
          alwaysMove: true,
          gridCornerSize: 50,
          minimumImageSize: 20,
        ),
      ),
      bottomNavigationBar: _buildButtons(),
    );
  }
}
