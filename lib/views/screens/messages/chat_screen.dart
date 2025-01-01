import 'package:cc_dr_side/views/widgets/chat_screen/building_the_message_input_section.dart';
import 'package:cc_dr_side/views/widgets/chat_screen/building_the_messages_section.dart';
import 'package:cc_dr_side/views/widgets/chat_screen/call_buttons.dart';
import 'package:cc_dr_side/views/widgets/chat_screen/header.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cc_dr_side/controllers/chat_controller.dart';


class ChatScreen extends StatefulWidget {
  final String userId;
  final String userName;
  final String userImage;

  const ChatScreen({
    super.key,
    required this.userId,
    required this.userName,
    required this.userImage,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ChatController chatController = Get.put(ChatController());
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Stream to fetch the chat messages
  Stream<QuerySnapshot<Map<String, dynamic>>> get chatStream {
    return FirebaseFirestore.instance
        .collection('chatRooms')
        .doc("${widget.userId}_${_auth.currentUser!.uid}")
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20),
          onPressed: () => Get.back(),
        ),
        title: Header(userImage: widget.userImage, userName: widget.userName),
        actions: [CallButtons()],
        centerTitle: false,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Expanded(child: buildMessages(chatStream)),
          buildMessageInput(widget.userId),
        ], 
      ),
    );
  }
}
