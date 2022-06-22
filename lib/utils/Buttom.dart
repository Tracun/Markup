import 'package:flutter/material.dart';

class SimpleRoundButton extends StatelessWidget {
  final Color? backgroundColor;
  final String? buttonText;
  final Color? textColor;
  final Color? splashColor;
  final Function()? onPressed;

  SimpleRoundButton(
      {this.backgroundColor,
      this.buttonText,
      this.textColor,
      this.splashColor,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: this.backgroundColor, //Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: this.onPressed,
        child: Text(this.buttonText!,
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: this.textColor, fontWeight: FontWeight.bold)),
      ),
    );
  }
}

class SimpleRoundButtonGrad extends StatelessWidget {
  final List<Color>? colors;
  final String? buttonText;
  final Color? textColor;
  final Color? splashColor;
  final Function()? onPressed;

  SimpleRoundButtonGrad(
      {this.colors,
      this.buttonText,
      this.textColor,
      this.splashColor,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
    return Container(
      height: 50.0,
      child: RaisedButton(
        onPressed: onPressed,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
        padding: EdgeInsets.all(1.0),
        child: Ink(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: colors!,
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(30.0)),
          child: Container(
            constraints: BoxConstraints(maxWidth: 350.0, minHeight: 50.0),
            alignment: Alignment.center,
            child: Text(
              this.buttonText!,
              textAlign: TextAlign.center,
              style: style.copyWith(
                  color: this.textColor, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        splashColor: splashColor,
      ),
    );
  }
}
