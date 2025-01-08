import 'package:flutter/material.dart';
import 'dart:io';

class ProfileImagePicker extends StatelessWidget {
  final File? image;
  final VoidCallback onTap;

  const ProfileImagePicker({
    Key? key,
    required this.image,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 80,
            backgroundColor: Colors.grey.shade300,
            backgroundImage: image != null ? FileImage(image!) : null,
            child: image == null
                ? Icon(
                    Icons.person,
                    size: 80,
                    color: Colors.white,
                  )
                : null,
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: onTap,
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Color(0xFF4A78FF),
                child: Icon(
                  Icons.add_a_photo,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}