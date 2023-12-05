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
  String _entSingle(String type) => """${{
        'Dice': 'Die',
        'CharacterClass': 'Class',
        'MoveCategory': 'Category',
        'GearSelection': 'Starting Gear',
        'AbilityScore': 'Ability Score',
        'AlignmentValue': 'Alignment'
      }[type] ?? type}""";
  String _entPlural(String type) => """${{
        'MoveCategory': 'Categories',
        'CharacterClass': 'Classes',
        'GearSelection': 'Starting Gear',
        'AbilityScore': 'Ability Scores',
        'AlignmentValue': 'Alignments'
      }[type] ?? '${type}s'}""";
  String entity(Type ent) => """${_entSingle(ent.toString())}""";
  String entityPlural(Type ent) => """${_entPlural(ent.toString())}""";
  String entityCount(Type ent, int cnt) =>
      """${cnt == 1 ? _entSingle(ent.toString()) : _entPlural(ent.toString())}""";
  AppMessages get app => AppMessages(this);
  GenericMessages get generic => GenericMessages(this);
  ErrorsMessages get errors => ErrorsMessages(this);
  SortMessages get sort => SortMessages(this);
  PlaybookMessages get playbook => PlaybookMessages(this);
  SettingsMessages get settings => SettingsMessages(this);
  UserMessages get user => UserMessages(this);
  AboutMessages get about => AboutMessages(this);
  CharacterMessages get character => CharacterMessages(this);
  DiceMessages get dice => DiceMessages(this);
  DialogsMessages get dialogs => DialogsMessages(this);
  ItemsMessages get items => ItemsMessages(this);
  SearchMessages get search => SearchMessages(this);
}

class AppMessages {
  final Messages _parent;
  const AppMessages(this._parent);
  String get name => """Dungeon Paper""";
}

class GenericMessages {
  final Messages _parent;
  const GenericMessages(this._parent);
  String get save => """Save""";
  String saveEntity(String ent) => """Save $ent""";
  String get cancel => """Cancel""";
  String get close => """Close""";
  String get view => """View""";
  String viewEntity(String ent) => """View $ent""";
  String get all => """All""";
  String allEntities(String ent) => """All $ent""";
  String get create => """Create""";
  String createEntity(String ent) => """Create $ent""";
  String get add => """Add""";
  String addEntity(String ent) => """Add $ent""";
  String get remove => """Remove""";
  String removeEntity(String ent) => """Remove $ent""";
  String get edit => """Edit""";
  String editEntity(String ent) => """Edit $ent""";
}

class ErrorsMessages {
  final Messages _parent;
  const ErrorsMessages(this._parent);
  String get userOperationCanceled => """Operation canceled""";
  String get uploadError =>
      """Error while uploading photo. Try again later, or contact support using the "About" page.""";
}

class SortMessages {
  final Messages _parent;
  const SortMessages(this._parent);
  String get moveUp => """Move up""";
  String get moveDown => """Move down""";
}

class PlaybookMessages {
  final Messages _parent;
  const PlaybookMessages(this._parent);
  String get myLibrary => """My Library""";
  String get myCampaigns => """My Campaigns""";
  DataPlaybookMessages get data => DataPlaybookMessages(this);
}

class DataPlaybookMessages {
  final PlaybookMessages _parent;
  const DataPlaybookMessages(this._parent);
  String get noDescription => """‹No description provided›""";
}

class SettingsMessages {
  final Messages _parent;
  const SettingsMessages(this._parent);
  String get title => """Settings""";
  String get importExport => """Export/Import""";
  String _switchMode(String mode) => """Switch to ${mode} Mode""";
  String get switchToDark => """${_switchMode('Dark')}""";
  String get switchToLight => """${_switchMode('Light')}""";
}

class UserMessages {
  final Messages _parent;
  const UserMessages(this._parent);
  String get logout => """Sign out""";
  String get login => """Sign in""";
  String get notLoggedIn => """Not logged in""";
  String get recentCharacters => """Recent Characters""";
}

class AboutMessages {
  final Messages _parent;
  const AboutMessages(this._parent);
  String get title => """About""";
}

class CharacterMessages {
  final Messages _parent;
  const CharacterMessages(this._parent);
  DataCharacterMessages get data => DataCharacterMessages(this);
}

class DataCharacterMessages {
  final CharacterMessages _parent;
  const DataCharacterMessages(this._parent);
  String get coins => """Coins""";
  LoadDataCharacterMessages get load => LoadDataCharacterMessages(this);
}

class LoadDataCharacterMessages {
  final DataCharacterMessages _parent;
  const LoadDataCharacterMessages(this._parent);
  String get load => """Load""";
  String get maxLoad => """Max Load""";
  String get autoMaxLoad => """Use class base load + STR mod""";
}

class DiceMessages {
  final Messages _parent;
  const DiceMessages(this._parent);
  FormDiceMessages get form => FormDiceMessages(this);
  RollDiceMessages get roll => RollDiceMessages(this);
}

class FormDiceMessages {
  final DiceMessages _parent;
  const FormDiceMessages(this._parent);
  String get amount => """Amount""";
  String get sides => """Sides""";
  String get diceSeparator => """d""";
  ModifierTypeFormDiceMessages get modifierType =>
      ModifierTypeFormDiceMessages(this);
  ValueFormDiceMessages get value => ValueFormDiceMessages(this);
  ModifierFormDiceMessages get modifier => ModifierFormDiceMessages(this);
  String statValue(String name, String key) => """$name ($key)""";
}

class ModifierTypeFormDiceMessages {
  final FormDiceMessages _parent;
  const ModifierTypeFormDiceMessages(this._parent);
  String get fixed => """Fixed Value""";
  String get modifier => """Stat Mod.""";
}

class ValueFormDiceMessages {
  final FormDiceMessages _parent;
  const ValueFormDiceMessages(this._parent);
  String get placeholder => """Number, e.g. 2 or -1""";
  String get label => """Modifier value""";
}

class ModifierFormDiceMessages {
  final FormDiceMessages _parent;
  const ModifierFormDiceMessages(this._parent);
  String get placeholder => """Select stat""";
  String get label => """Stat""";
}

class RollDiceMessages {
  final DiceMessages _parent;
  const RollDiceMessages(this._parent);
  TitleRollDiceMessages get title => TitleRollDiceMessages(this);
  String get action => """Roll""";
  String total(int amt) => """Total $amt""";
  String resultBreakdown(String dice, String mod) =>
      """Dice: $dice | Modifier: $mod""";
}

class TitleRollDiceMessages {
  final RollDiceMessages _parent;
  const TitleRollDiceMessages(this._parent);
  String rolled(int total) => """Rolled $total""";
  String rolling(int amt) =>
      """Rolling $amt ${_plural(amt, one: 'die', many: 'dice')}""";
}

class DialogsMessages {
  final Messages _parent;
  const DialogsMessages(this._parent);
  ConfirmationsDialogsMessages get confirmations =>
      ConfirmationsDialogsMessages(this);
}

class ConfirmationsDialogsMessages {
  final DialogsMessages _parent;
  const ConfirmationsDialogsMessages(this._parent);
  DeleteConfirmationsDialogsMessages get delete =>
      DeleteConfirmationsDialogsMessages(this);
}

class DeleteConfirmationsDialogsMessages {
  final ConfirmationsDialogsMessages _parent;
  const DeleteConfirmationsDialogsMessages(this._parent);
  String title(String ent) => """Delete $ent?""";
  String body(String ent, String name) =>
      """Are you sure you want to remove the $ent "$name" from the list?""";
}

class ItemsMessages {
  final Messages _parent;
  const ItemsMessages(this._parent);
  String amount(String amt) => """× $amt""";
  String get amountTooltip => """Amount""";
}

class SearchMessages {
  final Messages _parent;
  const SearchMessages(this._parent);
  String get placeholder => """Type to search""";
}

Map<String, String> get messagesMap => {
      """app.name""": """Dungeon Paper""",
      """generic.save""": """Save""",
      """generic.cancel""": """Cancel""",
      """generic.close""": """Close""",
      """generic.view""": """View""",
      """generic.all""": """All""",
      """generic.create""": """Create""",
      """generic.add""": """Add""",
      """generic.remove""": """Remove""",
      """generic.edit""": """Edit""",
      """errors.userOperationCanceled""": """Operation canceled""",
      """errors.uploadError""":
          """Error while uploading photo. Try again later, or contact support using the "About" page.""",
      """sort.moveUp""": """Move up""",
      """sort.moveDown""": """Move down""",
      """playbook.myLibrary""": """My Library""",
      """playbook.myCampaigns""": """My Campaigns""",
      """playbook.data.noDescription""": """‹No description provided›""",
      """settings.title""": """Settings""",
      """settings.importExport""": """Export/Import""",
      """user.logout""": """Sign out""",
      """user.login""": """Sign in""",
      """user.notLoggedIn""": """Not logged in""",
      """user.recentCharacters""": """Recent Characters""",
      """about.title""": """About""",
      """character.data.coins""": """Coins""",
      """character.data.load.load""": """Load""",
      """character.data.load.maxLoad""": """Max Load""",
      """character.data.load.autoMaxLoad""":
          """Use class base load + STR mod""",
      """dice.form.amount""": """Amount""",
      """dice.form.sides""": """Sides""",
      """dice.form.diceSeparator""": """d""",
      """dice.form.modifierType.fixed""": """Fixed Value""",
      """dice.form.modifierType.modifier""": """Stat Mod.""",
      """dice.form.value.placeholder""": """Number, e.g. 2 or -1""",
      """dice.form.value.label""": """Modifier value""",
      """dice.form.modifier.placeholder""": """Select stat""",
      """dice.form.modifier.label""": """Stat""",
      """dice.roll.action""": """Roll""",
      """items.amountTooltip""": """Amount""",
      """search.placeholder""": """Type to search""",
    };
