import 'dart:developer';

import 'package:chat_app/core/services/auth_service.dart';
import 'package:chat_app/views/components/buttons.dart';
import 'package:chat_app/views/components/inputs.dart';
import 'package:chat_app/views/components/text.dart';
import 'package:chat_app/views/pages/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  String _email = "";
  String _pass = "";

  FocusNode _passFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    AuthService _authService = AuthService(FirebaseAuth.instance);

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
                    "Login",
                    style: loginText,
                  ),
                ),
                TextField(
                  controller: _emailController..text = _email,
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
                  controller: _passController..text = _pass,
                  onChanged: (value) {
                    _pass = value;
                  },
                  focusNode: _passFocus,
                  enabled: true,
                  decoration: passDec,
                  obscureText: true,
                ),
                GestureDetector(
                  onTap: () {
                    log("clicked");
                    context.read<AuthService>().signIn(
                          _email.trim(),
                          _pass.trim(),
                        );

                    // _authService.signIn(_email, _pass).then(
                    //     (value) => Navigator.pushNamed(context, "home-page"));
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    width: double.infinity,
                    height: 50,
                    decoration: loginButton,
                    child: const Center(
                      child: Text(
                        "Login",
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const RegisterPage()),
                            );
                          },
                          child: const Text("Create an account."))
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
