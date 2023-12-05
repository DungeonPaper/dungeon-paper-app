// GENERATED FILE, do not edit!
// ignore_for_file: annotate_overrides, non_constant_identifier_names, prefer_single_quotes, unused_element, unused_field
import 'package:i18n/i18n.dart' as i18n;

String get _languageCode => 'en';
String _plural(
  int count, {
  String? zero,
  String? one,
  String? two,
  String? few,
  String? many,
  String? other,
}) =>
    i18n.plural(
      count,
      _languageCode,
      zero: zero,
      one: one,
      two: two,
      few: few,
      many: many,
      other: other,
    );
String _ordinal(
  int count, {
  String? zero,
  String? one,
  String? two,
  String? few,
  String? many,
  String? other,
}) =>
    i18n.ordinal(
      count,
      _languageCode,
      zero: zero,
      one: one,
      two: two,
      few: few,
      many: many,
      other: other,
    );
String _cardinal(
  int count, {
  String? zero,
  String? one,
  String? two,
  String? few,
  String? many,
  String? other,
}) =>
    i18n.cardinal(
      count,
      _languageCode,
      zero: zero,
      one: one,
      two: two,
      few: few,
      many: many,
      other: other,
    );

class Messages {
  const Messages();
  String get locale => "en";
  String get languageCode => "en";
  AppMessages get app => AppMessages(this);
  GenericMessages get generic => GenericMessages(this);
  PlaybookMessages get playbook => PlaybookMessages(this);
}

class AppMessages {
  final Messages _parent;
  const AppMessages(this._parent);
  String get name => """Dungeon Paper""";
}

class GenericMessages {
  final Messages _parent;
  const GenericMessages(this._parent);
  String get view => """View""";
  String viewEntity(String ent) => """View $ent""";
  String get all => """All""";
  String allEntities(String ent) => """All $ent""";
  String get create => """Create""";
  String createEntity(String ent) => """Create $ent""";
}

class PlaybookMessages {
  final Messages _parent;
  const PlaybookMessages(this._parent);
  String _p(String single, int cnt) =>
      """${_plural(cnt, one: single, many: '${single}s')}""";
  String Character(int cnt) => """${_p('Character', cnt)}""";
  String Move(int cnt) => """${_p('Move', cnt)}""";
  String Spell(int cnt) => """${_p('Spell', cnt)}""";
  String Item(int cnt) => """${_p('Item', cnt)}""";
}

Map<String, String> get messagesMap => {
      """app.name""": """Dungeon Paper""",
      """generic.view""": """View""",
      """generic.all""": """All""",
      """generic.create""": """Create""",
    };
