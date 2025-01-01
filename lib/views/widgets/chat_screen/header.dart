import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String userImage;
  final String userName;

  const Header({
    super.key,
    required this.userImage,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 12.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage(userImage),
            backgroundColor: Colors.grey[200],
            radius: 20,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              userName,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
