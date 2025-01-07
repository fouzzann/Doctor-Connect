import 'package:cc_dr_side/views/widgets/message_page/message_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';



class MessagePage extends StatelessWidget {
  MessagePage({super.key});

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: _buildAppBar(),
      body: MessageList(auth: _auth),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: Colors.white,
      title: Column(
        children: const [
          Text(
            'Messages',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: Color(0xFF1A1F36),
            ),
          ),
        ],
      ),
      centerTitle: true,
    );
  }
}