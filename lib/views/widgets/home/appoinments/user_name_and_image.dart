import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cc_dr_side/controllers/doctore_controller.dart';

class UserNameAndImage extends StatelessWidget {
  const UserNameAndImage({super.key});

  @override
  Widget build(BuildContext context) {
    final DoctorController doctorController = Get.put(DoctorController());

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Obx(() => CircleAvatar(
                radius: 25,
                backgroundColor: Colors.blue,
                child: _buildAvatarContent(doctorController.doctorImage.value),
              )),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Hey Dr',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                Obx(() => Text(
                      doctorController.doctorName.value,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatarContent(String imageUrl) {
    if (imageUrl.isEmpty) {
      // Return a fallback icon when no image URL is provided
      return const Icon(
        Icons.person,
        size: 30,
        color: Colors.white,
      );
    }

    return ClipOval(
      child: Image.network(
        imageUrl,
        width: 50,
        height: 50,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          // Return a fallback icon when image loading fails
          return const Icon(
            Icons.person,
            size: 30,
            color: Colors.white,
          );
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        },
      ),
    );
  }
}