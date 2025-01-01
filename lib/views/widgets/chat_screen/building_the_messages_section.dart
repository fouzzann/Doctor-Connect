import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
Widget buildMessages(Stream<QuerySnapshot<Map<String, dynamic>>> stream) {
  return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
    stream: stream,
    builder: (context, snapshot) {
      if (snapshot.hasError) {
        return Center(
          child: Text(
            "Error: ${snapshot.error}",
            style: TextStyle(color: Colors.red[400]),
          ),
        );
      }

      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.chat_bubble_outline,
                size: 48,
                color: Colors.grey[400],
              ),
              const SizedBox(height: 16),
              Text(
                "No messages yet.",
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 16,
                ),
              ),
            ],
          ),
        );
      }

      final listMessages = snapshot.data!.docs;
      return ListView.builder(
        reverse: true,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: listMessages.length,
        itemBuilder: (context, index) {
          final message = listMessages[index];
          final bool isMe = message['senderId'] == _auth.currentUser!.uid;

          return Align(
            alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
            child: Column(
              crossAxisAlignment:
                  isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                buildMessageBubble(message, isMe),
              ],
            ),
          );
        },
      );
    },
  );
}

// Message bubble widget
Widget buildMessageBubble(DocumentSnapshot message, bool isMe) {
  return Container(
    margin: EdgeInsets.only(
      bottom: 4,
      left: isMe ? 50 : 0,
      right: isMe ? 0 : 50,
    ),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    decoration: BoxDecoration(
      color: isMe ? Colors.blue[600] : Colors.grey[200],
      borderRadius: BorderRadius.only(
        topLeft: const Radius.circular(20),
        topRight: const Radius.circular(20),
        bottomLeft: Radius.circular(isMe ? 20 : 5),
        bottomRight: Radius.circular(isMe ? 5 : 20),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          message['message'],
          style: TextStyle(
            fontSize: 15,
            color: isMe ? Colors.white : Colors.black87,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          message['timestamp'] != null
              ? (message['timestamp'] as Timestamp)
                  .toDate()
                  .toLocal()
                  .toString()
                  .split(' ')[1]
                  .substring(0, 5)
              : 'sending..',
          style: TextStyle(
            fontSize: 10,
            color: isMe ? Colors.white70 : Colors.grey[600],
          ),
        ),
      ],
    ),
  );
}
