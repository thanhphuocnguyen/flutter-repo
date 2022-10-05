import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class FireBaseAuthProvider extends ChangeNotifier {
  String? userId = FirebaseAuth.instance.currentUser?.uid;
  String? get uid {
    if (userId != null) {
      return userId;
    }
    return null;
  }

  Future<String?> getUserNameById(String userId) async {
    final docsResponse =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    final dataMap = docsResponse.data() as Map<String, dynamic>;
    print(dataMap['username']);
    return dataMap['username'];
  }

  Future<String?> getAvatarUrlsById(String userId) async {
    final docsResponse =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    final dataMap = docsResponse.data() as Map<String, dynamic>;
    print(dataMap['avatar_url']);
    return dataMap['avatar_url'];
  }
}
