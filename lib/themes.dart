import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class MainTheme {
  static ThemeData get theme {
    return ThemeData(
      primarySwatch: Colors.lightBlue,
      primaryColorLight: Colors.lightBlueAccent,
      accentColor: Colors.white,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        foregroundColor: Colors.white,
        backgroundColor: Colors.lightBlue,
      ),
      // Text styles
      fontFamily: "Montserrat",
      textTheme: TextTheme(
        headline4: TextStyle(
            fontSize: 30.0, fontFamily: "Hind", fontWeight: FontWeight.bold,
            color: Colors.white, shadows: <Shadow>[Shadow(color: Colors.black12, offset: Offset(2.0, 2.0))]
        ),
        headline6: TextStyle(
          fontSize: 20.0, fontFamily: "Hind", fontWeight: FontWeight.bold,
          color: Colors.white, shadows: <Shadow>[Shadow(color: Colors.black12, offset: Offset(2.0, 2.0))]
        ),
        bodyText1: TextStyle(
            fontSize: 20.0, fontFamily: "arial", fontStyle: FontStyle.italic
        ),
        headline5: TextStyle(
            fontSize: 20.0, fontFamily: "Hind", fontWeight: FontWeight.bold,
            color: Colors.black, shadows: <Shadow>[
              Shadow(color: Colors.lightBlueAccent, offset: Offset(2.0, 2.0), blurRadius: 1.8),
            ]
        ),
      ),
    );
  }
}
