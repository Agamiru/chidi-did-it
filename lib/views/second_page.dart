import 'file:///C:/Users/hp/AndroidStudioProjects/chidididit/lib/common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:chidididit/views/base_page.dart' as basePage;
import 'package:chidididit/common.dart' as com;

class SecondPage extends StatelessWidget {

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            "This app was built with...",
            style: Theme.of(ctx).textTheme.headline5,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: githubPage(ctx),
        icon: Icon(Icons.arrow_forward_rounded),
        onPressed: () => Navigator.of(ctx).pushNamed("/github_homepage"),
      ),
      body: Stack(
        children: [
          basePage.triangleCLipPath(),
          Positioned(
            width: com.equalBothSides(ctx, onBothSides: com.MultipleSizesEnum.eighth),
            left: MediaQuery.of(ctx).size.width / 8,
            top: 130,
            child: PageBody().widget(ctx, showBoundingBox: false),
          ),
        ],
      ),
    );
  }
}


class PageBody extends com.CustomWidget {

  @override
  Widget widget(BuildContext ctx, {bool? showBoundingBox, Color? bbColor}) {
    Color? showBox = getShowBox(showBoundingBox, bbColor);
    return Container(
      color: showBox,
      child: Column(
        children: [
          // Center(child: appWasBuiltWith(ctx)),
          BuiltWithList().widget(ctx, showBoundingBox: false),
        ],
      ),
    );
  }
}

final List<String> appMadeWith = <String>[
  "Flutter", "Flask (Python)", "Github API", "Heroku",
  // "Baz", "Shell", "Camp", "Owerri", "Foo", "Bar"
];

class BuiltWithList extends com.CustomWidget {

  @override
  Container widget(BuildContext ctx, {bool? showBoundingBox, Color? bbColor}) {
    Color? showBox = getShowBox(showBoundingBox, bbColor);
    return Container(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
      width: 300,
      height: 360,
      decoration: BoxDecoration(
        color: showBox
      ),
      child: ListView.builder(
        itemCount: appMadeWith.length,
        itemBuilder: (BuildContext ctx, int index) {
          return Center(
            child: Container(
              padding: EdgeInsets.all(13),
              margin: EdgeInsets.symmetric(vertical: 3),
              decoration: BoxDecoration(
                color: Theme.of(ctx).primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                "${appMadeWith[index]}",
                style: Theme.of(ctx).textTheme.headline6,
              ),
            ),
          );
        },
      ),
    );
  }
}

// Text
Text githubPage(BuildContext ctx) => Text(
  "Github Projects",
  style: Theme.of(ctx).textTheme.headline5,
);

Text appWasBuiltWith(BuildContext ctx) => Text(
  "This app was built with:",
  style: Theme.of(ctx).textTheme.bodyText1,
);