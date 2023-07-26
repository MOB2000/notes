class Note {
  int? _id;
  String _title;
  String? _description;
  String date;
  int _priority, _color;

  Note(
    this._title,
    this.date,
    this._priority,
    this._color, [
    this._description,
  ]);

  Note.withId(
    this._id,
    this._title,
    this.date,
    this._priority,
    this._color, [
    this._description,
  ]);

  int? get id => _id;

  String get title => _title;

  String? get description => _description;

  int get priority => _priority;
  int get color => _color;

  set title(String newTitle) {
    if (newTitle.length <= 255) {
      _title = newTitle;
    }
  }

  set description(String? newDescription) {
    if (newDescription == null) {
      return;
    }
    if (newDescription.length <= 255) {
      _description = newDescription;
    }
  }

  set priority(int newPriority) {
    if (newPriority >= 1 && newPriority <= 3) {
      _priority = newPriority;
    }
  }

  set color(int newColor) {
    if (newColor >= 0 && newColor <= 9) {
      _color = newColor;
    }
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    if (id != null) {
      map['id'] = _id;
    }
    map['title'] = _title;
    map['description'] = _description;
    map['priority'] = _priority;
    map['color'] = _color;
    map['date'] = date;

    return map;
  }

  Note.fromMapObject(Map<String, dynamic> map)
      : _id = map['id'],
        _title = map['title'],
        _description = map['description'],
        _priority = map['priority'],
        _color = map['color'],
        date = map['date'];
}
