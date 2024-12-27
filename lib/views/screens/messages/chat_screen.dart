import 'package:cc_dr_side/controllers/chat_controller.dart';
import 'package:cc_dr_side/model/chat_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({super.key, required this.userId,});
  final String userId;
  

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ChatController chatController = Get.put(ChatController());
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('asdf')
      ),
      body: Column(
        children: [
          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: FirebaseFirestore.instance
                .collection('chatRooms')
                .doc("${widget.userId}_${_auth.currentUser!.uid}")
                .collection('messages')
                .orderBy('timestamp')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (!snapshot.hasData) {
                return Center(child: Text("No messages yet."));
              }
              final listmessages = snapshot.data!.docs;
              if (listmessages.isEmpty) {
                return Expanded(child: Center(child: Text("No messages yet.")));
              }
              return Expanded(
                child: ListView.builder(
                  itemCount: listmessages.length,
                  itemBuilder: (context, index) {
                    final message = listmessages[index];

                    return Align(
                      alignment: message['senderId'] != _auth.currentUser!.uid
                          ? Alignment.centerLeft
                          : Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 10.0),
                          decoration: BoxDecoration(
                            color: message['senderId'] != _auth.currentUser!.uid
                                ? Colors.grey[200]
                                : Colors.blue[100],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            message['message'],
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                   
                    controller: _messageController,
                    decoration: InputDecoration(
                      labelText: "Type Message...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration( 
                      shape: BoxShape.circle,
                      color: Colors.blue[600],
                    ),
                    child: Center(
                      child: IconButton(
                        onPressed: () async {
                          if (_messageController.text.trim().isNotEmpty) {                
                            final String chatRoomId =
                                await chatController.createChat(
                              _auth.currentUser!.uid,
                              widget.userId,
                            );
                            final chatModel = ChatModel(
                                senderId: _auth.currentUser!.uid,
                                resiverId: widget.userId,
                                message: _messageController.text,
                                timestamp: null);
                            chatController.sendMessage(chatModel, chatRoomId);
                            _messageController.clear();
                          }
                        },
                        icon: const Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
