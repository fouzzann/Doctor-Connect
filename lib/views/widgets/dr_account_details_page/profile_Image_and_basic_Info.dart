import 'package:cc_dr_side/model/dr_model.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ProfileImageAndBasicInfo extends StatelessWidget {
  const ProfileImageAndBasicInfo({super.key, required this.doctor});
final Doctor doctor;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Hero(
          tag: 'doctor-${doctor.email}',
          child: GestureDetector(
            onTap: () => showZoomableImage(context, doctor.image),
            child: CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(doctor.image),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                doctor.fullName,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                doctor.category,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${doctor.yearsOfExperience} years of experience',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

   showZoomableImage(BuildContext context, String imageUrl) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          backgroundColor: Colors.black.withOpacity(0.7),
          body: Center(
            child: PhotoViewGallery.builder(
              itemCount: 1,
              builder: (context, index) {
                return PhotoViewGalleryPageOptions(
                  imageProvider: NetworkImage(imageUrl),
                  minScale: PhotoViewComputedScale.contained,
                  maxScale: PhotoViewComputedScale.covered,
                );
              },
              scrollPhysics: BouncingScrollPhysics(),
              backgroundDecoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
              ),
              pageController: PageController(),
            ),
          ),
        ),
      ),
    );
  }