import 'dart:developer';

import 'package:chat_app/core/services/auth_service.dart';
import 'package:chat_app/core/viewmodels/user_model.dart';
import 'package:chat_app/views/components/buttons.dart';
import 'package:chat_app/views/components/text.dart';
import 'package:chat_app/views/pages/profile_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../core/models/user.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthService _auth = AuthService(FirebaseAuth.instance);
  final UserModelState _model = UserModelState();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    //_auth.getCurrentUser();
    fetchUser();
    // log(_model.currentUser.toString());
  }

  fetchUser() async {
    setState(() {
      isLoading = !isLoading;
    });
    await _model.getCurrentUser();
    setState(() {
      isLoading = !isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(0),
      child: SafeArea(
        child: Scaffold(
          body: isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Messages",
                            style: headerText,
                          ),
                          Container(
                            margin: const EdgeInsets.all(0),
                            decoration: profileButton,
                            child: IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ProfilePage()),
                                );
                              },
                              color: Colors.white,
                              icon: const FaIcon(FontAwesomeIcons.user),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Center(
                          child: Text("Hoşgeldin " + _model.currentUser!.name),
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
