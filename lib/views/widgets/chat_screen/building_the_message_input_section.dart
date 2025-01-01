import 'package:cc_dr_side/controllers/chat_controller.dart';
import 'package:cc_dr_side/model/chat_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final TextEditingController _messageController = TextEditingController();
final FirebaseAuth _auth = FirebaseAuth.instance;
final ChatController chatController = Get.put(ChatController());

Widget buildMessageInput(String userId) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    decoration: BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 10,
          offset: const Offset(0, -5),
        ),
      ],
    ),
    child: SafeArea(
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: "Type a message...",
                hintStyle: TextStyle(color: Colors.grey[500]),
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
              ),
              maxLines: null,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            height: 45,
            width: 45,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue[600],
            ),
            child: IconButton(
              onPressed: () async {
                if (_messageController.text.trim().isNotEmpty) {
                  final String chatRoomId = await chatController.createChat(
                    _auth.currentUser!.uid,
                    userId,
                  );
                  final chatModel = ChatModel(
                    senderId: _auth.currentUser!.uid,
                    resiverId: userId,
                    message: _messageController.text,
                    timestamp: Timestamp.now(),
                  );
                  chatController.sendMessage(chatModel, chatRoomId);
                  _messageController.clear();
                }
              },
              icon: const Icon(
                Icons.send,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
