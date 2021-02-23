import 'package:flutter/cupertino.dart';

class MyColors {
  appBarColor() => Color.fromRGBO(20, 140, 117, 1);
  
  appBarColorDark() => Color.fromRGBO(19, 138, 115, 1);
  
  buttonColor() => Color.fromRGBO(39, 179, 148, 1);

  List<Color> buttonGradientColor() => [
        MyColors().appBarColorDark(),
        MyColors().buttonColor(),
      ];
}
