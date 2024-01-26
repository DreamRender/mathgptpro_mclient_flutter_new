import 'dart:io';

import 'package:get/get.dart';
import 'package:mathgptpro_mclient_flutter/constant/ui_resource.dart';
import 'package:mathgptpro_mclient_flutter/view/question_module/image_crop_page.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';

class ImageSelectUtils {
  /// 从相册中选择图片
  static Future<void> galleryImageSelect(bool isRedirectToQuestionPage) async {
    List<AssetEntity>? pickedList = await AssetPicker.pickAssets(Get.context!,
        pickerConfig: AssetPickerConfig(
          maxAssets: 1,
          requestType: RequestType.image,
          themeColor: UiResource.primaryBlue,
          previewThumbnailSize: const ThumbnailSize(800, 800),
        ));

    if (pickedList != null && pickedList.length == 1) {
      File? rawImage = await pickedList[0].file;
      if (rawImage != null) {
        Get.to(() => ImageCropPage(
            rawImage: rawImage,
            isRedirectToQuestionPage: isRedirectToQuestionPage));
      }
    }
  }

  /// 从相机中选择图片
  static Future<void> cameraImageSelect(bool isRedirectToQuestionPage) async {
    AssetEntity? entity = await CameraPicker.pickFromCamera(Get.context!,
        locale: Get.deviceLocale,
        pickerConfig: CameraPickerConfig(
            shouldDeletePreviewFile: true,
            theme: CameraPicker.themeData(UiResource.primaryBlue)));
    if (entity != null) {
      File? rawImage = await entity.file;
      if (rawImage != null) {
        Get.to(() => ImageCropPage(
              rawImage: rawImage,
              isRedirectToQuestionPage: isRedirectToQuestionPage,
            ));
      }
    }
  }
}
