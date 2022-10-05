import 'dart:io';

import 'package:chat_app/widgets/avatar_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({
    Key? key,
    required this.submitForm,
    required this.isLoading,
  }) : super(key: key);

  final void Function({
    required String email,
    required String password,
    String? username,
    required bool isLogin,
    File? pickedImage,
    required BuildContext context,
  }) submitForm;

  final bool isLoading;

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLogin = true;
  String username = '';
  String email = '';
  String password = '';

  File? _pickedImage;

  void _onSaveImagePath(XFile? image) {
    if (image != null) {
      _pickedImage = File(image.path);
    }
  }

  void _trySubmit(BuildContext context) {
    final isValid = _formKey.currentState?.validate();
    FocusScope.of(context).unfocus();

    if (_pickedImage == null && !_isLogin) {
      return;
    }
    if (isValid == null || isValid == false) {
      return;
    }
    _formKey.currentState?.save();
    widget.submitForm(
      email: email,
      password: password,
      username: username,
      isLogin: _isLogin,
      pickedImage: _pickedImage,
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  if (!_isLogin) AvatarPicker(onSaveImage: _onSaveImagePath),
                  TextFormField(
                    key: const ValueKey('email'),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value)) {
                        return 'Invalid email!';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration:
                        const InputDecoration(labelText: 'Email address'),
                    onSaved: ((newValue) {
                      email = newValue!.trim();
                    }),
                  ),
                  if (!_isLogin)
                    TextFormField(
                      key: const ValueKey('username'),
                      validator: (value) {
                        if (value == null || value.length < 7) {
                          return 'User name is shorter 7 characters!';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(labelText: 'User name'),
                      onSaved: ((newValue) {
                        username = newValue!.trim();
                      }),
                    ),
                  TextFormField(
                    key: const ValueKey('password'),
                    validator: (value) {
                      if (value == null || value.length < 4) {
                        return 'password name is shorter 4 characters!';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    onChanged: (value) => password = value,
                    onSaved: ((newValue) {
                      password = newValue!.trim();
                    }),
                  ),
                  if (!_isLogin)
                    TextFormField(
                      key: const ValueKey('confirm password'),
                      validator: (value) {
                        if (value != password) {
                          return 'confirm password is not match!';
                        }
                        return null;
                      },
                      decoration:
                          const InputDecoration(labelText: 'Confirm password'),
                      obscureText: true,
                      onSaved: ((newValue) {
                        password = newValue!.trim();
                      }),
                    ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  widget.isLoading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: () {
                            _trySubmit(context);
                          },
                          child: Text(!_isLogin ? 'Sign up' : 'Login')),
                  TextButton(
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                      child: Text(_isLogin
                          ? "Create a new account"
                          : "Have account? Login!"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
