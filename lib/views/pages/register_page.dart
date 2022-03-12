import 'dart:developer';

import 'package:chat_app/core/services/auth_service.dart';
import 'package:chat_app/views/components/buttons.dart';
import 'package:chat_app/views/components/inputs.dart';
import 'package:chat_app/views/components/text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();

  String _email = "";
  String _pass = "";
  String _name = "";
  String _username = "";

  final FocusNode _usernameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passFocus = FocusNode();

  final AuthService _auth = AuthService(FirebaseAuth.instance);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          body: Container(
            margin: const EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 25),
                  child: const Text(
                    "Register",
                    style: loginText,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: nameController..text = _name,
                          onChanged: (value) {
                            _name = value;
                          },
                          onSubmitted: (value) {
                            _usernameFocus.requestFocus();
                          },
                          enabled: true,
                          decoration: nameDec,
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          focusNode: _usernameFocus,
                          controller: usernameController..text = _username,
                          onChanged: (value) {
                            _username = value;
                          },
                          onSubmitted: (value) {
                            _emailFocus.requestFocus();
                          },
                          enabled: true,
                          decoration: usernameDec,
                        ),
                      ),
                    ],
                  ),
                ),
                TextField(
                  focusNode: _emailFocus,
                  controller: emailController..text = _email,
                  onChanged: (value) {
                    _email = value;
                  },
                  onSubmitted: (value) {
                    _passFocus.requestFocus();
                  },
                  enabled: true,
                  decoration: emailDec,
                ),
                TextField(
                  focusNode: _passFocus,
                  enabled: true,
                  onChanged: (value) {
                    _pass = value;
                  },
                  onSubmitted: (value) {
                    _auth.createUser(
                        name: _name,
                        username: _username,
                        email: _email,
                        password: _pass);
                  },
                  decoration: passDec,
                  obscureText: true,
                ),
                GestureDetector(
                  onTap: () {
                    context.read<AuthService>().createUser(
                          name: _name,
                          username: _username,
                          email: _email,
                          password: _pass,
                        );
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    width: double.infinity,
                    height: 50,
                    decoration: loginButton,
                    child: const Center(
                      child: Text(
                        "Register",
                        style: loginButtonText,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(0),
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Or,",
                        style: TextStyle(
                          color: Color(0xFFAFA5AD),
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Log In."))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
