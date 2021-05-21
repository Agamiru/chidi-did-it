import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


/// Basically implements a show bounding box feature for layout analysis
class CustomWidget{

  Color? getShowBox(bool? showBoundingBox, Color? bbColor) {
    showBoundingBox ??= false;
    bbColor ??= Colors.black38;
    return showBoundingBox? bbColor : null;
  }

  Widget widget(BuildContext ctx, {bool? showBoundingBox, Color? bbColor}) {
    Color? showBox = getShowBox(showBoundingBox, bbColor);
    // TODO: implement widget
    throw UnimplementedError();
  }

}

class StatelessCustomWidget extends StatelessWidget{

  Color? getShowBox(bool? showBoundingBox, Color? bbColor) {
    showBoundingBox ??= false;
    bbColor ??= Colors.black38;
    return showBoundingBox? bbColor : null;
  }

  Widget widget(BuildContext ctx, {bool? showBoundingBox, Color? bbColor}) {
    Color? showBox = getShowBox(showBoundingBox, bbColor);
    // TODO: implement widget
    throw UnimplementedError();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

}

class CustomStatefulWidget extends StatefulWidget{

  Color? getShowBox(bool? showBoundingBox, Color? bbColor) {
    showBoundingBox ??= false;
    bbColor ??= Colors.black38;
    return showBoundingBox? bbColor : null;
  }

  Widget widget(BuildContext ctx, {bool? showBoundingBox, Color? bbColor}) {
    Color? showBox = getShowBox(showBoundingBox, bbColor);
    // TODO: implement widget
    throw UnimplementedError();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }

}


/// Helps manipulation of sizes in simple english
class MultipleSizes {
  double width;
  double height;

  MultipleSizes(this.width, this.height);

  // Original values
  get W => width;

  get H => height;

  // Half
  get halfW => width / 2;

  get halfH => height / 2;

  // Quarter
  get quarterW => width / 4;

  get quarterH => height / 4;

  // Three Quarters
  get threeQuartersW => (width * 3) / 4;

  get threeQuartersH => (height * 3) / 4;

  // Eighths
  get eighthW => width / 8;

  get eighthH => height / 8;

  // fifths
  get fifthW => width / 5;
  get fifthH => height / 5;

}

/// Returns a width/height double that widgets can use to manually pad
/// on both sides.
double equalBothSides(
    BuildContext ctx,
    {MultipleSizesEnum? onBothSides, double? sizeInPixels, bool isWidth = true}) {
  assert(
  onBothSides != MultipleSizesEnum.full &&
      onBothSides != MultipleSizesEnum.half,
  "Please let your size start from quarter"
  );
  var s = MultipleSizes(
      MediaQuery.of(ctx).size.width, MediaQuery.of(ctx).size.height
  );

  switch (onBothSides) {
    case MultipleSizesEnum.quarter:
      return isWidth? s.width - s.halfW : s.height - s.halfH;
    case MultipleSizesEnum.eighth:
      return isWidth? s.width - s.quarterW : s.height - s.quarterH;
    case MultipleSizesEnum.tenth:
      return isWidth? s.width - s.fifthW : s.height - s.fifthH;
    case MultipleSizesEnum.twentieth:
      return isWidth? s.width - s.width / 10 : s.height - s.height / 10;
    default:
      return sizeInPixels! * 2;
  }

}

enum MultipleSizesEnum {
  full, half, quarter, eighth, tenth, twentieth
}


Offset getCenterOffset(BuildContext ctx, {double? fromTop, double? fromBottom}) {
  // Todo: Find out why assertions aren't working.
  double width = MediaQuery.of(ctx).size.width / 2;
  double height = fromTop != null ?
    fromTop : MediaQuery.of(ctx).size.height - fromBottom!;

  return Offset(width, height);
}