import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const InputDecoration emailDec = InputDecoration(
  prefixIconConstraints: BoxConstraints(minWidth: 0, maxHeight: 30),
  prefixIcon: Padding(
    padding: EdgeInsets.only(right: 10),
    child: Icon(
      Icons.alternate_email,
      color: Color(0xFFA56684),
    ),
  ),
  hintText: "Email Address",
  hintStyle: TextStyle(
    color: Color(0xFFAFA5AD),
    fontSize: 16,
  ),
  border: InputBorder.none,
  // border: UnderlineInputBorder(
  //   borderSide: BorderSide(
  //     color: Color(0xFFA56684),
  //   ),
  // ),
);

const InputDecoration passDec = InputDecoration(
  prefixIconConstraints: BoxConstraints(minWidth: 0, maxHeight: 30),
  prefixIcon: Padding(
    padding: EdgeInsets.only(right: 10),
    child: Icon(
      Icons.lock_rounded,
      color: Color(0xFFA56684),
    ),
  ),
  hintText: "Password",
  hintStyle: TextStyle(
    color: Color(0xFFAFA5AD),
    fontSize: 16,
  ),
  border: InputBorder.none,
);

const InputDecoration nameDec = InputDecoration(
  prefixIconConstraints: BoxConstraints(minWidth: 0, maxHeight: 30),
  prefixIcon: Padding(
    padding: EdgeInsets.only(right: 10),
    child: FaIcon(
      FontAwesomeIcons.user,
      color: Color(0xFFA56684),
    ),
  ),
  hintText: "Name",
  hintStyle: TextStyle(
    color: Color(0xFFAFA5AD),
    fontSize: 16,
  ),
  border: InputBorder.none,
);

const InputDecoration usernameDec = InputDecoration(
  prefixIconConstraints: BoxConstraints(minWidth: 0, maxHeight: 30),
  prefixIcon: Padding(
    padding: EdgeInsets.only(right: 10),
    child: FaIcon(
      FontAwesomeIcons.userSecret,
      color: Color(0xFFA56684),
    ),
  ),
  hintText: "Username",
  hintStyle: TextStyle(
    color: Color(0xFFAFA5AD),
    fontSize: 16,
  ),
  border: InputBorder.none,
);

const InputDecoration nameTextField = InputDecoration(
    hintText: "Enter Name",
    border: InputBorder.none,
    contentPadding: EdgeInsets.only(left: 2, top: 0, bottom: 0));
