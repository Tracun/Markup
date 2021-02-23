import 'package:flutter/material.dart';

class Messages {
  showAlertDialog(BuildContext context, String title, String msg, {String buttonText = "OK"}) {
    // configura o button
    Widget okButton = FlatButton(
      child: Text(buttonText),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // configura o  AlertDialog
    AlertDialog alerta = AlertDialog(
      title: Text(title),
      content: Text(msg),
      actions: [
        okButton,
      ],
    );

    // exibe o dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(child: alerta);
      },
    );
  }

  showOkDialog(BuildContext context, String title, String msg, Function onPressed) {
    // configura o button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: onPressed,
    );

    // configura o  AlertDialog
    AlertDialog alerta = AlertDialog(
      title: Text(title),
      content: Text(msg),
      actions: [
        okButton,
      ],
    );

    // exibe o dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alerta;
      },
    );
  }

  void showYesNoDialog(BuildContext context, String title, String message,
      dynamic object, Function onPressedSim, Function onPressedNao, {String yesButtonText = "Sim", String noButtonText = "Não"}) {
    // configura o button
    Widget noButton = FlatButton(
      child: Text(yesButtonText),
      onPressed: onPressedSim,
    );

    Widget yesButton = FlatButton(
      child: Text(noButtonText),
      onPressed: onPressedNao,
    );

    // configura o  AlertDialog
    AlertDialog alerta = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        noButton,
        yesButton,
      ],
    );

    // exibe o dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alerta;
      },
    );
  }
}
