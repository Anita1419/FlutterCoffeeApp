import 'package:flutter/material.dart';

InputDecoration customdecoration = InputDecoration(
  hintStyle: TextStyle(fontSize: 17),
  suffixIcon: Icon(
    Icons.person,
    color: Colors.brown[900],
  ),
  border: InputBorder.none,
  contentPadding: EdgeInsets.all(10),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.brown.shade700, width: 2.0),
  ),
);

BoxDecoration boxfielddecoration = BoxDecoration(
  color: Colors.brown[50],
  borderRadius: BorderRadius.circular(2),
);
TextStyle errorstyle = TextStyle(
    color: Colors.red, fontSize: 17.0, decoration: TextDecoration.underline);
