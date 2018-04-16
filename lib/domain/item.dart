/// Hacker News Item Model
///
/// Stories, comments, jobs, Ask HNs and even polls are just items.
///
/// They're identified by their ids, which are unique integers,
/// and live under /v0/item/[id].
class HNItem {
  int id;
  final String type;
  final String by;
  int time;
  final String text;
  int parent;
  int poll;
  List<int> kids;
  final String url;
  int score;
  final String title;
  List<int> parts;
  List<int> descendants;

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
}
