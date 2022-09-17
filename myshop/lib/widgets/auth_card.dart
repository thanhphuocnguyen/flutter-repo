// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:myshop/models/http_exception.dart';
import 'package:myshop/providers/auth.dart';
import 'package:myshop/screens/product_overview_screen.dart';
import 'package:provider/provider.dart';

enum AuthMode { Login, Signup }

class AuthCard extends StatefulWidget {
  const AuthCard({Key? key}) : super(key: key);

  @override
  State<AuthCard> createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  final Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  var _isLoading = false;
  final _passwordController = TextEditingController();

  void _showErrDialog(BuildContext context, String message) async {
    await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              contentTextStyle: TextStyle(color: Theme.of(context).errorColor),
              title: const Text('An error occurs!'),
              content: Text(message),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Ok'))
              ],
            ));
  }

  void _submit(BuildContext context) async {
    final ctx = context;

    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState?.save();

    setState(() {
      _isLoading = true;
    });

    try {
      if (_authMode == AuthMode.Login) {
        await Provider.of<Auth>(context, listen: false)
            .login(_authData['email']!, _authData['password']!);
      } else {
        await Provider.of<Auth>(context, listen: false)
            .signup(_authData['email']!, _authData['password']!);
      }
    } on CustomException catch (error) {
      var errMsg = '';
      errMsg = error.toString();
      if (errMsg.isEmpty) {
        errMsg = 'Authentication failed, try later';
      }
      _showErrDialog(context, errMsg);
    } catch (error) {
      const message = "Could not authenticate";
      print(error);
      _showErrDialog(context, message);
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _switchAuthMode() {
    setState(() {
      if (_authMode == AuthMode.Login) {
        _authMode = AuthMode.Signup;
      } else {
        _authMode = AuthMode.Login;
      }
      _formKey.currentState?.reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 8.0,
      child: Container(
        height: _authMode == AuthMode.Signup ? 320 : 260,
        constraints:
            BoxConstraints(minHeight: _authMode == AuthMode.Signup ? 320 : 260),
        width: deviceSize.width * 0.75,
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        !value.contains('@')) {
                      return 'Invalid email.';
                    }
                    return null;
                  },
                  onSaved: (newValue) => _authData['email'] = newValue ?? "",
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  controller: _passwordController,
                  validator: (value) =>
                      (value == null || value.isEmpty || value.length < 5)
                          ? 'Password is too weak!'
                          : null,
                  onSaved: ((newValue) =>
                      _authData['password'] = newValue ?? ""),
                ),
                if (_authMode == AuthMode.Signup)
                  TextFormField(
                    enabled: _authMode == AuthMode.Signup,
                    decoration:
                        const InputDecoration(labelText: 'Confirm password'),
                    obscureText: true,
                    validator: _authMode == AuthMode.Signup
                        ? (value) => (value != _passwordController.text
                            ? 'Confirm password is not match'
                            : null)
                        : null,
                  ),
                const SizedBox(
                  height: 20,
                ),
                if (_isLoading)
                  const CircularProgressIndicator()
                else
                  ElevatedButton(
                    onPressed: () => _submit(context),
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30.0,
                          vertical: 8.0,
                        ),
                        primary: Theme.of(context).primaryColor,
                        onPrimary:
                            Theme.of(context).primaryTextTheme.button?.color),
                    child:
                        Text(_authMode == AuthMode.Login ? 'Login' : 'Sign up'),
                  ),
                TextButton(
                  onPressed: _switchAuthMode,
                  style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 4),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      textStyle:
                          TextStyle(color: Theme.of(context).primaryColor)),
                  child: Text(
                      "${_authMode == AuthMode.Login ? 'Sign up' : 'Login'} instead"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
