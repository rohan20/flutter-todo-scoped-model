class ToDo {
  int _id;
  final String _title;

  ToDo(this._title) {
    this._id = DateTime.now().millisecondsSinceEpoch;
  }

  int get id => _id;

  String get title => _title;

  @override
  int get hashCode => _id;

  @override
  String toString() => "$title $id";
}
