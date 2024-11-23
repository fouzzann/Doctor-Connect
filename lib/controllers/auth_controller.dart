import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AuthController extends GetxController {
  var image = Rx<File?>(null);

  final ImagePicker _picker = ImagePicker();
  Future<void> PicCertificateImage() async {
    try {
      final XFile? pickedImage =
          await _picker.pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        image.value = File(pickedImage.path);
      }
    } catch (e) { 
      log(e.toString());
    }
  }
}
