import 'dart:developer';
import 'package:cc_dr_side/model/chat_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class ChatController extends GetxController {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  List<Map<String, dynamic>> chatRooms = [];
  Future<String> createChat(String drId, String userId) async {
    final String chatRoomid = '${userId}_${drId}';
    final DocumentSnapshot getDoc =
        await db.collection('chatRooms').doc(chatRoomid).get();
    if (!getDoc.exists) {
      db.collection('chatRooms').doc(chatRoomid).set({
        'drId': drId,
        'userId': userId,
        'lastMessage': '',
        'lastMessageTime': '',
      });
    }
    return chatRoomid;
  }

  sendMessage(ChatModel chatModel, String chatRoomId) async {
    try {
      await db
          .collection('chatRooms')
          .doc(chatRoomId)
          .collection('messages')
          .add({
        'senderId': chatModel.senderId,
        'resiverId': chatModel.resiverId,
        'message': chatModel.message,
        'timestamp': FieldValue.serverTimestamp(),
      });
      await db.collection('chatRooms').doc(chatRoomId).update({
        'lastMessage': chatModel.message,
        'lastMessageTime': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      log(e.toString());
    }
  }

  pickChatRooms(String userUid) async {
    try {

    } catch (e) {
      log(e.toString());
    }
  }
}
