import 'package:flutter/material.dart';
import 'package:chidididit/views/package_modules.dart' as views;

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (_) => views.homePage);
      case "/second_page":
        return MaterialPageRoute(
          builder: (_) => views.secondPage,
        );
      case "/github_homepage":
        return MaterialPageRoute(builder: (_) => views.githubHomePage);
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute( [Object? wrongArgs]) {
    String msg = "I don't know how we got here";
    if (wrongArgs != null) {
      msg = "Something wrong with this arg: $wrongArgs";
    }
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Error"),
        ),
        body: Center(
            child: Text(msg)
        ),
      );
    });
  }
}

