import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:chidididit/common.dart';
import 'package:chidididit/views/base_page.dart' as basePage;


class HomePage extends StatelessWidget {
  
  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_forward_rounded),
        onPressed: () => Navigator.of(ctx).pushNamed("/second_page")
      ),
      body: Stack(
        children: [
          basePage.triangleCLipPath(),
          Center(child: WelcomeLogo().widget(ctx, showBoundingBox: false)),
          Positioned(
            right: 80,
            top: 200,
            child: ImageClip().widget(ctx, showBoundingBox: false),
          ),
        ],
      )
    );
  }
}


class WelcomeLogo extends CustomWidget {

  @override
  Container widget(BuildContext ctx, {bool? showBoundingBox, Color? bbColor}) {
    var showBox = getShowBox(showBoundingBox, bbColor);
    return Container(
      // margin: EdgeInsets.all(20),
        width: 300,
        height: 200,
        decoration: BoxDecoration(
            color: showBox
        ),
        padding: EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(child: welcomeTo, alignment: Alignment.centerLeft),
            Align(
              child: ChidididitContainer().widget(ctx, showBoundingBox: false, bbColor: Colors.amber),
              alignment: Alignment.center,
            )
          ],
        )
    );
  }
  
}

var welcomeTo = Text(
  "Welcome to...",
  style: TextStyle(
      fontSize: 20, decoration: TextDecoration.none
  ),
);


class ChidididitContainer extends CustomWidget {

  @override
  Container widget(BuildContext ctx, {bool? showBoundingBox, Color? bbColor}) {
    var showBox = getShowBox(showBoundingBox, bbColor);
    return Container(
        margin: EdgeInsets.symmetric(vertical: 3),
        decoration: BoxDecoration(color: showBox),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 3),
              decoration: BoxDecoration(
                  color: Colors.lightBlue, borderRadius: BorderRadius.circular(10)
              ),
              child: Text(
                "Chidi",
                style: TextStyle(
                    fontSize: 33, fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic, color: Colors.white,
                    decoration: TextDecoration.none, letterSpacing: 2.0
                  // fontFamily: "arial",
                ),
              ),
            ),
            Text(
              "didit!",
              style: TextStyle(
                  fontSize: 33, fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic, color: Colors.lightBlue,
                  decoration: TextDecoration.none, letterSpacing: 2.0,
              ),
            ),
          ],
        )
    );
  }
}


class ImageClip extends CustomWidget {

  @override
  Widget widget(BuildContext ctx, {bool? showBoundingBox, Color? bbColor}) {
    var showBox = getShowBox(showBoundingBox, bbColor);
    return Container(
      decoration: BoxDecoration(
        color: showBox,
      ),
      child: ClipOval(
        child: Image.asset(
          "images/chidi_pic.png",
        ),
      )
    );
  }
}


