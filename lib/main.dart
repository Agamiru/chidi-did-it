import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chidididit/route_generator.dart';
import 'package:chidididit/themes.dart' as customTheme;   // avoid clashes with flutter themes.dart
// import 'package:http/http.dart' as http;


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Demo",
      theme: customTheme.MainTheme.theme,
      initialRoute: "/",
      onGenerateRoute: RouteGenerator.generateRoute,

    );
  }
}
