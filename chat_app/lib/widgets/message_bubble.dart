import 'package:chat_app/providers/firebase_auth_providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    Key? key,
    required this.message,
    required this.isMe,
    required this.userId,
    required this.username,
  }) : super(key: key);
  final String message;
  final bool isMe;
  final String? userId;
  final String? username;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: <Widget>[
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              constraints: const BoxConstraints(
                maxWidth: 200,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                color: isMe ? Colors.purple.shade500 : Colors.indigo,
                borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(12),
                    topRight: const Radius.circular(12),
                    bottomLeft: isMe
                        ? const Radius.circular(12)
                        : const Radius.circular(5),
                    bottomRight: isMe
                        ? const Radius.circular(12)
                        : const Radius.circular(5)),
              ),
              child: Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  // FutureBuilder(
                  //     future: FirebaseFirestore.instance
                  //         .collection('users')
                  //         .doc(userId)
                  //         .get(),
                  //     builder: (context, snapshot) {
                  //       if (snapshot.connectionState == ConnectionState.waiting) {
                  //         return const CircularProgressIndicator();
                  //       }
                  //       if (!snapshot.hasData) {
                  //         return const SizedBox();
                  //       }
                  //       return
                  Text(
                    username ?? "",
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  // }),
                  const SizedBox(
                    height: 7.0,
                  ),
                  Text(
                    message,
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            FutureBuilder(
                future:
                    Provider.of<FireBaseAuthProvider>(context, listen: false)
                        .getAvatarUrlsById(userId!),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    if (isMe) {
                      return const Positioned(
                        top: -5,
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return const Positioned(
                        top: -5,
                        right: 0,
                        child: CircularProgressIndicator(),
                      );
                    }
                  }
                  if (snapshot.data != null) {
                    if (isMe) {
                      return Positioned(
                        top: -5,
                        child: CircleAvatar(
                          radius: 15,
                          backgroundImage:
                              NetworkImage(snapshot.data as String),
                        ),
                      );
                    }
                    return Positioned(
                      top: -5,
                      right: 0,
                      child: CircleAvatar(
                        radius: 15,
                        backgroundImage: NetworkImage(snapshot.data as String),
                      ),
                    );
                  }
                  return const CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.black,
                  );
                })
          ],
        ),
      ],
    );
  }
}
