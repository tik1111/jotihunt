import 'package:flutter/material.dart';

const textInputLoginDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
     color: Colors.white,
     width: 2
    ),
    borderRadius: BorderRadius.all(Radius.circular(8)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide:  BorderSide(
      color: Colors.white,
      width: 2,
    )
  )
);