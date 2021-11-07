import 'dart:async';

import 'package:flutter/material.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';

class CustomProgressButton extends StatefulWidget{
  CustomProgressButton({
    required Key key,
    required this.title,
    required this.text,
    required this.color,
    required this.onPressed,
    required this.onSuccess,
    required this.onFailure,
    required this.icon,
    this.delayAfterSuccess = 1500,
    this.delayAfterFailure = 1500
  }) : super(key: key);

  final String title;
  final Color color;
  final String text;
  final IconData icon;
  final Function onPressed;
  final Function onSuccess;
  final Function onFailure;
  final int delayAfterSuccess;
  final int delayAfterFailure;


  @override
  _ProgressButtonState createState() => _ProgressButtonState();
}

class _ProgressButtonState extends State<CustomProgressButton>(){
  
}
