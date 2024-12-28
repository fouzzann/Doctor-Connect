import 'package:cc_dr_side/controllers/doctore_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserNameAndImage extends StatelessWidget {
  const UserNameAndImage({super.key});

  @override
  Widget build(BuildContext context) {
    final DoctorController doctorController = Get.put(DoctorController());
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: Colors.blue,
            backgroundImage:
                _getAvatarImage(doctorController.doctorImage.value),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Hey Dr',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              Text(
                doctorController.doctorName.value,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ), 
            ],
          ),
        ],
      ),
    );
  }
}

ImageProvider _getAvatarImage(String url) {
  if (url.isNotEmpty) {
    return NetworkImage(url);
  }
  return const AssetImage('assets/default_avatar.jpg');
}
