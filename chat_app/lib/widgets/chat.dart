import 'package:chat_app/widgets/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MessageList extends StatelessWidget {
  const MessageList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('created_at', descending: true)
          .snapshots(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return const Center(
            child: Text('An error occured'),
          );
        }
        if (!snapshot.hasData) {
          return const Center(
            child: Text('There are no messages here!'),
          );
        }
        QuerySnapshot chatResponse = snapshot.data as QuerySnapshot;
        final documents = chatResponse.docs;
        return ListView.builder(
          reverse: true,
          itemCount: documents.length,
          itemBuilder: ((context, index) {
            String? userId;
            if ((documents[index].data() as Map<String, dynamic>)['user_id'] !=
                null) {
              userId = documents[index]['user_id'];
            }
            return MessageBubble(
              message: documents[index]['text'],
              isMe: userId == FirebaseAuth.instance.currentUser?.uid,
              userId: userId,
              username: documents[index]['username'],
            );
          }),
        );
      }),
    );
  }
}
