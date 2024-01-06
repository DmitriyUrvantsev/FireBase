import 'package:flutter/material.dart';

//---------------------------------------------------
const textInputDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  contentPadding: EdgeInsets.all(12.0),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 2.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.pink, width: 2.0),
  ),
);
//---------------------------------------------------

ButtonStyle buttonStyle = ButtonStyle(
    backgroundColor: MaterialStatePropertyAll(Colors.pink[400]),
    overlayColor: const MaterialStatePropertyAll(Colors.green),
    padding: const MaterialStatePropertyAll(
        EdgeInsets.symmetric(horizontal: 25, vertical: 8)));
