/// Hacker News Item Model
///
/// Stories, comments, jobs, Ask HNs and even polls are just items.
///
/// They're identified by their ids, which are unique integers,
/// and live under /v0/item/[id].
class HNItem {
  int id;
  String type;
  String by;
  int time;
  String text;
  int parent;
  int poll;
  List kids;
  String url;
  int score;
  String title;
  List parts;
  int descendants;

  HNItem(
      this.id,
      this.type,
      this.by,
      this.time,
      this.text,
      this.parent,
      this.poll,
      this.kids,
      this.url,
      this.score,
      this.title,
      this.parts,
      this.descendants);

  String getURLDomain() {
    if (url == null || url.startsWith("https://news.ycombinator.com")) {
      return "";
    }

    return Uri.parse(url).host;
  }

  String getUrl() {
    return url == null ? "https://news.ycombinator.com/item?id=$id" : url;
  }

  DateTime getTime() {
    return new DateTime.fromMillisecondsSinceEpoch(time * 1000, isUtc: true);
  }

  HNItem.fromJson(Map<dynamic, dynamic> json)
      : id = json['id'],
        type = json['type'],
        by = json['by'],
        time = json['time'],
        kids = json['kids'],
        url = json['url'],
        score = json['score'],
        title = json['title'],
        descendants = json['descendants'];

  @override
  String toString() {
    return '''{
    id: $id,
    type: $type,
    by: $by,
    time: $time,
    kids: $kids,
    url: $url,
    score: $score,
    title: $title,
    descendants: $descendants
        }''';
  }

  @override
  bool operator ==(dynamic other) {
    if (identical(this, other)) return true;
    if (other is! HNItem) return false;
    return other.id == id;
  }
}
