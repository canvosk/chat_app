import 'package:chat_app/views/components/buttons.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FloatingButton extends StatelessWidget {
  final Icon icon;
  //final String imagePath;
  final bool addGradient;
  const FloatingButton(
      {Key? key, required this.icon, required this.addGradient})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60.0,
      height: 60.0,
      decoration: BoxDecoration(
        gradient: addGradient ? addButton : null,
        color: addGradient ? null : deleteButton,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: icon,
    );
  }
}
