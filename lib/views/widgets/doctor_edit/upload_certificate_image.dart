import 'package:cc_dr_side/model/dr_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CertificateUploadWidget extends StatelessWidget {
  const CertificateUploadWidget({
    super.key,
    required this.doctor,
    required this.onImageSelected,
  });

  final Doctor doctor;
  final Function(String?) onImageSelected;

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = const Color(0xFF4A78FF);

    return Card(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Medical Certificate',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () async {
                final pickedImage =
                    await ImagePicker().pickImage(source: ImageSource.gallery);
                if (pickedImage != null) {
                  onImageSelected(pickedImage.path);
                }
              },
              child: Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: primaryColor.withOpacity(0.3)),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Image.network(doctor.certificateImage),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
