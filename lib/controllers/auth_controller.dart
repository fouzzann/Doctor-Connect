import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AuthController extends GetxController {
  var certificateImage = Rx<File?>(null);
  Rx<File?>  profileImage = Rx<File?>(null);
  final ImagePicker _picker = ImagePicker();
  Future<void> PicCertificateImage() async {
    try {
      final XFile? pickedImage =
          await _picker.pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        certificateImage.value = File(pickedImage.path);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> PicProfileImage() async {
    try {
      final XFile? pickedImage =
          await _picker.pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        profileImage.value = File(pickedImage.path);
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
