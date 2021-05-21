import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'file:///C:/Users/hp/AndroidStudioProjects/chidididit/lib/common.dart';


ClipPath triangleCLipPath([BuildContext? context]) {
  return ClipPath(
    clipper: TriangleClipper(),
    // A blank screen
    child: Scaffold(
      backgroundColor: Colors.blueGrey[100],
    ),
  );
}


class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return rightHandTriangle(size);
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) => false;

}

Path rightHandTriangle(Size size) {
  // to avoid lengthy declarations
  MultipleSizes s = MultipleSizes(size.width, size.height);
  var path = Path();
  path.moveTo(s.quarterW, s.H);   // move to bottom left
  // first curve
  var endPoint = Offset((s.W - s.quarterW) - 40, (s.halfH + s.eighthH));
  var ctrlPoint = Offset(s.quarterW, s.threeQuartersH + 10);
  path.quadraticBezierTo(
      ctrlPoint.dx, ctrlPoint.dy, endPoint.dx, endPoint.dy
  );
  // second curve
  endPoint = Offset(s.threeQuartersW, s.quarterH);
  ctrlPoint = Offset(s.W, s.halfH);
  path.quadraticBezierTo(
      ctrlPoint.dx, ctrlPoint.dy, endPoint.dx, endPoint.dy
  );
  // third curve
  endPoint = Offset((s.halfW - s.eighthW) - 20, s.eighthH - 10);
  ctrlPoint = Offset(s.threeQuartersW - 50, (s.quarterH - s.eighthH));
  path.quadraticBezierTo(
      ctrlPoint.dx, ctrlPoint.dy, endPoint.dx, endPoint.dy
  );
  // fourth curve
  endPoint = Offset(0, 0);
  ctrlPoint = Offset(20, s.eighthH - 20);
  path.quadraticBezierTo(
      ctrlPoint.dx, ctrlPoint.dy, endPoint.dx, endPoint.dy
  );
  // close shape
  path.lineTo(size.width, 0);
  path.lineTo(size.width, size.height);
  path.close();
  return path;
}
