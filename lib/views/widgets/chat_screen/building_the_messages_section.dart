import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
      String? currentDate;

      return ListView.builder(
        reverse: true,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: listMessages.length,
        itemBuilder: (context, index) {
          final message = listMessages[index];
          final bool isMe = message['senderId'] == _auth.currentUser!.uid;
          
          // Safely handle timestamp
          final timestamp = message['timestamp'];
          if (timestamp == null) {
            return buildMessageWithoutDate(message, isMe);
          }

          // Get message date
          final messageDate = (timestamp as Timestamp).toDate();
          final formattedDate = DateFormat('MMMM d, y').format(messageDate);
          
          // Check if we need to show a date header
          Widget? dateHeader;
          if (currentDate != formattedDate) {
            currentDate = formattedDate;
            dateHeader = Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              alignment: Alignment.center,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  formattedDate,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
          }

          return Column(
            children: [
              if (dateHeader != null) dateHeader,
              Align(
                alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment:
                      isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  children: [
                    buildMessageBubble(message, isMe),
                  ],
                ),
              ),
            ],
          );
        },
      );
    },
  );
}

Widget buildMessageWithoutDate(DocumentSnapshot message, bool isMe) {
  return Align(
    alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
    child: Column(
      crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        buildMessageBubble(message, isMe),
      ],
    ),
  );
}

Widget buildMessageBubble(DocumentSnapshot message, bool isMe) {
  String timeText = 'sending..';
  
  // Safely handle timestamp
  final timestamp = message['timestamp'];
  if (timestamp != null) {
    final messageDate = (timestamp as Timestamp).toDate();
    timeText = DateFormat('HH:mm').format(messageDate);
  }
  
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
          message['message'] ?? '',
          style: TextStyle(
            fontSize: 15,
            color: isMe ? Colors.white : Colors.black87,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          timeText,
          style: TextStyle(
            fontSize: 10,
            color: isMe ? Colors.white70 : Colors.grey[600],
          ),
        ),
      ],
    ),
  );
}