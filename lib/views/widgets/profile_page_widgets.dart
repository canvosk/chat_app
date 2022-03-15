import 'dart:developer';

import 'package:chat_app/views/components/inputs.dart';
import 'package:chat_app/views/components/text.dart';
import 'package:flutter/material.dart';

class ShowProfile extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String username;
  const ShowProfile(
      {Key? key,
      required this.imageUrl,
      required this.name,
      required this.username})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Container(
            margin: const EdgeInsets.all(0),
            width: 200,
            height: 200,
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                imageUrl,
              ),
            ),
          ),
        ),
        const SizedBox(height: 25),
        Center(
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
        )
      ],
    );
  }
}

class EditProfile extends StatefulWidget {
  final String name;
  final String username;
  const EditProfile({Key? key, required this.name, required this.username})
      : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController _nameController = TextEditingController();
  late String _name;

  @override
  void initState() {
    super.initState();
    _name = widget.name;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Container(
            margin: const EdgeInsets.all(0),
            width: 200,
            height: 200,
            child: const CircleAvatar(
              backgroundImage: NetworkImage(
                "https://firebasestorage.googleapis.com/v0/b/chat-app-7d6cc.appspot.com/o/nonprofile.png?alt=media&token=c0d3ef51-7921-4379-a56c-64c6a4356f55",
              ),
            ),
          ),
        ),
        const SizedBox(height: 25),
        Center(
          child: Expanded(
            child: TextField(
              textAlign: TextAlign.center,
              controller: _nameController..text = _name,
              onChanged: (value) {
                _name = value;
              },
              decoration: nameTextField,
              style: editNameText,
            ),
          ),
        ),
        Center(
          child: Text(
            "@" + widget.username,
            style: usernameText,
          ),
        )
      ],
    );
  }
}
