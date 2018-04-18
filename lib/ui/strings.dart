import 'package:hn_flutter/util/date_util.dart';

String newsItemTitle(int index, String title, String url) {
  Uri foo = Uri.parse(url);
  return "$index\. $title (${foo.host})";
}

String newsItemSubTitle(int score, String username, DateTime date, int commentCount) {
  return "$score points by $username ${getRelativeTimeSpanString(date, DateTime.now().toUtc())} $commentCount comments";
}