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
  LoadingMessages get loading => LoadingMessages(this);
  ErrorsMessages get errors => ErrorsMessages(this);
  SortMessages get sort => SortMessages(this);
  PlaybookMessages get playbook => PlaybookMessages(this);
  MyLibraryMessages get myLibrary => MyLibraryMessages(this);
  SettingsMessages get settings => SettingsMessages(this);
  UserMessages get user => UserMessages(this);
  AuthMessages get auth => AuthMessages(this);
  HomeMessages get home => HomeMessages(this);
  AboutMessages get about => AboutMessages(this);
  CharacterMessages get character => CharacterMessages(this);
  CharacterClassMessages get characterClass => CharacterClassMessages(this);
  DiceMessages get dice => DiceMessages(this);
  TagsMessages get tags => TagsMessages(this);
  DialogsMessages get dialogs => DialogsMessages(this);
  SpellsMessages get spells => SpellsMessages(this);
  ItemsMessages get items => ItemsMessages(this);
  AlignmentMessages get alignment => AlignmentMessages(this);
  BioMessages get bio => BioMessages(this);
  SearchMessages get search => SearchMessages(this);
  HpMessages get hp => HpMessages(this);
  XpMessages get xp => XpMessages(this);
  RichTextMessages get richText => RichTextMessages(this);
  CustomRollsMessages get customRolls => CustomRollsMessages(this);
  FlagsMessages get flags => FlagsMessages(this);
  CreateCharacterMessages get createCharacter => CreateCharacterMessages(this);
  AccountMessages get account => AccountMessages(this);
  ActionsMessages get actions => ActionsMessages(this);
  AbilityScoresMessages get abilityScores => AbilityScoresMessages(this);
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
  String get done => """Done""";
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
  String get unselect => """Unselect""";
  String unselectEntity(String ent) => """Unselect $ent""";
  String get delete => """Delete""";
  String deleteEntity(String ent) => """Delete $ent""";
  String get edit => """Edit""";
  String editEntity(String ent) => """Edit $ent""";
  String get select => """Select""";
  String selectEntity(String ent) => """Select $ent""";
  String get my => """My""";
  String myEntity(String ent) => """My $ent""";
  String selectToAdd(String ent) => """Select $ent to add""";
  String entityName(String ent) => """$ent name""";
  String entityValue(String ent) => """$ent value""";
  String entityDescription(String ent) => """$ent description""";
  String entityExplanation(String ent) => """$ent explanation""";
  String get noDescription => """‹No description provided›""";
  String noEntitySelected(String ent) => """No $ent selected""";
  String noEntitySelectedRequired(String ent) =>
      """No $ent selected (required)""";
}

class LoadingMessages {
  final Messages _parent;
  const LoadingMessages(this._parent);
  String get user => """Signing in...""";
  String get characters => """Getting characters...""";
  String get general => """Loading...""";
}

class ErrorsMessages {
  final Messages _parent;
  const ErrorsMessages(this._parent);
  String get userOperationCanceled => """Operation canceled""";
  String get uploadError =>
      """Error while uploading photo. Try again later, or contact support using the "About" page.""";
  String get invalidEmail => """Invalid email address""";
  InvalidPasswordErrorsMessages get invalidPassword =>
      InvalidPasswordErrorsMessages(this);
  String minLength(int cnt) =>
      """Must be at least $cnt ${_plural(cnt, one: 'character', many: 'characters')}""";
  String maxLength(int cnt) =>
      """Must be no more than $cnt ${_plural(cnt, one: 'character', many: 'characters')}""";
  String exactLength(int cnt) =>
      """Must be exactly $cnt ${_plural(cnt, one: 'character', many: 'characters')}""";
  String mustContain(String pattern) => """Must contain $pattern""";
  String mustNotContain(String pattern) => """Must not contain $pattern""";
}

class InvalidPasswordErrorsMessages {
  final ErrorsMessages _parent;
  const InvalidPasswordErrorsMessages(this._parent);
  String get letter => """Password must contain at least one capital letter""";
  String get number => """Password must contain at least one number""";
}

class SortMessages {
  final Messages _parent;
  const SortMessages(this._parent);
  String get moveUp => """Move up""";
  String get moveDown => """Move down""";
  String moveEntityToTop(String ent) => """Move $ent to top""";
  String moveEntityToBottom(String ent) => """Move $ent to bottom""";
}

class PlaybookMessages {
  final Messages _parent;
  const PlaybookMessages(this._parent);
  String get myLibrary => """My Library""";
  String get myCampaigns => """My Campaigns""";
}

class MyLibraryMessages {
  final Messages _parent;
  const MyLibraryMessages(this._parent);
  String get title => """My Library""";
  String get alreadyAdded => """Already added""";
  ItemTabMyLibraryMessages get itemTab => ItemTabMyLibraryMessages(this);
}

class ItemTabMyLibraryMessages {
  final MyLibraryMessages _parent;
  const ItemTabMyLibraryMessages(this._parent);
  String get playbook => """Playbook""";
  String get online => """Online""";
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
  String get recentCharacters => """Recent Characters""";
}

class AuthMessages {
  final Messages _parent;
  const AuthMessages(this._parent);
  String get orSeparator => """OR""";
  String get privacyPolicy => """Privacy Policy""";
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
  String loginWith(String provider) => """Sign in with $provider""";
  String signupWith(String provider) => """Sign up with $provider""";
  String unusable(String provider) =>
      """This device only supports unlinking $provider accounts.""";
  String name(String provider) => """${{
        'facebook': 'Facebook',
        'google': 'Google',
        'apple': 'Apple',
        'password': 'Dungeon Paper',
      }[provider] ?? 'Other'}""";
  String get unlink => """Unlink""";
  String get link => """Link""";
}

class ConfirmUnlinkAuthMessages {
  final AuthMessages _parent;
  const ConfirmUnlinkAuthMessages(this._parent);
  String title(String ent) => """Unlink from $ent""";
  String body(String ent) =>
      """Are you sure you want to unlink your account from $ent?\nBy clicking "Unlink", you will no longer be able to sign in with $ent.\n\nYou will be able to re-link your account at any time by going to your account settings.""";
}

class LoginAuthMessages {
  final AuthMessages _parent;
  const LoginAuthMessages(this._parent);
  String get title => """Sign In""";
  String get subtitle =>
      """Sign in to your account to sync your data online, and get access to many more features.""";
  String get button => """Sign in""";
  NoAccountLoginAuthMessages get noAccount => NoAccountLoginAuthMessages(this);
}

class NoAccountLoginAuthMessages {
  final LoginAuthMessages _parent;
  const NoAccountLoginAuthMessages(this._parent);
  String get label => """Don't have an account?""";
  String get button => """Sign up""";
}

class LogoutAuthMessages {
  final AuthMessages _parent;
  const LogoutAuthMessages(this._parent);
  String get button => """Sign out""";
}

class SignupAuthMessages {
  final AuthMessages _parent;
  const SignupAuthMessages(this._parent);
  String get title => """Sign Up""";
  String get subtitle =>
      """Enter the required details below to create your Dungeon Paper account.""";
  String get button => """Sign up""";
  NotLoggedInSignupAuthMessages get notLoggedIn =>
      NotLoggedInSignupAuthMessages(this);
  EmailSignupAuthMessages get email => EmailSignupAuthMessages(this);
  PasswordSignupAuthMessages get password => PasswordSignupAuthMessages(this);
}

class NotLoggedInSignupAuthMessages {
  final SignupAuthMessages _parent;
  const NotLoggedInSignupAuthMessages(this._parent);
  String get label => """Not logged in""";
}

class EmailSignupAuthMessages {
  final SignupAuthMessages _parent;
  const EmailSignupAuthMessages(this._parent);
  String get label => """Email""";
  String get placeholder => """Enter your email""";
  String get error => """Please enter a valid email address""";
}

class PasswordSignupAuthMessages {
  final SignupAuthMessages _parent;
  const PasswordSignupAuthMessages(this._parent);
  String get label => """Password""";
  String get placeholder => """Enter a password""";
  ConfirmPasswordSignupAuthMessages get confirm =>
      ConfirmPasswordSignupAuthMessages(this);
}

class ConfirmPasswordSignupAuthMessages {
  final PasswordSignupAuthMessages _parent;
  const ConfirmPasswordSignupAuthMessages(this._parent);
  String get label => """Confirm Password""";
  String get placeholder => """Enter the same password again""";
  String get error => """Passwords do not match""";
}

class HomeMessages {
  final Messages _parent;
  const HomeMessages(this._parent);
  CategoriesHomeMessages get categories => CategoriesHomeMessages(this);
  String get menus => """null""";
}

class CategoriesHomeMessages {
  final HomeMessages _parent;
  const CategoriesHomeMessages(this._parent);
  String get notes => """Bookmarked Notes""";
  String get moves => """Favorite Moves""";
  String get spells => """Prepared Spells""";
  String get items => """Equipped Items""";
}

class AboutMessages {
  final Messages _parent;
  const AboutMessages(this._parent);
  String get title => """About""";
  String version(String version) => """Version $version""";
  String copyright(int year) => """Copyright © 2018-$year""";
  String get author => """Chen Asraf""";
  DiscordAboutMessages get discord => DiscordAboutMessages(this);
  FeedbackAboutMessages get feedback => FeedbackAboutMessages(this);
  SocialsAboutMessages get socials => SocialsAboutMessages(this);
  String get specialThanks => """Special Thanks""";
  String get contributors => """Contributors""";
  String get icons => """Icon Credits""";
}

class DiscordAboutMessages {
  final AboutMessages _parent;
  const DiscordAboutMessages(this._parent);
  String get title => """Join Our Discord""";
  String get subtitle =>
      """Join the Discord community to ask questions, get help, send feedback, or just chat with other players.""";
}

class FeedbackAboutMessages {
  final AboutMessages _parent;
  const FeedbackAboutMessages(this._parent);
  String get title => """Send Feedback""";
  String get subtitle =>
      """We reply more promptly through Discord, but you can send us feedback, bug reports or suggestions about the app directly here as an alternative.""";
}

class SocialsAboutMessages {
  final AboutMessages _parent;
  const SocialsAboutMessages(this._parent);
  String get title => """Links""";
  String get twitter => """Twitter""";
  String get facebook => """Facebook""";
  String get discord => """Discord""";
  String get github => """GitHub""";
  String get google => """Play Store""";
  String get apple => """App Store""";
}

class CharacterMessages {
  final Messages _parent;
  const CharacterMessages(this._parent);
  DataCharacterMessages get data => DataCharacterMessages(this);
  HeaderCharacterMessages get header => HeaderCharacterMessages(this);
}

class DataCharacterMessages {
  final CharacterMessages _parent;
  const DataCharacterMessages(this._parent);
  String get coins => """Coins""";
  LoadDataCharacterMessages get load => LoadDataCharacterMessages(this);
  String get level => """Level""";
}

class LoadDataCharacterMessages {
  final DataCharacterMessages _parent;
  const LoadDataCharacterMessages(this._parent);
  String get load => """Load""";
  String get maxLoad => """Max Load""";
  String get autoMaxLoad => """Use class base load + STR mod""";
}

class HeaderCharacterMessages {
  final CharacterMessages _parent;
  const HeaderCharacterMessages(this._parent);
  String level(int lv) => """Level $lv""";
  String characterClass(String name) => """$name""";
  String race(String name) => """$name""";
  String alignment(String alignment) => """$alignment""";
  String get separator => """ ∙ """;
}

class CharacterClassMessages {
  final Messages _parent;
  const CharacterClassMessages(this._parent);
  String get baseLoad => """Base Load""";
  String get baseHp => """Base HP""";
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

class TagsMessages {
  final Messages _parent;
  const TagsMessages(this._parent);
  String copyFrom(String name) => """Copy from: $name""";
  DialogTagsMessages get dialog => DialogTagsMessages(this);
}

class DialogTagsMessages {
  final TagsMessages _parent;
  const DialogTagsMessages(this._parent);
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
  String title(String ent) => """Delete $ent?""";
  String body(String ent, String name) =>
      """Are you sure you want to remove the $ent "$name" from the list?""";
}

class ExitConfirmationsDialogsMessages {
  final ConfirmationsDialogsMessages _parent;
  const ExitConfirmationsDialogsMessages(this._parent);
  String get title => """Are you sure?""";
  String get body =>
      """Going back will lose any unsaved changes.\nAre you sure you want to go back?""";
  String get ok => """Exit & Discard""";
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
  String get title => """Delete Your Account?""";
  String get body =>
      """Are you sure you want to delete your account?\n\nThis action cannot be undone.""";
}

class Step2DeleteAccountConfirmationsDialogsMessages {
  final DeleteAccountConfirmationsDialogsMessages _parent;
  const Step2DeleteAccountConfirmationsDialogsMessages(this._parent);
  String get title => """Are you really sure?""";
  String get body =>
      """We do not save any data for deleted accounts. All your data will be permanently deleted.\n\nAre you sure you want to delete your account?\n\nPlease confirm this one last time.""";
}

class SpellsMessages {
  final Messages _parent;
  const SpellsMessages(this._parent);
  String spellLevel(String level) => """${{
        'rote': 'Rote',
        'cantrip': 'Cantrip',
      }[level] ?? 'Level $level'}""";
}

class ItemsMessages {
  final Messages _parent;
  const ItemsMessages(this._parent);
  String amount(String amt) => """× $amt""";
  String get amountTooltip => """Amount""";
  SettingsItemsMessages get settings => SettingsItemsMessages(this);
}

class SettingsItemsMessages {
  final ItemsMessages _parent;
  const SettingsItemsMessages(this._parent);
  String get countArmor => """Count Armor""";
  String get countDamage => """Count Damage""";
  String get countWeight => """Count Weight""";
}

class AlignmentMessages {
  final Messages _parent;
  const AlignmentMessages(this._parent);
  String name(String key) => """${{
        'chaotic': 'Chaotic',
        'evil': 'Evil',
        'good': 'Good',
        'lawful': 'Lawful',
        'neutral': 'Neutral',
      }[key] ?? key}""";
}

class BioMessages {
  final Messages _parent;
  const BioMessages(this._parent);
  DialogBioMessages get dialog => DialogBioMessages(this);
}

class DialogBioMessages {
  final BioMessages _parent;
  const DialogBioMessages(this._parent);
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
  String get label => """Character & background description""";
  String get placeholder =>
      """Describe your character's background, personality, goals, etc.""";
}

class LooksDialogBioMessages {
  final DialogBioMessages _parent;
  const LooksDialogBioMessages(this._parent);
  String get label => """Appearance""";
  String get placeholder =>
      """Describe your character's appearance. You may use the presets from the buttons above.""";
}

class AlignmentDialogBioMessages {
  final DialogBioMessages _parent;
  const AlignmentDialogBioMessages(this._parent);
  String get label => """Alignment""";
}

class AlignmentDescriptionDialogBioMessages {
  final DialogBioMessages _parent;
  const AlignmentDescriptionDialogBioMessages(this._parent);
  String get label => """Alignment Description""";
  String get placeholder =>
      """Alignment is your character's way of thinking and moral compass. This can center on an ethical ideal, religious strictures or early life events. It reflects what your character values and aspires to protect or create.""";
}

class SearchMessages {
  final Messages _parent;
  const SearchMessages(this._parent);
  String get placeholder => """Type to search""";
}

class HpMessages {
  final Messages _parent;
  const HpMessages(this._parent);
  DialogHpMessages get dialog => DialogHpMessages(this);
}

class DialogHpMessages {
  final HpMessages _parent;
  const DialogHpMessages(this._parent);
  String get title => """Modify HP""";
  ChangeDialogHpMessages get change => ChangeDialogHpMessages(this);
  String get overrideMax => """Override Max HP""";
}

class ChangeDialogHpMessages {
  final DialogHpMessages _parent;
  const ChangeDialogHpMessages(this._parent);
  String add(int amt) => """Heal\n+$amt""";
  String remove(int amt) => """Damage\n-$amt""";
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
  String get title => """Mark Session XP""";
  String get overridingTitle => """Update XP & Level""";
  EndOfSessionDialogXpMessages get endOfSession =>
      EndOfSessionDialogXpMessages(this);
  OverrideDialogXpMessages get override => OverrideDialogXpMessages(this);
}

class EndOfSessionDialogXpMessages {
  final DialogXpMessages _parent;
  const EndOfSessionDialogXpMessages(this._parent);
  String get button => """End Session""";
  QuestionsEndOfSessionDialogXpMessages get questions =>
      QuestionsEndOfSessionDialogXpMessages(this);
}

class QuestionsEndOfSessionDialogXpMessages {
  final EndOfSessionDialogXpMessages _parent;
  const QuestionsEndOfSessionDialogXpMessages(this._parent);
  String get title => """End of Session Questions""";
  String get subtitle =>
      """Answer these questions as a group. For each "yes" answer, XP is marked.""";
}

class OverrideDialogXpMessages {
  final DialogXpMessages _parent;
  const OverrideDialogXpMessages(this._parent);
  String get title => """Update Manually""";
  String get info =>
      """Changing the current XP or level manually will cause the pending XP to be discarded unless this is unchecked.""";
  String get resetCheckbox =>
      """Reset bonds, flags & end of session questions after saving""";
  String get xp => """Override XP""";
  String get level => """Override Level""";
}

class RichTextMessages {
  final Messages _parent;
  const RichTextMessages(this._parent);
  String get preview => """Preview""";
  String get help => """Formatting Help""";
  String get bold => """Bold""";
  String get italic => """Italic""";
  String get headings => """Headings""";
  String heading(int depth) => """Heading $depth""";
  String get bulletList => """Bullet List""";
  String get numberedList => """Numbered List""";
  CheckListRichTextMessages get checkList => CheckListRichTextMessages(this);
  String get url => """URL""";
  String get imageURL => """Image URL""";
  String get table => """Table""";
  String header(Object n) => """Header $n""";
  String cell(int n) => """Cell $n""";
  String get markdownPreview => """Markdown Preview""";
}

class CheckListRichTextMessages {
  final RichTextMessages _parent;
  const CheckListRichTextMessages(this._parent);
  String get unchecked => """Checklist (Unchecked)""";
  String get checked => """Checklist (Checked)""";
}

class CustomRollsMessages {
  final Messages _parent;
  const CustomRollsMessages(this._parent);
  String get title => """Quick Roll Buttons""";
  String get left => """Left Button""";
  String get right => """Right Button""";
  String get presets => """Presets""";
  String get useDefault => """Use Default""";
  String get buttonLabel => """Button Label""";
}

class FlagsMessages {
  final Messages _parent;
  const FlagsMessages(this._parent);
  String get title => """Bonds & Flags""";
  String get bond => """Bond""";
  String get bonds => """Bonds""";
  String get flag => """Flag""";
  String get flags => """Flags""";
}

class CreateCharacterMessages {
  final Messages _parent;
  const CreateCharacterMessages(this._parent);
  BasicInfoCreateCharacterMessages get basicInfo =>
      BasicInfoCreateCharacterMessages(this);
  StartingGearCreateCharacterMessages get startingGear =>
      StartingGearCreateCharacterMessages(this);
}

class BasicInfoCreateCharacterMessages {
  final CreateCharacterMessages _parent;
  const BasicInfoCreateCharacterMessages(this._parent);
  String get defaultName => """Unnamed Traveler""";
  String get helpText => """Select name & picture (required)""";
}

class StartingGearCreateCharacterMessages {
  final CreateCharacterMessages _parent;
  const StartingGearCreateCharacterMessages(this._parent);
  String get helpText =>
      """Select your starting gear determined by class (optional)""";
  String coins(String amt) =>
      """$amt ${_plural(double.tryParse(amt)?.ceil() ?? 0, one: 'coin', many: 'coins')}""";
  String item(String amt, String name) => """$amt × $name""";
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
  String get title => """Change Display Name""";
  String get label => """Display name""";
  String get placeholder => """Enter your public display name""";
  String get success => """Display name changed successfully""";
}

class ImageDetailsAccountMessages {
  final DetailsAccountMessages _parent;
  const ImageDetailsAccountMessages(this._parent);
  String get title => """Change Profile Picture""";
  String get subtitle => """Change your profile picture""";
}

class EmailDetailsAccountMessages {
  final DetailsAccountMessages _parent;
  const EmailDetailsAccountMessages(this._parent);
  String get title => """Change Email Address""";
  String get label => """Email address""";
  String get placeholder => """Enter a new email address""";
  String get success => """Email changed successfully""";
}

class PasswordDetailsAccountMessages {
  final DetailsAccountMessages _parent;
  const PasswordDetailsAccountMessages(this._parent);
  String get title => """Change Password""";
  String get subtitle => """Change your password""";
  String get success => """Password changed successfully""";
  String get label => """New password""";
  String get placeholder => """Enter your new password""";
  ConfirmPasswordDetailsAccountMessages get confirm =>
      ConfirmPasswordDetailsAccountMessages(this);
  String get error => """Passwords do not match""";
}

class ConfirmPasswordDetailsAccountMessages {
  final PasswordDetailsAccountMessages _parent;
  const ConfirmPasswordDetailsAccountMessages(this._parent);
  String get label => """Confirm New Password""";
  String get placeholder => """Enter the same password again""";
}

class ProvidersAccountMessages {
  final AccountMessages _parent;
  const ProvidersAccountMessages(this._parent);
  String get title => """Connected logins""";
}

class DeleteAccountAccountMessages {
  final AccountMessages _parent;
  const DeleteAccountAccountMessages(this._parent);
  String get title => """Delete Your Account""";
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
  String get basic => """Basic Moves""";
  String get special => """Special Moves""";
}

class AbilityScoresMessages {
  final Messages _parent;
  const AbilityScoresMessages(this._parent);
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
  String get stat => """Roll +{stat}""";
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
  String get name => """Bond""";
  String get description =>
      """When a move has you roll+bond you'll count the number of bonds you have with the character in question and add that to the roll.""";
  DebilityBondStatsAbilityScoresMessages get debility =>
      DebilityBondStatsAbilityScoresMessages(this);
}

class DebilityBondStatsAbilityScoresMessages {
  final BondStatsAbilityScoresMessages _parent;
  const DebilityBondStatsAbilityScoresMessages(this._parent);
  String get name => """Lonely""";
  String get description => """null""";
}

class ChaStatsAbilityScoresMessages {
  final StatsAbilityScoresMessages _parent;
  const ChaStatsAbilityScoresMessages(this._parent);
  String get description =>
      """Measures a character's personality, personal magnetism, ability to lead, and appearance.""";
  String get name => """Charisma""";
  DebilityChaStatsAbilityScoresMessages get debility =>
      DebilityChaStatsAbilityScoresMessages(this);
}

class DebilityChaStatsAbilityScoresMessages {
  final ChaStatsAbilityScoresMessages _parent;
  const DebilityChaStatsAbilityScoresMessages(this._parent);
  String get name => """Scarred""";
  String get description =>
      """It may not be permanent, but for now you don't look so good.""";
}

class ConStatsAbilityScoresMessages {
  final StatsAbilityScoresMessages _parent;
  const ConStatsAbilityScoresMessages(this._parent);
  String get description =>
      """Represents your character's health and stamina.""";
  String get name => """Constitution""";
  DebilityConStatsAbilityScoresMessages get debility =>
      DebilityConStatsAbilityScoresMessages(this);
}

class DebilityConStatsAbilityScoresMessages {
  final ConStatsAbilityScoresMessages _parent;
  const DebilityConStatsAbilityScoresMessages(this._parent);
  String get name => """Sick""";
  String get description =>
      """Something just isn't right inside. Maybe you've got a disease or a wasting illness. Maybe you just drank too much ale last night and it's coming back to haunt you.""";
}

class DexStatsAbilityScoresMessages {
  final StatsAbilityScoresMessages _parent;
  const DexStatsAbilityScoresMessages(this._parent);
  String get description => """Measures agility, reflexes and balance.""";
  String get name => """Dexterity""";
  DebilityDexStatsAbilityScoresMessages get debility =>
      DebilityDexStatsAbilityScoresMessages(this);
}

class DebilityDexStatsAbilityScoresMessages {
  final DexStatsAbilityScoresMessages _parent;
  const DebilityDexStatsAbilityScoresMessages(this._parent);
  String get name => """Shaky""";
  String get description =>
      """You're unsteady on your feet and you've got a shake in your hands.""";
}

class StrStatsAbilityScoresMessages {
  final StatsAbilityScoresMessages _parent;
  const StrStatsAbilityScoresMessages(this._parent);
  String get description => """Measures muscle and physical power.""";
  String get name => """Strength""";
  DebilityStrStatsAbilityScoresMessages get debility =>
      DebilityStrStatsAbilityScoresMessages(this);
}

class DebilityStrStatsAbilityScoresMessages {
  final StrStatsAbilityScoresMessages _parent;
  const DebilityStrStatsAbilityScoresMessages(this._parent);
  String get name => """Weak""";
  String get description =>
      """You can't exert much force. Maybe it's just fatigue and injury, or maybe your strength was drained by magic.""";
}

class WisStatsAbilityScoresMessages {
  final StatsAbilityScoresMessages _parent;
  const WisStatsAbilityScoresMessages(this._parent);
  String get description =>
      """Describes a character's willpower, common sense, awareness, and intuition.""";
  String get name => """Wisdom""";
  DebilityWisStatsAbilityScoresMessages get debility =>
      DebilityWisStatsAbilityScoresMessages(this);
}

class DebilityWisStatsAbilityScoresMessages {
  final WisStatsAbilityScoresMessages _parent;
  const DebilityWisStatsAbilityScoresMessages(this._parent);
  String get name => """Confused""";
  String get description =>
      """Ears ringing. Vision blurred. You're more than a little out of it.""";
}

class IntlStatsAbilityScoresMessages {
  final StatsAbilityScoresMessages _parent;
  const IntlStatsAbilityScoresMessages(this._parent);
  String get description =>
      """Determines how well your character learns and reasons.""";
  String get name => """Intelligence""";
  DebilityIntlStatsAbilityScoresMessages get debility =>
      DebilityIntlStatsAbilityScoresMessages(this);
}

class DebilityIntlStatsAbilityScoresMessages {
  final IntlStatsAbilityScoresMessages _parent;
  const DebilityIntlStatsAbilityScoresMessages(this._parent);
  String get name => """Stunned""";
  String get description =>
      """That last knock to the head shook something loose. Brain not work so good.""";
}

class FormAbilityScoresMessages {
  final AbilityScoresMessages _parent;
  const FormAbilityScoresMessages(this._parent);
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
  String get label => """Debility Description""";
  String get description =>
      """A description of the effect causing the debility and/or how it affects your character""";
}

class DebilityNameFormAbilityScoresMessages {
  final FormAbilityScoresMessages _parent;
  const DebilityNameFormAbilityScoresMessages(this._parent);
  String get label => """Debility Name""";
  String get description =>
      """The name for the debility that occurs when this stat is debilitated (takes -1 until recovered).""";
}

class DescriptionFormAbilityScoresMessages {
  final FormAbilityScoresMessages _parent;
  const DescriptionFormAbilityScoresMessages(this._parent);
  String get label => """Ability Score Description""";
  String get description =>
      """A description of what this ability score represents""";
}

class KeyFormAbilityScoresMessages {
  final FormAbilityScoresMessages _parent;
  const KeyFormAbilityScoresMessages(this._parent);
  String get label => """Ability Score Key""";
  String get description =>
      """A 3-letter unique key that identifies this ability score in dice and is used as the short label for the modifier value (and not the actual score)""";
}

class NameFormAbilityScoresMessages {
  final FormAbilityScoresMessages _parent;
  const NameFormAbilityScoresMessages(this._parent);
  String get label => """Ability Score Name""";
  String get description => """The name of this ability score""";
}

class IconFormAbilityScoresMessages {
  final FormAbilityScoresMessages _parent;
  const IconFormAbilityScoresMessages(this._parent);
  String get label => """Icon""";
  String get button => """Change Icon""";
}

Map<String, String> get messagesMap => {
      """app.name""": """Dungeon Paper""",
      """generic.save""": """Save""",
      """generic.cancel""": """Cancel""",
      """generic.close""": """Close""",
      """generic.done""": """Done""",
      """generic.view""": """View""",
      """generic.all""": """All""",
      """generic.create""": """Create""",
      """generic.add""": """Add""",
      """generic.remove""": """Remove""",
      """generic.unselect""": """Unselect""",
      """generic.delete""": """Delete""",
      """generic.edit""": """Edit""",
      """generic.select""": """Select""",
      """generic.my""": """My""",
      """generic.noDescription""": """‹No description provided›""",
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
      """sort.moveUp""": """Move up""",
      """sort.moveDown""": """Move down""",
      """playbook.myLibrary""": """My Library""",
      """playbook.myCampaigns""": """My Campaigns""",
      """myLibrary.title""": """My Library""",
      """myLibrary.alreadyAdded""": """Already added""",
      """myLibrary.itemTab.playbook""": """Playbook""",
      """myLibrary.itemTab.online""": """Online""",
      """settings.title""": """Settings""",
      """settings.importExport""": """Export/Import""",
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
      """home.categories.notes""": """Bookmarked Notes""",
      """home.categories.moves""": """Favorite Moves""",
      """home.categories.spells""": """Prepared Spells""",
      """home.categories.items""": """Equipped Items""",
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
      """character.header.separator""": """ ∙ """,
      """characterClass.baseLoad""": """Base Load""",
      """characterClass.baseHp""": """Base HP""",
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
      """customRolls.presets""": """Presets""",
      """customRolls.useDefault""": """Use Default""",
      """customRolls.buttonLabel""": """Button Label""",
      """flags.title""": """Bonds & Flags""",
      """flags.bond""": """Bond""",
      """flags.bonds""": """Bonds""",
      """flags.flag""": """Flag""",
      """flags.flags""": """Flags""",
      """createCharacter.basicInfo.defaultName""": """Unnamed Traveler""",
      """createCharacter.basicInfo.helpText""":
          """Select name & picture (required)""",
      """createCharacter.startingGear.helpText""":
          """Select your starting gear determined by class (optional)""",
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
    };
