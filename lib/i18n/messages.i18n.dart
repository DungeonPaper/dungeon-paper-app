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
  AuthMessages get auth => AuthMessages(this);
  AboutMessages get about => AboutMessages(this);
  CharacterMessages get character => CharacterMessages(this);
  DiceMessages get dice => DiceMessages(this);
  TagsMessages get tags => TagsMessages(this);
  DialogsMessages get dialogs => DialogsMessages(this);
  ItemsMessages get items => ItemsMessages(this);
  AlignmentMessages get alignment => AlignmentMessages(this);
  BioMessages get bio => BioMessages(this);
  SearchMessages get search => SearchMessages(this);
  XpDialogMessages get xpDialog => XpDialogMessages(this);
  RichTextMessages get richText => RichTextMessages(this);
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
  String entityName(String ent) => """$ent name""";
  String entityValue(String ent) => """$ent value""";
  String entityDescription(String ent) => """$ent description""";
  String entityExplanation(String ent) => """$ent explanation""";
  String get noDescription => """‹No description provided›""";
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
  String loginWith(String provider) => """Sign in with $provider""";
  String signupWith(String provider) => """Sign up with $provider""";
  String loginProvider(String provider) => """${{
        'facebook': 'Facebook',
        'google': 'Google',
        'apple': 'Apple',
        'password': 'Dungeon Paper',
      }[provider] ?? 'Other'}""";
}

class AuthMessages {
  final Messages _parent;
  const AuthMessages(this._parent);
  String get orSeparator => """OR""";
  String get privacyPolicy => """Privacy Policy""";
  String get changelog => """What's new?""";
  LoginAuthMessages get login => LoginAuthMessages(this);
  LogoutAuthMessages get logout => LogoutAuthMessages(this);
  SignupAuthMessages get signup => SignupAuthMessages(this);
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

class AboutMessages {
  final Messages _parent;
  const AboutMessages(this._parent);
  String get title => """About""";
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
  String get description => """Character & background description""";
  String get looks => """Appearance""";
  String get alignment => """Alignment:""";
}

class SearchMessages {
  final Messages _parent;
  const SearchMessages(this._parent);
  String get placeholder => """Type to search""";
}

class XpDialogMessages {
  final Messages _parent;
  const XpDialogMessages(this._parent);
  String get title => """Mark Session XP""";
  String get overridingTitle => """Update XP & Level""";
  EndOfSessionXpDialogMessages get endOfSession =>
      EndOfSessionXpDialogMessages(this);
  OverrideXpDialogMessages get override => OverrideXpDialogMessages(this);
}

class EndOfSessionXpDialogMessages {
  final XpDialogMessages _parent;
  const EndOfSessionXpDialogMessages(this._parent);
  String get button => """End Session""";
  QuestionsEndOfSessionXpDialogMessages get questions =>
      QuestionsEndOfSessionXpDialogMessages(this);
}

class QuestionsEndOfSessionXpDialogMessages {
  final EndOfSessionXpDialogMessages _parent;
  const QuestionsEndOfSessionXpDialogMessages(this._parent);
  String get title => """End of Session Questions""";
  String get subtitle =>
      """Answer these questions as a group. For each "yes" answer, XP is marked.""";
}

class OverrideXpDialogMessages {
  final XpDialogMessages _parent;
  const OverrideXpDialogMessages(this._parent);
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
      """generic.noDescription""": """‹No description provided›""",
      """errors.userOperationCanceled""": """Operation canceled""",
      """errors.uploadError""":
          """Error while uploading photo. Try again later, or contact support using the "About" page.""",
      """sort.moveUp""": """Move up""",
      """sort.moveDown""": """Move down""",
      """playbook.myLibrary""": """My Library""",
      """playbook.myCampaigns""": """My Campaigns""",
      """settings.title""": """Settings""",
      """settings.importExport""": """Export/Import""",
      """user.recentCharacters""": """Recent Characters""",
      """auth.orSeparator""": """OR""",
      """auth.privacyPolicy""": """Privacy Policy""",
      """auth.changelog""": """What's new?""",
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
      """about.title""": """About""",
      """character.data.coins""": """Coins""",
      """character.data.load.load""": """Load""",
      """character.data.load.maxLoad""": """Max Load""",
      """character.data.load.autoMaxLoad""":
          """Use class base load + STR mod""",
      """character.header.separator""": """ ∙ """,
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
      """bio.dialog.title""": """Character Biography""",
      """bio.dialog.description""": """Character & background description""",
      """bio.dialog.looks""": """Appearance""",
      """bio.dialog.alignment""": """Alignment:""",
      """search.placeholder""": """Type to search""",
      """xpDialog.title""": """Mark Session XP""",
      """xpDialog.overridingTitle""": """Update XP & Level""",
      """xpDialog.endOfSession.button""": """End Session""",
      """xpDialog.endOfSession.questions.title""":
          """End of Session Questions""",
      """xpDialog.endOfSession.questions.subtitle""":
          """Answer these questions as a group. For each "yes" answer, XP is marked.""",
      """xpDialog.override.title""": """Update Manually""",
      """xpDialog.override.info""":
          """Changing the current XP or level manually will cause the pending XP to be discarded unless this is unchecked.""",
      """xpDialog.override.resetCheckbox""":
          """Reset bonds, flags & end of session questions after saving""",
      """xpDialog.override.xp""": """Override XP""",
      """xpDialog.override.level""": """Override Level""",
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
    };
