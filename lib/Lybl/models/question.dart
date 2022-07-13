import 'dart:convert';

class Question {
  int _slot;
  int _page;
  String _type;
  String _multichoice;
  String _html;

  Question(
    this._slot,
    this._page,
    this._type,
    this._multichoice,
    this._html,
  );

  int get slot => this._slot;

  set slot(int value) => this._slot = value;

  get page => this._page;

  set page(value) => this._page = value;

  get type => this._type;

  set type(value) => this._type = value;

  get multichoice => this._multichoice;

  set multichoice(value) => this._multichoice = value;

  get html => this._html;

  set html(value) => this._html = value;

  Map<String, dynamic> toMap() {
    return {
      '_slot': _slot,
      '_page': _page,
      '_type': _type,
      '_multichoice': _multichoice,
      '_html': _html,
    };
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      map['_slot'],
      map['_page'],
      map['_type'],
      map['_multichoice'],
      map['_html'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Question.fromJson(String source) =>
      Question.fromMap(json.decode(source));
}
