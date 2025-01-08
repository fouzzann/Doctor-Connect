import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cc_dr_side/controllers/auth_controller.dart';

class CertificateImagePicker extends StatelessWidget {
  final AuthController authController;

  const CertificateImagePicker({Key? key, required this.authController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 95),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => authController.PicCertificateImage(),
              child: Obx(() {
                return Container(
                  height: 350,
                  width: 350,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Colors.white,
                  ),
                  child: authController.certificateImage.value == null
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.add_a_photo_rounded,
                              size: 100,
                              color: Color(0xFF4A78FF),
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Tap to add image',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        )
                      : Center(
                          child: Image.file(
                            authController.certificateImage.value!,
                            fit: BoxFit.fill,
                          ),
                        ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
