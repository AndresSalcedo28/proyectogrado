import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

AwesomeDialog formDialogLayout({
  @required context,
  @required Widget body,
  @required Function btnOkOnPress,
  @required Function  onSuccess,
  @required IconData mainIcon,
  Function onFailure,
  String okBtnTxt = "Crear",
  IconData okBtnIcon,
  VoidCallback btnCancelOnPress
}){
  return AwesomeDialog(
    context: context,
    width: 500,
    headerAnimationLoop: false,
    customHeader: CircleAvatar(
      radius: 50,
      backgroundColor: Colors.green,
      child: CircleAvatar(
        radius: 45,
        backgroundColor: Colors.white,
        child: Icon(Icons.list),
      ),
    ),
    animType: AnimType.BOTTOMSLIDE,
    title: 'Descripción',
    desc: 'Dialog description',
    body: body,
    btnOk: Button(),
    btnCancel: btnCancel,
    btnCancelOnPress: btnCancelOnPress,
  )..show();
}