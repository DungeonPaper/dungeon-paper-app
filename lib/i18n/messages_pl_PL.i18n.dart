// GENERATED FILE, do not edit!
// ignore_for_file: annotate_overrides, non_constant_identifier_names, prefer_single_quotes, unused_element, unused_field, unnecessary_string_interpolations
import 'package:i18n/i18n.dart' as i18n;
import 'messages.i18n.dart';

String get _languageCode => 'pl';
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

class MessagesPlPL extends Messages {
  const MessagesPlPL();
  String get locale => "pl_PL";
  String get languageCode => "pl";

  /// ```dart
  /// """
  /// ${switch (type) {
  ///   'AbilityScore' => 'Ability Score',
  ///   'AlignmentValue' => 'Alignment',
  ///   'CharacterClass' => 'Class',
  ///   'Dice' => 'Die',
  ///   'GearSelection' => 'Gear Set',
  ///   'GearChoice' => 'Gear Choice',
  ///   'GearOption' => 'Gear Set Item',
  ///   'MoveCategory' => 'Category',
  ///   _ => type,
  /// }}
  /// """
  /// ```
  String _entSingle(String type) => """${switch (type) {
        'AbilityScore' => 'Ability Score',
        'AlignmentValue' => 'Alignment',
        'CharacterClass' => 'Class',
        'Dice' => 'Die',
        'GearSelection' => 'Gear Set',
        'GearChoice' => 'Gear Choice',
        'GearOption' => 'Gear Set Item',
        'MoveCategory' => 'Category',
        _ => type,
      }}""";

  /// ```dart
  /// """
  /// ${switch (type) {
  ///   'CharacterClass' => 'Classes',
  ///   'Dice' => 'Dice',
  ///   'MoveCategory' => 'Categories',
  ///   _ => '${_entSingle(type)}s',
  /// }}
  /// """
  /// ```
  String _entPlural(String type) => """${switch (type) {
        'CharacterClass' => 'Classes',
        'Dice' => 'Dice',
        'MoveCategory' => 'Categories',
        _ => '${_entSingle(type)}s',
      }}""";

  /// ```dart
  /// "${_entSingle(ent.toString())}"
  /// ```
  String entity(String ent) => """${_entSingle(ent.toString())}""";

  /// ```dart
  /// "${_entPlural(ent.toString())}"
  /// ```
  String entityPlural(String ent) => """${_entPlural(ent.toString())}""";

  /// ```dart
  /// "${cnt == 1 ? _entSingle(ent.toString()) : _entPlural(ent.toString())}"
  /// ```
  String entityCount(String ent, int cnt) =>
      """${cnt == 1 ? _entSingle(ent.toString()) : _entPlural(ent.toString())}""";

  /// ```dart
  /// "$cnt ${entityCount(ent, cnt)}"
  /// ```
  String entityCountNum(String ent, int cnt) =>
      """$cnt ${entityCount(ent, cnt)}""";
  AppMessagesPlPL get app => AppMessagesPlPL(this);
  PlatformInteractionsMessagesPlPL get platformInteractions =>
      PlatformInteractionsMessagesPlPL(this);
  GenericMessagesPlPL get generic => GenericMessagesPlPL(this);
  LoadingMessagesPlPL get loading => LoadingMessagesPlPL(this);
  ErrorsMessagesPlPL get errors => ErrorsMessagesPlPL(this);
  NumberFieldsMessagesPlPL get numberFields => NumberFieldsMessagesPlPL(this);
  SortMessagesPlPL get sort => SortMessagesPlPL(this);
  PlaybookMessagesPlPL get playbook => PlaybookMessagesPlPL(this);
  MyLibraryMessagesPlPL get myLibrary => MyLibraryMessagesPlPL(this);
  NavMessagesPlPL get nav => NavMessagesPlPL(this);
  SyncMessagesPlPL get sync => SyncMessagesPlPL(this);
  SettingsMessagesPlPL get settings => SettingsMessagesPlPL(this);
  UserMessagesPlPL get user => UserMessagesPlPL(this);
  AuthMessagesPlPL get auth => AuthMessagesPlPL(this);
  HomeMessagesPlPL get home => HomeMessagesPlPL(this);
  AboutMessagesPlPL get about => AboutMessagesPlPL(this);
  CharacterMessagesPlPL get character => CharacterMessagesPlPL(this);
  CharacterClassMessagesPlPL get characterClass =>
      CharacterClassMessagesPlPL(this);
  StartingGearMessagesPlPL get startingGear => StartingGearMessagesPlPL(this);
  DiceMessagesPlPL get dice => DiceMessagesPlPL(this);
  BasicInfoMessagesPlPL get basicInfo => BasicInfoMessagesPlPL(this);
  DebilitiesMessagesPlPL get debilities => DebilitiesMessagesPlPL(this);
  TagsMessagesPlPL get tags => TagsMessagesPlPL(this);
  DialogsMessagesPlPL get dialogs => DialogsMessagesPlPL(this);
  MovesMessagesPlPL get moves => MovesMessagesPlPL(this);
  SpellsMessagesPlPL get spells => SpellsMessagesPlPL(this);
  ItemsMessagesPlPL get items => ItemsMessagesPlPL(this);
  NotesMessagesPlPL get notes => NotesMessagesPlPL(this);
  AlignmentMessagesPlPL get alignment => AlignmentMessagesPlPL(this);
  BioMessagesPlPL get bio => BioMessagesPlPL(this);
  SearchMessagesPlPL get search => SearchMessagesPlPL(this);
  HpMessagesPlPL get hp => HpMessagesPlPL(this);
  XpMessagesPlPL get xp => XpMessagesPlPL(this);
  ArmorMessagesPlPL get armor => ArmorMessagesPlPL(this);
  RichTextMessagesPlPL get richText => RichTextMessagesPlPL(this);
  CustomRollsMessagesPlPL get customRolls => CustomRollsMessagesPlPL(this);
  SessionMarksMessagesPlPL get sessionMarks => SessionMarksMessagesPlPL(this);
  CreateCharacterMessagesPlPL get createCharacter =>
      CreateCharacterMessagesPlPL(this);
  AccountMessagesPlPL get account => AccountMessagesPlPL(this);
  ActionsMessagesPlPL get actions => ActionsMessagesPlPL(this);
  AbilityScoresMessagesPlPL get abilityScores =>
      AbilityScoresMessagesPlPL(this);
  FeedbackMessagesPlPL get feedback => FeedbackMessagesPlPL(this);
  MigrationMessagesPlPL get migration => MigrationMessagesPlPL(this);
  BackupMessagesPlPL get backup => BackupMessagesPlPL(this);
  ChangelogMessagesPlPL get changelog => ChangelogMessagesPlPL(this);
}

class AppMessagesPlPL extends AppMessages {
  final MessagesPlPL _parent;
  const AppMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Dungeon Paper"
  /// ```
  String get name => """Dungeon Paper""";
}

class PlatformInteractionsMessagesPlPL extends PlatformInteractionsMessages {
  final MessagesPlPL _parent;
  const PlatformInteractionsMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Tap"
  /// ```
  String get tap => """Tap""";

  /// ```dart
  /// "Drag"
  /// ```
  String get drag => """Drag""";

  /// ```dart
  /// "Pan"
  /// ```
  String get pan => """Pan""";

  /// ```dart
  /// "Click"
  /// ```
  String get click => """Click""";
}

class GenericMessagesPlPL extends GenericMessages {
  final MessagesPlPL _parent;
  const GenericMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Save"
  /// ```
  String get save => """Save""";

  /// ```dart
  /// "Save $ent"
  /// ```
  String saveEntity(String ent) => """Save $ent""";

  /// ```dart
  /// "Cancel"
  /// ```
  String get cancel => """Cancel""";

  /// ```dart
  /// "Close"
  /// ```
  String get close => """Close""";

  /// ```dart
  /// "Done"
  /// ```
  String get done => """Done""";

  /// ```dart
  /// "View"
  /// ```
  String get view => """View""";

  /// ```dart
  /// "Continue"
  /// ```
  String get continue_ => """Continue""";

  /// ```dart
  /// "View $ent"
  /// ```
  String viewEntity(String ent) => """View $ent""";

  /// ```dart
  /// "All"
  /// ```
  String get all => """All""";

  /// ```dart
  /// "All $ent"
  /// ```
  String allEntities(String ent) => """All $ent""";

  /// ```dart
  /// "Create"
  /// ```
  String get create => """Create""";

  /// ```dart
  /// "Create $ent"
  /// ```
  String createEntity(String ent) => """Create $ent""";

  /// ```dart
  /// "Add"
  /// ```
  String get add => """Add""";

  /// ```dart
  /// "Add $ent"
  /// ```
  String addEntity(String ent) => """Add $ent""";

  /// ```dart
  /// "Remove"
  /// ```
  String get remove => """Remove""";

  /// ```dart
  /// "Remove $ent"
  /// ```
  String removeEntity(String ent) => """Remove $ent""";

  /// ```dart
  /// "Unselect"
  /// ```
  String get unselect => """Unselect""";

  /// ```dart
  /// "Unselect $ent"
  /// ```
  String unselectEntity(String ent) => """Unselect $ent""";

  /// ```dart
  /// "Delete"
  /// ```
  String get delete => """Delete""";

  /// ```dart
  /// "Delete $ent"
  /// ```
  String deleteEntity(String ent) => """Delete $ent""";

  /// ```dart
  /// "Edit"
  /// ```
  String get edit => """Edit""";

  /// ```dart
  /// "Edit $ent"
  /// ```
  String editEntity(String ent) => """Edit $ent""";

  /// ```dart
  /// "Yes"
  /// ```
  String get yes => """Yes""";

  /// ```dart
  /// "No"
  /// ```
  String get no => """No""";

  /// ```dart
  /// "No $ent"
  /// ```
  String noEntity(String ent) => """No $ent""";

  /// ```dart
  /// "Select"
  /// ```
  String get select => """Select""";

  /// ```dart
  /// "Select $ent"
  /// ```
  String selectEntity(String ent) => """Select $ent""";

  /// ```dart
  /// "Selected"
  /// ```
  String get selected => """Selected""";

  /// ```dart
  /// "Select All"
  /// ```
  String get selectAll => """Select All""";

  /// ```dart
  /// "Select None"
  /// ```
  String get selectNone => """Select None""";

  /// ```dart
  /// "My"
  /// ```
  String get my => """My""";

  /// ```dart
  /// "My $ent"
  /// ```
  String myEntity(String ent) => """My $ent""";

  /// ```dart
  /// "Change"
  /// ```
  String get change => """Change""";

  /// ```dart
  /// "Change $ent"
  /// ```
  String changeEntity(String ent) => """Change $ent""";

  /// ```dart
  /// "See All"
  /// ```
  String get seeAll => """See All""";

  /// ```dart
  /// "Select $ent to add"
  /// ```
  String selectToAdd(String ent) => """Select $ent to add""";

  /// ```dart
  /// "Name"
  /// ```
  String get name => """Name""";

  /// ```dart
  /// "$ent name"
  /// ```
  String entityName(String ent) => """$ent name""";

  /// ```dart
  /// "Value"
  /// ```
  String get value => """Value""";

  /// ```dart
  /// "$ent value"
  /// ```
  String entityValue(String ent) => """$ent value""";

  /// ```dart
  /// "Description"
  /// ```
  String get description => """Description""";

  /// ```dart
  /// "$ent description"
  /// ```
  String entityDescription(String ent) => """$ent description""";

  /// ```dart
  /// "Explanation"
  /// ```
  String get explanation => """Explanation""";

  /// ```dart
  /// "$ent explanation"
  /// ```
  String entityExplanation(String ent) => """$ent explanation""";

  /// ```dart
  /// "‹No description provided›"
  /// ```
  String get noDescription => """‹No description provided›""";

  /// ```dart
  /// "No $ent selected"
  /// ```
  String noEntitySelected(String ent) => """No $ent selected""";

  /// ```dart
  /// "No $ent selected (required)"
  /// ```
  String noEntitySelectedRequired(String ent) =>
      """No $ent selected (required)""";

  /// ```dart
  /// "Use Default"
  /// ```
  String get useDefault => """Use Default""";
}

class LoadingMessagesPlPL extends LoadingMessages {
  final MessagesPlPL _parent;
  const LoadingMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Signing in..."
  /// ```
  String get user => """Signing in...""";

  /// ```dart
  /// "Getting characters..."
  /// ```
  String get characters => """Getting characters...""";

  /// ```dart
  /// "Loading..."
  /// ```
  String get general => """Loading...""";
}

class ErrorsMessagesPlPL extends ErrorsMessages {
  final MessagesPlPL _parent;
  const ErrorsMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Operation canceled"
  /// ```
  String get userOperationCanceled => """Operation canceled""";

  /// ```dart
  /// "Error while uploading photo. Try again later, or contact support using the "About" page."
  /// ```
  String get uploadError =>
      """Error while uploading photo. Try again later, or contact support using the "About" page.""";

  /// ```dart
  /// "Invalid email address"
  /// ```
  String get invalidEmail => """Invalid email address""";
  InvalidPasswordErrorsMessagesPlPL get invalidPassword =>
      InvalidPasswordErrorsMessagesPlPL(this);

  /// ```dart
  /// "Must be at least $cnt ${_plural(cnt, one: 'character', many: 'characters')}"
  /// ```
  String minLength(int cnt) =>
      """Must be at least $cnt ${_plural(cnt, one: 'character', many: 'characters')}""";

  /// ```dart
  /// "Must be no more than $cnt ${_plural(cnt, one: 'character', many: 'characters')}"
  /// ```
  String maxLength(int cnt) =>
      """Must be no more than $cnt ${_plural(cnt, one: 'character', many: 'characters')}""";

  /// ```dart
  /// "Must be exactly $cnt ${_plural(cnt, one: 'character', many: 'characters')}"
  /// ```
  String exactLength(int cnt) =>
      """Must be exactly $cnt ${_plural(cnt, one: 'character', many: 'characters')}""";

  /// ```dart
  /// "Must contain $pattern"
  /// ```
  String mustContain(String pattern) => """Must contain $pattern""";

  /// ```dart
  /// "Must not contain $pattern"
  /// ```
  String mustNotContain(String pattern) => """Must not contain $pattern""";

  /// ```dart
  /// "Must contain letters only"
  /// ```
  String get onlyLetters => """Must contain letters only""";
}

class InvalidPasswordErrorsMessagesPlPL extends InvalidPasswordErrorsMessages {
  final ErrorsMessagesPlPL _parent;
  const InvalidPasswordErrorsMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Password must contain at least one capital letter"
  /// ```
  String get letter => """Password must contain at least one capital letter""";

  /// ```dart
  /// "Password must contain at least one number"
  /// ```
  String get number => """Password must contain at least one number""";
}

class NumberFieldsMessagesPlPL extends NumberFieldsMessages {
  final MessagesPlPL _parent;
  const NumberFieldsMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "+1"
  /// ```
  String get increase => """+1""";

  /// ```dart
  /// "-1"
  /// ```
  String get decrease => """-1""";
}

class SortMessagesPlPL extends SortMessages {
  final MessagesPlPL _parent;
  const SortMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Move up"
  /// ```
  String get moveUp => """Move up""";

  /// ```dart
  /// "Move down"
  /// ```
  String get moveDown => """Move down""";

  /// ```dart
  /// "Move $ent to top"
  /// ```
  String moveEntityToTop(String ent) => """Move $ent to top""";

  /// ```dart
  /// "Move $ent to bottom"
  /// ```
  String moveEntityToBottom(String ent) => """Move $ent to bottom""";
}

class PlaybookMessagesPlPL extends PlaybookMessages {
  final MessagesPlPL _parent;
  const PlaybookMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Playbook"
  /// ```
  String get title => """Playbook""";

  /// ```dart
  /// "My Library"
  /// ```
  String get myLibrary => """My Library""";

  /// ```dart
  /// "My Campaigns"
  /// ```
  String get myCampaigns => """My Campaigns""";
}

class MyLibraryMessagesPlPL extends MyLibraryMessages {
  final MessagesPlPL _parent;
  const MyLibraryMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "My Library"
  /// ```
  String get title => """My Library""";

  /// ```dart
  /// "Reload Library"
  /// ```
  String get reload => """Reload Library""";

  /// ```dart
  /// "You can remove this $ent by finding it in the "Use" tab,\nand clicking "Remove" on its context menu."
  /// ```
  String selectDisabled(String ent) =>
      """You can remove this $ent by finding it in the "Use" tab,\nand clicking "Remove" on its context menu.""";

  /// ```dart
  /// "$cnt in $type"
  /// ```
  String itemCount(String cnt, String type) => """$cnt in $type""";

  /// ```dart
  /// """
  /// ${switch (type) {
  ///   'builtIn' => 'Playbook',
  ///   'my' => 'My Library',
  ///   _ => type,
  /// }}
  /// """
  /// ```
  String libraryType(String type) => """${switch (type) {
        'builtIn' => 'Playbook',
        'my' => 'My Library',
        _ => type,
      }}""";

  /// ```dart
  /// "Already added"
  /// ```
  String get alreadyAdded => """Already added""";
  ItemTabMyLibraryMessagesPlPL get itemTab =>
      ItemTabMyLibraryMessagesPlPL(this);
  EmptyStateMyLibraryMessagesPlPL get emptyState =>
      EmptyStateMyLibraryMessagesPlPL(this);
  FiltersMyLibraryMessagesPlPL get filters =>
      FiltersMyLibraryMessagesPlPL(this);
}

class ItemTabMyLibraryMessagesPlPL extends ItemTabMyLibraryMessages {
  final MyLibraryMessagesPlPL _parent;
  const ItemTabMyLibraryMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Playbook"
  /// ```
  String get playbook => """Playbook""";

  /// ```dart
  /// "Online"
  /// ```
  String get online => """Online""";
}

class EmptyStateMyLibraryMessagesPlPL extends EmptyStateMyLibraryMessages {
  final MyLibraryMessagesPlPL _parent;
  const EmptyStateMyLibraryMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "No $ent found"
  /// ```
  String title(String ent) => """No $ent found""";
  SubtitleEmptyStateMyLibraryMessagesPlPL get subtitle =>
      SubtitleEmptyStateMyLibraryMessagesPlPL(this);
}

class SubtitleEmptyStateMyLibraryMessagesPlPL
    extends SubtitleEmptyStateMyLibraryMessages {
  final EmptyStateMyLibraryMessagesPlPL _parent;
  const SubtitleEmptyStateMyLibraryMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "No $ent found in this list."
  /// ```
  String filters(String ent) => """No $ent found in this list.""";

  /// ```dart
  /// "Try changing the search or filters to find more $ent."
  /// ```
  String noFilters(String ent) =>
      """Try changing the search or filters to find more $ent.""";
}

class FiltersMyLibraryMessagesPlPL extends FiltersMyLibraryMessages {
  final MyLibraryMessagesPlPL _parent;
  const FiltersMyLibraryMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Clear Filters"
  /// ```
  String get clear => """Clear Filters""";
}

class NavMessagesPlPL extends NavMessages {
  final MessagesPlPL _parent;
  const NavMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Use"
  /// ```
  String get actions => """Use""";

  /// ```dart
  /// "Character"
  /// ```
  String get character => """Character""";

  /// ```dart
  /// "Journal"
  /// ```
  String get journal => """Journal""";
}

class SyncMessagesPlPL extends SyncMessages {
  final MessagesPlPL _parent;
  const SyncMessagesPlPL(this._parent) : super(_parent);
  EntitySyncMessagesPlPL get entity => EntitySyncMessagesPlPL(this);
}

class EntitySyncMessagesPlPL extends EntitySyncMessages {
  final SyncMessagesPlPL _parent;
  const EntitySyncMessagesPlPL(this._parent) : super(_parent);
  StatusEntitySyncMessagesPlPL get status => StatusEntitySyncMessagesPlPL(this);
}

class StatusEntitySyncMessagesPlPL extends StatusEntitySyncMessages {
  final EntitySyncMessagesPlPL _parent;
  const StatusEntitySyncMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "This $ent is In Sync with its linked library item"
  /// ```
  String inSync(String ent) =>
      """This $ent is In Sync with its linked library item""";

  /// ```dart
  /// "This $ent is Out of Sync with its linked library item"
  /// ```
  String outOfSync(String ent) =>
      """This $ent is Out of Sync with its linked library item""";

  /// ```dart
  /// "This $ent is not linked to any library item"
  /// ```
  String detached(String ent) =>
      """This $ent is not linked to any library item""";
}

class SettingsMessagesPlPL extends SettingsMessages {
  final MessagesPlPL _parent;
  const SettingsMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Settings"
  /// ```
  String get title => """Settings""";

  /// ```dart
  /// "Export/Import"
  /// ```
  String get importExport => """Export/Import""";

  /// ```dart
  /// "Switch to ${mode} Mode"
  /// ```
  String _switchMode(String mode) => """Switch to ${mode} Mode""";

  /// ```dart
  /// "${_switchMode('Dark')}"
  /// ```
  String get switchToDark => """${_switchMode('Dark')}""";

  /// ```dart
  /// "${_switchMode('Light')}"
  /// ```
  String get switchToLight => """${_switchMode('Light')}""";
  CategoriesSettingsMessagesPlPL get categories =>
      CategoriesSettingsMessagesPlPL(this);

  /// ```dart
  /// "Keep screen awake while using the app"
  /// ```
  String get keepAwake => """Keep screen awake while using the app""";
  LocaleSettingsMessagesPlPL get locale => LocaleSettingsMessagesPlPL(this);
  LocalesSettingsMessagesPlPL get locales => LocalesSettingsMessagesPlPL(this);
  DefaultThemeSettingsMessagesPlPL get defaultTheme =>
      DefaultThemeSettingsMessagesPlPL(this);
}

class CategoriesSettingsMessagesPlPL extends CategoriesSettingsMessages {
  final SettingsMessagesPlPL _parent;
  const CategoriesSettingsMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "General"
  /// ```
  String get general => """General""";
}

class LocaleSettingsMessagesPlPL extends LocaleSettingsMessages {
  final SettingsMessagesPlPL _parent;
  const LocaleSettingsMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Language"
  /// ```
  String get title => """Language""";

  /// ```dart
  /// "Switching the language will reload the app"
  /// ```
  String get subtitle => """Switching the language will reload the app""";
}

class LocalesSettingsMessagesPlPL extends LocalesSettingsMessages {
  final SettingsMessagesPlPL _parent;
  const LocalesSettingsMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "English (United States)"
  /// ```
  String get en_US => """English (United States)""";

  /// ```dart
  /// "Português (Brasil)"
  /// ```
  String get pt_BR => """Português (Brasil)""";

  /// ```dart
  /// "Polski"
  /// ```
  String get pl_PL => """Polski""";
}

class DefaultThemeSettingsMessagesPlPL extends DefaultThemeSettingsMessages {
  final SettingsMessagesPlPL _parent;
  const DefaultThemeSettingsMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Default $type theme"
  /// ```
  String _p(String type) => """Default $type theme""";

  /// ```dart
  /// "${_p('light')}"
  /// ```
  String get light => """${_p('light')}""";

  /// ```dart
  /// "${_p('dark')}"
  /// ```
  String get dark => """${_p('dark')}""";
}

class UserMessagesPlPL extends UserMessages {
  final MessagesPlPL _parent;
  const UserMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Recent Characters"
  /// ```
  String get recentCharacters => """Recent Characters""";
}

class AuthMessagesPlPL extends AuthMessages {
  final MessagesPlPL _parent;
  const AuthMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "OR"
  /// ```
  String get orSeparator => """OR""";

  /// ```dart
  /// "Privacy Policy"
  /// ```
  String get privacyPolicy => """Privacy Policy""";

  /// ```dart
  /// "What's new?"
  /// ```
  String get changelog => """What's new?""";

  /// ```dart
  /// "Not logged in"
  /// ```
  String get notLoggedIn => """Not logged in""";

  /// ```dart
  /// "$displayName (@$username)"
  /// ```
  String menuTitle(String displayName, String username) =>
      """$displayName (@$username)""";

  /// ```dart
  /// "Account details"
  /// ```
  String menuSubtitle(String interact) => """Account details""";
  ProvidersAuthMessagesPlPL get providers => ProvidersAuthMessagesPlPL(this);
  ConfirmUnlinkAuthMessagesPlPL get confirmUnlink =>
      ConfirmUnlinkAuthMessagesPlPL(this);
  LoginAuthMessagesPlPL get login => LoginAuthMessagesPlPL(this);
  LogoutAuthMessagesPlPL get logout => LogoutAuthMessagesPlPL(this);
  SignupAuthMessagesPlPL get signup => SignupAuthMessagesPlPL(this);
}

class ProvidersAuthMessagesPlPL extends ProvidersAuthMessages {
  final AuthMessagesPlPL _parent;
  const ProvidersAuthMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Sign in with $provider"
  /// ```
  String loginWith(String provider) => """Sign in with $provider""";

  /// ```dart
  /// "Sign up with $provider"
  /// ```
  String signupWith(String provider) => """Sign up with $provider""";

  /// ```dart
  /// "This device only supports unlinking $provider accounts."
  /// ```
  String unusable(String provider) =>
      """This device only supports unlinking $provider accounts.""";

  /// ```dart
  /// """
  /// ${switch (provider) {
  ///   'facebook' => 'Facebook',
  ///   'google' => 'Google',
  ///   'apple' => 'Apple',
  ///   'password' => 'Dungeon Paper',
  ///   _ => 'Other',
  /// }}
  /// """
  /// ```
  String name(String provider) => """${switch (provider) {
        'facebook' => 'Facebook',
        'google' => 'Google',
        'apple' => 'Apple',
        'password' => 'Dungeon Paper',
        _ => 'Other',
      }}""";

  /// ```dart
  /// "Unlink"
  /// ```
  String get unlink => """Unlink""";

  /// ```dart
  /// "Link"
  /// ```
  String get link => """Link""";
}

class ConfirmUnlinkAuthMessagesPlPL extends ConfirmUnlinkAuthMessages {
  final AuthMessagesPlPL _parent;
  const ConfirmUnlinkAuthMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Unlink from $ent"
  /// ```
  String title(String ent) => """Unlink from $ent""";

  /// ```dart
  /// "Are you sure you want to unlink your account from $ent?\nBy clicking "Unlink", you will no longer be able to sign in with $ent.\n\nYou will be able to re-link your account at any time by going to your account settings."
  /// ```
  String body(String ent) =>
      """Are you sure you want to unlink your account from $ent?\nBy clicking "Unlink", you will no longer be able to sign in with $ent.\n\nYou will be able to re-link your account at any time by going to your account settings.""";
}

class LoginAuthMessagesPlPL extends LoginAuthMessages {
  final AuthMessagesPlPL _parent;
  const LoginAuthMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Sign In"
  /// ```
  String get title => """Sign In""";

  /// ```dart
  /// "Sign in to your account to sync your data online, and get access to many more features."
  /// ```
  String get subtitle =>
      """Sign in to your account to sync your data online, and get access to many more features.""";

  /// ```dart
  /// "Sign in"
  /// ```
  String get button => """Sign in""";
  NoAccountLoginAuthMessagesPlPL get noAccount =>
      NoAccountLoginAuthMessagesPlPL(this);
}

class NoAccountLoginAuthMessagesPlPL extends NoAccountLoginAuthMessages {
  final LoginAuthMessagesPlPL _parent;
  const NoAccountLoginAuthMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Don't have an account?"
  /// ```
  String get label => """Don't have an account?""";

  /// ```dart
  /// "Sign up"
  /// ```
  String get button => """Sign up""";
}

class LogoutAuthMessagesPlPL extends LogoutAuthMessages {
  final AuthMessagesPlPL _parent;
  const LogoutAuthMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Sign out"
  /// ```
  String get button => """Sign out""";
}

class SignupAuthMessagesPlPL extends SignupAuthMessages {
  final AuthMessagesPlPL _parent;
  const SignupAuthMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Sign Up"
  /// ```
  String get title => """Sign Up""";

  /// ```dart
  /// "Enter the required details below to create your Dungeon Paper account."
  /// ```
  String get subtitle =>
      """Enter the required details below to create your Dungeon Paper account.""";

  /// ```dart
  /// "Sign up"
  /// ```
  String get button => """Sign up""";
  EmailSignupAuthMessagesPlPL get email => EmailSignupAuthMessagesPlPL(this);
  PasswordSignupAuthMessagesPlPL get password =>
      PasswordSignupAuthMessagesPlPL(this);
}

class EmailSignupAuthMessagesPlPL extends EmailSignupAuthMessages {
  final SignupAuthMessagesPlPL _parent;
  const EmailSignupAuthMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Email"
  /// ```
  String get label => """Email""";

  /// ```dart
  /// "Enter your email"
  /// ```
  String get placeholder => """Enter your email""";

  /// ```dart
  /// "Please enter a valid email address"
  /// ```
  String get error => """Please enter a valid email address""";
}

class PasswordSignupAuthMessagesPlPL extends PasswordSignupAuthMessages {
  final SignupAuthMessagesPlPL _parent;
  const PasswordSignupAuthMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Password"
  /// ```
  String get label => """Password""";

  /// ```dart
  /// "Enter a password"
  /// ```
  String get placeholder => """Enter a password""";
  ConfirmPasswordSignupAuthMessagesPlPL get confirm =>
      ConfirmPasswordSignupAuthMessagesPlPL(this);
}

class ConfirmPasswordSignupAuthMessagesPlPL
    extends ConfirmPasswordSignupAuthMessages {
  final PasswordSignupAuthMessagesPlPL _parent;
  const ConfirmPasswordSignupAuthMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Confirm Password"
  /// ```
  String get label => """Confirm Password""";

  /// ```dart
  /// "Enter the same password again"
  /// ```
  String get placeholder => """Enter the same password again""";

  /// ```dart
  /// "Passwords do not match"
  /// ```
  String get error => """Passwords do not match""";
}

class HomeMessagesPlPL extends HomeMessages {
  final MessagesPlPL _parent;
  const HomeMessagesPlPL(this._parent) : super(_parent);
  CategoriesHomeMessagesPlPL get categories => CategoriesHomeMessagesPlPL(this);
  SummaryHomeMessagesPlPL get summary => SummaryHomeMessagesPlPL(this);
  MenuHomeMessagesPlPL get menu => MenuHomeMessagesPlPL(this);
  EmptyStateHomeMessagesPlPL get emptyState => EmptyStateHomeMessagesPlPL(this);
}

class CategoriesHomeMessagesPlPL extends CategoriesHomeMessages {
  final HomeMessagesPlPL _parent;
  const CategoriesHomeMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Bookmarked Notes"
  /// ```
  String get notes => """Bookmarked Notes""";

  /// ```dart
  /// "Favorite Moves"
  /// ```
  String get moves => """Favorite Moves""";

  /// ```dart
  /// "Prepared Spells"
  /// ```
  String get spells => """Prepared Spells""";

  /// ```dart
  /// "Equipped Items"
  /// ```
  String get items => """Equipped Items""";

  /// ```dart
  /// "Class Actions"
  /// ```
  String get classActions => """Class Actions""";
}

class SummaryHomeMessagesPlPL extends SummaryHomeMessages {
  final HomeMessagesPlPL _parent;
  const SummaryHomeMessagesPlPL(this._parent) : super(_parent);
  LoadSummaryHomeMessagesPlPL get load => LoadSummaryHomeMessagesPlPL(this);
  CoinsSummaryHomeMessagesPlPL get coins => CoinsSummaryHomeMessagesPlPL(this);
}

class LoadSummaryHomeMessagesPlPL extends LoadSummaryHomeMessages {
  final SummaryHomeMessagesPlPL _parent;
  const LoadSummaryHomeMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Load: $cur/$max"
  /// ```
  String label(String cur, String max) => """Load: $cur/$max""";

  /// ```dart
  /// "Max Load"
  /// ```
  String get tooltip => """Max Load""";
}

class CoinsSummaryHomeMessagesPlPL extends CoinsSummaryHomeMessages {
  final SummaryHomeMessagesPlPL _parent;
  const CoinsSummaryHomeMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "$amt G"
  /// ```
  String label(String amt) => """$amt G""";

  /// ```dart
  /// "Coins"
  /// ```
  String get tooltip => """Coins""";
}

class MenuHomeMessagesPlPL extends MenuHomeMessages {
  final HomeMessagesPlPL _parent;
  const MenuHomeMessagesPlPL(this._parent) : super(_parent);
  CharacterMenuHomeMessagesPlPL get character =>
      CharacterMenuHomeMessagesPlPL(this);

  /// ```dart
  /// "Character Biography"
  /// ```
  String get bio => """Character Biography""";

  /// ```dart
  /// "Debilities"
  /// ```
  String get debilities => """Debilities""";
}

class CharacterMenuHomeMessagesPlPL extends CharacterMenuHomeMessages {
  final MenuHomeMessagesPlPL _parent;
  const CharacterMenuHomeMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Character Menu"
  /// ```
  String get tooltip => """Character Menu""";

  /// ```dart
  /// "Basic Information"
  /// ```
  String get basicInfo => """Basic Information""";

  /// ```dart
  /// "Ability Scores"
  /// ```
  String get abilityScores => """Ability Scores""";

  /// ```dart
  /// "Quick-Roll Buttons"
  /// ```
  String get customRolls => """Quick-Roll Buttons""";

  /// ```dart
  /// "Character Theme"
  /// ```
  String get theme => """Character Theme""";

  /// ```dart
  /// "View Settings"
  /// ```
  String get settings => """View Settings""";

  /// ```dart
  /// "Change Favorites View"
  /// ```
  String get favoritesView => """Change Favorites View""";
}

class EmptyStateHomeMessagesPlPL extends EmptyStateHomeMessages {
  final HomeMessagesPlPL _parent;
  const EmptyStateHomeMessagesPlPL(this._parent) : super(_parent);
  GuestEmptyStateHomeMessagesPlPL get guest =>
      GuestEmptyStateHomeMessagesPlPL(this);

  /// ```dart
  /// "No Characters"
  /// ```
  String get title => """No Characters""";

  /// ```dart
  /// "Create a Character to get started"
  /// ```
  String get subtitle => """Create a Character to get started""";
}

class GuestEmptyStateHomeMessagesPlPL extends GuestEmptyStateHomeMessages {
  final EmptyStateHomeMessagesPlPL _parent;
  const GuestEmptyStateHomeMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Sign in to get more features"
  /// ```
  String get title => """Sign in to get more features""";

  /// ```dart
  /// "Online data sync, library sharing, campaigns and more!"
  /// ```
  String get subtitle =>
      """Online data sync, library sharing, campaigns and more!""";
}

class AboutMessagesPlPL extends AboutMessages {
  final MessagesPlPL _parent;
  const AboutMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "About"
  /// ```
  String get title => """About""";

  /// ```dart
  /// "Version $version"
  /// ```
  String version(String version) => """Version $version""";

  /// ```dart
  /// "Copyright © 2018-$year"
  /// ```
  String copyright(int year) => """Copyright © 2018-$year""";

  /// ```dart
  /// "Chen Asraf"
  /// ```
  String get author => """Chen Asraf""";
  ChangelogAboutMessagesPlPL get changelog => ChangelogAboutMessagesPlPL(this);
  DiscordAboutMessagesPlPL get discord => DiscordAboutMessagesPlPL(this);
  FeedbackAboutMessagesPlPL get feedback => FeedbackAboutMessagesPlPL(this);
  DonateAboutMessagesPlPL get donate => DonateAboutMessagesPlPL(this);
  SocialsAboutMessagesPlPL get socials => SocialsAboutMessagesPlPL(this);

  /// ```dart
  /// "Special Thanks"
  /// ```
  String get specialThanks => """Special Thanks""";

  /// ```dart
  /// "Contributors"
  /// ```
  String get contributors => """Contributors""";

  /// ```dart
  /// "Icon Credits"
  /// ```
  String get icons => """Icon Credits""";
}

class ChangelogAboutMessagesPlPL extends ChangelogAboutMessages {
  final AboutMessagesPlPL _parent;
  const ChangelogAboutMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "What's new?"
  /// ```
  String get title => """What's new?""";

  /// ```dart
  /// "Change log of Dungeon Paper release versions"
  /// ```
  String get subtitle => """Change log of Dungeon Paper release versions""";
}

class DiscordAboutMessagesPlPL extends DiscordAboutMessages {
  final AboutMessagesPlPL _parent;
  const DiscordAboutMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Join Our Discord"
  /// ```
  String get title => """Join Our Discord""";

  /// ```dart
  /// "Join the Discord community to ask questions, get help, send feedback, or just chat with other players."
  /// ```
  String get subtitle =>
      """Join the Discord community to ask questions, get help, send feedback, or just chat with other players.""";
}

class FeedbackAboutMessagesPlPL extends FeedbackAboutMessages {
  final AboutMessagesPlPL _parent;
  const FeedbackAboutMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Send Feedback"
  /// ```
  String get title => """Send Feedback""";

  /// ```dart
  /// "We reply more promptly through Discord, but you can send us feedback, bug reports or suggestions about the app directly here as an alternative."
  /// ```
  String get subtitle =>
      """We reply more promptly through Discord, but you can send us feedback, bug reports or suggestions about the app directly here as an alternative.""";
}

class DonateAboutMessagesPlPL extends DonateAboutMessages {
  final AboutMessagesPlPL _parent;
  const DonateAboutMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Make a Donation"
  /// ```
  String get title => """Make a Donation""";

  /// ```dart
  /// "If you are looking for a way to support the project, you can make a donation on the official Ko-fi page of the developer. Click this to be redirected to the Ko-fi page."
  /// ```
  String get subtitle =>
      """If you are looking for a way to support the project, you can make a donation on the official Ko-fi page of the developer. Click this to be redirected to the Ko-fi page.""";
}

class SocialsAboutMessagesPlPL extends SocialsAboutMessages {
  final AboutMessagesPlPL _parent;
  const SocialsAboutMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Links"
  /// ```
  String get title => """Links""";

  /// ```dart
  /// "Twitter"
  /// ```
  String get twitter => """Twitter""";

  /// ```dart
  /// "Facebook"
  /// ```
  String get facebook => """Facebook""";

  /// ```dart
  /// "Discord"
  /// ```
  String get discord => """Discord""";

  /// ```dart
  /// "GitHub"
  /// ```
  String get github => """GitHub""";

  /// ```dart
  /// "Play Store"
  /// ```
  String get google => """Play Store""";

  /// ```dart
  /// "App Store"
  /// ```
  String get apple => """App Store""";
}

class CharacterMessagesPlPL extends CharacterMessages {
  final MessagesPlPL _parent;
  const CharacterMessagesPlPL(this._parent) : super(_parent);
  DataCharacterMessagesPlPL get data => DataCharacterMessagesPlPL(this);
  HeaderCharacterMessagesPlPL get header => HeaderCharacterMessagesPlPL(this);

  /// ```dart
  /// "No Category"
  /// ```
  String get noCategory => """No Category""";
  ThemeCharacterMessagesPlPL get theme => ThemeCharacterMessagesPlPL(this);
  FavoritesViewCharacterMessagesPlPL get favoritesView =>
      FavoritesViewCharacterMessagesPlPL(this);
}

class DataCharacterMessagesPlPL extends DataCharacterMessages {
  final CharacterMessagesPlPL _parent;
  const DataCharacterMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Coins"
  /// ```
  String get coins => """Coins""";
  LoadDataCharacterMessagesPlPL get load => LoadDataCharacterMessagesPlPL(this);

  /// ```dart
  /// "Level"
  /// ```
  String get level => """Level""";

  /// ```dart
  /// "Damage Dice"
  /// ```
  String get damageDice => """Damage Dice""";

  /// ```dart
  /// "Use damage dice from class & equipped items"
  /// ```
  String get calculateDamage =>
      """Use damage dice from class & equipped items""";
}

class LoadDataCharacterMessagesPlPL extends LoadDataCharacterMessages {
  final DataCharacterMessagesPlPL _parent;
  const LoadDataCharacterMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Load"
  /// ```
  String get load => """Load""";

  /// ```dart
  /// "Max Load"
  /// ```
  String get maxLoad => """Max Load""";

  /// ```dart
  /// "Use class base load + STR mod"
  /// ```
  String get autoMaxLoad => """Use class base load + STR mod""";
}

class HeaderCharacterMessagesPlPL extends HeaderCharacterMessages {
  final CharacterMessagesPlPL _parent;
  const HeaderCharacterMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Level $lv"
  /// ```
  String level(int lv) => """Level $lv""";

  /// ```dart
  /// "$name"
  /// ```
  String characterClass(String name) => """$name""";

  /// ```dart
  /// "$name"
  /// ```
  String race(String name) => """$name""";

  /// ```dart
  /// "$alignment"
  /// ```
  String alignment(String alignment) => """$alignment""";

  /// ```dart
  /// " ∙ "
  /// ```
  String get separator => """ ∙ """;
}

class ThemeCharacterMessagesPlPL extends ThemeCharacterMessages {
  final CharacterMessagesPlPL _parent;
  const ThemeCharacterMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Character Theme"
  /// ```
  String get title => """Character Theme""";

  /// ```dart
  /// "Default $type theme"
  /// ```
  String _defaultTheme(String type) => """Default $type theme""";

  /// ```dart
  /// "${_defaultTheme('light')}"
  /// ```
  String get defaultLight => """${_defaultTheme('light')}""";

  /// ```dart
  /// "${_defaultTheme('dark')}"
  /// ```
  String get defaultDark => """${_defaultTheme('dark')}""";
}

class FavoritesViewCharacterMessagesPlPL
    extends FavoritesViewCharacterMessages {
  final CharacterMessagesPlPL _parent;
  const FavoritesViewCharacterMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Cards View"
  /// ```
  String get cards => """Cards View""";

  /// ```dart
  /// "List View"
  /// ```
  String get list => """List View""";
}

class CharacterClassMessagesPlPL extends CharacterClassMessages {
  final MessagesPlPL _parent;
  const CharacterClassMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Base Load"
  /// ```
  String get baseLoad => """Base Load""";

  /// ```dart
  /// "Base HP"
  /// ```
  String get baseHp => """Base HP""";

  /// ```dart
  /// "Damage Dice"
  /// ```
  String get damageDice => """Damage Dice""";
  IsSpellcasterCharacterClassMessagesPlPL get isSpellcaster =>
      IsSpellcasterCharacterClassMessagesPlPL(this);

  /// ```dart
  /// "Stats"
  /// ```
  String get stats => """Stats""";

  /// ```dart
  /// "Backgrounds"
  /// ```
  String get bio => """Backgrounds""";
  StartingGearCharacterClassMessagesPlPL get startingGear =>
      StartingGearCharacterClassMessagesPlPL(this);
}

class IsSpellcasterCharacterClassMessagesPlPL
    extends IsSpellcasterCharacterClassMessages {
  final CharacterClassMessagesPlPL _parent;
  const IsSpellcasterCharacterClassMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Spellcasting class"
  /// ```
  String get title => """Spellcasting class""";

  /// ```dart
  /// """
  /// Spellcasters are prompted to select spells (as well as moves) during character
  /// creation and leveling up.
  /// """
  /// ```
  String get subtitle =>
      """Spellcasters are prompted to select spells (as well as moves) during character
creation and leveling up.""";
}

class StartingGearCharacterClassMessagesPlPL
    extends StartingGearCharacterClassMessages {
  final CharacterClassMessagesPlPL _parent;
  const StartingGearCharacterClassMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Starting Gear Selections"
  /// ```
  String get label => """Starting Gear Selections""";
}

class StartingGearMessagesPlPL extends StartingGearMessages {
  final MessagesPlPL _parent;
  const StartingGearMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Edit Starting Gear"
  /// ```
  String get titleEdit => """Edit Starting Gear""";

  /// ```dart
  /// "Select Starting Gear"
  /// ```
  String get titleSelect => """Select Starting Gear""";

  /// ```dart
  /// "$amt G"
  /// ```
  String coins(String amt) => """$amt G""";

  /// ```dart
  /// "${amt}× $name"
  /// ```
  String item(String amt, String name) => """${amt}× $name""";
  ChoiceStartingGearMessagesPlPL get choice =>
      ChoiceStartingGearMessagesPlPL(this);
  SelectionStartingGearMessagesPlPL get selection =>
      SelectionStartingGearMessagesPlPL(this);
  OptionStartingGearMessagesPlPL get option =>
      OptionStartingGearMessagesPlPL(this);
}

class ChoiceStartingGearMessagesPlPL extends ChoiceStartingGearMessages {
  final StartingGearMessagesPlPL _parent;
  const ChoiceStartingGearMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Choice $index"
  /// ```
  String title(int index) => """Choice $index""";

  /// ```dart
  /// "A choice is a list of selections the player can make. It provides a possible set of items & coins that the player can select from."
  /// ```
  String get helpText =>
      """A choice is a list of selections the player can make. It provides a possible set of items & coins that the player can select from.""";
  DescriptionChoiceStartingGearMessagesPlPL get description =>
      DescriptionChoiceStartingGearMessagesPlPL(this);
  MaxSelectionsChoiceStartingGearMessagesPlPL get maxSelections =>
      MaxSelectionsChoiceStartingGearMessagesPlPL(this);

  /// ```dart
  /// "Move up"
  /// ```
  String get moveUp => """Move up""";

  /// ```dart
  /// "Move down"
  /// ```
  String get moveDown => """Move down""";
}

class DescriptionChoiceStartingGearMessagesPlPL
    extends DescriptionChoiceStartingGearMessages {
  final ChoiceStartingGearMessagesPlPL _parent;
  const DescriptionChoiceStartingGearMessagesPlPL(this._parent)
      : super(_parent);

  /// ```dart
  /// "Prompt"
  /// ```
  String get label => """Prompt""";

  /// ```dart
  /// "e.g. Choose your weapon"
  /// ```
  String get hintText => """e.g. Choose your weapon""";
}

class MaxSelectionsChoiceStartingGearMessagesPlPL
    extends MaxSelectionsChoiceStartingGearMessages {
  final ChoiceStartingGearMessagesPlPL _parent;
  const MaxSelectionsChoiceStartingGearMessagesPlPL(this._parent)
      : super(_parent);

  /// ```dart
  /// "Suggested max allowance"
  /// ```
  String get label => """Suggested max allowance""";

  /// ```dart
  /// "This will suggest a maximum amount to select, and will display a count, but will not limit the selection. Use 0 or leave blank for no limit."
  /// ```
  String get helpText =>
      """This will suggest a maximum amount to select, and will display a count, but will not limit the selection. Use 0 or leave blank for no limit.""";
}

class SelectionStartingGearMessagesPlPL extends SelectionStartingGearMessages {
  final StartingGearMessagesPlPL _parent;
  const SelectionStartingGearMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Gear Set"
  /// ```
  String get title => """Gear Set""";

  /// ```dart
  /// "Each gear set consists of some amount of coins, and a list of items to be given to the character. Choosing one gear set will give the character all the items and gold in that set."
  /// ```
  String get helpText =>
      """Each gear set consists of some amount of coins, and a list of items to be given to the character. Choosing one gear set will give the character all the items and gold in that set.""";

  /// ```dart
  /// "Add Gear Set"
  /// ```
  String get add => """Add Gear Set""";
  DescriptionSelectionStartingGearMessagesPlPL get description =>
      DescriptionSelectionStartingGearMessagesPlPL(this);
  CoinsSelectionStartingGearMessagesPlPL get coins =>
      CoinsSelectionStartingGearMessagesPlPL(this);
}

class DescriptionSelectionStartingGearMessagesPlPL
    extends DescriptionSelectionStartingGearMessages {
  final SelectionStartingGearMessagesPlPL _parent;
  const DescriptionSelectionStartingGearMessagesPlPL(this._parent)
      : super(_parent);

  /// ```dart
  /// "Selection description"
  /// ```
  String get label => """Selection description""";

  /// ```dart
  /// "e.g. Your father's old sword, and 10 coins"
  /// ```
  String get hintText => """e.g. Your father's old sword, and 10 coins""";
}

class CoinsSelectionStartingGearMessagesPlPL
    extends CoinsSelectionStartingGearMessages {
  final SelectionStartingGearMessagesPlPL _parent;
  const CoinsSelectionStartingGearMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Coins"
  /// ```
  String get label => """Coins""";

  /// ```dart
  /// "0"
  /// ```
  String get hintText => """0""";
}

class OptionStartingGearMessagesPlPL extends OptionStartingGearMessages {
  final StartingGearMessagesPlPL _parent;
  const OptionStartingGearMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Gear Set Items"
  /// ```
  String get title => """Gear Set Items""";

  /// ```dart
  /// "Each gear set item consists of X amount of a specific item."
  /// ```
  String get helpText =>
      """Each gear set item consists of X amount of a specific item.""";

  /// ```dart
  /// "Add Items"
  /// ```
  String get add => """Add Items""";
  AmountOptionStartingGearMessagesPlPL get amount =>
      AmountOptionStartingGearMessagesPlPL(this);
}

class AmountOptionStartingGearMessagesPlPL
    extends AmountOptionStartingGearMessages {
  final OptionStartingGearMessagesPlPL _parent;
  const AmountOptionStartingGearMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Amount"
  /// ```
  String get label => """Amount""";

  /// ```dart
  /// "1"
  /// ```
  String get hintText => """1""";
}

class DiceMessagesPlPL extends DiceMessages {
  final MessagesPlPL _parent;
  const DiceMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Suggested: $dice"
  /// ```
  String suggestion(String dice) => """Suggested: $dice""";
  FormDiceMessagesPlPL get form => FormDiceMessagesPlPL(this);
  RollDiceMessagesPlPL get roll => RollDiceMessagesPlPL(this);
}

class FormDiceMessagesPlPL extends FormDiceMessages {
  final DiceMessagesPlPL _parent;
  const FormDiceMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Amount"
  /// ```
  String get amount => """Amount""";

  /// ```dart
  /// "Sides"
  /// ```
  String get sides => """Sides""";

  /// ```dart
  /// "d"
  /// ```
  String get diceSeparator => """d""";
  ModifierTypeFormDiceMessagesPlPL get modifierType =>
      ModifierTypeFormDiceMessagesPlPL(this);
  ValueFormDiceMessagesPlPL get value => ValueFormDiceMessagesPlPL(this);
  ModifierFormDiceMessagesPlPL get modifier =>
      ModifierFormDiceMessagesPlPL(this);

  /// ```dart
  /// "$name ($key)"
  /// ```
  String statValue(String name, String key) => """$name ($key)""";
}

class ModifierTypeFormDiceMessagesPlPL extends ModifierTypeFormDiceMessages {
  final FormDiceMessagesPlPL _parent;
  const ModifierTypeFormDiceMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Fixed Value"
  /// ```
  String get fixed => """Fixed Value""";

  /// ```dart
  /// "Stat Mod."
  /// ```
  String get modifier => """Stat Mod.""";
}

class ValueFormDiceMessagesPlPL extends ValueFormDiceMessages {
  final FormDiceMessagesPlPL _parent;
  const ValueFormDiceMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Number, e.g. 2 or -1"
  /// ```
  String get placeholder => """Number, e.g. 2 or -1""";

  /// ```dart
  /// "Modifier value"
  /// ```
  String get label => """Modifier value""";
}

class ModifierFormDiceMessagesPlPL extends ModifierFormDiceMessages {
  final FormDiceMessagesPlPL _parent;
  const ModifierFormDiceMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Select stat"
  /// ```
  String get placeholder => """Select stat""";

  /// ```dart
  /// "Stat"
  /// ```
  String get label => """Stat""";
}

class RollDiceMessagesPlPL extends RollDiceMessages {
  final DiceMessagesPlPL _parent;
  const RollDiceMessagesPlPL(this._parent) : super(_parent);
  TitleRollDiceMessagesPlPL get title => TitleRollDiceMessagesPlPL(this);

  /// ```dart
  /// "Roll"
  /// ```
  String get action => """Roll""";

  /// ```dart
  /// "Total $amt"
  /// ```
  String total(int amt) => """Total $amt""";

  /// ```dart
  /// "Dice: $dice | Modifier: $mod"
  /// ```
  String resultBreakdown(String dice, String mod) =>
      """Dice: $dice | Modifier: $mod""";
}

class TitleRollDiceMessagesPlPL extends TitleRollDiceMessages {
  final RollDiceMessagesPlPL _parent;
  const TitleRollDiceMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Rolled $total"
  /// ```
  String rolled(int total) => """Rolled $total""";

  /// ```dart
  /// "Rolling $amt ${_plural(amt, one: 'die', many: 'dice')}"
  /// ```
  String rolling(int amt) =>
      """Rolling $amt ${_plural(amt, one: 'die', many: 'dice')}""";
}

class BasicInfoMessagesPlPL extends BasicInfoMessages {
  final MessagesPlPL _parent;
  const BasicInfoMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Basic Information"
  /// ```
  String get title => """Basic Information""";
  FormBasicInfoMessagesPlPL get form => FormBasicInfoMessagesPlPL(this);
}

class FormBasicInfoMessagesPlPL extends FormBasicInfoMessages {
  final BasicInfoMessagesPlPL _parent;
  const FormBasicInfoMessagesPlPL(this._parent) : super(_parent);
  NameFormBasicInfoMessagesPlPL get name => NameFormBasicInfoMessagesPlPL(this);
  PhotoFormBasicInfoMessagesPlPL get photo =>
      PhotoFormBasicInfoMessagesPlPL(this);
}

class NameFormBasicInfoMessagesPlPL extends NameFormBasicInfoMessages {
  final FormBasicInfoMessagesPlPL _parent;
  const NameFormBasicInfoMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Character Name"
  /// ```
  String get label => """Character Name""";

  /// ```dart
  /// "Enter your character's name"
  /// ```
  String get placeholder => """Enter your character's name""";
  RandomNameFormBasicInfoMessagesPlPL get random =>
      RandomNameFormBasicInfoMessagesPlPL(this);
}

class RandomNameFormBasicInfoMessagesPlPL
    extends RandomNameFormBasicInfoMessages {
  final NameFormBasicInfoMessagesPlPL _parent;
  const RandomNameFormBasicInfoMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "$act to generate a random name"
  /// ```
  String tooltip(String act) => """$act to generate a random name""";
}

class PhotoFormBasicInfoMessagesPlPL extends PhotoFormBasicInfoMessages {
  final FormBasicInfoMessagesPlPL _parent;
  const PhotoFormBasicInfoMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Change Photo..."
  /// ```
  String get change => """Change Photo...""";

  /// ```dart
  /// "Remove Photo"
  /// ```
  String get remove => """Remove Photo""";

  /// ```dart
  /// "Choose Photo..."
  /// ```
  String get choose => """Choose Photo...""";
  GuestPhotoFormBasicInfoMessagesPlPL get guest =>
      GuestPhotoFormBasicInfoMessagesPlPL(this);

  /// ```dart
  /// "UPLOADING..."
  /// ```
  String get uploading => """UPLOADING...""";

  /// ```dart
  /// "OR"
  /// ```
  String get orSeparator => """OR""";
  UrlPhotoFormBasicInfoMessagesPlPL get url =>
      UrlPhotoFormBasicInfoMessagesPlPL(this);
}

class GuestPhotoFormBasicInfoMessagesPlPL
    extends GuestPhotoFormBasicInfoMessages {
  final PhotoFormBasicInfoMessagesPlPL _parent;
  const GuestPhotoFormBasicInfoMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "You need to be signed in to upload images. "
  /// ```
  String get prefix => """You need to be signed in to upload images. """;

  /// ```dart
  /// "Sign in or create an account"
  /// ```
  String get label => """Sign in or create an account""";

  /// ```dart
  /// ", or upload using your own URL below."
  /// ```
  String get suffix => """, or upload using your own URL below.""";
}

class UrlPhotoFormBasicInfoMessagesPlPL extends UrlPhotoFormBasicInfoMessages {
  final PhotoFormBasicInfoMessagesPlPL _parent;
  const UrlPhotoFormBasicInfoMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Image URL"
  /// ```
  String get label => """Image URL""";

  /// ```dart
  /// "Paste an image URL"
  /// ```
  String get placeholder => """Paste an image URL""";
}

class DebilitiesMessagesPlPL extends DebilitiesMessages {
  final MessagesPlPL _parent;
  const DebilitiesMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "$name ($key)"
  /// ```
  String label(String name, String key) => """$name ($key)""";
  DialogDebilitiesMessagesPlPL get dialog => DialogDebilitiesMessagesPlPL(this);
}

class DialogDebilitiesMessagesPlPL extends DialogDebilitiesMessages {
  final DebilitiesMessagesPlPL _parent;
  const DialogDebilitiesMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Debilities"
  /// ```
  String get title => """Debilities""";

  /// ```dart
  /// "Debilities are temporary, negative conditions or states in which your character is in. When a stat is debilitated, it causes its modifier to be reduced by 1 until recovered."
  /// ```
  String get info =>
      """Debilities are temporary, negative conditions or states in which your character is in. When a stat is debilitated, it causes its modifier to be reduced by 1 until recovered.""";
}

class TagsMessagesPlPL extends TagsMessages {
  final MessagesPlPL _parent;
  const TagsMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Copy from: $name"
  /// ```
  String copyFrom(String name) => """Copy from: $name""";
  DialogTagsMessagesPlPL get dialog => DialogTagsMessagesPlPL(this);
}

class DialogTagsMessagesPlPL extends DialogTagsMessages {
  final TagsMessagesPlPL _parent;
  const DialogTagsMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Tag Information"
  /// ```
  String get title => """Tag Information""";
}

class DialogsMessagesPlPL extends DialogsMessages {
  final MessagesPlPL _parent;
  const DialogsMessagesPlPL(this._parent) : super(_parent);
  ConfirmationsDialogsMessagesPlPL get confirmations =>
      ConfirmationsDialogsMessagesPlPL(this);
}

class ConfirmationsDialogsMessagesPlPL extends ConfirmationsDialogsMessages {
  final DialogsMessagesPlPL _parent;
  const ConfirmationsDialogsMessagesPlPL(this._parent) : super(_parent);
  DeleteConfirmationsDialogsMessagesPlPL get delete =>
      DeleteConfirmationsDialogsMessagesPlPL(this);
  ExitConfirmationsDialogsMessagesPlPL get exit =>
      ExitConfirmationsDialogsMessagesPlPL(this);
  DeleteAccountConfirmationsDialogsMessagesPlPL get deleteAccount =>
      DeleteAccountConfirmationsDialogsMessagesPlPL(this);
}

class DeleteConfirmationsDialogsMessagesPlPL
    extends DeleteConfirmationsDialogsMessages {
  final ConfirmationsDialogsMessagesPlPL _parent;
  const DeleteConfirmationsDialogsMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Delete $ent?"
  /// ```
  String title(String ent) => """Delete $ent?""";

  /// ```dart
  /// "Are you sure you want to remove the $ent "$name" from the list?"
  /// ```
  String body(String ent, String name) =>
      """Are you sure you want to remove the $ent "$name" from the list?""";
}

class ExitConfirmationsDialogsMessagesPlPL
    extends ExitConfirmationsDialogsMessages {
  final ConfirmationsDialogsMessagesPlPL _parent;
  const ExitConfirmationsDialogsMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Are you sure?"
  /// ```
  String get title => """Are you sure?""";

  /// ```dart
  /// "Going back will lose any unsaved changes.\nAre you sure you want to go back?"
  /// ```
  String get body =>
      """Going back will lose any unsaved changes.\nAre you sure you want to go back?""";

  /// ```dart
  /// "Exit & Discard"
  /// ```
  String get ok => """Exit & Discard""";

  /// ```dart
  /// "Continue editing"
  /// ```
  String get cancel => """Continue editing""";
}

class DeleteAccountConfirmationsDialogsMessagesPlPL
    extends DeleteAccountConfirmationsDialogsMessages {
  final ConfirmationsDialogsMessagesPlPL _parent;
  const DeleteAccountConfirmationsDialogsMessagesPlPL(this._parent)
      : super(_parent);
  Step1DeleteAccountConfirmationsDialogsMessagesPlPL get step1 =>
      Step1DeleteAccountConfirmationsDialogsMessagesPlPL(this);
  Step2DeleteAccountConfirmationsDialogsMessagesPlPL get step2 =>
      Step2DeleteAccountConfirmationsDialogsMessagesPlPL(this);
}

class Step1DeleteAccountConfirmationsDialogsMessagesPlPL
    extends Step1DeleteAccountConfirmationsDialogsMessages {
  final DeleteAccountConfirmationsDialogsMessagesPlPL _parent;
  const Step1DeleteAccountConfirmationsDialogsMessagesPlPL(this._parent)
      : super(_parent);

  /// ```dart
  /// "Delete Your Account?"
  /// ```
  String get title => """Delete Your Account?""";

  /// ```dart
  /// "Are you sure you want to delete your account?\n\nThis action cannot be undone."
  /// ```
  String get body =>
      """Are you sure you want to delete your account?\n\nThis action cannot be undone.""";
}

class Step2DeleteAccountConfirmationsDialogsMessagesPlPL
    extends Step2DeleteAccountConfirmationsDialogsMessages {
  final DeleteAccountConfirmationsDialogsMessagesPlPL _parent;
  const Step2DeleteAccountConfirmationsDialogsMessagesPlPL(this._parent)
      : super(_parent);

  /// ```dart
  /// "Are you really sure?"
  /// ```
  String get title => """Are you really sure?""";

  /// ```dart
  /// "We do not save any data for deleted accounts. All your data will be permanently deleted.\n\nAre you sure you want to delete your account?\n\nPlease confirm this one last time."
  /// ```
  String get body =>
      """We do not save any data for deleted accounts. All your data will be permanently deleted.\n\nAre you sure you want to delete your account?\n\nPlease confirm this one last time.""";
}

class MovesMessagesPlPL extends MovesMessages {
  final MessagesPlPL _parent;
  const MovesMessagesPlPL(this._parent) : super(_parent);
  CategoryMovesMessagesPlPL get category => CategoryMovesMessagesPlPL(this);
}

class CategoryMovesMessagesPlPL extends CategoryMovesMessages {
  final MovesMessagesPlPL _parent;
  const CategoryMovesMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// """
  /// ${switch (cat) {
  ///   'starting' => 'Starting',
  ///   'basic' => 'Basic',
  ///   'special' => 'Special',
  ///   'advanced1' => 'Advanced',
  ///   'advanced2' => 'Advanced+',
  ///   _ => 'Other'
  /// }}
  /// """
  /// ```
  String shortName(String cat) => """${switch (cat) {
        'starting' => 'Starting',
        'basic' => 'Basic',
        'special' => 'Special',
        'advanced1' => 'Advanced',
        'advanced2' => 'Advanced+',
        _ => 'Other'
      }}""";

  /// ```dart
  /// """
  /// ${switch (cat) {
  ///   'starting' => 'Starting',
  ///   'basic' => 'Basic',
  ///   'special' => 'Special',
  ///   'advanced1' => 'Advanced (1-5)',
  ///   'advanced2' => 'Advanced (6-10)',
  ///   _ => 'Other'
  /// }}
  /// """
  /// ```
  String mediumName(String cat) => """${switch (cat) {
        'starting' => 'Starting',
        'basic' => 'Basic',
        'special' => 'Special',
        'advanced1' => 'Advanced (1-5)',
        'advanced2' => 'Advanced (6-10)',
        _ => 'Other'
      }}""";

  /// ```dart
  /// """
  /// ${switch (cat) {
  ///   'starting' => 'Starting',
  ///   'basic' => 'Basic',
  ///   'special' => 'Special',
  ///   'advanced1' => 'Advanced (level 1-5)',
  ///   'advanced2' => 'Advanced (level 6-10)',
  ///   _ => 'Other'
  /// }}
  /// """
  /// ```
  String longName(String cat) => """${switch (cat) {
        'starting' => 'Starting',
        'basic' => 'Basic',
        'special' => 'Special',
        'advanced1' => 'Advanced (level 1-5)',
        'advanced2' => 'Advanced (level 6-10)',
        _ => 'Other'
      }}""";
}

class SpellsMessagesPlPL extends SpellsMessages {
  final MessagesPlPL _parent;
  const SpellsMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// """
  /// ${switch (level) {
  ///   'rote' => 'Rote',
  ///   'cantrip' => 'Cantrip',
  ///   _ =>  'Level $level',
  /// }}
  /// """
  /// ```
  String spellLevel(String level) => """${switch (level) {
        'rote' => 'Rote',
        'cantrip' => 'Cantrip',
        _ => 'Level $level',
      }}""";
}

class ItemsMessagesPlPL extends ItemsMessages {
  final MessagesPlPL _parent;
  const ItemsMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "× $amt"
  /// ```
  String amount(String amt) => """× $amt""";

  /// ```dart
  /// "Amount"
  /// ```
  String get amountTooltip => """Amount""";
  SettingsItemsMessagesPlPL get settings => SettingsItemsMessagesPlPL(this);
}

class SettingsItemsMessagesPlPL extends SettingsItemsMessages {
  final ItemsMessagesPlPL _parent;
  const SettingsItemsMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Count Armor"
  /// ```
  String get countArmor => """Count Armor""";

  /// ```dart
  /// "Count Damage"
  /// ```
  String get countDamage => """Count Damage""";

  /// ```dart
  /// "Count Weight"
  /// ```
  String get countWeight => """Count Weight""";
}

class NotesMessagesPlPL extends NotesMessages {
  final MessagesPlPL _parent;
  const NotesMessagesPlPL(this._parent) : super(_parent);
  CategoryNotesMessagesPlPL get category => CategoryNotesMessagesPlPL(this);

  /// ```dart
  /// "General"
  /// ```
  String get noCategory => """General""";
  EmptyStateNotesMessagesPlPL get emptyState =>
      EmptyStateNotesMessagesPlPL(this);
}

class CategoryNotesMessagesPlPL extends CategoryNotesMessages {
  final NotesMessagesPlPL _parent;
  const CategoryNotesMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Category"
  /// ```
  String get label => """Category""";
}

class EmptyStateNotesMessagesPlPL extends EmptyStateNotesMessages {
  final NotesMessagesPlPL _parent;
  const EmptyStateNotesMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "No Notes"
  /// ```
  String get title => """No Notes""";

  /// ```dart
  /// "You can record your progress, memos, lists, maps and more using the journal."
  /// ```
  String get subtitle =>
      """You can record your progress, memos, lists, maps and more using the journal.""";

  /// ```dart
  /// "Create Note"
  /// ```
  String get button => """Create Note""";
}

class AlignmentMessagesPlPL extends AlignmentMessages {
  final MessagesPlPL _parent;
  const AlignmentMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// """
  /// ${switch (key) {
  ///   'chaotic' => 'Chaotic',
  ///   'evil' => 'Evil',
  ///   'good' => 'Good',
  ///   'lawful' => 'Lawful',
  ///   'neutral' => 'Neutral',
  ///   _ => key,
  /// }}
  /// """
  /// ```
  String name(String key) => """${switch (key) {
        'chaotic' => 'Chaotic',
        'evil' => 'Evil',
        'good' => 'Good',
        'lawful' => 'Lawful',
        'neutral' => 'Neutral',
        _ => key,
      }}""";
  AlignmentValuesAlignmentMessagesPlPL get alignmentValues =>
      AlignmentValuesAlignmentMessagesPlPL(this);
}

class AlignmentValuesAlignmentMessagesPlPL
    extends AlignmentValuesAlignmentMessages {
  final AlignmentMessagesPlPL _parent;
  const AlignmentValuesAlignmentMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Alignments"
  /// ```
  String get title => """Alignments""";
}

class BioMessagesPlPL extends BioMessages {
  final MessagesPlPL _parent;
  const BioMessagesPlPL(this._parent) : super(_parent);
  DialogBioMessagesPlPL get dialog => DialogBioMessagesPlPL(this);
}

class DialogBioMessagesPlPL extends DialogBioMessages {
  final BioMessagesPlPL _parent;
  const DialogBioMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Character Biography"
  /// ```
  String get title => """Character Biography""";
  DescriptionDialogBioMessagesPlPL get description =>
      DescriptionDialogBioMessagesPlPL(this);
  LooksDialogBioMessagesPlPL get looks => LooksDialogBioMessagesPlPL(this);
  AlignmentDialogBioMessagesPlPL get alignment =>
      AlignmentDialogBioMessagesPlPL(this);
  AlignmentDescriptionDialogBioMessagesPlPL get alignmentDescription =>
      AlignmentDescriptionDialogBioMessagesPlPL(this);
}

class DescriptionDialogBioMessagesPlPL extends DescriptionDialogBioMessages {
  final DialogBioMessagesPlPL _parent;
  const DescriptionDialogBioMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Character & background description"
  /// ```
  String get label => """Character & background description""";

  /// ```dart
  /// "Describe your character's background, personality, goals, etc."
  /// ```
  String get placeholder =>
      """Describe your character's background, personality, goals, etc.""";
}

class LooksDialogBioMessagesPlPL extends LooksDialogBioMessages {
  final DialogBioMessagesPlPL _parent;
  const LooksDialogBioMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Appearance"
  /// ```
  String get label => """Appearance""";

  /// ```dart
  /// "Describe your character's appearance. You may use the presets from the buttons above."
  /// ```
  String get placeholder =>
      """Describe your character's appearance. You may use the presets from the buttons above.""";
}

class AlignmentDialogBioMessagesPlPL extends AlignmentDialogBioMessages {
  final DialogBioMessagesPlPL _parent;
  const AlignmentDialogBioMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Alignment"
  /// ```
  String get label => """Alignment""";
}

class AlignmentDescriptionDialogBioMessagesPlPL
    extends AlignmentDescriptionDialogBioMessages {
  final DialogBioMessagesPlPL _parent;
  const AlignmentDescriptionDialogBioMessagesPlPL(this._parent)
      : super(_parent);

  /// ```dart
  /// "Alignment Description"
  /// ```
  String get label => """Alignment Description""";

  /// ```dart
  /// "Alignment is your character's way of thinking and moral compass. This can center on an ethical ideal, religious strictures or early life events. It reflects what your character values and aspires to protect or create."
  /// ```
  String get placeholder =>
      """Alignment is your character's way of thinking and moral compass. This can center on an ethical ideal, religious strictures or early life events. It reflects what your character values and aspires to protect or create.""";
}

class SearchMessagesPlPL extends SearchMessages {
  final MessagesPlPL _parent;
  const SearchMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Type to search"
  /// ```
  String get placeholder => """Type to search""";

  /// ```dart
  /// "Type to search $ent"
  /// ```
  String placeholderEntity(String ent) => """Type to search $ent""";

  /// ```dart
  /// "Search in"
  /// ```
  String get searchIn => """Search in""";
}

class HpMessagesPlPL extends HpMessages {
  final MessagesPlPL _parent;
  const HpMessagesPlPL(this._parent) : super(_parent);
  DialogHpMessagesPlPL get dialog => DialogHpMessagesPlPL(this);
  BarHpMessagesPlPL get bar => BarHpMessagesPlPL(this);
}

class DialogHpMessagesPlPL extends DialogHpMessages {
  final HpMessagesPlPL _parent;
  const DialogHpMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Modify HP"
  /// ```
  String get title => """Modify HP""";
  ChangeDialogHpMessagesPlPL get change => ChangeDialogHpMessagesPlPL(this);

  /// ```dart
  /// "Override Max HP"
  /// ```
  String get overrideMax => """Override Max HP""";
}

class ChangeDialogHpMessagesPlPL extends ChangeDialogHpMessages {
  final DialogHpMessagesPlPL _parent;
  const ChangeDialogHpMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Heal\n+$amt"
  /// ```
  String add(int amt) => """Heal\n+$amt""";

  /// ```dart
  /// "Damage\n-$amt"
  /// ```
  String remove(int amt) => """Damage\n-$amt""";

  /// ```dart
  /// "No Change"
  /// ```
  String get neutral => """No Change""";
}

class BarHpMessagesPlPL extends BarHpMessages {
  final HpMessagesPlPL _parent;
  const BarHpMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "HP"
  /// ```
  String get label => """HP""";

  /// ```dart
  /// "$act to modify your HP"
  /// ```
  String tooltip(String act) => """$act to modify your HP""";
}

class XpMessagesPlPL extends XpMessages {
  final MessagesPlPL _parent;
  const XpMessagesPlPL(this._parent) : super(_parent);
  DialogXpMessagesPlPL get dialog => DialogXpMessagesPlPL(this);
  BarXpMessagesPlPL get bar => BarXpMessagesPlPL(this);
}

class DialogXpMessagesPlPL extends DialogXpMessages {
  final XpMessagesPlPL _parent;
  const DialogXpMessagesPlPL(this._parent) : super(_parent);
  EndOfSessionDialogXpMessagesPlPL get endOfSession =>
      EndOfSessionDialogXpMessagesPlPL(this);
  LevelUpDialogXpMessagesPlPL get levelUp => LevelUpDialogXpMessagesPlPL(this);
  OverwriteDialogXpMessagesPlPL get overwrite =>
      OverwriteDialogXpMessagesPlPL(this);
}

class EndOfSessionDialogXpMessagesPlPL extends EndOfSessionDialogXpMessages {
  final DialogXpMessagesPlPL _parent;
  const EndOfSessionDialogXpMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "End Session"
  /// ```
  String get title => """End Session""";

  /// ```dart
  /// "End Session"
  /// ```
  String get button => """End Session""";
  QuestionsEndOfSessionDialogXpMessagesPlPL get questions =>
      QuestionsEndOfSessionDialogXpMessagesPlPL(this);
}

class QuestionsEndOfSessionDialogXpMessagesPlPL
    extends QuestionsEndOfSessionDialogXpMessages {
  final EndOfSessionDialogXpMessagesPlPL _parent;
  const QuestionsEndOfSessionDialogXpMessagesPlPL(this._parent)
      : super(_parent);

  /// ```dart
  /// "End of Session Questions"
  /// ```
  String get title => """End of Session Questions""";

  /// ```dart
  /// "Answer these questions as a group. For each "yes" answer, XP is marked."
  /// ```
  String get subtitle =>
      """Answer these questions as a group. For each "yes" answer, XP is marked.""";
}

class LevelUpDialogXpMessagesPlPL extends LevelUpDialogXpMessages {
  final DialogXpMessagesPlPL _parent;
  const LevelUpDialogXpMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Level Up"
  /// ```
  String get title => """Level Up""";

  /// ```dart
  /// "Level Up"
  /// ```
  String get button => """Level Up""";

  /// ```dart
  /// "Increase a stat by 1:"
  /// ```
  String get increaseStat => """Increase a stat by 1:""";
  ChooseLevelUpDialogXpMessagesPlPL get choose =>
      ChooseLevelUpDialogXpMessagesPlPL(this);
}

class ChooseLevelUpDialogXpMessagesPlPL extends ChooseLevelUpDialogXpMessages {
  final LevelUpDialogXpMessagesPlPL _parent;
  const ChooseLevelUpDialogXpMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Then, select $what:"
  /// ```
  String info(String what) => """Then, select $what:""";

  /// ```dart
  /// "$ent1 and $ent2"
  /// ```
  String both(String ent1, String ent2) => """$ent1 and $ent2""";

  /// ```dart
  /// "an advanced move"
  /// ```
  String get move => """an advanced move""";

  /// ```dart
  /// "a spell"
  /// ```
  String get spell => """a spell""";
}

class OverwriteDialogXpMessagesPlPL extends OverwriteDialogXpMessages {
  final DialogXpMessagesPlPL _parent;
  const OverwriteDialogXpMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Overwrite XP and Level"
  /// ```
  String get title => """Overwrite XP and Level""";

  /// ```dart
  /// "Overwrite"
  /// ```
  String get button => """Overwrite""";

  /// ```dart
  /// "Changing the current XP or level manually will cause the pending XP to be discarded unless this is unchecked."
  /// ```
  String get info =>
      """Changing the current XP or level manually will cause the pending XP to be discarded unless this is unchecked.""";

  /// ```dart
  /// "Reset bonds, flags & end of session questions after saving"
  /// ```
  String get resetCheckbox =>
      """Reset bonds, flags & end of session questions after saving""";

  /// ```dart
  /// "Overwrite XP"
  /// ```
  String get xp => """Overwrite XP""";

  /// ```dart
  /// "Overwrite Level"
  /// ```
  String get level => """Overwrite Level""";
}

class BarXpMessagesPlPL extends BarXpMessages {
  final XpMessagesPlPL _parent;
  const BarXpMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "XP"
  /// ```
  String get label => """XP""";

  /// ```dart
  /// "$act to end the session, level up or update your XP"
  /// ```
  String tooltip(String act) =>
      """$act to end the session, level up or update your XP""";

  /// ```dart
  /// "$act to add +1 XP"
  /// ```
  String plusOneTooltip(String act) => """$act to add +1 XP""";
}

class ArmorMessagesPlPL extends ArmorMessages {
  final MessagesPlPL _parent;
  const ArmorMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Armor"
  /// ```
  String get title => """Armor""";
  DialogArmorMessagesPlPL get dialog => DialogArmorMessagesPlPL(this);
}

class DialogArmorMessagesPlPL extends DialogArmorMessages {
  final ArmorMessagesPlPL _parent;
  const DialogArmorMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Armor"
  /// ```
  String get title => """Armor""";

  /// ```dart
  /// "Use armor from class & equipped items"
  /// ```
  String get autoArmor => """Use armor from class & equipped items""";
}

class RichTextMessagesPlPL extends RichTextMessages {
  final MessagesPlPL _parent;
  const RichTextMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Preview"
  /// ```
  String get preview => """Preview""";

  /// ```dart
  /// "Formatting Help"
  /// ```
  String get help => """Formatting Help""";

  /// ```dart
  /// "Bold"
  /// ```
  String get bold => """Bold""";

  /// ```dart
  /// "Italic"
  /// ```
  String get italic => """Italic""";

  /// ```dart
  /// "Headings"
  /// ```
  String get headings => """Headings""";

  /// ```dart
  /// "Heading $depth"
  /// ```
  String heading(int depth) => """Heading $depth""";

  /// ```dart
  /// "Bullet List"
  /// ```
  String get bulletList => """Bullet List""";

  /// ```dart
  /// "Numbered List"
  /// ```
  String get numberedList => """Numbered List""";
  CheckListRichTextMessagesPlPL get checkList =>
      CheckListRichTextMessagesPlPL(this);

  /// ```dart
  /// "URL"
  /// ```
  String get url => """URL""";

  /// ```dart
  /// "Image URL"
  /// ```
  String get imageURL => """Image URL""";

  /// ```dart
  /// "Table"
  /// ```
  String get table => """Table""";

  /// ```dart
  /// "Header $n"
  /// ```
  String header(Object n) => """Header $n""";

  /// ```dart
  /// "Cell $n"
  /// ```
  String cell(int n) => """Cell $n""";

  /// ```dart
  /// "Markdown Preview"
  /// ```
  String get markdownPreview => """Markdown Preview""";

  /// ```dart
  /// "Add Current Date"
  /// ```
  String get date => """Add Current Date""";

  /// ```dart
  /// "Add Current Time"
  /// ```
  String get time => """Add Current Time""";
}

class CheckListRichTextMessagesPlPL extends CheckListRichTextMessages {
  final RichTextMessagesPlPL _parent;
  const CheckListRichTextMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Checklist (Unchecked)"
  /// ```
  String get unchecked => """Checklist (Unchecked)""";

  /// ```dart
  /// "Checklist (Checked)"
  /// ```
  String get checked => """Checklist (Checked)""";
}

class CustomRollsMessagesPlPL extends CustomRollsMessages {
  final MessagesPlPL _parent;
  const CustomRollsMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Quick Roll Buttons"
  /// ```
  String get title => """Quick Roll Buttons""";

  /// ```dart
  /// "Left Button"
  /// ```
  String get left => """Left Button""";

  /// ```dart
  /// "Right Button"
  /// ```
  String get right => """Right Button""";

  /// ```dart
  /// "Button Label"
  /// ```
  String get buttonLabel => """Button Label""";
  SpecialDiceCustomRollsMessagesPlPL get specialDice =>
      SpecialDiceCustomRollsMessagesPlPL(this);
  TooltipCustomRollsMessagesPlPL get tooltip =>
      TooltipCustomRollsMessagesPlPL(this);
  PresetsCustomRollsMessagesPlPL get presets =>
      PresetsCustomRollsMessagesPlPL(this);
}

class SpecialDiceCustomRollsMessagesPlPL
    extends SpecialDiceCustomRollsMessages {
  final CustomRollsMessagesPlPL _parent;
  const SpecialDiceCustomRollsMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Special Dice"
  /// ```
  String get title => """Special Dice""";

  /// ```dart
  /// "${switch (btn) {'damage' => 'Damage', _ => btn}}"
  /// ```
  String button(String btn) =>
      """${switch (btn) { 'damage' => 'Damage', _ => btn }}""";
}

class TooltipCustomRollsMessagesPlPL extends TooltipCustomRollsMessages {
  final CustomRollsMessagesPlPL _parent;
  const TooltipCustomRollsMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Roll $dice"
  /// ```
  String rollNormal(String dice) => """Roll $dice""";

  /// ```dart
  /// "Roll $dice\n* Rolling with debility"
  /// ```
  String rollWithDebility(String dice) =>
      """Roll $dice\n* Rolling with debility""";
}

class PresetsCustomRollsMessagesPlPL extends PresetsCustomRollsMessages {
  final CustomRollsMessagesPlPL _parent;
  const PresetsCustomRollsMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Presets"
  /// ```
  String get title => """Presets""";

  /// ```dart
  /// "Basic Action"
  /// ```
  String get basicAction => """Basic Action""";

  /// ```dart
  /// "Hack & Slash"
  /// ```
  String get hackAndSlash => """Hack & Slash""";

  /// ```dart
  /// "Volley"
  /// ```
  String get volley => """Volley""";

  /// ```dart
  /// "Discern Realities"
  /// ```
  String get discernRealities => """Discern Realities""";
}

class SessionMarksMessagesPlPL extends SessionMarksMessages {
  final MessagesPlPL _parent;
  const SessionMarksMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Bonds & Flags"
  /// ```
  String get title => """Bonds & Flags""";

  /// ```dart
  /// "Bond"
  /// ```
  String get bond => """Bond""";

  /// ```dart
  /// "Bonds"
  /// ```
  String get bonds => """Bonds""";

  /// ```dart
  /// "Flag"
  /// ```
  String get flag => """Flag""";

  /// ```dart
  /// "Flags"
  /// ```
  String get flags => """Flags""";

  /// ```dart
  /// "You have no bonds or flags. You can add some using the edit button above, then mark them off as completed as you go along your adventure."
  /// ```
  String get noData =>
      """You have no bonds or flags. You can add some using the edit button above, then mark them off as completed as you go along your adventure.""";

  /// ```dart
  /// "You can add, update or remove bonds & flags using the edit icon above."
  /// ```
  String get info =>
      """You can add, update or remove bonds & flags using the edit icon above.""";
  EndOfSessionSessionMarksMessagesPlPL get endOfSession =>
      EndOfSessionSessionMarksMessagesPlPL(this);
}

class EndOfSessionSessionMarksMessagesPlPL
    extends EndOfSessionSessionMarksMessages {
  final SessionMarksMessagesPlPL _parent;
  const EndOfSessionSessionMarksMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Did we learn something new and important about the world?"
  /// ```
  String get q1 =>
      """Did we learn something new and important about the world?""";

  /// ```dart
  /// "Did we overcome a notable monster or enemy?"
  /// ```
  String get q2 => """Did we overcome a notable monster or enemy?""";

  /// ```dart
  /// "Did we loot a memorable treasure?"
  /// ```
  String get q3 => """Did we loot a memorable treasure?""";
}

class CreateCharacterMessagesPlPL extends CreateCharacterMessages {
  final MessagesPlPL _parent;
  const CreateCharacterMessagesPlPL(this._parent) : super(_parent);
  CharacterClassCreateCharacterMessagesPlPL get characterClass =>
      CharacterClassCreateCharacterMessagesPlPL(this);
  BasicInfoCreateCharacterMessagesPlPL get basicInfo =>
      BasicInfoCreateCharacterMessagesPlPL(this);
  StartingGearCreateCharacterMessagesPlPL get startingGear =>
      StartingGearCreateCharacterMessagesPlPL(this);
  MovesSpellsCreateCharacterMessagesPlPL get movesSpells =>
      MovesSpellsCreateCharacterMessagesPlPL(this);
}

class CharacterClassCreateCharacterMessagesPlPL
    extends CharacterClassCreateCharacterMessages {
  final CreateCharacterMessagesPlPL _parent;
  const CharacterClassCreateCharacterMessagesPlPL(this._parent)
      : super(_parent);

  /// ```dart
  /// "No class selected (required)"
  /// ```
  String get noSelection => """No class selected (required)""";

  /// ```dart
  /// "Base HP: $hp, Load: $load, Damage Dice: $damageDice"
  /// ```
  String description(int hp, int load, String damageDice) =>
      """Base HP: $hp, Load: $load, Damage Dice: $damageDice""";
}

class BasicInfoCreateCharacterMessagesPlPL
    extends BasicInfoCreateCharacterMessages {
  final CreateCharacterMessagesPlPL _parent;
  const BasicInfoCreateCharacterMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Unnamed Traveler"
  /// ```
  String get defaultName => """Unnamed Traveler""";

  /// ```dart
  /// "Select name & picture (required)"
  /// ```
  String get helpText => """Select name & picture (required)""";

  /// ```dart
  /// "Level 1 $cls"
  /// ```
  String description(String cls) => """Level 1 $cls""";
}

class StartingGearCreateCharacterMessagesPlPL
    extends StartingGearCreateCharacterMessages {
  final CreateCharacterMessagesPlPL _parent;
  const StartingGearCreateCharacterMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Select your starting gear determined by class (optional)"
  /// ```
  String get helpText =>
      """Select your starting gear determined by class (optional)""";

  /// ```dart
  /// "$amt G"
  /// ```
  String coins(String amt) => """$amt G""";

  /// ```dart
  /// "${amt}× $name"
  /// ```
  String item(String amt, String name) => """${amt}× $name""";
  CountStartingGearCreateCharacterMessagesPlPL get count =>
      CountStartingGearCreateCharacterMessagesPlPL(this);
}

class CountStartingGearCreateCharacterMessagesPlPL
    extends CountStartingGearCreateCharacterMessages {
  final StartingGearCreateCharacterMessagesPlPL _parent;
  const CountStartingGearCreateCharacterMessagesPlPL(this._parent)
      : super(_parent);

  /// ```dart
  /// "$cnt selected (class allowance: $max)"
  /// ```
  String withMax(int cnt, int max) =>
      """$cnt selected (class allowance: $max)""";

  /// ```dart
  /// "$cnt selected"
  /// ```
  String noMax(int cnt) => """$cnt selected""";
}

class MovesSpellsCreateCharacterMessagesPlPL
    extends MovesSpellsCreateCharacterMessages {
  final CreateCharacterMessagesPlPL _parent;
  const MovesSpellsCreateCharacterMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Moves & Spells"
  /// ```
  String get title => """Moves & Spells""";

  /// ```dart
  /// "$moves Moves, $spells Spells selected"
  /// ```
  String description(int moves, int spells) =>
      """$moves Moves, $spells Spells selected""";
}

class AccountMessagesPlPL extends AccountMessages {
  final MessagesPlPL _parent;
  const AccountMessagesPlPL(this._parent) : super(_parent);
  DetailsAccountMessagesPlPL get details => DetailsAccountMessagesPlPL(this);
  ProvidersAccountMessagesPlPL get providers =>
      ProvidersAccountMessagesPlPL(this);
  DeleteAccountAccountMessagesPlPL get deleteAccount =>
      DeleteAccountAccountMessagesPlPL(this);
  UnlinkAccountMessagesPlPL get unlink => UnlinkAccountMessagesPlPL(this);
}

class DetailsAccountMessagesPlPL extends DetailsAccountMessages {
  final AccountMessagesPlPL _parent;
  const DetailsAccountMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Account details"
  /// ```
  String get title => """Account details""";
  DisplayNameDetailsAccountMessagesPlPL get displayName =>
      DisplayNameDetailsAccountMessagesPlPL(this);
  ImageDetailsAccountMessagesPlPL get image =>
      ImageDetailsAccountMessagesPlPL(this);
  EmailDetailsAccountMessagesPlPL get email =>
      EmailDetailsAccountMessagesPlPL(this);
  PasswordDetailsAccountMessagesPlPL get password =>
      PasswordDetailsAccountMessagesPlPL(this);
}

class DisplayNameDetailsAccountMessagesPlPL
    extends DisplayNameDetailsAccountMessages {
  final DetailsAccountMessagesPlPL _parent;
  const DisplayNameDetailsAccountMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Change Display Name"
  /// ```
  String get title => """Change Display Name""";

  /// ```dart
  /// "Display name"
  /// ```
  String get label => """Display name""";

  /// ```dart
  /// "Enter your public display name"
  /// ```
  String get placeholder => """Enter your public display name""";

  /// ```dart
  /// "Display name changed successfully"
  /// ```
  String get success => """Display name changed successfully""";
}

class ImageDetailsAccountMessagesPlPL extends ImageDetailsAccountMessages {
  final DetailsAccountMessagesPlPL _parent;
  const ImageDetailsAccountMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Change Profile Picture"
  /// ```
  String get title => """Change Profile Picture""";

  /// ```dart
  /// "Change your profile picture"
  /// ```
  String get subtitle => """Change your profile picture""";
}

class EmailDetailsAccountMessagesPlPL extends EmailDetailsAccountMessages {
  final DetailsAccountMessagesPlPL _parent;
  const EmailDetailsAccountMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Change Email Address"
  /// ```
  String get title => """Change Email Address""";

  /// ```dart
  /// "Email address"
  /// ```
  String get label => """Email address""";

  /// ```dart
  /// "Enter a new email address"
  /// ```
  String get placeholder => """Enter a new email address""";

  /// ```dart
  /// "Email changed successfully"
  /// ```
  String get success => """Email changed successfully""";
}

class PasswordDetailsAccountMessagesPlPL
    extends PasswordDetailsAccountMessages {
  final DetailsAccountMessagesPlPL _parent;
  const PasswordDetailsAccountMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Change Password"
  /// ```
  String get title => """Change Password""";

  /// ```dart
  /// "Change your password"
  /// ```
  String get subtitle => """Change your password""";

  /// ```dart
  /// "Password changed successfully"
  /// ```
  String get success => """Password changed successfully""";

  /// ```dart
  /// "New password"
  /// ```
  String get label => """New password""";

  /// ```dart
  /// "Enter your new password"
  /// ```
  String get placeholder => """Enter your new password""";
  VisibilityPasswordDetailsAccountMessagesPlPL get visibility =>
      VisibilityPasswordDetailsAccountMessagesPlPL(this);
  ConfirmPasswordDetailsAccountMessagesPlPL get confirm =>
      ConfirmPasswordDetailsAccountMessagesPlPL(this);

  /// ```dart
  /// "Passwords do not match"
  /// ```
  String get error => """Passwords do not match""";
}

class VisibilityPasswordDetailsAccountMessagesPlPL
    extends VisibilityPasswordDetailsAccountMessages {
  final PasswordDetailsAccountMessagesPlPL _parent;
  const VisibilityPasswordDetailsAccountMessagesPlPL(this._parent)
      : super(_parent);

  /// ```dart
  /// "Show password"
  /// ```
  String get show => """Show password""";

  /// ```dart
  /// "Hide password"
  /// ```
  String get hide => """Hide password""";
}

class ConfirmPasswordDetailsAccountMessagesPlPL
    extends ConfirmPasswordDetailsAccountMessages {
  final PasswordDetailsAccountMessagesPlPL _parent;
  const ConfirmPasswordDetailsAccountMessagesPlPL(this._parent)
      : super(_parent);

  /// ```dart
  /// "Confirm New Password"
  /// ```
  String get label => """Confirm New Password""";

  /// ```dart
  /// "Enter the same password again"
  /// ```
  String get placeholder => """Enter the same password again""";
}

class ProvidersAccountMessagesPlPL extends ProvidersAccountMessages {
  final AccountMessagesPlPL _parent;
  const ProvidersAccountMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Connected logins"
  /// ```
  String get title => """Connected logins""";
}

class DeleteAccountAccountMessagesPlPL extends DeleteAccountAccountMessages {
  final AccountMessagesPlPL _parent;
  const DeleteAccountAccountMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Delete Your Account"
  /// ```
  String get title => """Delete Your Account""";

  /// ```dart
  /// "A deletion request for your account was sent successfully"
  /// ```
  String get success =>
      """A deletion request for your account was sent successfully""";
}

class UnlinkAccountMessagesPlPL extends UnlinkAccountMessages {
  final AccountMessagesPlPL _parent;
  const UnlinkAccountMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "You successfully unlinked $provider."
  /// ```
  String success(String provider) => """You successfully unlinked $provider.""";
}

class ActionsMessagesPlPL extends ActionsMessages {
  final MessagesPlPL _parent;
  const ActionsMessagesPlPL(this._parent) : super(_parent);
  MovesActionsMessagesPlPL get moves => MovesActionsMessagesPlPL(this);
  ClassActionsActionsMessagesPlPL get classActions =>
      ClassActionsActionsMessagesPlPL(this);
}

class MovesActionsMessagesPlPL extends MovesActionsMessages {
  final ActionsMessagesPlPL _parent;
  const MovesActionsMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Basic Moves"
  /// ```
  String get basic => """Basic Moves""";

  /// ```dart
  /// "Special Moves"
  /// ```
  String get special => """Special Moves""";
}

class ClassActionsActionsMessagesPlPL extends ClassActionsActionsMessages {
  final ActionsMessagesPlPL _parent;
  const ClassActionsActionsMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Class Actions"
  /// ```
  String get title => """Class Actions""";
  MarkXPClassActionsActionsMessagesPlPL get markXP =>
      MarkXPClassActionsActionsMessagesPlPL(this);
}

class MarkXPClassActionsActionsMessagesPlPL
    extends MarkXPClassActionsActionsMessages {
  final ClassActionsActionsMessagesPlPL _parent;
  const MarkXPClassActionsActionsMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Mark +1 XP"
  /// ```
  String get button => """Mark +1 XP""";

  /// ```dart
  /// "+1 XP marked"
  /// ```
  String get success => """+1 XP marked""";
}

class AbilityScoresMessagesPlPL extends AbilityScoresMessages {
  final MessagesPlPL _parent;
  const AbilityScoresMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "You can drag & drop the stat cards to change the order in which they appear throughout this character's screens."
  /// ```
  String get info =>
      """You can drag & drop the stat cards to change the order in which they appear throughout this character's screens.""";
  RollButtonAbilityScoresMessagesPlPL get rollButton =>
      RollButtonAbilityScoresMessagesPlPL(this);
  StatsAbilityScoresMessagesPlPL get stats =>
      StatsAbilityScoresMessagesPlPL(this);
  FormAbilityScoresMessagesPlPL get form => FormAbilityScoresMessagesPlPL(this);
}

class RollButtonAbilityScoresMessagesPlPL
    extends RollButtonAbilityScoresMessages {
  final AbilityScoresMessagesPlPL _parent;
  const RollButtonAbilityScoresMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Roll +{stat}"
  /// ```
  String get stat => """Roll +{stat}""";

  /// ```dart
  /// "Roll random stat"
  /// ```
  String get randStat => """Roll random stat""";
}

class StatsAbilityScoresMessagesPlPL extends StatsAbilityScoresMessages {
  final AbilityScoresMessagesPlPL _parent;
  const StatsAbilityScoresMessagesPlPL(this._parent) : super(_parent);
  BondStatsAbilityScoresMessagesPlPL get bond =>
      BondStatsAbilityScoresMessagesPlPL(this);
  ChaStatsAbilityScoresMessagesPlPL get cha =>
      ChaStatsAbilityScoresMessagesPlPL(this);
  ConStatsAbilityScoresMessagesPlPL get con =>
      ConStatsAbilityScoresMessagesPlPL(this);
  DexStatsAbilityScoresMessagesPlPL get dex =>
      DexStatsAbilityScoresMessagesPlPL(this);
  StrStatsAbilityScoresMessagesPlPL get str =>
      StrStatsAbilityScoresMessagesPlPL(this);
  WisStatsAbilityScoresMessagesPlPL get wis =>
      WisStatsAbilityScoresMessagesPlPL(this);
  IntlStatsAbilityScoresMessagesPlPL get intl =>
      IntlStatsAbilityScoresMessagesPlPL(this);
}

class BondStatsAbilityScoresMessagesPlPL
    extends BondStatsAbilityScoresMessages {
  final StatsAbilityScoresMessagesPlPL _parent;
  const BondStatsAbilityScoresMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Bond"
  /// ```
  String get name => """Bond""";

  /// ```dart
  /// "When a move has you roll+bond you'll count the number of bonds you have with the character in question and add that to the roll."
  /// ```
  String get description =>
      """When a move has you roll+bond you'll count the number of bonds you have with the character in question and add that to the roll.""";
  DebilityBondStatsAbilityScoresMessagesPlPL get debility =>
      DebilityBondStatsAbilityScoresMessagesPlPL(this);
}

class DebilityBondStatsAbilityScoresMessagesPlPL
    extends DebilityBondStatsAbilityScoresMessages {
  final BondStatsAbilityScoresMessagesPlPL _parent;
  const DebilityBondStatsAbilityScoresMessagesPlPL(this._parent)
      : super(_parent);

  /// ```dart
  /// "Lonely"
  /// ```
  String get name => """Lonely""";

  String get description => """null""";
}

class ChaStatsAbilityScoresMessagesPlPL extends ChaStatsAbilityScoresMessages {
  final StatsAbilityScoresMessagesPlPL _parent;
  const ChaStatsAbilityScoresMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Measures a character's personality, personal magnetism, ability to lead, and appearance."
  /// ```
  String get description =>
      """Measures a character's personality, personal magnetism, ability to lead, and appearance.""";

  /// ```dart
  /// "Charisma"
  /// ```
  String get name => """Charisma""";
  DebilityChaStatsAbilityScoresMessagesPlPL get debility =>
      DebilityChaStatsAbilityScoresMessagesPlPL(this);
}

class DebilityChaStatsAbilityScoresMessagesPlPL
    extends DebilityChaStatsAbilityScoresMessages {
  final ChaStatsAbilityScoresMessagesPlPL _parent;
  const DebilityChaStatsAbilityScoresMessagesPlPL(this._parent)
      : super(_parent);

  /// ```dart
  /// "Scarred"
  /// ```
  String get name => """Scarred""";

  /// ```dart
  /// "It may not be permanent, but for now you don't look so good."
  /// ```
  String get description =>
      """It may not be permanent, but for now you don't look so good.""";
}

class ConStatsAbilityScoresMessagesPlPL extends ConStatsAbilityScoresMessages {
  final StatsAbilityScoresMessagesPlPL _parent;
  const ConStatsAbilityScoresMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Represents your character's health and stamina."
  /// ```
  String get description =>
      """Represents your character's health and stamina.""";

  /// ```dart
  /// "Constitution"
  /// ```
  String get name => """Constitution""";
  DebilityConStatsAbilityScoresMessagesPlPL get debility =>
      DebilityConStatsAbilityScoresMessagesPlPL(this);
}

class DebilityConStatsAbilityScoresMessagesPlPL
    extends DebilityConStatsAbilityScoresMessages {
  final ConStatsAbilityScoresMessagesPlPL _parent;
  const DebilityConStatsAbilityScoresMessagesPlPL(this._parent)
      : super(_parent);

  /// ```dart
  /// "Sick"
  /// ```
  String get name => """Sick""";

  /// ```dart
  /// "Something just isn't right inside. Maybe you've got a disease or a wasting illness. Maybe you just drank too much ale last night and it's coming back to haunt you."
  /// ```
  String get description =>
      """Something just isn't right inside. Maybe you've got a disease or a wasting illness. Maybe you just drank too much ale last night and it's coming back to haunt you.""";
}

class DexStatsAbilityScoresMessagesPlPL extends DexStatsAbilityScoresMessages {
  final StatsAbilityScoresMessagesPlPL _parent;
  const DexStatsAbilityScoresMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Measures agility, reflexes and balance."
  /// ```
  String get description => """Measures agility, reflexes and balance.""";

  /// ```dart
  /// "Dexterity"
  /// ```
  String get name => """Dexterity""";
  DebilityDexStatsAbilityScoresMessagesPlPL get debility =>
      DebilityDexStatsAbilityScoresMessagesPlPL(this);
}

class DebilityDexStatsAbilityScoresMessagesPlPL
    extends DebilityDexStatsAbilityScoresMessages {
  final DexStatsAbilityScoresMessagesPlPL _parent;
  const DebilityDexStatsAbilityScoresMessagesPlPL(this._parent)
      : super(_parent);

  /// ```dart
  /// "Shaky"
  /// ```
  String get name => """Shaky""";

  /// ```dart
  /// "You're unsteady on your feet and you've got a shake in your hands."
  /// ```
  String get description =>
      """You're unsteady on your feet and you've got a shake in your hands.""";
}

class StrStatsAbilityScoresMessagesPlPL extends StrStatsAbilityScoresMessages {
  final StatsAbilityScoresMessagesPlPL _parent;
  const StrStatsAbilityScoresMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Measures muscle and physical power."
  /// ```
  String get description => """Measures muscle and physical power.""";

  /// ```dart
  /// "Strength"
  /// ```
  String get name => """Strength""";
  DebilityStrStatsAbilityScoresMessagesPlPL get debility =>
      DebilityStrStatsAbilityScoresMessagesPlPL(this);
}

class DebilityStrStatsAbilityScoresMessagesPlPL
    extends DebilityStrStatsAbilityScoresMessages {
  final StrStatsAbilityScoresMessagesPlPL _parent;
  const DebilityStrStatsAbilityScoresMessagesPlPL(this._parent)
      : super(_parent);

  /// ```dart
  /// "Weak"
  /// ```
  String get name => """Weak""";

  /// ```dart
  /// "You can't exert much force. Maybe it's just fatigue and injury, or maybe your strength was drained by magic."
  /// ```
  String get description =>
      """You can't exert much force. Maybe it's just fatigue and injury, or maybe your strength was drained by magic.""";
}

class WisStatsAbilityScoresMessagesPlPL extends WisStatsAbilityScoresMessages {
  final StatsAbilityScoresMessagesPlPL _parent;
  const WisStatsAbilityScoresMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Describes a character's willpower, common sense, awareness, and intuition."
  /// ```
  String get description =>
      """Describes a character's willpower, common sense, awareness, and intuition.""";

  /// ```dart
  /// "Wisdom"
  /// ```
  String get name => """Wisdom""";
  DebilityWisStatsAbilityScoresMessagesPlPL get debility =>
      DebilityWisStatsAbilityScoresMessagesPlPL(this);
}

class DebilityWisStatsAbilityScoresMessagesPlPL
    extends DebilityWisStatsAbilityScoresMessages {
  final WisStatsAbilityScoresMessagesPlPL _parent;
  const DebilityWisStatsAbilityScoresMessagesPlPL(this._parent)
      : super(_parent);

  /// ```dart
  /// "Confused"
  /// ```
  String get name => """Confused""";

  /// ```dart
  /// "Ears ringing. Vision blurred. You're more than a little out of it."
  /// ```
  String get description =>
      """Ears ringing. Vision blurred. You're more than a little out of it.""";
}

class IntlStatsAbilityScoresMessagesPlPL
    extends IntlStatsAbilityScoresMessages {
  final StatsAbilityScoresMessagesPlPL _parent;
  const IntlStatsAbilityScoresMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Determines how well your character learns and reasons."
  /// ```
  String get description =>
      """Determines how well your character learns and reasons.""";

  /// ```dart
  /// "Intelligence"
  /// ```
  String get name => """Intelligence""";
  DebilityIntlStatsAbilityScoresMessagesPlPL get debility =>
      DebilityIntlStatsAbilityScoresMessagesPlPL(this);
}

class DebilityIntlStatsAbilityScoresMessagesPlPL
    extends DebilityIntlStatsAbilityScoresMessages {
  final IntlStatsAbilityScoresMessagesPlPL _parent;
  const DebilityIntlStatsAbilityScoresMessagesPlPL(this._parent)
      : super(_parent);

  /// ```dart
  /// "Stunned"
  /// ```
  String get name => """Stunned""";

  /// ```dart
  /// "That last knock to the head shook something loose. Brain not work so good."
  /// ```
  String get description =>
      """That last knock to the head shook something loose. Brain not work so good.""";
}

class FormAbilityScoresMessagesPlPL extends FormAbilityScoresMessages {
  final AbilityScoresMessagesPlPL _parent;
  const FormAbilityScoresMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Modifier:\n$mod"
  /// ```
  String modifierValueLabel(String mod) => """Modifier:\n$mod""";
  DebilityDescriptionFormAbilityScoresMessagesPlPL get debilityDescription =>
      DebilityDescriptionFormAbilityScoresMessagesPlPL(this);
  DebilityNameFormAbilityScoresMessagesPlPL get debilityName =>
      DebilityNameFormAbilityScoresMessagesPlPL(this);
  DescriptionFormAbilityScoresMessagesPlPL get description =>
      DescriptionFormAbilityScoresMessagesPlPL(this);
  KeyFormAbilityScoresMessagesPlPL get key =>
      KeyFormAbilityScoresMessagesPlPL(this);
  NameFormAbilityScoresMessagesPlPL get name =>
      NameFormAbilityScoresMessagesPlPL(this);
  IconFormAbilityScoresMessagesPlPL get icon =>
      IconFormAbilityScoresMessagesPlPL(this);
}

class DebilityDescriptionFormAbilityScoresMessagesPlPL
    extends DebilityDescriptionFormAbilityScoresMessages {
  final FormAbilityScoresMessagesPlPL _parent;
  const DebilityDescriptionFormAbilityScoresMessagesPlPL(this._parent)
      : super(_parent);

  /// ```dart
  /// "Debility Description"
  /// ```
  String get label => """Debility Description""";

  /// ```dart
  /// "A description of the effect causing the debility and/or how it affects your character"
  /// ```
  String get description =>
      """A description of the effect causing the debility and/or how it affects your character""";
}

class DebilityNameFormAbilityScoresMessagesPlPL
    extends DebilityNameFormAbilityScoresMessages {
  final FormAbilityScoresMessagesPlPL _parent;
  const DebilityNameFormAbilityScoresMessagesPlPL(this._parent)
      : super(_parent);

  /// ```dart
  /// "Debility Name"
  /// ```
  String get label => """Debility Name""";

  /// ```dart
  /// "The name for the debility that occurs when this stat is debilitated (takes -1 until recovered)."
  /// ```
  String get description =>
      """The name for the debility that occurs when this stat is debilitated (takes -1 until recovered).""";
}

class DescriptionFormAbilityScoresMessagesPlPL
    extends DescriptionFormAbilityScoresMessages {
  final FormAbilityScoresMessagesPlPL _parent;
  const DescriptionFormAbilityScoresMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Ability Score Description"
  /// ```
  String get label => """Ability Score Description""";

  /// ```dart
  /// "A description of what this ability score represents"
  /// ```
  String get description =>
      """A description of what this ability score represents""";
}

class KeyFormAbilityScoresMessagesPlPL extends KeyFormAbilityScoresMessages {
  final FormAbilityScoresMessagesPlPL _parent;
  const KeyFormAbilityScoresMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Ability Score Key"
  /// ```
  String get label => """Ability Score Key""";

  /// ```dart
  /// "A 3-letter unique key that identifies this ability score in dice and is used as the short label for the modifier value (and not the actual score)"
  /// ```
  String get description =>
      """A 3-letter unique key that identifies this ability score in dice and is used as the short label for the modifier value (and not the actual score)""";
}

class NameFormAbilityScoresMessagesPlPL extends NameFormAbilityScoresMessages {
  final FormAbilityScoresMessagesPlPL _parent;
  const NameFormAbilityScoresMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Ability Score Name"
  /// ```
  String get label => """Ability Score Name""";

  /// ```dart
  /// "The name of this ability score"
  /// ```
  String get description => """The name of this ability score""";
}

class IconFormAbilityScoresMessagesPlPL extends IconFormAbilityScoresMessages {
  final FormAbilityScoresMessagesPlPL _parent;
  const IconFormAbilityScoresMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Icon"
  /// ```
  String get label => """Icon""";

  /// ```dart
  /// "Change Icon"
  /// ```
  String get button => """Change Icon""";
}

class FeedbackMessagesPlPL extends FeedbackMessages {
  final MessagesPlPL _parent;
  const FeedbackMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Send App Feedback"
  /// ```
  String get title => """Send App Feedback""";

  /// ```dart
  /// "Send"
  /// ```
  String get send => """Send""";
  FormFeedbackMessagesPlPL get form => FormFeedbackMessagesPlPL(this);
  SuccessFeedbackMessagesPlPL get success => SuccessFeedbackMessagesPlPL(this);
}

class FormFeedbackMessagesPlPL extends FormFeedbackMessages {
  final FeedbackMessagesPlPL _parent;
  const FormFeedbackMessagesPlPL(this._parent) : super(_parent);
  TitleFormFeedbackMessagesPlPL get title =>
      TitleFormFeedbackMessagesPlPL(this);
  BodyFormFeedbackMessagesPlPL get body => BodyFormFeedbackMessagesPlPL(this);
  EmailFormFeedbackMessagesPlPL get email =>
      EmailFormFeedbackMessagesPlPL(this);
}

class TitleFormFeedbackMessagesPlPL extends TitleFormFeedbackMessages {
  final FormFeedbackMessagesPlPL _parent;
  const TitleFormFeedbackMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Feedback title"
  /// ```
  String get label => """Feedback title""";
}

class BodyFormFeedbackMessagesPlPL extends BodyFormFeedbackMessages {
  final FormFeedbackMessagesPlPL _parent;
  const BodyFormFeedbackMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Problem, idea or feedback description"
  /// ```
  String get label => """Problem, idea or feedback description""";
}

class EmailFormFeedbackMessagesPlPL extends EmailFormFeedbackMessages {
  final FormFeedbackMessagesPlPL _parent;
  const EmailFormFeedbackMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Enter your email"
  /// ```
  String get label => """Enter your email""";
}

class SuccessFeedbackMessagesPlPL extends SuccessFeedbackMessages {
  final FeedbackMessagesPlPL _parent;
  const SuccessFeedbackMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Feedback sent!"
  /// ```
  String get title => """Feedback sent!""";

  /// ```dart
  /// "Thank you for your feedback! We will review your feedback as soon as we can."
  /// ```
  String get message =>
      """Thank you for your feedback! We will review your feedback as soon as we can.""";
}

class MigrationMessagesPlPL extends MigrationMessages {
  final MessagesPlPL _parent;
  const MigrationMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Welcome to\nDungeon Paper 2!"
  /// ```
  String get title => """Welcome to\nDungeon Paper 2!""";

  /// ```dart
  /// "To get started, pick a username and the language for the rulebook & app. If you already have an existing Dungeon Paper account your data might take a few seconds to migrate."
  /// ```
  String get subtitle =>
      """To get started, pick a username and the language for the rulebook & app. If you already have an existing Dungeon Paper account your data might take a few seconds to migrate.""";
  UsernameMigrationMessagesPlPL get username =>
      UsernameMigrationMessagesPlPL(this);
  LanguageMigrationMessagesPlPL get language =>
      LanguageMigrationMessagesPlPL(this);
}

class UsernameMigrationMessagesPlPL extends UsernameMigrationMessages {
  final MigrationMessagesPlPL _parent;
  const UsernameMigrationMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Username"
  /// ```
  String get label => """Username""";

  /// ```dart
  /// "Pick a unique username"
  /// ```
  String get placeholder => """Pick a unique username""";

  /// ```dart
  /// "Your username is unique and can not be changed later, so think carefully! It will be used to identify all your library items when publishing."
  /// ```
  String get info =>
      """Your username is unique and can not be changed later, so think carefully! It will be used to identify all your library items when publishing.""";
}

class LanguageMigrationMessagesPlPL extends LanguageMigrationMessages {
  final MigrationMessagesPlPL _parent;
  const LanguageMigrationMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Default data language"
  /// ```
  String get data => """Default data language""";
}

class BackupMessagesPlPL extends BackupMessages {
  final MessagesPlPL _parent;
  const BackupMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Export/Import"
  /// ```
  String get title => """Export/Import""";
  ImportingBackupMessagesPlPL get importing =>
      ImportingBackupMessagesPlPL(this);
  ExportingBackupMessagesPlPL get exporting =>
      ExportingBackupMessagesPlPL(this);
}

class ImportingBackupMessagesPlPL extends ImportingBackupMessages {
  final BackupMessagesPlPL _parent;
  const ImportingBackupMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Import"
  /// ```
  String get title => """Import""";

  /// ```dart
  /// "Import"
  /// ```
  String get button => """Import""";
  ProgressImportingBackupMessagesPlPL get progress =>
      ProgressImportingBackupMessagesPlPL(this);
  FileImportingBackupMessagesPlPL get file =>
      FileImportingBackupMessagesPlPL(this);
  SuccessImportingBackupMessagesPlPL get success =>
      SuccessImportingBackupMessagesPlPL(this);
  ErrorImportingBackupMessagesPlPL get error =>
      ErrorImportingBackupMessagesPlPL(this);
}

class ProgressImportingBackupMessagesPlPL
    extends ProgressImportingBackupMessages {
  final ImportingBackupMessagesPlPL _parent;
  const ProgressImportingBackupMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Importing..."
  /// ```
  String get title => """Importing...""";

  /// ```dart
  /// "Processing $ent..."
  /// ```
  String processing(String ent) => """Processing $ent...""";
}

class FileImportingBackupMessagesPlPL extends FileImportingBackupMessages {
  final ImportingBackupMessagesPlPL _parent;
  const FileImportingBackupMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Browse..."
  /// ```
  String get browse => """Browse...""";

  /// ```dart
  /// "Clear selected file"
  /// ```
  String get clearFile => """Clear selected file""";

  /// ```dart
  /// "To start importing, pick the file you want to import from.\nYou will then be able to select what to save and what to leave out."
  /// ```
  String get info =>
      """To start importing, pick the file you want to import from.\nYou will then be able to select what to save and what to leave out.""";
}

class SuccessImportingBackupMessagesPlPL
    extends SuccessImportingBackupMessages {
  final ImportingBackupMessagesPlPL _parent;
  const SuccessImportingBackupMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Import Successful"
  /// ```
  String get title => """Import Successful""";

  /// ```dart
  /// "Your data was imported from file successfully"
  /// ```
  String get message => """Your data was imported from file successfully""";
}

class ErrorImportingBackupMessagesPlPL extends ErrorImportingBackupMessages {
  final ImportingBackupMessagesPlPL _parent;
  const ErrorImportingBackupMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Import Failed"
  /// ```
  String get title => """Import Failed""";

  /// ```dart
  /// "Something went wrong.\nTry again or contact support if this persists"
  /// ```
  String get message =>
      """Something went wrong.\nTry again or contact support if this persists""";
}

class ExportingBackupMessagesPlPL extends ExportingBackupMessages {
  final BackupMessagesPlPL _parent;
  const ExportingBackupMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Export"
  /// ```
  String get title => """Export""";

  /// ```dart
  /// "Export"
  /// ```
  String get button => """Export""";
  ErrorExportingBackupMessagesPlPL get error =>
      ErrorExportingBackupMessagesPlPL(this);
  SuccessExportingBackupMessagesPlPL get success =>
      SuccessExportingBackupMessagesPlPL(this);
  BundlesExportingBackupMessagesPlPL get bundles =>
      BundlesExportingBackupMessagesPlPL(this);
}

class ErrorExportingBackupMessagesPlPL extends ErrorExportingBackupMessages {
  final ExportingBackupMessagesPlPL _parent;
  const ErrorExportingBackupMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Export Failed"
  /// ```
  String get title => """Export Failed""";

  /// ```dart
  /// "Something went wrong.\nTry again or contact support if this persists"
  /// ```
  String get message =>
      """Something went wrong.\nTry again or contact support if this persists""";
}

class SuccessExportingBackupMessagesPlPL
    extends SuccessExportingBackupMessages {
  final ExportingBackupMessagesPlPL _parent;
  const SuccessExportingBackupMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Export Successful"
  /// ```
  String get title => """Export Successful""";

  /// ```dart
  /// "Your data was exported to file successfully"
  /// ```
  String get message => """Your data was exported to file successfully""";
}

class BundlesExportingBackupMessagesPlPL
    extends BundlesExportingBackupMessages {
  final ExportingBackupMessagesPlPL _parent;
  const BundlesExportingBackupMessagesPlPL(this._parent) : super(_parent);
  CharacterClassBundlesExportingBackupMessagesPlPL get characterClass =>
      CharacterClassBundlesExportingBackupMessagesPlPL(this);
}

class CharacterClassBundlesExportingBackupMessagesPlPL
    extends CharacterClassBundlesExportingBackupMessages {
  final BundlesExportingBackupMessagesPlPL _parent;
  const CharacterClassBundlesExportingBackupMessagesPlPL(this._parent)
      : super(_parent);

  /// ```dart
  /// "Export Class Bundle"
  /// ```
  String get button => """Export Class Bundle""";

  /// ```dart
  /// "Export Class Bundle"
  /// ```
  String get title => """Export Class Bundle""";
}

class ChangelogMessagesPlPL extends ChangelogMessages {
  final MessagesPlPL _parent;
  const ChangelogMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "What's New?"
  /// ```
  String get title => """What's New?""";
  TagsChangelogMessagesPlPL get tags => TagsChangelogMessagesPlPL(this);
}

class TagsChangelogMessagesPlPL extends TagsChangelogMessages {
  final ChangelogMessagesPlPL _parent;
  const TagsChangelogMessagesPlPL(this._parent) : super(_parent);

  /// ```dart
  /// "Latest"
  /// ```
  String get latest => """Latest""";

  /// ```dart
  /// "Current"
  /// ```
  String get current => """Current""";
}

Map<String, String> get messagesPlPLMap => {
      """app.name""": """Dungeon Paper""",
      """platformInteractions.tap""": """Tap""",
      """platformInteractions.drag""": """Drag""",
      """platformInteractions.pan""": """Pan""",
      """platformInteractions.click""": """Click""",
      """generic.save""": """Save""",
      """generic.cancel""": """Cancel""",
      """generic.close""": """Close""",
      """generic.done""": """Done""",
      """generic.view""": """View""",
      """generic.continue_""": """Continue""",
      """generic.all""": """All""",
      """generic.create""": """Create""",
      """generic.add""": """Add""",
      """generic.remove""": """Remove""",
      """generic.unselect""": """Unselect""",
      """generic.delete""": """Delete""",
      """generic.edit""": """Edit""",
      """generic.yes""": """Yes""",
      """generic.no""": """No""",
      """generic.select""": """Select""",
      """generic.selected""": """Selected""",
      """generic.selectAll""": """Select All""",
      """generic.selectNone""": """Select None""",
      """generic.my""": """My""",
      """generic.change""": """Change""",
      """generic.seeAll""": """See All""",
      """generic.name""": """Name""",
      """generic.value""": """Value""",
      """generic.description""": """Description""",
      """generic.explanation""": """Explanation""",
      """generic.noDescription""": """‹No description provided›""",
      """generic.useDefault""": """Use Default""",
      """loading.user""": """Signing in...""",
      """loading.characters""": """Getting characters...""",
      """loading.general""": """Loading...""",
      """errors.userOperationCanceled""": """Operation canceled""",
      """errors.uploadError""":
          """Error while uploading photo. Try again later, or contact support using the "About" page.""",
      """errors.invalidEmail""": """Invalid email address""",
      """errors.invalidPassword.letter""":
          """Password must contain at least one capital letter""",
      """errors.invalidPassword.number""":
          """Password must contain at least one number""",
      """errors.onlyLetters""": """Must contain letters only""",
      """numberFields.increase""": """+1""",
      """numberFields.decrease""": """-1""",
      """sort.moveUp""": """Move up""",
      """sort.moveDown""": """Move down""",
      """playbook.title""": """Playbook""",
      """playbook.myLibrary""": """My Library""",
      """playbook.myCampaigns""": """My Campaigns""",
      """myLibrary.title""": """My Library""",
      """myLibrary.reload""": """Reload Library""",
      """myLibrary.alreadyAdded""": """Already added""",
      """myLibrary.itemTab.playbook""": """Playbook""",
      """myLibrary.itemTab.online""": """Online""",
      """myLibrary.filters.clear""": """Clear Filters""",
      """nav.actions""": """Use""",
      """nav.character""": """Character""",
      """nav.journal""": """Journal""",
      """settings.title""": """Settings""",
      """settings.importExport""": """Export/Import""",
      """settings.categories.general""": """General""",
      """settings.keepAwake""": """Keep screen awake while using the app""",
      """settings.locale.title""": """Language""",
      """settings.locale.subtitle""":
          """Switching the language will reload the app""",
      """settings.locales.en_US""": """English (United States)""",
      """settings.locales.pt_BR""": """Português (Brasil)""",
      """settings.locales.pl_PL""": """Polski""",
      """user.recentCharacters""": """Recent Characters""",
      """auth.orSeparator""": """OR""",
      """auth.privacyPolicy""": """Privacy Policy""",
      """auth.changelog""": """What's new?""",
      """auth.notLoggedIn""": """Not logged in""",
      """auth.menuSubtitle(String interact)""": """Account details""",
      """auth.providers.unlink""": """Unlink""",
      """auth.providers.link""": """Link""",
      """auth.login.title""": """Sign In""",
      """auth.login.subtitle""":
          """Sign in to your account to sync your data online, and get access to many more features.""",
      """auth.login.button""": """Sign in""",
      """auth.login.noAccount.label""": """Don't have an account?""",
      """auth.login.noAccount.button""": """Sign up""",
      """auth.logout.button""": """Sign out""",
      """auth.signup.title""": """Sign Up""",
      """auth.signup.subtitle""":
          """Enter the required details below to create your Dungeon Paper account.""",
      """auth.signup.button""": """Sign up""",
      """auth.signup.email.label""": """Email""",
      """auth.signup.email.placeholder""": """Enter your email""",
      """auth.signup.email.error""": """Please enter a valid email address""",
      """auth.signup.password.label""": """Password""",
      """auth.signup.password.placeholder""": """Enter a password""",
      """auth.signup.password.confirm.label""": """Confirm Password""",
      """auth.signup.password.confirm.placeholder""":
          """Enter the same password again""",
      """auth.signup.password.confirm.error""": """Passwords do not match""",
      """home.categories.notes""": """Bookmarked Notes""",
      """home.categories.moves""": """Favorite Moves""",
      """home.categories.spells""": """Prepared Spells""",
      """home.categories.items""": """Equipped Items""",
      """home.categories.classActions""": """Class Actions""",
      """home.summary.load.tooltip""": """Max Load""",
      """home.summary.coins.tooltip""": """Coins""",
      """home.menu.character.tooltip""": """Character Menu""",
      """home.menu.character.basicInfo""": """Basic Information""",
      """home.menu.character.abilityScores""": """Ability Scores""",
      """home.menu.character.customRolls""": """Quick-Roll Buttons""",
      """home.menu.character.theme""": """Character Theme""",
      """home.menu.character.settings""": """View Settings""",
      """home.menu.character.favoritesView""": """Change Favorites View""",
      """home.menu.bio""": """Character Biography""",
      """home.menu.debilities""": """Debilities""",
      """home.emptyState.guest.title""": """Sign in to get more features""",
      """home.emptyState.guest.subtitle""":
          """Online data sync, library sharing, campaigns and more!""",
      """home.emptyState.title""": """No Characters""",
      """home.emptyState.subtitle""": """Create a Character to get started""",
      """about.title""": """About""",
      """about.author""": """Chen Asraf""",
      """about.changelog.title""": """What's new?""",
      """about.changelog.subtitle""":
          """Change log of Dungeon Paper release versions""",
      """about.discord.title""": """Join Our Discord""",
      """about.discord.subtitle""":
          """Join the Discord community to ask questions, get help, send feedback, or just chat with other players.""",
      """about.feedback.title""": """Send Feedback""",
      """about.feedback.subtitle""":
          """We reply more promptly through Discord, but you can send us feedback, bug reports or suggestions about the app directly here as an alternative.""",
      """about.donate.title""": """Make a Donation""",
      """about.donate.subtitle""":
          """If you are looking for a way to support the project, you can make a donation on the official Ko-fi page of the developer. Click this to be redirected to the Ko-fi page.""",
      """about.socials.title""": """Links""",
      """about.socials.twitter""": """Twitter""",
      """about.socials.facebook""": """Facebook""",
      """about.socials.discord""": """Discord""",
      """about.socials.github""": """GitHub""",
      """about.socials.google""": """Play Store""",
      """about.socials.apple""": """App Store""",
      """about.specialThanks""": """Special Thanks""",
      """about.contributors""": """Contributors""",
      """about.icons""": """Icon Credits""",
      """character.data.coins""": """Coins""",
      """character.data.load.load""": """Load""",
      """character.data.load.maxLoad""": """Max Load""",
      """character.data.load.autoMaxLoad""":
          """Use class base load + STR mod""",
      """character.data.level""": """Level""",
      """character.data.damageDice""": """Damage Dice""",
      """character.data.calculateDamage""":
          """Use damage dice from class & equipped items""",
      """character.header.separator""": """ ∙ """,
      """character.noCategory""": """No Category""",
      """character.theme.title""": """Character Theme""",
      """character.favoritesView.cards""": """Cards View""",
      """character.favoritesView.list""": """List View""",
      """characterClass.baseLoad""": """Base Load""",
      """characterClass.baseHp""": """Base HP""",
      """characterClass.damageDice""": """Damage Dice""",
      """characterClass.isSpellcaster.title""": """Spellcasting class""",
      """characterClass.isSpellcaster.subtitle""":
          """Spellcasters are prompted to select spells (as well as moves) during character
creation and leveling up.""",
      """characterClass.stats""": """Stats""",
      """characterClass.bio""": """Backgrounds""",
      """characterClass.startingGear.label""": """Starting Gear Selections""",
      """startingGear.titleEdit""": """Edit Starting Gear""",
      """startingGear.titleSelect""": """Select Starting Gear""",
      """startingGear.choice.helpText""":
          """A choice is a list of selections the player can make. It provides a possible set of items & coins that the player can select from.""",
      """startingGear.choice.description.label""": """Prompt""",
      """startingGear.choice.description.hintText""":
          """e.g. Choose your weapon""",
      """startingGear.choice.maxSelections.label""":
          """Suggested max allowance""",
      """startingGear.choice.maxSelections.helpText""":
          """This will suggest a maximum amount to select, and will display a count, but will not limit the selection. Use 0 or leave blank for no limit.""",
      """startingGear.choice.moveUp""": """Move up""",
      """startingGear.choice.moveDown""": """Move down""",
      """startingGear.selection.title""": """Gear Set""",
      """startingGear.selection.helpText""":
          """Each gear set consists of some amount of coins, and a list of items to be given to the character. Choosing one gear set will give the character all the items and gold in that set.""",
      """startingGear.selection.add""": """Add Gear Set""",
      """startingGear.selection.description.label""":
          """Selection description""",
      """startingGear.selection.description.hintText""":
          """e.g. Your father's old sword, and 10 coins""",
      """startingGear.selection.coins.label""": """Coins""",
      """startingGear.option.title""": """Gear Set Items""",
      """startingGear.option.helpText""":
          """Each gear set item consists of X amount of a specific item.""",
      """startingGear.option.add""": """Add Items""",
      """startingGear.option.amount.label""": """Amount""",
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
      """basicInfo.title""": """Basic Information""",
      """basicInfo.form.name.label""": """Character Name""",
      """basicInfo.form.name.placeholder""": """Enter your character's name""",
      """basicInfo.form.photo.change""": """Change Photo...""",
      """basicInfo.form.photo.remove""": """Remove Photo""",
      """basicInfo.form.photo.choose""": """Choose Photo...""",
      """basicInfo.form.photo.guest.prefix""":
          """You need to be signed in to upload images. """,
      """basicInfo.form.photo.guest.label""":
          """Sign in or create an account""",
      """basicInfo.form.photo.guest.suffix""":
          """, or upload using your own URL below.""",
      """basicInfo.form.photo.uploading""": """UPLOADING...""",
      """basicInfo.form.photo.orSeparator""": """OR""",
      """basicInfo.form.photo.url.label""": """Image URL""",
      """basicInfo.form.photo.url.placeholder""": """Paste an image URL""",
      """debilities.dialog.title""": """Debilities""",
      """debilities.dialog.info""":
          """Debilities are temporary, negative conditions or states in which your character is in. When a stat is debilitated, it causes its modifier to be reduced by 1 until recovered.""",
      """tags.dialog.title""": """Tag Information""",
      """dialogs.confirmations.exit.title""": """Are you sure?""",
      """dialogs.confirmations.exit.body""":
          """Going back will lose any unsaved changes.\nAre you sure you want to go back?""",
      """dialogs.confirmations.exit.ok""": """Exit & Discard""",
      """dialogs.confirmations.exit.cancel""": """Continue editing""",
      """dialogs.confirmations.deleteAccount.step1.title""":
          """Delete Your Account?""",
      """dialogs.confirmations.deleteAccount.step1.body""":
          """Are you sure you want to delete your account?\n\nThis action cannot be undone.""",
      """dialogs.confirmations.deleteAccount.step2.title""":
          """Are you really sure?""",
      """dialogs.confirmations.deleteAccount.step2.body""":
          """We do not save any data for deleted accounts. All your data will be permanently deleted.\n\nAre you sure you want to delete your account?\n\nPlease confirm this one last time.""",
      """items.amountTooltip""": """Amount""",
      """items.settings.countArmor""": """Count Armor""",
      """items.settings.countDamage""": """Count Damage""",
      """items.settings.countWeight""": """Count Weight""",
      """notes.category.label""": """Category""",
      """notes.noCategory""": """General""",
      """notes.emptyState.title""": """No Notes""",
      """notes.emptyState.subtitle""":
          """You can record your progress, memos, lists, maps and more using the journal.""",
      """notes.emptyState.button""": """Create Note""",
      """alignment.alignmentValues.title""": """Alignments""",
      """bio.dialog.title""": """Character Biography""",
      """bio.dialog.description.label""":
          """Character & background description""",
      """bio.dialog.description.placeholder""":
          """Describe your character's background, personality, goals, etc.""",
      """bio.dialog.looks.label""": """Appearance""",
      """bio.dialog.looks.placeholder""":
          """Describe your character's appearance. You may use the presets from the buttons above.""",
      """bio.dialog.alignment.label""": """Alignment""",
      """bio.dialog.alignmentDescription.label""": """Alignment Description""",
      """bio.dialog.alignmentDescription.placeholder""":
          """Alignment is your character's way of thinking and moral compass. This can center on an ethical ideal, religious strictures or early life events. It reflects what your character values and aspires to protect or create.""",
      """search.placeholder""": """Type to search""",
      """search.searchIn""": """Search in""",
      """hp.dialog.title""": """Modify HP""",
      """hp.dialog.change.neutral""": """No Change""",
      """hp.dialog.overrideMax""": """Override Max HP""",
      """hp.bar.label""": """HP""",
      """xp.dialog.endOfSession.title""": """End Session""",
      """xp.dialog.endOfSession.button""": """End Session""",
      """xp.dialog.endOfSession.questions.title""":
          """End of Session Questions""",
      """xp.dialog.endOfSession.questions.subtitle""":
          """Answer these questions as a group. For each "yes" answer, XP is marked.""",
      """xp.dialog.levelUp.title""": """Level Up""",
      """xp.dialog.levelUp.button""": """Level Up""",
      """xp.dialog.levelUp.increaseStat""": """Increase a stat by 1:""",
      """xp.dialog.levelUp.choose.move""": """an advanced move""",
      """xp.dialog.levelUp.choose.spell""": """a spell""",
      """xp.dialog.overwrite.title""": """Overwrite XP and Level""",
      """xp.dialog.overwrite.button""": """Overwrite""",
      """xp.dialog.overwrite.info""":
          """Changing the current XP or level manually will cause the pending XP to be discarded unless this is unchecked.""",
      """xp.dialog.overwrite.resetCheckbox""":
          """Reset bonds, flags & end of session questions after saving""",
      """xp.dialog.overwrite.xp""": """Overwrite XP""",
      """xp.dialog.overwrite.level""": """Overwrite Level""",
      """xp.bar.label""": """XP""",
      """armor.title""": """Armor""",
      """armor.dialog.title""": """Armor""",
      """armor.dialog.autoArmor""": """Use armor from class & equipped items""",
      """richText.preview""": """Preview""",
      """richText.help""": """Formatting Help""",
      """richText.bold""": """Bold""",
      """richText.italic""": """Italic""",
      """richText.headings""": """Headings""",
      """richText.bulletList""": """Bullet List""",
      """richText.numberedList""": """Numbered List""",
      """richText.checkList.unchecked""": """Checklist (Unchecked)""",
      """richText.checkList.checked""": """Checklist (Checked)""",
      """richText.url""": """URL""",
      """richText.imageURL""": """Image URL""",
      """richText.table""": """Table""",
      """richText.markdownPreview""": """Markdown Preview""",
      """richText.date""": """Add Current Date""",
      """richText.time""": """Add Current Time""",
      """customRolls.title""": """Quick Roll Buttons""",
      """customRolls.left""": """Left Button""",
      """customRolls.right""": """Right Button""",
      """customRolls.buttonLabel""": """Button Label""",
      """customRolls.specialDice.title""": """Special Dice""",
      """customRolls.presets.title""": """Presets""",
      """customRolls.presets.basicAction""": """Basic Action""",
      """customRolls.presets.hackAndSlash""": """Hack & Slash""",
      """customRolls.presets.volley""": """Volley""",
      """customRolls.presets.discernRealities""": """Discern Realities""",
      """sessionMarks.title""": """Bonds & Flags""",
      """sessionMarks.bond""": """Bond""",
      """sessionMarks.bonds""": """Bonds""",
      """sessionMarks.flag""": """Flag""",
      """sessionMarks.flags""": """Flags""",
      """sessionMarks.noData""":
          """You have no bonds or flags. You can add some using the edit button above, then mark them off as completed as you go along your adventure.""",
      """sessionMarks.info""":
          """You can add, update or remove bonds & flags using the edit icon above.""",
      """sessionMarks.endOfSession.q1""":
          """Did we learn something new and important about the world?""",
      """sessionMarks.endOfSession.q2""":
          """Did we overcome a notable monster or enemy?""",
      """sessionMarks.endOfSession.q3""":
          """Did we loot a memorable treasure?""",
      """createCharacter.characterClass.noSelection""":
          """No class selected (required)""",
      """createCharacter.basicInfo.defaultName""": """Unnamed Traveler""",
      """createCharacter.basicInfo.helpText""":
          """Select name & picture (required)""",
      """createCharacter.startingGear.helpText""":
          """Select your starting gear determined by class (optional)""",
      """createCharacter.movesSpells.title""": """Moves & Spells""",
      """account.details.title""": """Account details""",
      """account.details.displayName.title""": """Change Display Name""",
      """account.details.displayName.label""": """Display name""",
      """account.details.displayName.placeholder""":
          """Enter your public display name""",
      """account.details.displayName.success""":
          """Display name changed successfully""",
      """account.details.image.title""": """Change Profile Picture""",
      """account.details.image.subtitle""": """Change your profile picture""",
      """account.details.email.title""": """Change Email Address""",
      """account.details.email.label""": """Email address""",
      """account.details.email.placeholder""": """Enter a new email address""",
      """account.details.email.success""": """Email changed successfully""",
      """account.details.password.title""": """Change Password""",
      """account.details.password.subtitle""": """Change your password""",
      """account.details.password.success""":
          """Password changed successfully""",
      """account.details.password.label""": """New password""",
      """account.details.password.placeholder""": """Enter your new password""",
      """account.details.password.visibility.show""": """Show password""",
      """account.details.password.visibility.hide""": """Hide password""",
      """account.details.password.confirm.label""": """Confirm New Password""",
      """account.details.password.confirm.placeholder""":
          """Enter the same password again""",
      """account.details.password.error""": """Passwords do not match""",
      """account.providers.title""": """Connected logins""",
      """account.deleteAccount.title""": """Delete Your Account""",
      """account.deleteAccount.success""":
          """A deletion request for your account was sent successfully""",
      """actions.moves.basic""": """Basic Moves""",
      """actions.moves.special""": """Special Moves""",
      """actions.classActions.title""": """Class Actions""",
      """actions.classActions.markXP.button""": """Mark +1 XP""",
      """actions.classActions.markXP.success""": """+1 XP marked""",
      """abilityScores.info""":
          """You can drag & drop the stat cards to change the order in which they appear throughout this character's screens.""",
      """abilityScores.rollButton.stat""": """Roll +{stat}""",
      """abilityScores.rollButton.randStat""": """Roll random stat""",
      """abilityScores.stats.bond.name""": """Bond""",
      """abilityScores.stats.bond.description""":
          """When a move has you roll+bond you'll count the number of bonds you have with the character in question and add that to the roll.""",
      """abilityScores.stats.bond.debility.name""": """Lonely""",
      """abilityScores.stats.cha.description""":
          """Measures a character's personality, personal magnetism, ability to lead, and appearance.""",
      """abilityScores.stats.cha.name""": """Charisma""",
      """abilityScores.stats.cha.debility.name""": """Scarred""",
      """abilityScores.stats.cha.debility.description""":
          """It may not be permanent, but for now you don't look so good.""",
      """abilityScores.stats.con.description""":
          """Represents your character's health and stamina.""",
      """abilityScores.stats.con.name""": """Constitution""",
      """abilityScores.stats.con.debility.name""": """Sick""",
      """abilityScores.stats.con.debility.description""":
          """Something just isn't right inside. Maybe you've got a disease or a wasting illness. Maybe you just drank too much ale last night and it's coming back to haunt you.""",
      """abilityScores.stats.dex.description""":
          """Measures agility, reflexes and balance.""",
      """abilityScores.stats.dex.name""": """Dexterity""",
      """abilityScores.stats.dex.debility.name""": """Shaky""",
      """abilityScores.stats.dex.debility.description""":
          """You're unsteady on your feet and you've got a shake in your hands.""",
      """abilityScores.stats.str.description""":
          """Measures muscle and physical power.""",
      """abilityScores.stats.str.name""": """Strength""",
      """abilityScores.stats.str.debility.name""": """Weak""",
      """abilityScores.stats.str.debility.description""":
          """You can't exert much force. Maybe it's just fatigue and injury, or maybe your strength was drained by magic.""",
      """abilityScores.stats.wis.description""":
          """Describes a character's willpower, common sense, awareness, and intuition.""",
      """abilityScores.stats.wis.name""": """Wisdom""",
      """abilityScores.stats.wis.debility.name""": """Confused""",
      """abilityScores.stats.wis.debility.description""":
          """Ears ringing. Vision blurred. You're more than a little out of it.""",
      """abilityScores.stats.intl.description""":
          """Determines how well your character learns and reasons.""",
      """abilityScores.stats.intl.name""": """Intelligence""",
      """abilityScores.stats.intl.debility.name""": """Stunned""",
      """abilityScores.stats.intl.debility.description""":
          """That last knock to the head shook something loose. Brain not work so good.""",
      """abilityScores.form.debilityDescription.label""":
          """Debility Description""",
      """abilityScores.form.debilityDescription.description""":
          """A description of the effect causing the debility and/or how it affects your character""",
      """abilityScores.form.debilityName.label""": """Debility Name""",
      """abilityScores.form.debilityName.description""":
          """The name for the debility that occurs when this stat is debilitated (takes -1 until recovered).""",
      """abilityScores.form.description.label""":
          """Ability Score Description""",
      """abilityScores.form.description.description""":
          """A description of what this ability score represents""",
      """abilityScores.form.key.label""": """Ability Score Key""",
      """abilityScores.form.key.description""":
          """A 3-letter unique key that identifies this ability score in dice and is used as the short label for the modifier value (and not the actual score)""",
      """abilityScores.form.name.label""": """Ability Score Name""",
      """abilityScores.form.name.description""":
          """The name of this ability score""",
      """abilityScores.form.icon.label""": """Icon""",
      """abilityScores.form.icon.button""": """Change Icon""",
      """feedback.title""": """Send App Feedback""",
      """feedback.send""": """Send""",
      """feedback.form.title.label""": """Feedback title""",
      """feedback.form.body.label""":
          """Problem, idea or feedback description""",
      """feedback.form.email.label""": """Enter your email""",
      """feedback.success.title""": """Feedback sent!""",
      """feedback.success.message""":
          """Thank you for your feedback! We will review your feedback as soon as we can.""",
      """migration.title""": """Welcome to\nDungeon Paper 2!""",
      """migration.subtitle""":
          """To get started, pick a username and the language for the rulebook & app. If you already have an existing Dungeon Paper account your data might take a few seconds to migrate.""",
      """migration.username.label""": """Username""",
      """migration.username.placeholder""": """Pick a unique username""",
      """migration.username.info""":
          """Your username is unique and can not be changed later, so think carefully! It will be used to identify all your library items when publishing.""",
      """migration.language.data""": """Default data language""",
      """backup.title""": """Export/Import""",
      """backup.importing.title""": """Import""",
      """backup.importing.button""": """Import""",
      """backup.importing.progress.title""": """Importing...""",
      """backup.importing.file.browse""": """Browse...""",
      """backup.importing.file.clearFile""": """Clear selected file""",
      """backup.importing.file.info""":
          """To start importing, pick the file you want to import from.\nYou will then be able to select what to save and what to leave out.""",
      """backup.importing.success.title""": """Import Successful""",
      """backup.importing.success.message""":
          """Your data was imported from file successfully""",
      """backup.importing.error.title""": """Import Failed""",
      """backup.importing.error.message""":
          """Something went wrong.\nTry again or contact support if this persists""",
      """backup.exporting.title""": """Export""",
      """backup.exporting.button""": """Export""",
      """backup.exporting.error.title""": """Export Failed""",
      """backup.exporting.error.message""":
          """Something went wrong.\nTry again or contact support if this persists""",
      """backup.exporting.success.title""": """Export Successful""",
      """backup.exporting.success.message""":
          """Your data was exported to file successfully""",
      """backup.exporting.bundles.characterClass.button""":
          """Export Class Bundle""",
      """backup.exporting.bundles.characterClass.title""":
          """Export Class Bundle""",
      """changelog.title""": """What's New?""",
      """changelog.tags.latest""": """Latest""",
      """changelog.tags.current""": """Current""",
    };
