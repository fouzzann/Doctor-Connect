import 'package:cc_dr_side/model/dr_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileImageWidget extends StatelessWidget {
  const ProfileImageWidget({
    super.key,
    required this.doctor,
    required this.onImageSelected,
  });

  final Doctor doctor;
  final Function(String?) onImageSelected;

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = const Color(0xFF4A78FF);

    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 60,
            backgroundImage: NetworkImage(doctor.image),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: CircleAvatar(
              backgroundColor: primaryColor,
              child: IconButton(
                icon: const Icon(Icons.add_a_photo, color: Colors.white),
                onPressed: () async {
                  final pickedImage = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                  if (pickedImage != null) {
                    onImageSelected(pickedImage.path);
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
