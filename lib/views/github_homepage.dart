import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:chidididit/views/base_page.dart' as basePage;
import 'package:chidididit/common.dart' as com;
import 'package:chidididit/settings.dart' as settings;
import "package:intl/intl.dart" as intl;


// Keys
final GlobalKey<ScaffoldState> _githubHomepageScaffoldKey = GlobalKey();


class GithubHomePage extends StatelessWidget {

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Github Repositories", style: Theme.of(ctx).textTheme.headline5,
        ),
      ),
      key: _githubHomepageScaffoldKey,
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              padding: EdgeInsets.only(left: 15),
              height: MediaQuery.of(ctx).padding.top * 3,
              margin: EdgeInsets.fromLTRB(
                0, MediaQuery.of(ctx).padding.top, 0, 0
              ),
              color: Colors.blueGrey,
              child: (
                Stack(
                  children: [
                    ClipPath(
                      clipper: basePage.TriangleClipper(),
                      child: Container(
                        color: Colors.black12,
                      ),
                    ),
                    Positioned(
                      top: 10,
                      child: Text(
                        "Filter and Sort",
                        style: Theme.of(ctx).textTheme.headline4,
                      ),
                    )
                  ],
                )
              ),
            ),
            ListTile(
              title: Text("Most Recent"),
              onTap: () {
                Navigator.pop(ctx);
              },
            ),
            ListTile(
              title: Text("Alphabetically"),
              onTap: () {
                Navigator.pop(ctx);
              },
            ),
          ],
        )
      ),
      body: Stack(
      children: [
        basePage.triangleCLipPath(),
        Positioned(
          top: 50.0,
          left: MediaQuery.of(ctx).size.width / 20,
          child: ScrollWindow(),
        ),
        // Center(child: helloFromGithubPage(ctx)),
        ],
      ),
    );
  }
}


class Repo {

  final String name;
  final DateTime updatedAt;
  final String? language;
  late ReadMe readMe;

  Repo({required this.name, required this.updatedAt, this.language});

  factory Repo.json(Map<String, dynamic> repoJson) {
    String repoName = repoJson["name"];
    final DateTime updatedAt = DateTime.parse(repoJson["updated_at"]);
    return Repo(
      name: repoName,
      updatedAt: updatedAt,
      language: repoJson["language"],
    );
  }

  Future<ReadMe> getReadMe(String repoName) async {
    Uri url = Uri.parse("https://api.github.com/repos/${settings.REPO_OWNER}/$repoName/readme");
    final res = await http.get(url);
    if (res.statusCode == 200) {
      final readMeJson = jsonDecode(res.body);
      readMe = ReadMe.json(repoName, readMeJson);
      return readMe;
    } else {
      readMe = ReadMe(repoName: repoName, isNull: true);
      return readMe;
    }
  }

  String readableDateTime(DateTime datetimeObj) {
    return intl.DateFormat.yMMMMEEEEd().format(updatedAt);
  }
}
//
//
class ReadMe {
  final String repoName;
  final String? downloadUrl;
  final int? size;
  final String? content;
  final bool isNull;

  ReadMe({
    required this.repoName, this.downloadUrl, this.size,
    this.content, this.isNull=false
  });

  factory ReadMe.json(String repoName, Map<String, dynamic> readMeJson) {
    return ReadMe(
      repoName: repoName,
      downloadUrl: readMeJson["download_url"],
      size: readMeJson["size"] as int,
      content: readMeJson["content"],
    );
  }
}


class ScrollWindow extends StatefulWidget {
  @override
  ScrollWindowState createState() => ScrollWindowState();
}

class ScrollWindowState extends State<ScrollWindow> {

  late Future<List<Repo>?> repoList;
  List<Repo>? actualValue;
  bool initialized = false;

  @override
  void initState() {
    super.initState();
    setValues();
  }

  Future<void> setValues() async {
    super.initState();
    repoList = fetchRepoList();
    actualValue = await repoList;
    initialized = true;
  }

  Color? getShowBox(bool? showBoundingBox, Color? bbColor) {
    showBoundingBox ??= false;
    bbColor ??= Colors.black38;
    return showBoundingBox? bbColor : null;
  }

  // void orderByMostRecent() {
  //
  //   for (Repo repo in actualValue!) {
  //
  //   }
  // }

  ListView listViewBuilder(BuildContext ctx, repoList) {
    return ListView.builder(
        itemCount: repoList.length,
        itemBuilder: (ctx, int idx) {
          return GitHubCards(repoList[idx]).widget(ctx, showBoundingBox: true);
        });
  }

  Widget customBuild(BuildContext ctx, {bool? showBoundingBox, Color? bbColor}) {
    var showBox = getShowBox(showBoundingBox, bbColor);
    return Container(
        decoration: BoxDecoration(
          color: showBox,
        ),
        // padding: EdgeInsets.symmetric(horizontal: 15.0),
        width: com.equalBothSides(ctx, onBothSides: com.MultipleSizesEnum.twentieth),
        height: 450.0,
        child: FutureBuilder<List<Repo>?>(
          future: repoList,
          builder: (ctx, snapshot) {
            switch (initialized) {
              case true:
                print("Initialized is $initialized");
                // List<Repo> repoList = snapshot.data!;
                return listViewBuilder(ctx, actualValue);
              case false:
                if (snapshot.hasData) {
                  List<Repo> repoList = snapshot.data!;
                  return listViewBuilder(ctx, repoList);
                }
                if (snapshot.hasError) {
                  if (snapshot.error is SocketException) {
                    return Center(child: Text(
                        "Connection Error: No internet connection"));
                  } else {
                    return Center(child: Text("Internal Server Error"),);
                  }
                }
                return Center(
                  child: Container(
                      width: 90.0, height: 90.0,
                      child: CircularProgressIndicator(
                        backgroundColor: Theme.of(ctx).primaryColor,)
                  ),
                );
              default:
                return Center(child: Text("Internal Server Error"),);
            }
          }),


    );
  }

  @override
  Widget build(BuildContext context) {
    return customBuild(context);
  }

}

Future<List<Repo>?> fetchRepoList() async {
  var url = Uri.parse(settings.repos_endpoint);
  final response = await http.get(url);
  if (response.statusCode == 200) {
    var repoList = jsonDecode(response.body);
    List<Repo> repoNameList = [];
    repoList.forEach((dynamic map) => repoNameList.add(Repo.json(map)));
    return repoNameList;
  } else {
    // Render Error page
    return null;
  }
}


class GitHubCards extends com.CustomWidget {
  final Repo repo;

  GitHubCards(this.repo);

  Widget widget(BuildContext ctx, {bool? showBoundingBox, Color? bbColor}) {
    Color? showBox = getShowBox(showBoundingBox, bbColor);
    return Container(
      padding: EdgeInsets.all(13),
      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      decoration: BoxDecoration(
        color: Theme.of(ctx).primaryColor,
        borderRadius: BorderRadius.all(Radius.circular(15)),
        boxShadow: [BoxShadow(color: Colors.black54 ,offset: Offset(1.0, 3.0))]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${repo.name}",
            style: Theme.of(ctx).textTheme.headline4,
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 3, 0, 0),
            child: Text(
              "Last Updated: ${repo.readableDateTime(repo.updatedAt)}",
              style: Theme.of(ctx).textTheme.bodyText2,
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 3, 0, 0),
            child: Text(
              "Language: ${repo.language}",
              style: Theme.of(ctx).textTheme.bodyText2,
            ),
          ),
        ],
      ),
    );
  }
}

class CustomMenuButton extends StatefulWidget {
  @override
  CustomMenuButtonState createState() => CustomMenuButtonState();

}

class CustomMenuButtonState extends State<CustomMenuButton> {

  bool _drawerOpen = false;

  @override
  Widget build(BuildContext ctx) {
    return IconButton(
      iconSize: 35,
      icon: _drawerOpen
          ? Icon(Icons.arrow_back)
          : Icon(Icons.menu),
      onPressed: () {
        if (!_drawerOpen) {
          _githubHomepageScaffoldKey.currentState!.openEndDrawer();
          setState(() {
            _drawerOpen = true;
          });
        } else {
          Navigator.pop(ctx);
          setState(() {
            _drawerOpen = false;
          });
        }

      },
    );
  }

}

IconButton customScaffoldButton() {
  return IconButton(
    iconSize: 35,
    icon: Icon(Icons.menu),
    onPressed: () {
    _githubHomepageScaffoldKey.currentState!.openEndDrawer();
    },
  );
}


Text helloFromGithubPage(BuildContext ctx) {
  return Text(
    "Github Repositories",
    style: Theme.of(ctx).textTheme.bodyText1,
  );
}

// class GithubCardsClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     // TODO: implement getClip
//     throw UnimplementedError();
//   }
//
//   @override
//   bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
//
// }

// Path GithubCardsPath(Container card) {
//   double maxWidth = card.constraints!.maxWidth;
//   double maxHeight = card.constraints!.maxHeight;
//   com.MultipleSizes s = com.MultipleSizes(maxWidth, maxHeight);
//   Path p = Path();
//   p.
//   p.moveTo(s.halfW + s.quarterW, s.H);
//
// }



