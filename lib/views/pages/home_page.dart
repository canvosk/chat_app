import 'dart:developer';

import 'package:chat_app/core/services/auth_service.dart';
import 'package:chat_app/core/viewmodels/user_model.dart';
import 'package:chat_app/views/components/text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
                          IconButton(
                            onPressed: () {
                              context.read<AuthService>().signOut();
                            },
                            icon: const Icon(Icons.exit_to_app_rounded),
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


// currentUser.first.name

// ElevatedButton(
//                 onPressed: () {
//                   context.read<AuthService>().signOut();
//                 },
//                 child: const Text("SIGN OUT"),
//               ),
