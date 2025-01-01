import 'package:flutter/material.dart';

class CallButtons extends StatelessWidget {
  const CallButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.video_call),
        ),
        IconButton(onPressed: () {}, icon: Icon(Icons.call)),
        SizedBox(
          width: 10,
        ),
      ],
    );
  }
}
