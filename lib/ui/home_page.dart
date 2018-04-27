import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:hn_flutter/domain/item.dart';
import 'package:hn_flutter/ui/strings.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart' as urlLauncher;

class HNHomePage extends StatefulWidget {
  HNHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _HNHomePageState createState() => new _HNHomePageState();
}

class _HNHomePageState extends State<HNHomePage> {
  List<HNItem> items = new List<HNItem>();
  List<dynamic> idList = new List<dynamic>();
  int pageSize = 25;
  int lastIndex = 0;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void refresh() {
    // perform refresh here
    if (loading) return;
    idList.clear();
    if (items.isNotEmpty) items.clear();
    loadData();
  }

  // TODO: is this the best way to load items from the network?
  // should we get the top stories and load the first page (25 items?) then once
  // thats done, load the rest in the background? i feel like this current
  // implemntation could be more efficient... it makes the app seem slow when using it
  loadData() async {
    setState(() {
      loading = true;
    });

    String url = "https://hacker-news.firebaseio.com/v0/";
    if (idList.isEmpty) {
      http.Response response = await http.get(url + "topstories.json");
      idList = json.decode(response.body);
    }

    List<HNItem> newItems = new List<HNItem>();
    for (var i = lastIndex; i < lastIndex + pageSize; ++i) {
      var id = idList[i];
      http.Response itemResponse = await http.get(url + 'item/$id.json');
      newItems.add(HNItem.fromJson(json.decode(itemResponse.body)));
    }
    
    lastIndex += pageSize;
    setState(() {
      items.addAll(newItems);
      loading = false;
    });
  }

  Widget showLoadingIndicator() {
    print("is loading? $loading");
    return loading ? new CircularProgressIndicator() : new Container();
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
                if (!loading && index + 5 > items.length) {
                  loadData();
                }

                var item = items[index];
                return new ListTile(
                  title: new Text.rich(newsItemTitle(
                      index + 1, item.title, item.getURLDomain())),
                  subtitle: new Text.rich(newsItemSubTitle(
                      item.score, item.by, item.getTime(), item.descendants)),
                  onTap: () { openUrl(item.url); },
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
