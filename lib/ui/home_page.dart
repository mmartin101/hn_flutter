import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:hn_flutter/domain/item.dart';

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
  List<HNItem> items = new List<HNItem>.generate(500, (i) =>
      new HNItem(
          i,
          "foo",
          "internet_dude",
          DateTime.now().millisecondsSinceEpoch,
          "Something on the internet sparks controversy",
          -1,
          -1,
          new List<int>(),
          "https://google.com",
          42,
          "Clickbait title",
          new List<int>(),
          new List<int>()
      )
  );

  void refresh() {
    // perform refresh here
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return new Scaffold(
      appBar: new AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: new Text(widget.title),
      ),
      body: new ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            var item = items[index];
            return new ListTile(
              title: new Text(item.title),
              subtitle: new Text(item.text),
            );
          }
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: refresh,
        tooltip: 'Refresh',
        child: new Icon(Icons.refresh),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
