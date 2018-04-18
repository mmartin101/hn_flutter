import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:hn_flutter/util/date_util.dart';

TextSpan newsItemTitle(int index, String title, String url) {
  return new TextSpan(
      style: new TextStyle(fontSize: 14.0, color: Colors.black),
      text: "$index\. $title",
      children: <TextSpan>[
        new TextSpan(
            style: new TextStyle(fontSize: 12.0, color: Colors.grey), text: " ($url)")
      ]);
}

TextSpan newsItemSubTitle(
    int score, String username, DateTime date, int commentCount) {
  return new TextSpan(
      style: new TextStyle(fontSize: 12.0, color: Colors.grey),
      text: "$score points by $username ${getRelativeTimeSpanString(
          date, DateTime.now().toUtc())} $commentCount comments");
}
