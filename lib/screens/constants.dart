import 'package:flutter/material.dart';

//Screens:Register, Login

const kTextFieldDecoration=InputDecoration(
  fillColor: Color(0x00ffffff),
  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xffd2dae2),)),
  floatingLabelBehavior: FloatingLabelBehavior.always,
  labelText: "Name",
  labelStyle: TextStyle(
    fontWeight: FontWeight.w700,
    fontFamily: 'Roboto',
    fontSize: 16,
    color: Color(0xff4eb447),
  ),
  hintText: "Full name/Trade name",
  hintStyle: TextStyle(
    fontWeight: FontWeight.w900,
    fontFamily: 'Roboto',
    fontSize: 14,
    color: Color(0xffd2dae2),
  ),
);

