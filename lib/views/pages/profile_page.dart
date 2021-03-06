import 'dart:developer';
import 'dart:io';

import 'package:chat_app/core/services/auth_service.dart';
import 'package:chat_app/core/viewmodels/user_model.dart';
import 'package:chat_app/views/components/buttons.dart';
import 'package:chat_app/views/components/inputs.dart';
import 'package:chat_app/views/components/text.dart';
import 'package:chat_app/views/widgets/profile_page_widgets.dart';
import 'package:chat_app/views/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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

  late String uid;
  late String name;
  late String username;
  late String email;
  late String password;
  late String profileUrl;
  final TextEditingController _nameController = TextEditingController();

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
      uid = _model.currentUser!.userId;
      name = _model.currentUser!.name;
      username = _model.currentUser!.username;
      email = _model.currentUser!.email;
      password = _model.currentUser!.password;
      profileUrl = _model.currentUser!.profileUrl;
    });
  }

  var _image;

  void getImage(ImageSource source) async {
    XFile? image = await ImagePicker().pickImage(source: source);
    setState(() {
      _image = File(image!.path);
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
                                        if (isEditing == true) {
                                          if (_image != null) {
                                            _model.uploadImage(uid, _image);
                                          }
                                          setState(() {
                                            fetchUser();
                                            profileUrl =
                                                _model.currentUser!.profileUrl;
                                          });
                                        }

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
                                  ? Center(
                                      child: Stack(
                                        children: [
                                          _image == null
                                              ? Container(
                                                  margin:
                                                      const EdgeInsets.all(0),
                                                  width: 200,
                                                  height: 200,
                                                  child: CircleAvatar(
                                                    backgroundImage:
                                                        NetworkImage(
                                                      profileUrl,
                                                    ),
                                                  ),
                                                )
                                              : Container(
                                                  margin:
                                                      const EdgeInsets.all(0),
                                                  width: 200,
                                                  height: 200,
                                                  child: CircleAvatar(
                                                    backgroundImage:
                                                        FileImage(_image),
                                                  ),
                                                ),
                                          Positioned(
                                            bottom: 0,
                                            right: 15,
                                            child: GestureDetector(
                                              onTap: (() {
                                                _selectImage(context);
                                              }),
                                              child: Container(
                                                width: 50,
                                                height: 50,
                                                decoration: pickImageButton,
                                                child: const Image(
                                                    image: AssetImage(
                                                        "assets/images/add_icon.png")),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Center(
                                      child: Container(
                                        margin: const EdgeInsets.all(0),
                                        width: 200,
                                        height: 200,
                                        child: CircleAvatar(
                                          backgroundImage: NetworkImage(
                                            profileUrl,
                                          ),
                                        ),
                                      ),
                                    ),
                              const SizedBox(height: 25),
                              isEditing
                                  ? Center(
                                      child: Expanded(
                                        child: TextField(
                                          textAlign: TextAlign.center,
                                          controller: _nameController
                                            ..text = name,
                                          onChanged: (value) {
                                            name = value;
                                          },
                                          onSubmitted: (value) async {
                                            await _model.updateUser(
                                              uid: uid,
                                              name: value,
                                              username: username,
                                              email: email,
                                              password: password,
                                            );
                                          },
                                          decoration: nameTextField,
                                          style: editNameText,
                                        ),
                                      ),
                                    )
                                  : Center(
                                      child: Text(
                                        name,
                                        style: nameText,
                                      ),
                                    ),
                              Center(
                                child: Text(
                                  "@" + username,
                                  style: usernameText,
                                ),
                              ),
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

  Future<dynamic> _selectImage(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Container(
          margin: const EdgeInsets.all(0),
          child: AlertDialog(
            title: const Text(
              "Choose Option",
              style: chooseImageText,
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  InkWell(
                    onTap: () {
                      getImage(ImageSource.camera);
                      Navigator.pop(context);
                    },
                    splashColor: Colors.purpleAccent,
                    child: Expanded(
                      child: Row(
                        children: const [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.camera,
                              color: Colors.purpleAccent,
                            ),
                          ),
                          Text(
                            "Take a picture",
                            style: listText,
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      getImage(ImageSource.gallery);
                      Navigator.pop(context);
                    },
                    splashColor: Colors.purpleAccent,
                    child: Expanded(
                      child: Row(
                        children: const [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.image,
                              color: Colors.purpleAccent,
                            ),
                          ),
                          Text(
                            "Choose on gallery",
                            style: listText,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
