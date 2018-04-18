String getRelativeTimeSpanString(DateTime from, DateTime then) {
  Duration duration = then.difference(from);
  String result;
  if (duration.inMinutes < 60) {
    result = "${duration.inMinutes} minutes ago";
  } else if (duration.inHours < 24) {
    result = "${duration.inHours} hours ago";
  } else {
    result = "${duration.inDays} days ago";
  }

  return result;
}