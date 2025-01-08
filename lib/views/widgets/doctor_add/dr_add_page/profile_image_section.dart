import 'dart:io';

import 'package:flutter/material.dart';

class ProfileImageSection extends StatelessWidget {
  final File? image;
  final VoidCallback onPickImage;

  const ProfileImageSection({
    Key? key,
    required this.image,
    required this.onPickImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPickImage,
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey[200],
          image: image != null
              ? DecorationImage(
                  image: FileImage(image!),
                  fit: BoxFit.cover,
                )
              : null,
        ),
        child: image == null
            ? Icon(
                Icons.add_a_photo,
                size: 40,
                color: Colors.grey[400],
              )
            : null,
      ),
    );
  }
}
