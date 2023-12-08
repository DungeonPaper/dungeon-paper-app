// GENERATED FILE, do not edit!
// ignore_for_file: annotate_overrides, non_constant_identifier_names, prefer_single_quotes, unused_element, unused_field, unnecessary_string_interpolations
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
String _select(
  String key,
  Map<String, String> cases, {
  String? other,
}) =>
    i18n.select(key, cases, other: other);

class Messages {
  const Messages();
  String get locale => "en";
  String get languageCode => "en";

  /// ```dart
  /// """
  /// ${_select(type, {
  ///   'Dice': 'Die',
  ///   'CharacterClass': 'Class',
  ///   'MoveCategory': 'Category',
  ///   'GearSelection': 'Starting Gear',
  ///   'AbilityScore': 'Ability Score',
  ///   'AlignmentValue': 'Alignment'
  /// })}
  /// """
  /// ```
  String _entSingle(String type) => """${_select(type, {
            'Dice': 'Die',
            'CharacterClass': 'Class',
            'MoveCategory': 'Category',
            'GearSelection': 'Starting Gear',
            'AbilityScore': 'Ability Score',
            'AlignmentValue': 'Alignment'
          })}""";

  /// ```dart
  /// """
  /// ${_select(type, {
  ///   'MoveCategory': 'Categories',
  ///   'CharacterClass': 'Classes',
  /// }, other: '${_entSingle(type)}s')}
  /// """
  /// ```
  String _entPlural(String type) => """${_select(type, {
        'MoveCategory': 'Categories',
        'CharacterClass': 'Classes',
      }, other: '${_entSingle(type)}s')}""";

  /// `${_entSingle(ent.toString())}`
  String entity(Type ent) => """${_entSingle(ent.toString())}""";

  /// `${_entPlural(ent.toString())}`
  String entityPlural(Type ent) => """${_entPlural(ent.toString())}""";

  /// `${cnt == 1 ? _entSingle(ent.toString()) : _entPlural(ent.toString())}`
  String entityCount(Type ent, int cnt) =>
      """${cnt == 1 ? _entSingle(ent.toString()) : _entPlural(ent.toString())}""";

  /// `$cnt ${entityCount(ent, cnt)}`
  String entityCountNum(Type ent, int cnt) =>
      """$cnt ${entityCount(ent, cnt)}""";
  AppMessages get app => AppMessages(this);
  GenericMessages get generic => GenericMessages(this);
  LoadingMessages get loading => LoadingMessages(this);
  ErrorsMessages get errors => ErrorsMessages(this);
  SortMessages get sort => SortMessages(this);
  PlaybookMessages get playbook => PlaybookMessages(this);
  MyLibraryMessages get myLibrary => MyLibraryMessages(this);
  NavMessages get nav => NavMessages(this);
  SyncMessages get sync => SyncMessages(this);
  SettingsMessages get settings => SettingsMessages(this);
  UserMessages get user => UserMessages(this);
  AuthMessages get auth => AuthMessages(this);
  HomeMessages get home => HomeMessages(this);
  AboutMessages get about => AboutMessages(this);
  CharacterMessages get character => CharacterMessages(this);
  CharacterClassMessages get characterClass => CharacterClassMessages(this);
  DiceMessages get dice => DiceMessages(this);
  BasicInfoMessages get basicInfo => BasicInfoMessages(this);
  DebilitiesMessages get debilities => DebilitiesMessages(this);
  TagsMessages get tags => TagsMessages(this);
  DialogsMessages get dialogs => DialogsMessages(this);
  MovesMessages get moves => MovesMessages(this);
  SpellsMessages get spells => SpellsMessages(this);
  ItemsMessages get items => ItemsMessages(this);
  NotesMessages get notes => NotesMessages(this);
  AlignmentMessages get alignment => AlignmentMessages(this);
  BioMessages get bio => BioMessages(this);
  SearchMessages get search => SearchMessages(this);
  HpMessages get hp => HpMessages(this);
  XpMessages get xp => XpMessages(this);
  ArmorMessages get armor => ArmorMessages(this);
  RichTextMessages get richText => RichTextMessages(this);
  CustomRollsMessages get customRolls => CustomRollsMessages(this);
  SessionMarksMessages get sessionMarks => SessionMarksMessages(this);
  CreateCharacterMessages get createCharacter => CreateCharacterMessages(this);
  AccountMessages get account => AccountMessages(this);
  ActionsMessages get actions => ActionsMessages(this);
  AbilityScoresMessages get abilityScores => AbilityScoresMessages(this);
  FeedbackMessages get feedback => FeedbackMessages(this);
  MigrationMessages get migration => MigrationMessages(this);
  BackupMessages get backup => BackupMessages(this);
}

class AppMessages {
  final Messages _parent;
  const AppMessages(this._parent);

  /// `Dungeon Paper`
  String get name => """Dungeon Paper""";
}

class GenericMessages {
  final Messages _parent;
  const GenericMessages(this._parent);

  /// `Save`
  String get save => """Save""";

  /// `Save $ent`
  String saveEntity(String ent) => """Save $ent""";

  /// `Cancel`
  String get cancel => """Cancel""";

  /// `Close`
  String get close => """Close""";

  /// `Done`
  String get done => """Done""";

  /// `View`
  String get view => """View""";

  /// `Continue`
  String get continue_ => """Continue""";

  /// `View $ent`
  String viewEntity(String ent) => """View $ent""";

  /// `All`
  String get all => """All""";

  /// `All $ent`
  String allEntities(String ent) => """All $ent""";

  /// `Create`
  String get create => """Create""";

  /// `Create $ent`
  String createEntity(String ent) => """Create $ent""";

  /// `Add`
  String get add => """Add""";

  /// `Add $ent`
  String addEntity(String ent) => """Add $ent""";

  /// `Remove`
  String get remove => """Remove""";

  /// `Remove $ent`
  String removeEntity(String ent) => """Remove $ent""";

  /// `Unselect`
  String get unselect => """Unselect""";

  /// `Unselect $ent`
  String unselectEntity(String ent) => """Unselect $ent""";

  /// `Delete`
  String get delete => """Delete""";

  /// `Delete $ent`
  String deleteEntity(String ent) => """Delete $ent""";

  /// `Edit`
  String get edit => """Edit""";

  /// `Edit $ent`
  String editEntity(String ent) => """Edit $ent""";

  /// `Yes`
  String get yes => """Yes""";

  /// `No`
  String get no => """No""";

  /// `No $ent`
  String noEntity(String ent) => """No $ent""";

  /// `Select`
  String get select => """Select""";

  /// `Select $ent`
  String selectEntity(String ent) => """Select $ent""";

  /// `Selected`
  String get selected => """Selected""";

  /// `Select All`
  String get selectAll => """Select All""";

  /// `Select None`
  String get selectNone => """Select None""";

  /// `My`
  String get my => """My""";

  /// `My $ent`
  String myEntity(String ent) => """My $ent""";

  /// `Change`
  String get change => """Change""";

  /// `Change $ent`
  String changeEntity(String ent) => """Change $ent""";

  /// `See All`
  String get seeAll => """See All""";

  /// `Select $ent to add`
  String selectToAdd(String ent) => """Select $ent to add""";

  /// `Name`
  String get name => """Name""";

  /// `$ent name`
  String entityName(String ent) => """$ent name""";

  /// `Value`
  String get value => """Value""";

  /// `$ent value`
  String entityValue(String ent) => """$ent value""";

  /// `Description`
  String get description => """Description""";

  /// `$ent description`
  String entityDescription(String ent) => """$ent description""";

  /// `Explanation`
  String get explanation => """Explanation""";

  /// `$ent explanation`
  String entityExplanation(String ent) => """$ent explanation""";

  /// `‹No description provided›`
  String get noDescription => """‹No description provided›""";

  /// `No $ent selected`
  String noEntitySelected(String ent) => """No $ent selected""";

  /// `No $ent selected (required)`
  String noEntitySelectedRequired(String ent) =>
      """No $ent selected (required)""";

  /// `Use Default`
  String get useDefault => """Use Default""";
}

class LoadingMessages {
  final Messages _parent;
  const LoadingMessages(this._parent);

  /// `Signing in...`
  String get user => """Signing in...""";

  /// `Getting characters...`
  String get characters => """Getting characters...""";

  /// `Loading...`
  String get general => """Loading...""";
}

class ErrorsMessages {
  final Messages _parent;
  const ErrorsMessages(this._parent);

  /// `Operation canceled`
  String get userOperationCanceled => """Operation canceled""";

  /// `Error while uploading photo. Try again later, or contact support using the "About" page.`
  String get uploadError =>
      """Error while uploading photo. Try again later, or contact support using the "About" page.""";

  /// `Invalid email address`
  String get invalidEmail => """Invalid email address""";
  InvalidPasswordErrorsMessages get invalidPassword =>
      InvalidPasswordErrorsMessages(this);

  /// `Must be at least $cnt ${_plural(cnt, one: 'character', many: 'characters')}`
  String minLength(int cnt) =>
      """Must be at least $cnt ${_plural(cnt, one: 'character', many: 'characters')}""";

  /// `Must be no more than $cnt ${_plural(cnt, one: 'character', many: 'characters')}`
  String maxLength(int cnt) =>
      """Must be no more than $cnt ${_plural(cnt, one: 'character', many: 'characters')}""";

  /// `Must be exactly $cnt ${_plural(cnt, one: 'character', many: 'characters')}`
  String exactLength(int cnt) =>
      """Must be exactly $cnt ${_plural(cnt, one: 'character', many: 'characters')}""";

  /// `Must contain $pattern`
  String mustContain(String pattern) => """Must contain $pattern""";

  /// `Must not contain $pattern`
  String mustNotContain(String pattern) => """Must not contain $pattern""";

  /// `Must contain letters only`
  String get onlyLetters => """Must contain letters only""";
}

class InvalidPasswordErrorsMessages {
  final ErrorsMessages _parent;
  const InvalidPasswordErrorsMessages(this._parent);

  /// `Password must contain at least one capital letter`
  String get letter => """Password must contain at least one capital letter""";

  /// `Password must contain at least one number`
  String get number => """Password must contain at least one number""";
}

class SortMessages {
  final Messages _parent;
  const SortMessages(this._parent);

  /// `Move up`
  String get moveUp => """Move up""";

  /// `Move down`
  String get moveDown => """Move down""";

  /// `Move $ent to top`
  String moveEntityToTop(String ent) => """Move $ent to top""";

  /// `Move $ent to bottom`
  String moveEntityToBottom(String ent) => """Move $ent to bottom""";
}

class PlaybookMessages {
  final Messages _parent;
  const PlaybookMessages(this._parent);

  /// `Playbook`
  String get title => """Playbook""";

  /// `My Library`
  String get myLibrary => """My Library""";

  /// `My Campaigns`
  String get myCampaigns => """My Campaigns""";
}

class MyLibraryMessages {
  final Messages _parent;
  const MyLibraryMessages(this._parent);

  /// `My Library`
  String get title => """My Library""";

  /// `Reload Library`
  String get reload => """Reload Library""";

  /// `$cnt in $type`
  String itemCount(String cnt, String type) => """$cnt in $type""";

  /// ```dart
  /// """
  /// ${_select(type, {
  ///   'builtIn': 'Playbook',
  ///   'my': 'My Library'
  /// })}
  /// """
  /// ```
  String libraryType(String type) =>
      """${_select(type, {'builtIn': 'Playbook', 'my': 'My Library'})}""";

  /// `Already added`
  String get alreadyAdded => """Already added""";
  ItemTabMyLibraryMessages get itemTab => ItemTabMyLibraryMessages(this);
  EmptyStateMyLibraryMessages get emptyState =>
      EmptyStateMyLibraryMessages(this);
  FiltersMyLibraryMessages get filters => FiltersMyLibraryMessages(this);
}

class ItemTabMyLibraryMessages {
  final MyLibraryMessages _parent;
  const ItemTabMyLibraryMessages(this._parent);

  /// `Playbook`
  String get playbook => """Playbook""";

  /// `Online`
  String get online => """Online""";
}

class EmptyStateMyLibraryMessages {
  final MyLibraryMessages _parent;
  const EmptyStateMyLibraryMessages(this._parent);

  /// `No $ent found`
  String title(String ent) => """No $ent found""";
  SubtitleEmptyStateMyLibraryMessages get subtitle =>
      SubtitleEmptyStateMyLibraryMessages(this);
}

class SubtitleEmptyStateMyLibraryMessages {
  final EmptyStateMyLibraryMessages _parent;
  const SubtitleEmptyStateMyLibraryMessages(this._parent);

  /// `No $ent found in this list.`
  String filters(String ent) => """No $ent found in this list.""";

  /// `Try changing the search or filters to find more $ent.`
  String noFilters(String ent) =>
      """Try changing the search or filters to find more $ent.""";
}

class FiltersMyLibraryMessages {
  final MyLibraryMessages _parent;
  const FiltersMyLibraryMessages(this._parent);

  /// `Clear Filters`
  String get clear => """Clear Filters""";
}

class NavMessages {
  final Messages _parent;
  const NavMessages(this._parent);

  /// `Use`
  String get actions => """Use""";

  /// `Character`
  String get character => """Character""";

  /// `Journal`
  String get journal => """Journal""";
}

class SyncMessages {
  final Messages _parent;
  const SyncMessages(this._parent);
  EntitySyncMessages get entity => EntitySyncMessages(this);
}

class EntitySyncMessages {
  final SyncMessages _parent;
  const EntitySyncMessages(this._parent);
  StatusEntitySyncMessages get status => StatusEntitySyncMessages(this);
}

class StatusEntitySyncMessages {
  final EntitySyncMessages _parent;
  const StatusEntitySyncMessages(this._parent);

  /// `This $ent is In Sync with its linked library item`
  String inSync(String ent) =>
      """This $ent is In Sync with its linked library item""";

  /// `This $ent is Out of Sync with its linked library item`
  String outOfSync(String ent) =>
      """This $ent is Out of Sync with its linked library item""";

  /// `This $ent is not linked to any library item`
  String detached(String ent) =>
      """This $ent is not linked to any library item""";
}

class SettingsMessages {
  final Messages _parent;
  const SettingsMessages(this._parent);

  /// `Settings`
  String get title => """Settings""";

  /// `Export/Import`
  String get importExport => """Export/Import""";

  /// `Switch to ${mode} Mode`
  String _switchMode(String mode) => """Switch to ${mode} Mode""";

  /// `${_switchMode('Dark')}`
  String get switchToDark => """${_switchMode('Dark')}""";

  /// `${_switchMode('Light')}`
  String get switchToLight => """${_switchMode('Light')}""";
  CategoriesSettingsMessages get categories => CategoriesSettingsMessages(this);

  /// `Keep screen awake while using the app`
  String get keepAwake => """Keep screen awake while using the app""";
  DefaultThemeSettingsMessages get defaultTheme =>
      DefaultThemeSettingsMessages(this);
}

class CategoriesSettingsMessages {
  final SettingsMessages _parent;
  const CategoriesSettingsMessages(this._parent);

  /// `General`
  String get general => """General""";
}

class DefaultThemeSettingsMessages {
  final SettingsMessages _parent;
  const DefaultThemeSettingsMessages(this._parent);

  /// `Default $type theme`
  String _p(String type) => """Default $type theme""";

  /// `${_p('light')}`
  String get light => """${_p('light')}""";

  /// `${_p('dark')}`
  String get dark => """${_p('dark')}""";
}

class UserMessages {
  final Messages _parent;
  const UserMessages(this._parent);

  /// `Recent Characters`
  String get recentCharacters => """Recent Characters""";
}

class AuthMessages {
  final Messages _parent;
  const AuthMessages(this._parent);

  /// `OR`
  String get orSeparator => """OR""";

  /// `Privacy Policy`
  String get privacyPolicy => """Privacy Policy""";

  /// `What's new?`
  String get changelog => """What's new?""";
  ProvidersAuthMessages get providers => ProvidersAuthMessages(this);
  ConfirmUnlinkAuthMessages get confirmUnlink =>
      ConfirmUnlinkAuthMessages(this);
  LoginAuthMessages get login => LoginAuthMessages(this);
  LogoutAuthMessages get logout => LogoutAuthMessages(this);
  SignupAuthMessages get signup => SignupAuthMessages(this);
}

class ProvidersAuthMessages {
  final AuthMessages _parent;
  const ProvidersAuthMessages(this._parent);

  /// `Sign in with $provider`
  String loginWith(String provider) => """Sign in with $provider""";

  /// `Sign up with $provider`
  String signupWith(String provider) => """Sign up with $provider""";

  /// `This device only supports unlinking $provider accounts.`
  String unusable(String provider) =>
      """This device only supports unlinking $provider accounts.""";

  /// ```dart
  /// """
  /// ${_select(provider, {
  /// 'facebook': 'Facebook',
  /// 'google': 'Google',
  /// 'apple': 'Apple',
  /// 'password': 'Dungeon Paper',
  /// }, other: 'Other')}
  /// """
  /// ```
  String name(String provider) => """${_select(provider, {
        'facebook': 'Facebook',
        'google': 'Google',
        'apple': 'Apple',
        'password': 'Dungeon Paper',
      }, other: 'Other')}""";

  /// `Unlink`
  String get unlink => """Unlink""";

  /// `Link`
  String get link => """Link""";
}

class ConfirmUnlinkAuthMessages {
  final AuthMessages _parent;
  const ConfirmUnlinkAuthMessages(this._parent);

  /// `Unlink from $ent`
  String title(String ent) => """Unlink from $ent""";

  /// `Are you sure you want to unlink your account from $ent?\nBy clicking "Unlink", you will no longer be able to sign in with $ent.\n\nYou will be able to re-link your account at any time by going to your account settings.`
  String body(String ent) =>
      """Are you sure you want to unlink your account from $ent?\nBy clicking "Unlink", you will no longer be able to sign in with $ent.\n\nYou will be able to re-link your account at any time by going to your account settings.""";
}

class LoginAuthMessages {
  final AuthMessages _parent;
  const LoginAuthMessages(this._parent);

  /// `Sign In`
  String get title => """Sign In""";

  /// `Sign in to your account to sync your data online, and get access to many more features.`
  String get subtitle =>
      """Sign in to your account to sync your data online, and get access to many more features.""";

  /// `Sign in`
  String get button => """Sign in""";
  NoAccountLoginAuthMessages get noAccount => NoAccountLoginAuthMessages(this);
}

class NoAccountLoginAuthMessages {
  final LoginAuthMessages _parent;
  const NoAccountLoginAuthMessages(this._parent);

  /// `Don't have an account?`
  String get label => """Don't have an account?""";

  /// `Sign up`
  String get button => """Sign up""";
}

class LogoutAuthMessages {
  final AuthMessages _parent;
  const LogoutAuthMessages(this._parent);

  /// `Sign out`
  String get button => """Sign out""";
}

class SignupAuthMessages {
  final AuthMessages _parent;
  const SignupAuthMessages(this._parent);

  /// `Sign Up`
  String get title => """Sign Up""";

  /// `Enter the required details below to create your Dungeon Paper account.`
  String get subtitle =>
      """Enter the required details below to create your Dungeon Paper account.""";

  /// `Sign up`
  String get button => """Sign up""";
  NotLoggedInSignupAuthMessages get notLoggedIn =>
      NotLoggedInSignupAuthMessages(this);
  EmailSignupAuthMessages get email => EmailSignupAuthMessages(this);
  PasswordSignupAuthMessages get password => PasswordSignupAuthMessages(this);
}

class NotLoggedInSignupAuthMessages {
  final SignupAuthMessages _parent;
  const NotLoggedInSignupAuthMessages(this._parent);

  /// `Not logged in`
  String get label => """Not logged in""";
}

class EmailSignupAuthMessages {
  final SignupAuthMessages _parent;
  const EmailSignupAuthMessages(this._parent);

  /// `Email`
  String get label => """Email""";

  /// `Enter your email`
  String get placeholder => """Enter your email""";

  /// `Please enter a valid email address`
  String get error => """Please enter a valid email address""";
}

class PasswordSignupAuthMessages {
  final SignupAuthMessages _parent;
  const PasswordSignupAuthMessages(this._parent);

  /// `Password`
  String get label => """Password""";

  /// `Enter a password`
  String get placeholder => """Enter a password""";
  ConfirmPasswordSignupAuthMessages get confirm =>
      ConfirmPasswordSignupAuthMessages(this);
}

class ConfirmPasswordSignupAuthMessages {
  final PasswordSignupAuthMessages _parent;
  const ConfirmPasswordSignupAuthMessages(this._parent);

  /// `Confirm Password`
  String get label => """Confirm Password""";

  /// `Enter the same password again`
  String get placeholder => """Enter the same password again""";

  /// `Passwords do not match`
  String get error => """Passwords do not match""";
}

class HomeMessages {
  final Messages _parent;
  const HomeMessages(this._parent);
  BarsHomeMessages get bars => BarsHomeMessages(this);
  CategoriesHomeMessages get categories => CategoriesHomeMessages(this);
  SummaryHomeMessages get summary => SummaryHomeMessages(this);
  MenuHomeMessages get menu => MenuHomeMessages(this);
  EmptyStateHomeMessages get emptyState => EmptyStateHomeMessages(this);
}

class BarsHomeMessages {
  final HomeMessages _parent;
  const BarsHomeMessages(this._parent);

  /// `XP`
  String get xp => """XP""";

  /// `HP`
  String get hp => """HP""";
}

class CategoriesHomeMessages {
  final HomeMessages _parent;
  const CategoriesHomeMessages(this._parent);

  /// `Bookmarked Notes`
  String get notes => """Bookmarked Notes""";

  /// `Favorite Moves`
  String get moves => """Favorite Moves""";

  /// `Prepared Spells`
  String get spells => """Prepared Spells""";

  /// `Equipped Items`
  String get items => """Equipped Items""";
}

class SummaryHomeMessages {
  final HomeMessages _parent;
  const SummaryHomeMessages(this._parent);
  LoadSummaryHomeMessages get load => LoadSummaryHomeMessages(this);
  CoinsSummaryHomeMessages get coins => CoinsSummaryHomeMessages(this);
}

class LoadSummaryHomeMessages {
  final SummaryHomeMessages _parent;
  const LoadSummaryHomeMessages(this._parent);

  /// `Load: $cur/$max`
  String label(int cur, int max) => """Load: $cur/$max""";

  /// `Max Load`
  String get tooltip => """Max Load""";
}

class CoinsSummaryHomeMessages {
  final SummaryHomeMessages _parent;
  const CoinsSummaryHomeMessages(this._parent);

  /// `$amt G`
  String label(String amt) => """$amt G""";

  /// `Coins`
  String get tooltip => """Coins""";
}

class MenuHomeMessages {
  final HomeMessages _parent;
  const MenuHomeMessages(this._parent);
  CharacterMenuHomeMessages get character => CharacterMenuHomeMessages(this);

  /// `Character Biography`
  String get bio => """Character Biography""";

  /// `Debilities`
  String get debilities => """Debilities""";
}

class CharacterMenuHomeMessages {
  final MenuHomeMessages _parent;
  const CharacterMenuHomeMessages(this._parent);

  /// `Character Menu`
  String get tooltip => """Character Menu""";

  /// `Basic Information`
  String get basicInfo => """Basic Information""";

  /// `Ability Scores`
  String get abilityScores => """Ability Scores""";

  /// `Quick-Roll Buttons`
  String get customRolls => """Quick-Roll Buttons""";

  /// `Character Theme`
  String get theme => """Character Theme""";
}

class EmptyStateHomeMessages {
  final HomeMessages _parent;
  const EmptyStateHomeMessages(this._parent);
  GuestEmptyStateHomeMessages get guest => GuestEmptyStateHomeMessages(this);

  /// `No Characters`
  String get title => """No Characters""";

  /// `Create a Character to get started`
  String get subtitle => """Create a Character to get started""";
}

class GuestEmptyStateHomeMessages {
  final EmptyStateHomeMessages _parent;
  const GuestEmptyStateHomeMessages(this._parent);

  /// `Sign in to get more features`
  String get title => """Sign in to get more features""";

  /// `Online data sync, library sharing, campaigns and more!`
  String get subtitle =>
      """Online data sync, library sharing, campaigns and more!""";
}

class AboutMessages {
  final Messages _parent;
  const AboutMessages(this._parent);

  /// `About`
  String get title => """About""";

  /// `Version $version`
  String version(String version) => """Version $version""";

  /// `Copyright © 2018-$year`
  String copyright(int year) => """Copyright © 2018-$year""";

  /// `Chen Asraf`
  String get author => """Chen Asraf""";
  DiscordAboutMessages get discord => DiscordAboutMessages(this);
  FeedbackAboutMessages get feedback => FeedbackAboutMessages(this);
  SocialsAboutMessages get socials => SocialsAboutMessages(this);

  /// `Special Thanks`
  String get specialThanks => """Special Thanks""";

  /// `Contributors`
  String get contributors => """Contributors""";

  /// `Icon Credits`
  String get icons => """Icon Credits""";
}

class DiscordAboutMessages {
  final AboutMessages _parent;
  const DiscordAboutMessages(this._parent);

  /// `Join Our Discord`
  String get title => """Join Our Discord""";

  /// `Join the Discord community to ask questions, get help, send feedback, or just chat with other players.`
  String get subtitle =>
      """Join the Discord community to ask questions, get help, send feedback, or just chat with other players.""";
}

class FeedbackAboutMessages {
  final AboutMessages _parent;
  const FeedbackAboutMessages(this._parent);

  /// `Send Feedback`
  String get title => """Send Feedback""";

  /// `We reply more promptly through Discord, but you can send us feedback, bug reports or suggestions about the app directly here as an alternative.`
  String get subtitle =>
      """We reply more promptly through Discord, but you can send us feedback, bug reports or suggestions about the app directly here as an alternative.""";
}

class SocialsAboutMessages {
  final AboutMessages _parent;
  const SocialsAboutMessages(this._parent);

  /// `Links`
  String get title => """Links""";

  /// `Twitter`
  String get twitter => """Twitter""";

  /// `Facebook`
  String get facebook => """Facebook""";

  /// `Discord`
  String get discord => """Discord""";

  /// `GitHub`
  String get github => """GitHub""";

  /// `Play Store`
  String get google => """Play Store""";

  /// `App Store`
  String get apple => """App Store""";
}

class CharacterMessages {
  final Messages _parent;
  const CharacterMessages(this._parent);
  DataCharacterMessages get data => DataCharacterMessages(this);
  HeaderCharacterMessages get header => HeaderCharacterMessages(this);

  /// `No Category`
  String get noCategory => """No Category""";
  ThemeCharacterMessages get theme => ThemeCharacterMessages(this);
}

class DataCharacterMessages {
  final CharacterMessages _parent;
  const DataCharacterMessages(this._parent);

  /// `Coins`
  String get coins => """Coins""";
  LoadDataCharacterMessages get load => LoadDataCharacterMessages(this);

  /// `Level`
  String get level => """Level""";

  /// `Damage Dice`
  String get damageDice => """Damage Dice""";

  /// `Use damage dice from class & equipped items`
  String get calculateDamage =>
      """Use damage dice from class & equipped items""";
}

class LoadDataCharacterMessages {
  final DataCharacterMessages _parent;
  const LoadDataCharacterMessages(this._parent);

  /// `Load`
  String get load => """Load""";

  /// `Max Load`
  String get maxLoad => """Max Load""";

  /// `Use class base load + STR mod`
  String get autoMaxLoad => """Use class base load + STR mod""";
}

class HeaderCharacterMessages {
  final CharacterMessages _parent;
  const HeaderCharacterMessages(this._parent);

  /// `Level $lv`
  String level(int lv) => """Level $lv""";

  /// `$name`
  String characterClass(String name) => """$name""";

  /// `$name`
  String race(String name) => """$name""";

  /// `$alignment`
  String alignment(String alignment) => """$alignment""";

  /// ` ∙ `
  String get separator => """ ∙ """;
}

class ThemeCharacterMessages {
  final CharacterMessages _parent;
  const ThemeCharacterMessages(this._parent);

  /// `Character Theme`
  String get title => """Character Theme""";

  /// `Default $type theme`
  String _defaultTheme(String type) => """Default $type theme""";

  /// `${_defaultTheme('light')}`
  String get defaultLight => """${_defaultTheme('light')}""";

  /// `${_defaultTheme('dark')}`
  String get defaultDark => """${_defaultTheme('dark')}""";
}

class CharacterClassMessages {
  final Messages _parent;
  const CharacterClassMessages(this._parent);

  /// `Base Load`
  String get baseLoad => """Base Load""";

  /// `Base HP`
  String get baseHp => """Base HP""";

  /// `Damage Dice`
  String get damageDice => """Damage Dice""";
}

class DiceMessages {
  final Messages _parent;
  const DiceMessages(this._parent);

  /// `Suggested: $dice`
  String suggestion(String dice) => """Suggested: $dice""";
  FormDiceMessages get form => FormDiceMessages(this);
  RollDiceMessages get roll => RollDiceMessages(this);
}

class FormDiceMessages {
  final DiceMessages _parent;
  const FormDiceMessages(this._parent);

  /// `Amount`
  String get amount => """Amount""";

  /// `Sides`
  String get sides => """Sides""";

  /// `d`
  String get diceSeparator => """d""";
  ModifierTypeFormDiceMessages get modifierType =>
      ModifierTypeFormDiceMessages(this);
  ValueFormDiceMessages get value => ValueFormDiceMessages(this);
  ModifierFormDiceMessages get modifier => ModifierFormDiceMessages(this);

  /// `$name ($key)`
  String statValue(String name, String key) => """$name ($key)""";
}

class ModifierTypeFormDiceMessages {
  final FormDiceMessages _parent;
  const ModifierTypeFormDiceMessages(this._parent);

  /// `Fixed Value`
  String get fixed => """Fixed Value""";

  /// `Stat Mod.`
  String get modifier => """Stat Mod.""";
}

class ValueFormDiceMessages {
  final FormDiceMessages _parent;
  const ValueFormDiceMessages(this._parent);

  /// `Number, e.g. 2 or -1`
  String get placeholder => """Number, e.g. 2 or -1""";

  /// `Modifier value`
  String get label => """Modifier value""";
}

class ModifierFormDiceMessages {
  final FormDiceMessages _parent;
  const ModifierFormDiceMessages(this._parent);

  /// `Select stat`
  String get placeholder => """Select stat""";

  /// `Stat`
  String get label => """Stat""";
}

class RollDiceMessages {
  final DiceMessages _parent;
  const RollDiceMessages(this._parent);
  TitleRollDiceMessages get title => TitleRollDiceMessages(this);

  /// `Roll`
  String get action => """Roll""";

  /// `Total $amt`
  String total(int amt) => """Total $amt""";

  /// `Dice: $dice | Modifier: $mod`
  String resultBreakdown(String dice, String mod) =>
      """Dice: $dice | Modifier: $mod""";
}

class TitleRollDiceMessages {
  final RollDiceMessages _parent;
  const TitleRollDiceMessages(this._parent);

  /// `Rolled $total`
  String rolled(int total) => """Rolled $total""";

  /// `Rolling $amt ${_plural(amt, one: 'die', many: 'dice')}`
  String rolling(int amt) =>
      """Rolling $amt ${_plural(amt, one: 'die', many: 'dice')}""";
}

class BasicInfoMessages {
  final Messages _parent;
  const BasicInfoMessages(this._parent);

  /// `Basic Information`
  String get title => """Basic Information""";
  FormBasicInfoMessages get form => FormBasicInfoMessages(this);
}

class FormBasicInfoMessages {
  final BasicInfoMessages _parent;
  const FormBasicInfoMessages(this._parent);
  NameFormBasicInfoMessages get name => NameFormBasicInfoMessages(this);
  PhotoFormBasicInfoMessages get photo => PhotoFormBasicInfoMessages(this);
}

class NameFormBasicInfoMessages {
  final FormBasicInfoMessages _parent;
  const NameFormBasicInfoMessages(this._parent);

  /// `Character Name`
  String get label => """Character Name""";

  /// `Enter your character's name`
  String get placeholder => """Enter your character's name""";
  RandomNameFormBasicInfoMessages get random =>
      RandomNameFormBasicInfoMessages(this);
}

class RandomNameFormBasicInfoMessages {
  final NameFormBasicInfoMessages _parent;
  const RandomNameFormBasicInfoMessages(this._parent);
  TooltipRandomNameFormBasicInfoMessages get tooltip =>
      TooltipRandomNameFormBasicInfoMessages(this);
}

class TooltipRandomNameFormBasicInfoMessages {
  final RandomNameFormBasicInfoMessages _parent;
  const TooltipRandomNameFormBasicInfoMessages(this._parent);

  /// `$act to generate a random name`
  String _p(String act) => """$act to generate a random name""";

  /// `${_p('Tap')}`
  String get touch => """${_p('Tap')}""";

  /// `${_p('Click')}`
  String get click => """${_p('Click')}""";
}

class PhotoFormBasicInfoMessages {
  final FormBasicInfoMessages _parent;
  const PhotoFormBasicInfoMessages(this._parent);

  /// `Change Photo...`
  String get change => """Change Photo...""";

  /// `Remove Photo`
  String get remove => """Remove Photo""";

  /// `Choose Photo...`
  String get choose => """Choose Photo...""";
  GuestPhotoFormBasicInfoMessages get guest =>
      GuestPhotoFormBasicInfoMessages(this);

  /// `UPLOADING...`
  String get uploading => """UPLOADING...""";

  /// `OR`
  String get orSeparator => """OR""";
  UrlPhotoFormBasicInfoMessages get url => UrlPhotoFormBasicInfoMessages(this);
}

class GuestPhotoFormBasicInfoMessages {
  final PhotoFormBasicInfoMessages _parent;
  const GuestPhotoFormBasicInfoMessages(this._parent);

  /// `You need to be signed in to upload images. `
  String get prefix => """You need to be signed in to upload images. """;

  /// `Sign in or create an account`
  String get label => """Sign in or create an account""";

  /// `, or upload using your own URL below.`
  String get suffix => """, or upload using your own URL below.""";
}

class UrlPhotoFormBasicInfoMessages {
  final PhotoFormBasicInfoMessages _parent;
  const UrlPhotoFormBasicInfoMessages(this._parent);

  /// `Image URL`
  String get label => """Image URL""";

  /// `Paste an image URL`
  String get placeholder => """Paste an image URL""";
}

class DebilitiesMessages {
  final Messages _parent;
  const DebilitiesMessages(this._parent);

  /// `$name ($key)`
  String label(String name, String key) => """$name ($key)""";
  DialogDebilitiesMessages get dialog => DialogDebilitiesMessages(this);
}

class DialogDebilitiesMessages {
  final DebilitiesMessages _parent;
  const DialogDebilitiesMessages(this._parent);

  /// `Debilities`
  String get title => """Debilities""";

  /// `Debilities are temporary, negative conditions or states in which your character is in. When a stat is debilitated, it causes its modifier to be reduced by 1 until recovered.`
  String get info =>
      """Debilities are temporary, negative conditions or states in which your character is in. When a stat is debilitated, it causes its modifier to be reduced by 1 until recovered.""";
}

class TagsMessages {
  final Messages _parent;
  const TagsMessages(this._parent);

  /// `Copy from: $name`
  String copyFrom(String name) => """Copy from: $name""";
  DialogTagsMessages get dialog => DialogTagsMessages(this);
}

class DialogTagsMessages {
  final TagsMessages _parent;
  const DialogTagsMessages(this._parent);

  /// `Tag Information`
  String get title => """Tag Information""";
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
  ExitConfirmationsDialogsMessages get exit =>
      ExitConfirmationsDialogsMessages(this);
  DeleteAccountConfirmationsDialogsMessages get deleteAccount =>
      DeleteAccountConfirmationsDialogsMessages(this);
}

class DeleteConfirmationsDialogsMessages {
  final ConfirmationsDialogsMessages _parent;
  const DeleteConfirmationsDialogsMessages(this._parent);

  /// `Delete $ent?`
  String title(String ent) => """Delete $ent?""";

  /// `Are you sure you want to remove the $ent "$name" from the list?`
  String body(String ent, String name) =>
      """Are you sure you want to remove the $ent "$name" from the list?""";
}

class ExitConfirmationsDialogsMessages {
  final ConfirmationsDialogsMessages _parent;
  const ExitConfirmationsDialogsMessages(this._parent);

  /// `Are you sure?`
  String get title => """Are you sure?""";

  /// `Going back will lose any unsaved changes.\nAre you sure you want to go back?`
  String get body =>
      """Going back will lose any unsaved changes.\nAre you sure you want to go back?""";

  /// `Exit & Discard`
  String get ok => """Exit & Discard""";

  /// `Continue editing`
  String get cancel => """Continue editing""";
}

class DeleteAccountConfirmationsDialogsMessages {
  final ConfirmationsDialogsMessages _parent;
  const DeleteAccountConfirmationsDialogsMessages(this._parent);
  Step1DeleteAccountConfirmationsDialogsMessages get step1 =>
      Step1DeleteAccountConfirmationsDialogsMessages(this);
  Step2DeleteAccountConfirmationsDialogsMessages get step2 =>
      Step2DeleteAccountConfirmationsDialogsMessages(this);
}

class Step1DeleteAccountConfirmationsDialogsMessages {
  final DeleteAccountConfirmationsDialogsMessages _parent;
  const Step1DeleteAccountConfirmationsDialogsMessages(this._parent);

  /// `Delete Your Account?`
  String get title => """Delete Your Account?""";

  /// `Are you sure you want to delete your account?\n\nThis action cannot be undone.`
  String get body =>
      """Are you sure you want to delete your account?\n\nThis action cannot be undone.""";
}

class Step2DeleteAccountConfirmationsDialogsMessages {
  final DeleteAccountConfirmationsDialogsMessages _parent;
  const Step2DeleteAccountConfirmationsDialogsMessages(this._parent);

  /// `Are you really sure?`
  String get title => """Are you really sure?""";

  /// `We do not save any data for deleted accounts. All your data will be permanently deleted.\n\nAre you sure you want to delete your account?\n\nPlease confirm this one last time.`
  String get body =>
      """We do not save any data for deleted accounts. All your data will be permanently deleted.\n\nAre you sure you want to delete your account?\n\nPlease confirm this one last time.""";
}

class MovesMessages {
  final Messages _parent;
  const MovesMessages(this._parent);
  CategoryMovesMessages get category => CategoryMovesMessages(this);
}

class CategoryMovesMessages {
  final MovesMessages _parent;
  const CategoryMovesMessages(this._parent);

  /// ```dart
  /// """
  /// ${_select(cat, {
  ///   'starting': 'Starting',
  ///   'basic': 'Basic',
  ///   'special': 'Special',
  ///   'advanced1': 'Advanced',
  ///   'advanced2': 'Advanced',
  /// }, other: 'Other')}
  /// """
  /// ```
  String shortName(String cat) => """${_select(cat, {
        'starting': 'Starting',
        'basic': 'Basic',
        'special': 'Special',
        'advanced1': 'Advanced',
        'advanced2': 'Advanced',
      }, other: 'Other')}""";

  /// ```dart
  /// """
  /// ${_select(cat, {
  ///   'starting': 'Starting',
  ///   'basic': 'Basic',
  ///   'special': 'Special',
  ///   'advanced1': 'Advanced (1-5)',
  ///   'advanced2': 'Advanced (6-10)',
  /// }, other: 'Other')}
  /// """
  /// ```
  String mediumName(String cat) => """${_select(cat, {
        'starting': 'Starting',
        'basic': 'Basic',
        'special': 'Special',
        'advanced1': 'Advanced (1-5)',
        'advanced2': 'Advanced (6-10)',
      }, other: 'Other')}""";

  /// ```dart
  /// """
  /// ${_select(cat, {
  ///   'starting': 'Starting',
  ///   'basic': 'Basic',
  ///   'special': 'Special',
  ///   'advanced1': 'Advanced (level 1-5)',
  ///   'advanced2': 'Advanced (level 6-10)',
  /// }, other: 'Other')}
  /// """
  /// ```
  String longName(String cat) => """${_select(cat, {
        'starting': 'Starting',
        'basic': 'Basic',
        'special': 'Special',
        'advanced1': 'Advanced (level 1-5)',
        'advanced2': 'Advanced (level 6-10)',
      }, other: 'Other')}""";
}

class SpellsMessages {
  final Messages _parent;
  const SpellsMessages(this._parent);

  /// ```dart
  /// """
  /// ${_select(level, {
  ///   'rote': 'Rote',
  ///   'cantrip': 'Cantrip',
  /// }, other: 'Level $level')}
  /// """
  /// ```
  String spellLevel(String level) => """${_select(level, {
        'rote': 'Rote',
        'cantrip': 'Cantrip',
      }, other: 'Level $level')}""";
}

class ItemsMessages {
  final Messages _parent;
  const ItemsMessages(this._parent);

  /// `× $amt`
  String amount(String amt) => """× $amt""";

  /// `Amount`
  String get amountTooltip => """Amount""";
  SettingsItemsMessages get settings => SettingsItemsMessages(this);
}

class SettingsItemsMessages {
  final ItemsMessages _parent;
  const SettingsItemsMessages(this._parent);

  /// `Count Armor`
  String get countArmor => """Count Armor""";

  /// `Count Damage`
  String get countDamage => """Count Damage""";

  /// `Count Weight`
  String get countWeight => """Count Weight""";
}

class NotesMessages {
  final Messages _parent;
  const NotesMessages(this._parent);

  /// `General`
  String get noCategory => """General""";
}

class AlignmentMessages {
  final Messages _parent;
  const AlignmentMessages(this._parent);

  /// ```dart
  /// """
  /// ${_select(key, {
  ///   'chaotic': 'Chaotic',
  ///   'evil': 'Evil',
  ///   'good': 'Good',
  ///   'lawful': 'Lawful',
  ///   'neutral': 'Neutral',
  /// })}
  /// """
  /// ```
  String name(String key) => """${_select(key, {
            'chaotic': 'Chaotic',
            'evil': 'Evil',
            'good': 'Good',
            'lawful': 'Lawful',
            'neutral': 'Neutral',
          })}""";
}

class BioMessages {
  final Messages _parent;
  const BioMessages(this._parent);
  DialogBioMessages get dialog => DialogBioMessages(this);
}

class DialogBioMessages {
  final BioMessages _parent;
  const DialogBioMessages(this._parent);

  /// `Character Biography`
  String get title => """Character Biography""";
  DescriptionDialogBioMessages get description =>
      DescriptionDialogBioMessages(this);
  LooksDialogBioMessages get looks => LooksDialogBioMessages(this);
  AlignmentDialogBioMessages get alignment => AlignmentDialogBioMessages(this);
  AlignmentDescriptionDialogBioMessages get alignmentDescription =>
      AlignmentDescriptionDialogBioMessages(this);
}

class DescriptionDialogBioMessages {
  final DialogBioMessages _parent;
  const DescriptionDialogBioMessages(this._parent);

  /// `Character & background description`
  String get label => """Character & background description""";

  /// `Describe your character's background, personality, goals, etc.`
  String get placeholder =>
      """Describe your character's background, personality, goals, etc.""";
}

class LooksDialogBioMessages {
  final DialogBioMessages _parent;
  const LooksDialogBioMessages(this._parent);

  /// `Appearance`
  String get label => """Appearance""";

  /// `Describe your character's appearance. You may use the presets from the buttons above.`
  String get placeholder =>
      """Describe your character's appearance. You may use the presets from the buttons above.""";
}

class AlignmentDialogBioMessages {
  final DialogBioMessages _parent;
  const AlignmentDialogBioMessages(this._parent);

  /// `Alignment`
  String get label => """Alignment""";
}

class AlignmentDescriptionDialogBioMessages {
  final DialogBioMessages _parent;
  const AlignmentDescriptionDialogBioMessages(this._parent);

  /// `Alignment Description`
  String get label => """Alignment Description""";

  /// `Alignment is your character's way of thinking and moral compass. This can center on an ethical ideal, religious strictures or early life events. It reflects what your character values and aspires to protect or create.`
  String get placeholder =>
      """Alignment is your character's way of thinking and moral compass. This can center on an ethical ideal, religious strictures or early life events. It reflects what your character values and aspires to protect or create.""";
}

class SearchMessages {
  final Messages _parent;
  const SearchMessages(this._parent);

  /// `Type to search`
  String get placeholder => """Type to search""";

  /// `Type to search $ent`
  String placeholderEntity(String ent) => """Type to search $ent""";

  /// `Search in`
  String get searchIn => """Search in""";
}

class HpMessages {
  final Messages _parent;
  const HpMessages(this._parent);
  DialogHpMessages get dialog => DialogHpMessages(this);
}

class DialogHpMessages {
  final HpMessages _parent;
  const DialogHpMessages(this._parent);

  /// `Modify HP`
  String get title => """Modify HP""";
  ChangeDialogHpMessages get change => ChangeDialogHpMessages(this);

  /// `Override Max HP`
  String get overrideMax => """Override Max HP""";
}

class ChangeDialogHpMessages {
  final DialogHpMessages _parent;
  const ChangeDialogHpMessages(this._parent);

  /// `Heal\n+$amt`
  String add(int amt) => """Heal\n+$amt""";

  /// `Damage\n-$amt`
  String remove(int amt) => """Damage\n-$amt""";

  /// `No Change`
  String get neutral => """No Change""";
}

class XpMessages {
  final Messages _parent;
  const XpMessages(this._parent);
  DialogXpMessages get dialog => DialogXpMessages(this);
}

class DialogXpMessages {
  final XpMessages _parent;
  const DialogXpMessages(this._parent);

  /// `Mark Session XP`
  String get title => """Mark Session XP""";

  /// `Update XP & Level`
  String get overridingTitle => """Update XP & Level""";
  EndOfSessionDialogXpMessages get endOfSession =>
      EndOfSessionDialogXpMessages(this);
  OverrideDialogXpMessages get override => OverrideDialogXpMessages(this);
}

class EndOfSessionDialogXpMessages {
  final DialogXpMessages _parent;
  const EndOfSessionDialogXpMessages(this._parent);

  /// `End Session`
  String get button => """End Session""";
  QuestionsEndOfSessionDialogXpMessages get questions =>
      QuestionsEndOfSessionDialogXpMessages(this);
}

class QuestionsEndOfSessionDialogXpMessages {
  final EndOfSessionDialogXpMessages _parent;
  const QuestionsEndOfSessionDialogXpMessages(this._parent);

  /// `End of Session Questions`
  String get title => """End of Session Questions""";

  /// `Answer these questions as a group. For each "yes" answer, XP is marked.`
  String get subtitle =>
      """Answer these questions as a group. For each "yes" answer, XP is marked.""";
}

class OverrideDialogXpMessages {
  final DialogXpMessages _parent;
  const OverrideDialogXpMessages(this._parent);

  /// `Update Manually`
  String get title => """Update Manually""";

  /// `Changing the current XP or level manually will cause the pending XP to be discarded unless this is unchecked.`
  String get info =>
      """Changing the current XP or level manually will cause the pending XP to be discarded unless this is unchecked.""";

  /// `Reset bonds, flags & end of session questions after saving`
  String get resetCheckbox =>
      """Reset bonds, flags & end of session questions after saving""";

  /// `Override XP`
  String get xp => """Override XP""";

  /// `Override Level`
  String get level => """Override Level""";
}

class ArmorMessages {
  final Messages _parent;
  const ArmorMessages(this._parent);

  /// `Armor`
  String get title => """Armor""";
  DialogArmorMessages get dialog => DialogArmorMessages(this);
}

class DialogArmorMessages {
  final ArmorMessages _parent;
  const DialogArmorMessages(this._parent);

  /// `Armor`
  String get title => """Armor""";

  /// `Use armor from class & equipped items`
  String get autoArmor => """Use armor from class & equipped items""";
}

class RichTextMessages {
  final Messages _parent;
  const RichTextMessages(this._parent);

  /// `Preview`
  String get preview => """Preview""";

  /// `Formatting Help`
  String get help => """Formatting Help""";

  /// `Bold`
  String get bold => """Bold""";

  /// `Italic`
  String get italic => """Italic""";

  /// `Headings`
  String get headings => """Headings""";

  /// `Heading $depth`
  String heading(int depth) => """Heading $depth""";

  /// `Bullet List`
  String get bulletList => """Bullet List""";

  /// `Numbered List`
  String get numberedList => """Numbered List""";
  CheckListRichTextMessages get checkList => CheckListRichTextMessages(this);

  /// `URL`
  String get url => """URL""";

  /// `Image URL`
  String get imageURL => """Image URL""";

  /// `Table`
  String get table => """Table""";

  /// `Header $n`
  String header(Object n) => """Header $n""";

  /// `Cell $n`
  String cell(int n) => """Cell $n""";

  /// `Markdown Preview`
  String get markdownPreview => """Markdown Preview""";
}

class CheckListRichTextMessages {
  final RichTextMessages _parent;
  const CheckListRichTextMessages(this._parent);

  /// `Checklist (Unchecked)`
  String get unchecked => """Checklist (Unchecked)""";

  /// `Checklist (Checked)`
  String get checked => """Checklist (Checked)""";
}

class CustomRollsMessages {
  final Messages _parent;
  const CustomRollsMessages(this._parent);

  /// `Quick Roll Buttons`
  String get title => """Quick Roll Buttons""";

  /// `Left Button`
  String get left => """Left Button""";

  /// `Right Button`
  String get right => """Right Button""";

  /// `Button Label`
  String get buttonLabel => """Button Label""";
  SpecialDiceCustomRollsMessages get specialDice =>
      SpecialDiceCustomRollsMessages(this);
  TooltipCustomRollsMessages get tooltip => TooltipCustomRollsMessages(this);
  PresetsCustomRollsMessages get presets => PresetsCustomRollsMessages(this);
}

class SpecialDiceCustomRollsMessages {
  final CustomRollsMessages _parent;
  const SpecialDiceCustomRollsMessages(this._parent);

  /// `Special Dice`
  String get title => """Special Dice""";

  /// `${_select(btn, {'damage': 'Damage'}, other: btn)}`
  String button(String btn) =>
      """${_select(btn, {'damage': 'Damage'}, other: btn)}""";
}

class TooltipCustomRollsMessages {
  final CustomRollsMessages _parent;
  const TooltipCustomRollsMessages(this._parent);

  /// `Roll $dice\n* Rolling with debility`
  String rollNormal(String dice) => """Roll $dice\n* Rolling with debility""";

  /// `Roll $dice`
  String rollWithDebility(String dice) => """Roll $dice""";
}

class PresetsCustomRollsMessages {
  final CustomRollsMessages _parent;
  const PresetsCustomRollsMessages(this._parent);

  /// `Presets`
  String get title => """Presets""";

  /// `Basic Action`
  String get basicAction => """Basic Action""";

  /// `Hack & Slash`
  String get hackAndSlash => """Hack & Slash""";

  /// `Volley`
  String get volley => """Volley""";

  /// `Discern Realities`
  String get discernRealities => """Discern Realities""";
}

class SessionMarksMessages {
  final Messages _parent;
  const SessionMarksMessages(this._parent);

  /// `Bonds & Flags`
  String get title => """Bonds & Flags""";

  /// `Bond`
  String get bond => """Bond""";

  /// `Bonds`
  String get bonds => """Bonds""";

  /// `Flag`
  String get flag => """Flag""";

  /// `Flags`
  String get flags => """Flags""";

  /// `You have no bonds or flags. You can add some using the edit button above, then mark them off as completed as you go along your adventure.`
  String get noData =>
      """You have no bonds or flags. You can add some using the edit button above, then mark them off as completed as you go along your adventure.""";

  /// `You can add, update or remove bonds & flags using the edit icon above.`
  String get info =>
      """You can add, update or remove bonds & flags using the edit icon above.""";
  EndOfSessionSessionMarksMessages get endOfSession =>
      EndOfSessionSessionMarksMessages(this);
}

class EndOfSessionSessionMarksMessages {
  final SessionMarksMessages _parent;
  const EndOfSessionSessionMarksMessages(this._parent);

  /// `Did we learn something new and important about the world?`
  String get q1 =>
      """Did we learn something new and important about the world?""";

  /// `Did we overcome a notable monster or enemy?`
  String get q2 => """Did we overcome a notable monster or enemy?""";

  /// `Did we loot a memorable treasure?`
  String get q3 => """Did we loot a memorable treasure?""";
}

class CreateCharacterMessages {
  final Messages _parent;
  const CreateCharacterMessages(this._parent);
  CharacterClassCreateCharacterMessages get characterClass =>
      CharacterClassCreateCharacterMessages(this);
  BasicInfoCreateCharacterMessages get basicInfo =>
      BasicInfoCreateCharacterMessages(this);
  StartingGearCreateCharacterMessages get startingGear =>
      StartingGearCreateCharacterMessages(this);
  MovesSpellsCreateCharacterMessages get movesSpells =>
      MovesSpellsCreateCharacterMessages(this);
}

class CharacterClassCreateCharacterMessages {
  final CreateCharacterMessages _parent;
  const CharacterClassCreateCharacterMessages(this._parent);

  /// `No class selected (required)`
  String get noSelection => """No class selected (required)""";

  /// `Base HP: $hp, Load: $load, Damage Dice: $damageDice`
  String description(int hp, int load, String damageDice) =>
      """Base HP: $hp, Load: $load, Damage Dice: $damageDice""";
}

class BasicInfoCreateCharacterMessages {
  final CreateCharacterMessages _parent;
  const BasicInfoCreateCharacterMessages(this._parent);

  /// `Unnamed Traveler`
  String get defaultName => """Unnamed Traveler""";

  /// `Select name & picture (required)`
  String get helpText => """Select name & picture (required)""";

  /// `Level 1 $cls`
  String description(String cls) => """Level 1 $cls""";
}

class StartingGearCreateCharacterMessages {
  final CreateCharacterMessages _parent;
  const StartingGearCreateCharacterMessages(this._parent);

  /// `Select your starting gear determined by class (optional)`
  String get helpText =>
      """Select your starting gear determined by class (optional)""";

  /// `$amt ${_plural(double.tryParse(amt)?.ceil() ?? 0, one: 'coin', many: 'coins')}`
  String coins(String amt) =>
      """$amt ${_plural(double.tryParse(amt)?.ceil() ?? 0, one: 'coin', many: 'coins')}""";

  /// `$amt × $name`
  String item(String amt, String name) => """$amt × $name""";
  CountStartingGearCreateCharacterMessages get count =>
      CountStartingGearCreateCharacterMessages(this);
}

class CountStartingGearCreateCharacterMessages {
  final StartingGearCreateCharacterMessages _parent;
  const CountStartingGearCreateCharacterMessages(this._parent);

  /// `$cnt selected (class allowance: $max)`
  String withMax(int cnt, int max) =>
      """$cnt selected (class allowance: $max)""";

  /// `$cnt selected`
  String noMax(int cnt) => """$cnt selected""";
}

class MovesSpellsCreateCharacterMessages {
  final CreateCharacterMessages _parent;
  const MovesSpellsCreateCharacterMessages(this._parent);

  /// `Moves & Spells`
  String get title => """Moves & Spells""";

  /// `$moves Moves, $spells Spells selected`
  String description(int moves, int spells) =>
      """$moves Moves, $spells Spells selected""";
}

class AccountMessages {
  final Messages _parent;
  const AccountMessages(this._parent);
  DetailsAccountMessages get details => DetailsAccountMessages(this);
  ProvidersAccountMessages get providers => ProvidersAccountMessages(this);
  DeleteAccountAccountMessages get deleteAccount =>
      DeleteAccountAccountMessages(this);
}

class DetailsAccountMessages {
  final AccountMessages _parent;
  const DetailsAccountMessages(this._parent);

  /// `Account details`
  String get title => """Account details""";
  DisplayNameDetailsAccountMessages get displayName =>
      DisplayNameDetailsAccountMessages(this);
  ImageDetailsAccountMessages get image => ImageDetailsAccountMessages(this);
  EmailDetailsAccountMessages get email => EmailDetailsAccountMessages(this);
  PasswordDetailsAccountMessages get password =>
      PasswordDetailsAccountMessages(this);
}

class DisplayNameDetailsAccountMessages {
  final DetailsAccountMessages _parent;
  const DisplayNameDetailsAccountMessages(this._parent);

  /// `Change Display Name`
  String get title => """Change Display Name""";

  /// `Display name`
  String get label => """Display name""";

  /// `Enter your public display name`
  String get placeholder => """Enter your public display name""";

  /// `Display name changed successfully`
  String get success => """Display name changed successfully""";
}

class ImageDetailsAccountMessages {
  final DetailsAccountMessages _parent;
  const ImageDetailsAccountMessages(this._parent);

  /// `Change Profile Picture`
  String get title => """Change Profile Picture""";

  /// `Change your profile picture`
  String get subtitle => """Change your profile picture""";
}

class EmailDetailsAccountMessages {
  final DetailsAccountMessages _parent;
  const EmailDetailsAccountMessages(this._parent);

  /// `Change Email Address`
  String get title => """Change Email Address""";

  /// `Email address`
  String get label => """Email address""";

  /// `Enter a new email address`
  String get placeholder => """Enter a new email address""";

  /// `Email changed successfully`
  String get success => """Email changed successfully""";
}

class PasswordDetailsAccountMessages {
  final DetailsAccountMessages _parent;
  const PasswordDetailsAccountMessages(this._parent);

  /// `Change Password`
  String get title => """Change Password""";

  /// `Change your password`
  String get subtitle => """Change your password""";

  /// `Password changed successfully`
  String get success => """Password changed successfully""";

  /// `New password`
  String get label => """New password""";

  /// `Enter your new password`
  String get placeholder => """Enter your new password""";
  VisibilityPasswordDetailsAccountMessages get visibility =>
      VisibilityPasswordDetailsAccountMessages(this);
  ConfirmPasswordDetailsAccountMessages get confirm =>
      ConfirmPasswordDetailsAccountMessages(this);

  /// `Passwords do not match`
  String get error => """Passwords do not match""";
}

class VisibilityPasswordDetailsAccountMessages {
  final PasswordDetailsAccountMessages _parent;
  const VisibilityPasswordDetailsAccountMessages(this._parent);

  /// `Show password`
  String get show => """Show password""";

  /// `Hide password`
  String get hide => """Hide password""";
}

class ConfirmPasswordDetailsAccountMessages {
  final PasswordDetailsAccountMessages _parent;
  const ConfirmPasswordDetailsAccountMessages(this._parent);

  /// `Confirm New Password`
  String get label => """Confirm New Password""";

  /// `Enter the same password again`
  String get placeholder => """Enter the same password again""";
}

class ProvidersAccountMessages {
  final AccountMessages _parent;
  const ProvidersAccountMessages(this._parent);

  /// `Connected logins`
  String get title => """Connected logins""";
}

class DeleteAccountAccountMessages {
  final AccountMessages _parent;
  const DeleteAccountAccountMessages(this._parent);

  /// `Delete Your Account`
  String get title => """Delete Your Account""";

  /// `A deletion request for your account was sent successfully`
  String get success =>
      """A deletion request for your account was sent successfully""";
}

class ActionsMessages {
  final Messages _parent;
  const ActionsMessages(this._parent);
  MovesActionsMessages get moves => MovesActionsMessages(this);
}

class MovesActionsMessages {
  final ActionsMessages _parent;
  const MovesActionsMessages(this._parent);

  /// `Basic Moves`
  String get basic => """Basic Moves""";

  /// `Special Moves`
  String get special => """Special Moves""";
}

class AbilityScoresMessages {
  final Messages _parent;
  const AbilityScoresMessages(this._parent);

  /// `You can drag & drop the stat cards to change the order in which they appear throughout this character's screens.`
  String get info =>
      """You can drag & drop the stat cards to change the order in which they appear throughout this character's screens.""";
  RollButtonAbilityScoresMessages get rollButton =>
      RollButtonAbilityScoresMessages(this);
  StatsAbilityScoresMessages get stats => StatsAbilityScoresMessages(this);
  FormAbilityScoresMessages get form => FormAbilityScoresMessages(this);
}

class RollButtonAbilityScoresMessages {
  final AbilityScoresMessages _parent;
  const RollButtonAbilityScoresMessages(this._parent);

  /// `Roll +{stat}`
  String get stat => """Roll +{stat}""";

  /// `Roll random stat`
  String get randStat => """Roll random stat""";
}

class StatsAbilityScoresMessages {
  final AbilityScoresMessages _parent;
  const StatsAbilityScoresMessages(this._parent);
  BondStatsAbilityScoresMessages get bond =>
      BondStatsAbilityScoresMessages(this);
  ChaStatsAbilityScoresMessages get cha => ChaStatsAbilityScoresMessages(this);
  ConStatsAbilityScoresMessages get con => ConStatsAbilityScoresMessages(this);
  DexStatsAbilityScoresMessages get dex => DexStatsAbilityScoresMessages(this);
  StrStatsAbilityScoresMessages get str => StrStatsAbilityScoresMessages(this);
  WisStatsAbilityScoresMessages get wis => WisStatsAbilityScoresMessages(this);
  IntlStatsAbilityScoresMessages get intl =>
      IntlStatsAbilityScoresMessages(this);
}

class BondStatsAbilityScoresMessages {
  final StatsAbilityScoresMessages _parent;
  const BondStatsAbilityScoresMessages(this._parent);

  /// `Bond`
  String get name => """Bond""";

  /// `When a move has you roll+bond you'll count the number of bonds you have with the character in question and add that to the roll.`
  String get description =>
      """When a move has you roll+bond you'll count the number of bonds you have with the character in question and add that to the roll.""";
  DebilityBondStatsAbilityScoresMessages get debility =>
      DebilityBondStatsAbilityScoresMessages(this);
}

class DebilityBondStatsAbilityScoresMessages {
  final BondStatsAbilityScoresMessages _parent;
  const DebilityBondStatsAbilityScoresMessages(this._parent);

  /// `Lonely`
  String get name => """Lonely""";

  String get description => """null""";
}

class ChaStatsAbilityScoresMessages {
  final StatsAbilityScoresMessages _parent;
  const ChaStatsAbilityScoresMessages(this._parent);

  /// `Measures a character's personality, personal magnetism, ability to lead, and appearance.`
  String get description =>
      """Measures a character's personality, personal magnetism, ability to lead, and appearance.""";

  /// `Charisma`
  String get name => """Charisma""";
  DebilityChaStatsAbilityScoresMessages get debility =>
      DebilityChaStatsAbilityScoresMessages(this);
}

class DebilityChaStatsAbilityScoresMessages {
  final ChaStatsAbilityScoresMessages _parent;
  const DebilityChaStatsAbilityScoresMessages(this._parent);

  /// `Scarred`
  String get name => """Scarred""";

  /// `It may not be permanent, but for now you don't look so good.`
  String get description =>
      """It may not be permanent, but for now you don't look so good.""";
}

class ConStatsAbilityScoresMessages {
  final StatsAbilityScoresMessages _parent;
  const ConStatsAbilityScoresMessages(this._parent);

  /// `Represents your character's health and stamina.`
  String get description =>
      """Represents your character's health and stamina.""";

  /// `Constitution`
  String get name => """Constitution""";
  DebilityConStatsAbilityScoresMessages get debility =>
      DebilityConStatsAbilityScoresMessages(this);
}

class DebilityConStatsAbilityScoresMessages {
  final ConStatsAbilityScoresMessages _parent;
  const DebilityConStatsAbilityScoresMessages(this._parent);

  /// `Sick`
  String get name => """Sick""";

  /// `Something just isn't right inside. Maybe you've got a disease or a wasting illness. Maybe you just drank too much ale last night and it's coming back to haunt you.`
  String get description =>
      """Something just isn't right inside. Maybe you've got a disease or a wasting illness. Maybe you just drank too much ale last night and it's coming back to haunt you.""";
}

class DexStatsAbilityScoresMessages {
  final StatsAbilityScoresMessages _parent;
  const DexStatsAbilityScoresMessages(this._parent);

  /// `Measures agility, reflexes and balance.`
  String get description => """Measures agility, reflexes and balance.""";

  /// `Dexterity`
  String get name => """Dexterity""";
  DebilityDexStatsAbilityScoresMessages get debility =>
      DebilityDexStatsAbilityScoresMessages(this);
}

class DebilityDexStatsAbilityScoresMessages {
  final DexStatsAbilityScoresMessages _parent;
  const DebilityDexStatsAbilityScoresMessages(this._parent);

  /// `Shaky`
  String get name => """Shaky""";

  /// `You're unsteady on your feet and you've got a shake in your hands.`
  String get description =>
      """You're unsteady on your feet and you've got a shake in your hands.""";
}

class StrStatsAbilityScoresMessages {
  final StatsAbilityScoresMessages _parent;
  const StrStatsAbilityScoresMessages(this._parent);

  /// `Measures muscle and physical power.`
  String get description => """Measures muscle and physical power.""";

  /// `Strength`
  String get name => """Strength""";
  DebilityStrStatsAbilityScoresMessages get debility =>
      DebilityStrStatsAbilityScoresMessages(this);
}

class DebilityStrStatsAbilityScoresMessages {
  final StrStatsAbilityScoresMessages _parent;
  const DebilityStrStatsAbilityScoresMessages(this._parent);

  /// `Weak`
  String get name => """Weak""";

  /// `You can't exert much force. Maybe it's just fatigue and injury, or maybe your strength was drained by magic.`
  String get description =>
      """You can't exert much force. Maybe it's just fatigue and injury, or maybe your strength was drained by magic.""";
}

class WisStatsAbilityScoresMessages {
  final StatsAbilityScoresMessages _parent;
  const WisStatsAbilityScoresMessages(this._parent);

  /// `Describes a character's willpower, common sense, awareness, and intuition.`
  String get description =>
      """Describes a character's willpower, common sense, awareness, and intuition.""";

  /// `Wisdom`
  String get name => """Wisdom""";
  DebilityWisStatsAbilityScoresMessages get debility =>
      DebilityWisStatsAbilityScoresMessages(this);
}

class DebilityWisStatsAbilityScoresMessages {
  final WisStatsAbilityScoresMessages _parent;
  const DebilityWisStatsAbilityScoresMessages(this._parent);

  /// `Confused`
  String get name => """Confused""";

  /// `Ears ringing. Vision blurred. You're more than a little out of it.`
  String get description =>
      """Ears ringing. Vision blurred. You're more than a little out of it.""";
}

class IntlStatsAbilityScoresMessages {
  final StatsAbilityScoresMessages _parent;
  const IntlStatsAbilityScoresMessages(this._parent);

  /// `Determines how well your character learns and reasons.`
  String get description =>
      """Determines how well your character learns and reasons.""";

  /// `Intelligence`
  String get name => """Intelligence""";
  DebilityIntlStatsAbilityScoresMessages get debility =>
      DebilityIntlStatsAbilityScoresMessages(this);
}

class DebilityIntlStatsAbilityScoresMessages {
  final IntlStatsAbilityScoresMessages _parent;
  const DebilityIntlStatsAbilityScoresMessages(this._parent);

  /// `Stunned`
  String get name => """Stunned""";

  /// `That last knock to the head shook something loose. Brain not work so good.`
  String get description =>
      """That last knock to the head shook something loose. Brain not work so good.""";
}

class FormAbilityScoresMessages {
  final AbilityScoresMessages _parent;
  const FormAbilityScoresMessages(this._parent);

  /// `Modifier:\n$mod`
  String modifierValueLabel(String mod) => """Modifier:\n$mod""";
  DebilityDescriptionFormAbilityScoresMessages get debilityDescription =>
      DebilityDescriptionFormAbilityScoresMessages(this);
  DebilityNameFormAbilityScoresMessages get debilityName =>
      DebilityNameFormAbilityScoresMessages(this);
  DescriptionFormAbilityScoresMessages get description =>
      DescriptionFormAbilityScoresMessages(this);
  KeyFormAbilityScoresMessages get key => KeyFormAbilityScoresMessages(this);
  NameFormAbilityScoresMessages get name => NameFormAbilityScoresMessages(this);
  IconFormAbilityScoresMessages get icon => IconFormAbilityScoresMessages(this);
}

class DebilityDescriptionFormAbilityScoresMessages {
  final FormAbilityScoresMessages _parent;
  const DebilityDescriptionFormAbilityScoresMessages(this._parent);

  /// `Debility Description`
  String get label => """Debility Description""";

  /// `A description of the effect causing the debility and/or how it affects your character`
  String get description =>
      """A description of the effect causing the debility and/or how it affects your character""";
}

class DebilityNameFormAbilityScoresMessages {
  final FormAbilityScoresMessages _parent;
  const DebilityNameFormAbilityScoresMessages(this._parent);

  /// `Debility Name`
  String get label => """Debility Name""";

  /// `The name for the debility that occurs when this stat is debilitated (takes -1 until recovered).`
  String get description =>
      """The name for the debility that occurs when this stat is debilitated (takes -1 until recovered).""";
}

class DescriptionFormAbilityScoresMessages {
  final FormAbilityScoresMessages _parent;
  const DescriptionFormAbilityScoresMessages(this._parent);

  /// `Ability Score Description`
  String get label => """Ability Score Description""";

  /// `A description of what this ability score represents`
  String get description =>
      """A description of what this ability score represents""";
}

class KeyFormAbilityScoresMessages {
  final FormAbilityScoresMessages _parent;
  const KeyFormAbilityScoresMessages(this._parent);

  /// `Ability Score Key`
  String get label => """Ability Score Key""";

  /// `A 3-letter unique key that identifies this ability score in dice and is used as the short label for the modifier value (and not the actual score)`
  String get description =>
      """A 3-letter unique key that identifies this ability score in dice and is used as the short label for the modifier value (and not the actual score)""";
}

class NameFormAbilityScoresMessages {
  final FormAbilityScoresMessages _parent;
  const NameFormAbilityScoresMessages(this._parent);

  /// `Ability Score Name`
  String get label => """Ability Score Name""";

  /// `The name of this ability score`
  String get description => """The name of this ability score""";
}

class IconFormAbilityScoresMessages {
  final FormAbilityScoresMessages _parent;
  const IconFormAbilityScoresMessages(this._parent);

  /// `Icon`
  String get label => """Icon""";

  /// `Change Icon`
  String get button => """Change Icon""";
}

class FeedbackMessages {
  final Messages _parent;
  const FeedbackMessages(this._parent);

  /// `Send App Feedback`
  String get title => """Send App Feedback""";

  /// `Send`
  String get send => """Send""";
  FormFeedbackMessages get form => FormFeedbackMessages(this);
  SuccessFeedbackMessages get success => SuccessFeedbackMessages(this);
}

class FormFeedbackMessages {
  final FeedbackMessages _parent;
  const FormFeedbackMessages(this._parent);
  TitleFormFeedbackMessages get title => TitleFormFeedbackMessages(this);
  BodyFormFeedbackMessages get body => BodyFormFeedbackMessages(this);
  EmailFormFeedbackMessages get email => EmailFormFeedbackMessages(this);
}

class TitleFormFeedbackMessages {
  final FormFeedbackMessages _parent;
  const TitleFormFeedbackMessages(this._parent);

  /// `Feedback title`
  String get label => """Feedback title""";
}

class BodyFormFeedbackMessages {
  final FormFeedbackMessages _parent;
  const BodyFormFeedbackMessages(this._parent);

  /// `Problem, idea or feedback description`
  String get label => """Problem, idea or feedback description""";
}

class EmailFormFeedbackMessages {
  final FormFeedbackMessages _parent;
  const EmailFormFeedbackMessages(this._parent);

  /// `Enter your email`
  String get label => """Enter your email""";
}

class SuccessFeedbackMessages {
  final FeedbackMessages _parent;
  const SuccessFeedbackMessages(this._parent);

  /// `Feedback sent!`
  String get title => """Feedback sent!""";

  /// `Thank you for your feedback! We will review your feedback as soon as we can.`
  String get message =>
      """Thank you for your feedback! We will review your feedback as soon as we can.""";
}

class MigrationMessages {
  final Messages _parent;
  const MigrationMessages(this._parent);

  /// `Welcome to\nDungeon Paper 2!`
  String get title => """Welcome to\nDungeon Paper 2!""";

  /// `To get started, pick a username and the language for the rulebook & app. If you already have an existing Dungeon Paper account your data might take a few seconds to migrate.`
  String get subtitle =>
      """To get started, pick a username and the language for the rulebook & app. If you already have an existing Dungeon Paper account your data might take a few seconds to migrate.""";
  UsernameMigrationMessages get username => UsernameMigrationMessages(this);
  LanguageMigrationMessages get language => LanguageMigrationMessages(this);
}

class UsernameMigrationMessages {
  final MigrationMessages _parent;
  const UsernameMigrationMessages(this._parent);

  /// `Username`
  String get label => """Username""";

  /// `Pick a unique username`
  String get placeholder => """Pick a unique username""";

  /// `Your username is unique and can not be changed later, so think carefully! It will be used to identify all your library items when publishing.`
  String get info =>
      """Your username is unique and can not be changed later, so think carefully! It will be used to identify all your library items when publishing.""";
}

class LanguageMigrationMessages {
  final MigrationMessages _parent;
  const LanguageMigrationMessages(this._parent);

  /// `Default data language`
  String get data => """Default data language""";
}

class BackupMessages {
  final Messages _parent;
  const BackupMessages(this._parent);

  /// `Export/Import`
  String get title => """Export/Import""";
  ImportingBackupMessages get importing => ImportingBackupMessages(this);
  ExportingBackupMessages get exporting => ExportingBackupMessages(this);
}

class ImportingBackupMessages {
  final BackupMessages _parent;
  const ImportingBackupMessages(this._parent);

  /// `Import`
  String get title => """Import""";

  /// `Import`
  String get button => """Import""";
  ProgressImportingBackupMessages get progress =>
      ProgressImportingBackupMessages(this);
  FileImportingBackupMessages get file => FileImportingBackupMessages(this);
  SuccessImportingBackupMessages get success =>
      SuccessImportingBackupMessages(this);
  ErrorImportingBackupMessages get error => ErrorImportingBackupMessages(this);
}

class ProgressImportingBackupMessages {
  final ImportingBackupMessages _parent;
  const ProgressImportingBackupMessages(this._parent);

  /// `Importing...`
  String get title => """Importing...""";

  /// `Processing $ent...`
  String processing(String ent) => """Processing $ent...""";
}

class FileImportingBackupMessages {
  final ImportingBackupMessages _parent;
  const FileImportingBackupMessages(this._parent);

  /// `Browse...`
  String get browse => """Browse...""";

  /// `Clear selected file`
  String get clearFile => """Clear selected file""";

  /// `To start importing, pick the file you want to import from.\nYou will then be able to select what to save and what to leave out.`
  String get info =>
      """To start importing, pick the file you want to import from.\nYou will then be able to select what to save and what to leave out.""";
}

class SuccessImportingBackupMessages {
  final ImportingBackupMessages _parent;
  const SuccessImportingBackupMessages(this._parent);

  /// `Import Successful`
  String get title => """Import Successful""";

  /// `Your data was imported from file successfully`
  String get message => """Your data was imported from file successfully""";
}

class ErrorImportingBackupMessages {
  final ImportingBackupMessages _parent;
  const ErrorImportingBackupMessages(this._parent);

  /// `Import Failed`
  String get title => """Import Failed""";

  /// `Something went wrong.\nTry again or contact support if this persists`
  String get message =>
      """Something went wrong.\nTry again or contact support if this persists""";
}

class ExportingBackupMessages {
  final BackupMessages _parent;
  const ExportingBackupMessages(this._parent);

  /// `Export`
  String get title => """Export""";

  /// `Export`
  String get button => """Export""";
  ErrorExportingBackupMessages get error => ErrorExportingBackupMessages(this);
  SuccessExportingBackupMessages get success =>
      SuccessExportingBackupMessages(this);
}

class ErrorExportingBackupMessages {
  final ExportingBackupMessages _parent;
  const ErrorExportingBackupMessages(this._parent);

  /// `Export Failed`
  String get title => """Export Failed""";

  /// `Something went wrong.\nTry again or contact support if this persists`
  String get message =>
      """Something went wrong.\nTry again or contact support if this persists""";
}

class SuccessExportingBackupMessages {
  final ExportingBackupMessages _parent;
  const SuccessExportingBackupMessages(this._parent);

  /// `Export Successful`
  String get title => """Export Successful""";

  /// `Your data was exported to file successfully`
  String get message => """Your data was exported to file successfully""";
}

Map<String, String> get messagesMap => {
      """app.name""": """Dungeon Paper""",
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
      """user.recentCharacters""": """Recent Characters""",
      """auth.orSeparator""": """OR""",
      """auth.privacyPolicy""": """Privacy Policy""",
      """auth.changelog""": """What's new?""",
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
      """auth.signup.notLoggedIn.label""": """Not logged in""",
      """auth.signup.email.label""": """Email""",
      """auth.signup.email.placeholder""": """Enter your email""",
      """auth.signup.email.error""": """Please enter a valid email address""",
      """auth.signup.password.label""": """Password""",
      """auth.signup.password.placeholder""": """Enter a password""",
      """auth.signup.password.confirm.label""": """Confirm Password""",
      """auth.signup.password.confirm.placeholder""":
          """Enter the same password again""",
      """auth.signup.password.confirm.error""": """Passwords do not match""",
      """home.bars.xp""": """XP""",
      """home.bars.hp""": """HP""",
      """home.categories.notes""": """Bookmarked Notes""",
      """home.categories.moves""": """Favorite Moves""",
      """home.categories.spells""": """Prepared Spells""",
      """home.categories.items""": """Equipped Items""",
      """home.summary.load.tooltip""": """Max Load""",
      """home.summary.coins.tooltip""": """Coins""",
      """home.menu.character.tooltip""": """Character Menu""",
      """home.menu.character.basicInfo""": """Basic Information""",
      """home.menu.character.abilityScores""": """Ability Scores""",
      """home.menu.character.customRolls""": """Quick-Roll Buttons""",
      """home.menu.character.theme""": """Character Theme""",
      """home.menu.bio""": """Character Biography""",
      """home.menu.debilities""": """Debilities""",
      """home.emptyState.guest.title""": """Sign in to get more features""",
      """home.emptyState.guest.subtitle""":
          """Online data sync, library sharing, campaigns and more!""",
      """home.emptyState.title""": """No Characters""",
      """home.emptyState.subtitle""": """Create a Character to get started""",
      """about.title""": """About""",
      """about.author""": """Chen Asraf""",
      """about.discord.title""": """Join Our Discord""",
      """about.discord.subtitle""":
          """Join the Discord community to ask questions, get help, send feedback, or just chat with other players.""",
      """about.feedback.title""": """Send Feedback""",
      """about.feedback.subtitle""":
          """We reply more promptly through Discord, but you can send us feedback, bug reports or suggestions about the app directly here as an alternative.""",
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
      """characterClass.baseLoad""": """Base Load""",
      """characterClass.baseHp""": """Base HP""",
      """characterClass.damageDice""": """Damage Dice""",
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
      """notes.noCategory""": """General""",
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
      """xp.dialog.title""": """Mark Session XP""",
      """xp.dialog.overridingTitle""": """Update XP & Level""",
      """xp.dialog.endOfSession.button""": """End Session""",
      """xp.dialog.endOfSession.questions.title""":
          """End of Session Questions""",
      """xp.dialog.endOfSession.questions.subtitle""":
          """Answer these questions as a group. For each "yes" answer, XP is marked.""",
      """xp.dialog.override.title""": """Update Manually""",
      """xp.dialog.override.info""":
          """Changing the current XP or level manually will cause the pending XP to be discarded unless this is unchecked.""",
      """xp.dialog.override.resetCheckbox""":
          """Reset bonds, flags & end of session questions after saving""",
      """xp.dialog.override.xp""": """Override XP""",
      """xp.dialog.override.level""": """Override Level""",
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
    };
