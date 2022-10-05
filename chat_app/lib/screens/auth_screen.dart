import 'dart:io';

import 'package:chat_app/widgets/auth_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLoading = false;
  final _auth = FirebaseAuth.instance;

  Future<void> _submitForm({
    required String email,
    required String password,
    String? username,
    required bool isLogin,
    File? pickedImage,
    required BuildContext context,
  }) async {
    UserCredential firebaseLoginResponse;
    setState(() {
      isLoading = true;
    });
    try {
      if (isLogin) {
        firebaseLoginResponse = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        firebaseLoginResponse = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        final storageRef = FirebaseStorage.instance.ref();
        storageRef.child('user_avatar');

        final avatarRef =
            storageRef.child('${firebaseLoginResponse.user?.uid}.jpg');

        await avatarRef
            .putFile(
                pickedImage!,
                SettableMetadata(
                  contentType: "image/jpg",
                ))
            .whenComplete(() => null);

        final url = await avatarRef.getDownloadURL();

        await FirebaseFirestore.instance
            .collection('users')
            .doc(firebaseLoginResponse.user?.uid)
            .set({
          'username': username,
          'email': email,
          'avatar_url': url,
        });
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('user-not-found'),
        ));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('wrong-password'),
        ));
      }
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.message!),
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Login')),
        body: AuthForm(
          submitForm: _submitForm,
          isLoading: isLoading,
        ));
  }
}
