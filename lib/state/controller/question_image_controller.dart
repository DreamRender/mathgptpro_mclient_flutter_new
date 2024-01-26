import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

class QuestionImageController extends GetxController {
  File? croppedImage;

  Uint8List? uint8list;

  empty() {
    croppedImage = null;
    uint8list = null;
    update();
  }
}
