import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  test("Check Datetimes", () {
    DateTime timeNow = DateTime.now();
    print("${TimeOfDay.fromDateTime(timeNow)}");
  });
}
