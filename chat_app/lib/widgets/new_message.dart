import 'package:chat_app/providers/firebase_auth_providers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({Key? key}) : super(key: key);

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  User? currentUser;

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        currentUser = user;
      }
    });
  }

  String _enteredMessage = '';

  final _messageInputController = TextEditingController();
  Future<void> _sendMessage() async {
    FocusScope.of(context).unfocus();
    try {
      final username =
          await Provider.of<FireBaseAuthProvider>(context, listen: false)
              .getUserNameById(currentUser!.uid);
      await FirebaseFirestore.instance.collection('chat').add(
        {
          'text': _enteredMessage,
          'created_at': Timestamp.now(),
          'user_id': currentUser?.uid,
          'username': username,
        },
      );
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message!)),
      );
    }
    _messageInputController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      padding: const EdgeInsets.all(8),
      child: Row(children: [
        Expanded(
          child: TextField(
            controller: _messageInputController,
            decoration: const InputDecoration(
              labelText: 'Send messages...',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.all(10),
            ),
            onChanged: ((value) => setState(() {
                  _enteredMessage = value;
                })),
          ),
        ),
        IconButton(
          onPressed:
              _enteredMessage.trim().isEmpty ? null : () => _sendMessage(),
          icon: Icon(
            Icons.send,
            color: _enteredMessage.trim().isEmpty ? Colors.grey : Colors.teal,
          ),
        )
      ]),
    );
  }
}
