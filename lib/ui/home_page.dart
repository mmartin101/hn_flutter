import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:hn_flutter/domain/item.dart';
import 'package:hn_flutter/ui/strings.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:url_launcher/url_launcher.dart' as urlLauncher;

class HNHomePage extends StatefulWidget {
  HNHomePage({Key key, this.title, this.firebaseApp}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  final FirebaseApp firebaseApp;

  @override
  _HNHomePageState createState() => new _HNHomePageState();
}

class _HNHomePageState extends State<HNHomePage> {
  List<HNItem> items = new List<HNItem>();
  bool loading = true;
  CircularProgressIndicator progressIndicator = new CircularProgressIndicator();
  Container empty = new Container();
  FirebaseDatabase database;

  @override
  void initState() {
    super.initState();
    database = FirebaseDatabase(app: widget.firebaseApp);
    loadData();
  }

  void refresh() {
    // perform refresh here
    if (loading) return;
    if (items.isNotEmpty) items.clear();
    loadData();
  }

  loadData() async {
    setState(() {
      loading = true;
    });

    if (items.isEmpty) {
      database.reference().child('v0/topstories').limitToFirst(500).once().then(
          (DataSnapshot snapshot) {
        getItems(snapshot.value).then(appendItems);
      }, onError: (error) {
        print(error);
      });
    }
  }

  appendItems(List<HNItem> value) {
    setState(() {
      items.addAll(value);
      print(items.length);
      loading = false;
    });
  }

  Future<List<HNItem>> getItems(List<dynamic> idList) async {
    DatabaseReference ref = database.reference().child("v0/item");
    Completer<List<HNItem>> completer = new Completer<List<HNItem>>();

    Future
        .wait(idList.map((id) => ref
            .child(id.toString())
            .once()
            .then((snapshot) => HNItem.fromJson(snapshot.value))))
        .then((value) => completer.complete(value));

    return completer.future;
  }

  Widget showLoadingIndicator() {
    return loading ? progressIndicator : empty;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Stack(
        children: <Widget>[
          new ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                var item = items[index];
                return new ListTile(
                  title: new Text.rich(newsItemTitle(
                      index + 1, item.title, item.getURLDomain())),
                  subtitle: new Text.rich(newsItemSubTitle(
                      item.score, item.by, item.getTime(), item.descendants)),
                  onTap: () {
                    openUrl(item.getUrl());
                  },
                );
              }),
          new Center(
            child: showLoadingIndicator(),
          )
        ],
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: refresh,
        tooltip: 'Refresh',
        child: new Icon(Icons.refresh),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void openUrl(String url) async {
    if (url != null && url.isNotEmpty && await urlLauncher.canLaunch(url)) {
      await urlLauncher.launch(url);
    }
  }
}
