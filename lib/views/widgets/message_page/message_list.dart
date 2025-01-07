import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:cc_dr_side/views/widgets/message_page/message_tile.dart';

class MessageList extends StatelessWidget {
  final FirebaseAuth auth;
  
  MessageList({required this.auth});

  String _formatMessageTime(DateTime time) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final messageDate = DateTime(time.year, time.month, time.day);

    if (messageDate == today) {
      return DateFormat.jm().format(time);
    } else if (messageDate == today.subtract(const Duration(days: 1))) {
      return 'Yesterday';
    } else if (now.difference(time).inDays < 7) {
      return DateFormat.E().format(time);
    } else {
      return DateFormat.MMMd().format(time);
    }
  }

  Future<List<Map<String, dynamic>>> _loadChatRooms() async {
    final chatRoomQuery = await FirebaseFirestore.instance
        .collection('chatRooms')
        .where('drId', isEqualTo: auth.currentUser!.uid)
        .get();

    final chatRooms = chatRoomQuery.docs;

    final List<Map<String, dynamic>> chatRoomDetails = await Future.wait(chatRooms.map((room) async {
      final userId = room['userId'];
      final userQuery = await FirebaseFirestore.instance
          .collection('users')
          .where('uid', isEqualTo: userId)
          .limit(1)
          .get();

      final userData = userQuery.docs.isNotEmpty ? userQuery.docs.first.data() : null;

      return {
        'chatRoom': room.data(),
        'user': userData,
      };
    }).toList());

    chatRoomDetails.sort((a, b) {
      final aTime = (a['chatRoom']['lastMessageTime'] as Timestamp?)?.toDate() ?? DateTime(0);
      final bTime = (b['chatRoom']['lastMessageTime'] as Timestamp?)?.toDate() ?? DateTime(0);
      return bTime.compareTo(aTime);
    });

    return chatRoomDetails;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _loadChatRooms(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: Color(0xFF4A78FF)),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.error_outline, size: 48, color: Colors.red[300]),
                const SizedBox(height: 16),
                Text(
                  'Something went wrong',
                  style: TextStyle(color: Colors.grey[800]),
                ),
              ],
            ),
          );
        }

        final chatRoomDetails = snapshot.data ?? [];

        if (chatRoomDetails.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.chat_bubble_outline_rounded,
                  size: 64,
                  color: Colors.blue[200],
                ),
                const SizedBox(height: 16),
                const Text(
                  'No messages yet',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          itemCount: chatRoomDetails.length,
          itemBuilder: (context, index) {
            final data = chatRoomDetails[index];
            return MessageTile(
              chatRoom: data['chatRoom'],
              user: data['user'],
              formatTime: _formatMessageTime,
            );
          },
        );
      },
    );
  }
}