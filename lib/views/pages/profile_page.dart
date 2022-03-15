import 'dart:developer';

import 'package:chat_app/core/services/auth_service.dart';
import 'package:chat_app/core/viewmodels/user_model.dart';
import 'package:chat_app/views/components/text.dart';
import 'package:chat_app/views/widgets/profile_page_widgets.dart';
import 'package:chat_app/views/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final AuthService _auth = AuthService(FirebaseAuth.instance);
  final UserModelState _model = UserModelState();
  bool isLoading = false;
  bool isEditing = false;

  late String name;
  late String username;

  @override
  void initState() {
    super.initState();
    fetchUser();
  }

  fetchUser() async {
    setState(() {
      isLoading = !isLoading;
    });
    await _model.getCurrentUser();
    setState(() {
      isLoading = !isLoading;
      name = _model.currentUser!.name;
      username = _model.currentUser!.username;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_model.currentUser == null) {
      return Container(
        margin: const EdgeInsets.all(0),
        child: SafeArea(
          child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(24.0),
                      child: Image(
                        image: AssetImage('assets/images/back_arrow_icon.png'),
                      ),
                    ),
                  ),
                  const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      return Container(
        margin: const EdgeInsets.all(0),
        child: SafeArea(
          child: Scaffold(
            body: Stack(
              children: [
                Container(
                  margin: const EdgeInsets.all(0),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: isLoading
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(24.0),
                                  child: Image(
                                    image: AssetImage(
                                        'assets/images/back_arrow_icon.png'),
                                  ),
                                ),
                              ),
                              const Expanded(
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.all(24.0),
                                      child: Image(
                                        image: AssetImage(
                                            'assets/images/back_arrow_icon.png'),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(right: 24),
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isEditing = !isEditing;
                                        });
                                      },
                                      child: isEditing
                                          ? const Icon(
                                              Icons.check_rounded,
                                              size: 24,
                                            )
                                          : const Icon(
                                              Icons.edit,
                                              size: 24,
                                            ),
                                    ),
                                  ),
                                ],
                              ),
                              isEditing
                                  ? EditProfile(name: name, username: username)
                                  : ShowProfile(
                                      imageUrl:
                                          "https://firebasestorage.googleapis.com/v0/b/chat-app-7d6cc.appspot.com/o/nonprofile.png?alt=media&token=c0d3ef51-7921-4379-a56c-64c6a4356f55",
                                      name: name,
                                      username: username),
                            ],
                          ),
                  ),
                ),
                Positioned(
                  bottom: 24.0,
                  right: 24.0,
                  child: GestureDetector(
                    onTap: () {
                      context.read<AuthService>().signOut();
                      Navigator.pop(context);
                    },
                    child: const FloatingButton(
                        icon: Icon(
                          Icons.exit_to_app_rounded,
                          size: 30,
                          color: Colors.white,
                        ),
                        addGradient: false),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
