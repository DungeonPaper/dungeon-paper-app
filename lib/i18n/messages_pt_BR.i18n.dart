// GENERATED FILE, do not edit!
// ignore_for_file: annotate_overrides, non_constant_identifier_names, prefer_single_quotes, unused_element, unused_field, unnecessary_string_interpolations
import 'package:i18n/i18n.dart' as i18n;
import 'messages.i18n.dart';

String get _languageCode => 'pt';
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

class MessagesPtBR extends Messages {
  const MessagesPtBR();
  String get locale => "pt_BR";
  String get languageCode => "pt";

  /// ```dart
  /// """
  /// ${switch (type) {
  ///   'AbilityScore' => 'Habilidade',
  ///   'AlignmentValue' => 'Alinhamento',
  ///   'CharacterClass' => 'Classe',
  ///   'Dice' => 'Dado',
  ///   'GearSelection' => 'Conjunto de Equipamento',
  ///   'GearChoice' => 'Escolha de Equipamento',
  ///   'GearOption' => 'Item do Conjunto de Equipamento',
  ///   'MoveCategory' => 'Categoria',
  ///   'Campaign' => 'Campanha',
  ///   'Character' => 'Personagem',
  ///   'Move' => 'Movimento',
  ///   'Spell' => 'Feitiço',
  ///   'Item' => 'Item',
  ///   'Race' => 'Raça',
  ///   'Note' => 'Nota',
  ///   'Tag' => 'Etiqueta',
  ///   _ => type,
  /// }}
  /// """
  /// ```
  String _entSingle(String type) => """${switch (type) {
        'AbilityScore' => 'Habilidade',
        'AlignmentValue' => 'Alinhamento',
        'CharacterClass' => 'Classe',
        'Dice' => 'Dado',
        'GearSelection' => 'Conjunto de Equipamento',
        'GearChoice' => 'Escolha de Equipamento',
        'GearOption' => 'Item do Conjunto de Equipamento',
        'MoveCategory' => 'Categoria',
        'Campaign' => 'Campanha',
        'Character' => 'Personagem',
        'Move' => 'Movimento',
        'Spell' => 'Feitiço',
        'Item' => 'Item',
        'Race' => 'Raça',
        'Note' => 'Nota',
        'Tag' => 'Etiqueta',
        _ => type,
      }}""";

  /// ```dart
  /// """
  /// ${switch (type) {
  ///   'CharacterClass' => 'Classes',
  ///   'Dice' => 'Dados',
  ///   'MoveCategory' => 'Categorias',
  ///   'Campaign' => 'Campanhas',
  ///   'Character' => 'Personagens',
  ///   'Move' => 'Movimentos',
  ///   'Spell' => 'Feitiços',
  ///   'Item' => 'Itens',
  ///   'Race' => 'Raças',
  ///   'Note' => 'Notas',
  ///   'Tag' => 'Etiquetas',
  ///   'AbilityScore' => 'Habilidades',
  ///   'AlignmentValue' => 'Alinhamentos',
  ///   'GearSelection' => 'Conjuntos de Equipamento',
  ///   'GearChoice' => 'Escolhas de Equipamento',
  ///   'GearOption' => 'Itens do Conjunto de Equipamento',
  ///   _ => '${_entSingle(type)}s',
  /// }}
  /// """
  /// ```
  String _entPlural(String type) => """${switch (type) {
        'CharacterClass' => 'Classes',
        'Dice' => 'Dados',
        'MoveCategory' => 'Categorias',
        'Campaign' => 'Campanhas',
        'Character' => 'Personagens',
        'Move' => 'Movimentos',
        'Spell' => 'Feitiços',
        'Item' => 'Itens',
        'Race' => 'Raças',
        'Note' => 'Notas',
        'Tag' => 'Etiquetas',
        'AbilityScore' => 'Habilidades',
        'AlignmentValue' => 'Alinhamentos',
        'GearSelection' => 'Conjuntos de Equipamento',
        'GearChoice' => 'Escolhas de Equipamento',
        'GearOption' => 'Itens do Conjunto de Equipamento',
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
  AppMessagesPtBR get app => AppMessagesPtBR(this);
  PlatformInteractionsMessagesPtBR get platformInteractions =>
      PlatformInteractionsMessagesPtBR(this);
  GenericMessagesPtBR get generic => GenericMessagesPtBR(this);
  LoadingMessagesPtBR get loading => LoadingMessagesPtBR(this);
  ErrorsMessagesPtBR get errors => ErrorsMessagesPtBR(this);
  NumberFieldsMessagesPtBR get numberFields => NumberFieldsMessagesPtBR(this);
  SortMessagesPtBR get sort => SortMessagesPtBR(this);
  PlaybookMessagesPtBR get playbook => PlaybookMessagesPtBR(this);
  MyLibraryMessagesPtBR get myLibrary => MyLibraryMessagesPtBR(this);
  NavMessagesPtBR get nav => NavMessagesPtBR(this);
  SyncMessagesPtBR get sync => SyncMessagesPtBR(this);
  SettingsMessagesPtBR get settings => SettingsMessagesPtBR(this);
  UserMessagesPtBR get user => UserMessagesPtBR(this);
  AuthMessagesPtBR get auth => AuthMessagesPtBR(this);
  HomeMessagesPtBR get home => HomeMessagesPtBR(this);
  AboutMessagesPtBR get about => AboutMessagesPtBR(this);
  CharacterMessagesPtBR get character => CharacterMessagesPtBR(this);
  CharacterClassMessagesPtBR get characterClass =>
      CharacterClassMessagesPtBR(this);
  StartingGearMessagesPtBR get startingGear => StartingGearMessagesPtBR(this);
  DiceMessagesPtBR get dice => DiceMessagesPtBR(this);
  BasicInfoMessagesPtBR get basicInfo => BasicInfoMessagesPtBR(this);
  DebilitiesMessagesPtBR get debilities => DebilitiesMessagesPtBR(this);
  TagsMessagesPtBR get tags => TagsMessagesPtBR(this);
  DialogsMessagesPtBR get dialogs => DialogsMessagesPtBR(this);
  MovesMessagesPtBR get moves => MovesMessagesPtBR(this);
  SpellsMessagesPtBR get spells => SpellsMessagesPtBR(this);
  ItemsMessagesPtBR get items => ItemsMessagesPtBR(this);
  NotesMessagesPtBR get notes => NotesMessagesPtBR(this);
  AlignmentMessagesPtBR get alignment => AlignmentMessagesPtBR(this);
  BioMessagesPtBR get bio => BioMessagesPtBR(this);
  SearchMessagesPtBR get search => SearchMessagesPtBR(this);
  HpMessagesPtBR get hp => HpMessagesPtBR(this);
  XpMessagesPtBR get xp => XpMessagesPtBR(this);
  ArmorMessagesPtBR get armor => ArmorMessagesPtBR(this);
  RichTextMessagesPtBR get richText => RichTextMessagesPtBR(this);
  CustomRollsMessagesPtBR get customRolls => CustomRollsMessagesPtBR(this);
  SessionMarksMessagesPtBR get sessionMarks => SessionMarksMessagesPtBR(this);
  CreateCharacterMessagesPtBR get createCharacter =>
      CreateCharacterMessagesPtBR(this);
  AccountMessagesPtBR get account => AccountMessagesPtBR(this);
  ActionsMessagesPtBR get actions => ActionsMessagesPtBR(this);
  AbilityScoresMessagesPtBR get abilityScores =>
      AbilityScoresMessagesPtBR(this);
  FeedbackMessagesPtBR get feedback => FeedbackMessagesPtBR(this);
  MigrationMessagesPtBR get migration => MigrationMessagesPtBR(this);
  BackupMessagesPtBR get backup => BackupMessagesPtBR(this);
  ChangelogMessagesPtBR get changelog => ChangelogMessagesPtBR(this);
}

class AppMessagesPtBR extends AppMessages {
  final MessagesPtBR _parent;
  const AppMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Dungeon Paper"
  /// ```
  String get name => """Dungeon Paper""";
}

class PlatformInteractionsMessagesPtBR extends PlatformInteractionsMessages {
  final MessagesPtBR _parent;
  const PlatformInteractionsMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Toque"
  /// ```
  String get tap => """Toque""";

  /// ```dart
  /// "Arraste"
  /// ```
  String get drag => """Arraste""";

  /// ```dart
  /// "Mova"
  /// ```
  String get pan => """Mova""";

  /// ```dart
  /// "Clique"
  /// ```
  String get click => """Clique""";
}

class GenericMessagesPtBR extends GenericMessages {
  final MessagesPtBR _parent;
  const GenericMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Salvar"
  /// ```
  String get save => """Salvar""";

  /// ```dart
  /// "Salvar $ent"
  /// ```
  String saveEntity(String ent) => """Salvar $ent""";

  /// ```dart
  /// "Cancelar"
  /// ```
  String get cancel => """Cancelar""";

  /// ```dart
  /// "Fechar"
  /// ```
  String get close => """Fechar""";

  /// ```dart
  /// "Concluído"
  /// ```
  String get done => """Concluído""";

  /// ```dart
  /// "Visualizar"
  /// ```
  String get view => """Visualizar""";

  /// ```dart
  /// "Continuar"
  /// ```
  String get continue_ => """Continuar""";

  /// ```dart
  /// "Visualizar $ent"
  /// ```
  String viewEntity(String ent) => """Visualizar $ent""";

  /// ```dart
  /// "Todos"
  /// ```
  String get all => """Todos""";

  /// ```dart
  /// "Todos os $ent"
  /// ```
  String allEntities(String ent) => """Todos os $ent""";

  /// ```dart
  /// "Criar"
  /// ```
  String get create => """Criar""";

  /// ```dart
  /// "Criar $ent"
  /// ```
  String createEntity(String ent) => """Criar $ent""";

  /// ```dart
  /// "Adicionar"
  /// ```
  String get add => """Adicionar""";

  /// ```dart
  /// "Adicionar $ent"
  /// ```
  String addEntity(String ent) => """Adicionar $ent""";

  /// ```dart
  /// "Remover"
  /// ```
  String get remove => """Remover""";

  /// ```dart
  /// "Remover $ent"
  /// ```
  String removeEntity(String ent) => """Remover $ent""";

  /// ```dart
  /// "Desmarcar"
  /// ```
  String get unselect => """Desmarcar""";

  /// ```dart
  /// "Desmarcar $ent"
  /// ```
  String unselectEntity(String ent) => """Desmarcar $ent""";

  /// ```dart
  /// "Excluir"
  /// ```
  String get delete => """Excluir""";

  /// ```dart
  /// "Excluir $ent"
  /// ```
  String deleteEntity(String ent) => """Excluir $ent""";

  /// ```dart
  /// "Editar"
  /// ```
  String get edit => """Editar""";

  /// ```dart
  /// "Editar $ent"
  /// ```
  String editEntity(String ent) => """Editar $ent""";

  /// ```dart
  /// "Sim"
  /// ```
  String get yes => """Sim""";

  /// ```dart
  /// "Não"
  /// ```
  String get no => """Não""";

  /// ```dart
  /// "Nenhum $ent"
  /// ```
  String noEntity(String ent) => """Nenhum $ent""";

  /// ```dart
  /// "Selecionar"
  /// ```
  String get select => """Selecionar""";

  /// ```dart
  /// "Selecionar $ent"
  /// ```
  String selectEntity(String ent) => """Selecionar $ent""";

  /// ```dart
  /// "Selecionado"
  /// ```
  String get selected => """Selecionado""";

  /// ```dart
  /// "Selecionar Todos"
  /// ```
  String get selectAll => """Selecionar Todos""";

  /// ```dart
  /// "Selecionar Nenhum"
  /// ```
  String get selectNone => """Selecionar Nenhum""";

  /// ```dart
  /// "Meu"
  /// ```
  String get my => """Meu""";

  /// ```dart
  /// "Meu $ent"
  /// ```
  String myEntity(String ent) => """Meu $ent""";

  /// ```dart
  /// "Alterar"
  /// ```
  String get change => """Alterar""";

  /// ```dart
  /// "Alterar $ent"
  /// ```
  String changeEntity(String ent) => """Alterar $ent""";

  /// ```dart
  /// "Ver Todos"
  /// ```
  String get seeAll => """Ver Todos""";

  /// ```dart
  /// "Selecionar $ent para adicionar"
  /// ```
  String selectToAdd(String ent) => """Selecionar $ent para adicionar""";

  /// ```dart
  /// "Nome"
  /// ```
  String get name => """Nome""";

  /// ```dart
  /// "Nome do $ent"
  /// ```
  String entityName(String ent) => """Nome do $ent""";

  /// ```dart
  /// "Valor"
  /// ```
  String get value => """Valor""";

  /// ```dart
  /// "Valor do $ent"
  /// ```
  String entityValue(String ent) => """Valor do $ent""";

  /// ```dart
  /// "Descrição"
  /// ```
  String get description => """Descrição""";

  /// ```dart
  /// "Descrição do $ent"
  /// ```
  String entityDescription(String ent) => """Descrição do $ent""";

  /// ```dart
  /// "Explicação"
  /// ```
  String get explanation => """Explicação""";

  /// ```dart
  /// "Explicação do $ent"
  /// ```
  String entityExplanation(String ent) => """Explicação do $ent""";

  /// ```dart
  /// "‹Nenhuma descrição fornecida›"
  /// ```
  String get noDescription => """‹Nenhuma descrição fornecida›""";

  /// ```dart
  /// "Nenhum $ent selecionado"
  /// ```
  String noEntitySelected(String ent) => """Nenhum $ent selecionado""";

  /// ```dart
  /// "Nenhum $ent selecionado (obrigatório)"
  /// ```
  String noEntitySelectedRequired(String ent) =>
      """Nenhum $ent selecionado (obrigatório)""";

  /// ```dart
  /// "Usar Padrão"
  /// ```
  String get useDefault => """Usar Padrão""";
}

class LoadingMessagesPtBR extends LoadingMessages {
  final MessagesPtBR _parent;
  const LoadingMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Entrando..."
  /// ```
  String get user => """Entrando...""";

  /// ```dart
  /// "Obtendo personagens..."
  /// ```
  String get characters => """Obtendo personagens...""";

  /// ```dart
  /// "Carregando..."
  /// ```
  String get general => """Carregando...""";
}

class ErrorsMessagesPtBR extends ErrorsMessages {
  final MessagesPtBR _parent;
  const ErrorsMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Operação cancelada"
  /// ```
  String get userOperationCanceled => """Operação cancelada""";

  /// ```dart
  /// "Erro ao carregar a foto. Tente novamente mais tarde ou entre em contato com o suporte usando a página "Sobre"."
  /// ```
  String get uploadError =>
      """Erro ao carregar a foto. Tente novamente mais tarde ou entre em contato com o suporte usando a página "Sobre".""";

  /// ```dart
  /// "Endereço de email inválido"
  /// ```
  String get invalidEmail => """Endereço de email inválido""";
  InvalidPasswordErrorsMessagesPtBR get invalidPassword =>
      InvalidPasswordErrorsMessagesPtBR(this);

  /// ```dart
  /// "Deve ter pelo menos $cnt ${_plural(cnt, one: 'caractere', many: 'caracteres')}"
  /// ```
  String minLength(int cnt) =>
      """Deve ter pelo menos $cnt ${_plural(cnt, one: 'caractere', many: 'caracteres')}""";

  /// ```dart
  /// "Não deve ter mais de $cnt ${_plural(cnt, one: 'caractere', many: 'caracteres')}"
  /// ```
  String maxLength(int cnt) =>
      """Não deve ter mais de $cnt ${_plural(cnt, one: 'caractere', many: 'caracteres')}""";

  /// ```dart
  /// "Deve ter exatamente $cnt ${_plural(cnt, one: 'caractere', many: 'caracteres')}"
  /// ```
  String exactLength(int cnt) =>
      """Deve ter exatamente $cnt ${_plural(cnt, one: 'caractere', many: 'caracteres')}""";

  /// ```dart
  /// "Deve conter $pattern"
  /// ```
  String mustContain(String pattern) => """Deve conter $pattern""";

  /// ```dart
  /// "Não deve conter $pattern"
  /// ```
  String mustNotContain(String pattern) => """Não deve conter $pattern""";

  /// ```dart
  /// "Deve conter apenas letras"
  /// ```
  String get onlyLetters => """Deve conter apenas letras""";
}

class InvalidPasswordErrorsMessagesPtBR extends InvalidPasswordErrorsMessages {
  final ErrorsMessagesPtBR _parent;
  const InvalidPasswordErrorsMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "A senha deve conter pelo menos uma letra maiúscula"
  /// ```
  String get letter => """A senha deve conter pelo menos uma letra maiúscula""";

  /// ```dart
  /// "A senha deve conter pelo menos um número"
  /// ```
  String get number => """A senha deve conter pelo menos um número""";
}

class NumberFieldsMessagesPtBR extends NumberFieldsMessages {
  final MessagesPtBR _parent;
  const NumberFieldsMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "+1"
  /// ```
  String get increase => """+1""";

  /// ```dart
  /// "-1"
  /// ```
  String get decrease => """-1""";
}

class SortMessagesPtBR extends SortMessages {
  final MessagesPtBR _parent;
  const SortMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Mover para cima"
  /// ```
  String get moveUp => """Mover para cima""";

  /// ```dart
  /// "Mover para baixo"
  /// ```
  String get moveDown => """Mover para baixo""";

  /// ```dart
  /// "Mover $ent para o topo"
  /// ```
  String moveEntityToTop(String ent) => """Mover $ent para o topo""";

  /// ```dart
  /// "Mover $ent para o final"
  /// ```
  String moveEntityToBottom(String ent) => """Mover $ent para o final""";
}

class PlaybookMessagesPtBR extends PlaybookMessages {
  final MessagesPtBR _parent;
  const PlaybookMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Playbook"
  /// ```
  String get title => """Playbook""";

  /// ```dart
  /// "Minha Biblioteca"
  /// ```
  String get myLibrary => """Minha Biblioteca""";

  /// ```dart
  /// "Minhas Campanhas"
  /// ```
  String get myCampaigns => """Minhas Campanhas""";
}

class MyLibraryMessagesPtBR extends MyLibraryMessages {
  final MessagesPtBR _parent;
  const MyLibraryMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Minha Biblioteca"
  /// ```
  String get title => """Minha Biblioteca""";

  /// ```dart
  /// "Recarregar Biblioteca"
  /// ```
  String get reload => """Recarregar Biblioteca""";

  /// ```dart
  /// "Você pode remover este $ent encontrando-o na aba "Usar" e clicando em "Remover" no menu de contexto."
  /// ```
  String selectDisabled(String ent) =>
      """Você pode remover este $ent encontrando-o na aba "Usar" e clicando em "Remover" no menu de contexto.""";

  /// ```dart
  /// "$cnt em $type"
  /// ```
  String itemCount(String cnt, String type) => """$cnt em $type""";

  /// ```dart
  /// """
  /// ${switch (type) {
  ///   'builtIn' => 'Playbook',
  ///   'my' => 'Minha Biblioteca',
  ///   _ => type,
  /// }}
  /// """
  /// ```
  String libraryType(String type) => """${switch (type) {
        'builtIn' => 'Playbook',
        'my' => 'Minha Biblioteca',
        _ => type,
      }}""";

  /// ```dart
  /// "Já adicionado"
  /// ```
  String get alreadyAdded => """Já adicionado""";
  ItemTabMyLibraryMessagesPtBR get itemTab =>
      ItemTabMyLibraryMessagesPtBR(this);
  EmptyStateMyLibraryMessagesPtBR get emptyState =>
      EmptyStateMyLibraryMessagesPtBR(this);
  FiltersMyLibraryMessagesPtBR get filters =>
      FiltersMyLibraryMessagesPtBR(this);
}

class ItemTabMyLibraryMessagesPtBR extends ItemTabMyLibraryMessages {
  final MyLibraryMessagesPtBR _parent;
  const ItemTabMyLibraryMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Playbook"
  /// ```
  String get playbook => """Playbook""";

  /// ```dart
  /// "Online"
  /// ```
  String get online => """Online""";
}

class EmptyStateMyLibraryMessagesPtBR extends EmptyStateMyLibraryMessages {
  final MyLibraryMessagesPtBR _parent;
  const EmptyStateMyLibraryMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Nenhum $ent encontrado"
  /// ```
  String title(String ent) => """Nenhum $ent encontrado""";
  SubtitleEmptyStateMyLibraryMessagesPtBR get subtitle =>
      SubtitleEmptyStateMyLibraryMessagesPtBR(this);
}

class SubtitleEmptyStateMyLibraryMessagesPtBR
    extends SubtitleEmptyStateMyLibraryMessages {
  final EmptyStateMyLibraryMessagesPtBR _parent;
  const SubtitleEmptyStateMyLibraryMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Nenhum $ent encontrado nesta lista."
  /// ```
  String filters(String ent) => """Nenhum $ent encontrado nesta lista.""";

  /// ```dart
  /// "Tente alterar a pesquisa ou os filtros para encontrar mais $ent."
  /// ```
  String noFilters(String ent) =>
      """Tente alterar a pesquisa ou os filtros para encontrar mais $ent.""";
}

class FiltersMyLibraryMessagesPtBR extends FiltersMyLibraryMessages {
  final MyLibraryMessagesPtBR _parent;
  const FiltersMyLibraryMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Limpar Filtros"
  /// ```
  String get clear => """Limpar Filtros""";
}

class NavMessagesPtBR extends NavMessages {
  final MessagesPtBR _parent;
  const NavMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Usar"
  /// ```
  String get actions => """Usar""";

  /// ```dart
  /// "Personagem"
  /// ```
  String get character => """Personagem""";

  /// ```dart
  /// "Diário"
  /// ```
  String get journal => """Diário""";
}

class SyncMessagesPtBR extends SyncMessages {
  final MessagesPtBR _parent;
  const SyncMessagesPtBR(this._parent) : super(_parent);
  EntitySyncMessagesPtBR get entity => EntitySyncMessagesPtBR(this);
}

class EntitySyncMessagesPtBR extends EntitySyncMessages {
  final SyncMessagesPtBR _parent;
  const EntitySyncMessagesPtBR(this._parent) : super(_parent);
  StatusEntitySyncMessagesPtBR get status => StatusEntitySyncMessagesPtBR(this);
}

class StatusEntitySyncMessagesPtBR extends StatusEntitySyncMessages {
  final EntitySyncMessagesPtBR _parent;
  const StatusEntitySyncMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Este $ent está sincronizado com o item vinculado da biblioteca"
  /// ```
  String inSync(String ent) =>
      """Este $ent está sincronizado com o item vinculado da biblioteca""";

  /// ```dart
  /// "Este $ent está fora de sincronia com o item vinculado da biblioteca"
  /// ```
  String outOfSync(String ent) =>
      """Este $ent está fora de sincronia com o item vinculado da biblioteca""";

  /// ```dart
  /// "Este $ent não está vinculado a nenhum item da biblioteca"
  /// ```
  String detached(String ent) =>
      """Este $ent não está vinculado a nenhum item da biblioteca""";
}

class SettingsMessagesPtBR extends SettingsMessages {
  final MessagesPtBR _parent;
  const SettingsMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Configurações"
  /// ```
  String get title => """Configurações""";

  /// ```dart
  /// "Exportar/Importar"
  /// ```
  String get importExport => """Exportar/Importar""";

  /// ```dart
  /// "Mudar para o modo ${mode}"
  /// ```
  String _switchMode(String mode) => """Mudar para o modo ${mode}""";

  /// ```dart
  /// "${_switchMode('Escuro')}"
  /// ```
  String get switchToDark => """${_switchMode('Escuro')}""";

  /// ```dart
  /// "${_switchMode('Claro')}"
  /// ```
  String get switchToLight => """${_switchMode('Claro')}""";
  CategoriesSettingsMessagesPtBR get categories =>
      CategoriesSettingsMessagesPtBR(this);

  /// ```dart
  /// "Manter a tela ativa enquanto usa o aplicativo"
  /// ```
  String get keepAwake => """Manter a tela ativa enquanto usa o aplicativo""";
  LocaleSettingsMessagesPtBR get locale => LocaleSettingsMessagesPtBR(this);
  LocalesSettingsMessagesPtBR get locales => LocalesSettingsMessagesPtBR(this);
  DefaultThemeSettingsMessagesPtBR get defaultTheme =>
      DefaultThemeSettingsMessagesPtBR(this);
}

class CategoriesSettingsMessagesPtBR extends CategoriesSettingsMessages {
  final SettingsMessagesPtBR _parent;
  const CategoriesSettingsMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Geral"
  /// ```
  String get general => """Geral""";
}

class LocaleSettingsMessagesPtBR extends LocaleSettingsMessages {
  final SettingsMessagesPtBR _parent;
  const LocaleSettingsMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Idioma"
  /// ```
  String get title => """Idioma""";

  /// ```dart
  /// "Alterar o idioma irá recarregar o aplicativo"
  /// ```
  String get subtitle => """Alterar o idioma irá recarregar o aplicativo""";
}

class LocalesSettingsMessagesPtBR extends LocalesSettingsMessages {
  final SettingsMessagesPtBR _parent;
  const LocalesSettingsMessagesPtBR(this._parent) : super(_parent);

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

class DefaultThemeSettingsMessagesPtBR extends DefaultThemeSettingsMessages {
  final SettingsMessagesPtBR _parent;
  const DefaultThemeSettingsMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Tema padrão $type"
  /// ```
  String _p(String type) => """Tema padrão $type""";

  /// ```dart
  /// "${_p('claro')}"
  /// ```
  String get light => """${_p('claro')}""";

  /// ```dart
  /// "${_p('escuro')}"
  /// ```
  String get dark => """${_p('escuro')}""";
}

class UserMessagesPtBR extends UserMessages {
  final MessagesPtBR _parent;
  const UserMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Personagens Recentes"
  /// ```
  String get recentCharacters => """Personagens Recentes""";
}

class AuthMessagesPtBR extends AuthMessages {
  final MessagesPtBR _parent;
  const AuthMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "OU"
  /// ```
  String get orSeparator => """OU""";

  /// ```dart
  /// "Política de Privacidade"
  /// ```
  String get privacyPolicy => """Política de Privacidade""";

  /// ```dart
  /// "O que há de novo?"
  /// ```
  String get changelog => """O que há de novo?""";

  /// ```dart
  /// "Não conectado"
  /// ```
  String get notLoggedIn => """Não conectado""";

  /// ```dart
  /// "$displayName (@$username)"
  /// ```
  String menuTitle(String displayName, String username) =>
      """$displayName (@$username)""";

  /// ```dart
  /// "Detalhes da conta"
  /// ```
  String menuSubtitle(String interact) => """Detalhes da conta""";
  ProvidersAuthMessagesPtBR get providers => ProvidersAuthMessagesPtBR(this);
  ConfirmUnlinkAuthMessagesPtBR get confirmUnlink =>
      ConfirmUnlinkAuthMessagesPtBR(this);
  LoginAuthMessagesPtBR get login => LoginAuthMessagesPtBR(this);
  LogoutAuthMessagesPtBR get logout => LogoutAuthMessagesPtBR(this);
  SignupAuthMessagesPtBR get signup => SignupAuthMessagesPtBR(this);
}

class ProvidersAuthMessagesPtBR extends ProvidersAuthMessages {
  final AuthMessagesPtBR _parent;
  const ProvidersAuthMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Entrar com $provider"
  /// ```
  String loginWith(String provider) => """Entrar com $provider""";

  /// ```dart
  /// "Inscrever-se com $provider"
  /// ```
  String signupWith(String provider) => """Inscrever-se com $provider""";

  /// ```dart
  /// "Este dispositivo só suporta desvincular contas $provider."
  /// ```
  String unusable(String provider) =>
      """Este dispositivo só suporta desvincular contas $provider.""";

  /// ```dart
  /// """
  /// ${switch (provider) {
  ///   'facebook' => 'Facebook',
  ///   'google' => 'Google',
  ///   'apple' => 'Apple',
  ///   'password' => 'Dungeon Paper',
  ///   _ => 'Outro',
  /// }}
  /// """
  /// ```
  String name(String provider) => """${switch (provider) {
        'facebook' => 'Facebook',
        'google' => 'Google',
        'apple' => 'Apple',
        'password' => 'Dungeon Paper',
        _ => 'Outro',
      }}""";

  /// ```dart
  /// "Desvincular"
  /// ```
  String get unlink => """Desvincular""";

  /// ```dart
  /// "Vincular"
  /// ```
  String get link => """Vincular""";
}

class ConfirmUnlinkAuthMessagesPtBR extends ConfirmUnlinkAuthMessages {
  final AuthMessagesPtBR _parent;
  const ConfirmUnlinkAuthMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Desvincular de $ent"
  /// ```
  String title(String ent) => """Desvincular de $ent""";

  /// ```dart
  /// "Tem certeza de que deseja desvincular sua conta de $ent?\nAo clicar em "Desvincular", você não poderá mais fazer login com $ent.\n\nVocê poderá relinkar sua conta a qualquer momento indo para as configurações da sua conta."
  /// ```
  String body(String ent) =>
      """Tem certeza de que deseja desvincular sua conta de $ent?\nAo clicar em "Desvincular", você não poderá mais fazer login com $ent.\n\nVocê poderá relinkar sua conta a qualquer momento indo para as configurações da sua conta.""";
}

class LoginAuthMessagesPtBR extends LoginAuthMessages {
  final AuthMessagesPtBR _parent;
  const LoginAuthMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Entrar"
  /// ```
  String get title => """Entrar""";

  /// ```dart
  /// "Entre na sua conta para sincronizar seus dados online e obter acesso a muitos outros recursos."
  /// ```
  String get subtitle =>
      """Entre na sua conta para sincronizar seus dados online e obter acesso a muitos outros recursos.""";

  /// ```dart
  /// "Entrar"
  /// ```
  String get button => """Entrar""";
  NoAccountLoginAuthMessagesPtBR get noAccount =>
      NoAccountLoginAuthMessagesPtBR(this);
}

class NoAccountLoginAuthMessagesPtBR extends NoAccountLoginAuthMessages {
  final LoginAuthMessagesPtBR _parent;
  const NoAccountLoginAuthMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Não tem uma conta?"
  /// ```
  String get label => """Não tem uma conta?""";

  /// ```dart
  /// "Inscreva-se"
  /// ```
  String get button => """Inscreva-se""";
}

class LogoutAuthMessagesPtBR extends LogoutAuthMessages {
  final AuthMessagesPtBR _parent;
  const LogoutAuthMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Sair"
  /// ```
  String get button => """Sair""";
}

class SignupAuthMessagesPtBR extends SignupAuthMessages {
  final AuthMessagesPtBR _parent;
  const SignupAuthMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Inscrever-se"
  /// ```
  String get title => """Inscrever-se""";

  /// ```dart
  /// "Insira os detalhes necessários abaixo para criar sua conta Dungeon Paper."
  /// ```
  String get subtitle =>
      """Insira os detalhes necessários abaixo para criar sua conta Dungeon Paper.""";

  /// ```dart
  /// "Inscrever-se"
  /// ```
  String get button => """Inscrever-se""";
  EmailSignupAuthMessagesPtBR get email => EmailSignupAuthMessagesPtBR(this);
  PasswordSignupAuthMessagesPtBR get password =>
      PasswordSignupAuthMessagesPtBR(this);
}

class EmailSignupAuthMessagesPtBR extends EmailSignupAuthMessages {
  final SignupAuthMessagesPtBR _parent;
  const EmailSignupAuthMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Email"
  /// ```
  String get label => """Email""";

  /// ```dart
  /// "Digite seu email"
  /// ```
  String get placeholder => """Digite seu email""";

  /// ```dart
  /// "Por favor, insira um endereço de email válido"
  /// ```
  String get error => """Por favor, insira um endereço de email válido""";
}

class PasswordSignupAuthMessagesPtBR extends PasswordSignupAuthMessages {
  final SignupAuthMessagesPtBR _parent;
  const PasswordSignupAuthMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Senha"
  /// ```
  String get label => """Senha""";

  /// ```dart
  /// "Insira uma senha"
  /// ```
  String get placeholder => """Insira uma senha""";
  ConfirmPasswordSignupAuthMessagesPtBR get confirm =>
      ConfirmPasswordSignupAuthMessagesPtBR(this);
}

class ConfirmPasswordSignupAuthMessagesPtBR
    extends ConfirmPasswordSignupAuthMessages {
  final PasswordSignupAuthMessagesPtBR _parent;
  const ConfirmPasswordSignupAuthMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Confirmar Senha"
  /// ```
  String get label => """Confirmar Senha""";

  /// ```dart
  /// "Digite a mesma senha novamente"
  /// ```
  String get placeholder => """Digite a mesma senha novamente""";

  /// ```dart
  /// "As senhas não coincidem"
  /// ```
  String get error => """As senhas não coincidem""";
}

class HomeMessagesPtBR extends HomeMessages {
  final MessagesPtBR _parent;
  const HomeMessagesPtBR(this._parent) : super(_parent);
  CategoriesHomeMessagesPtBR get categories => CategoriesHomeMessagesPtBR(this);
  SummaryHomeMessagesPtBR get summary => SummaryHomeMessagesPtBR(this);
  MenuHomeMessagesPtBR get menu => MenuHomeMessagesPtBR(this);
  EmptyStateHomeMessagesPtBR get emptyState => EmptyStateHomeMessagesPtBR(this);
}

class CategoriesHomeMessagesPtBR extends CategoriesHomeMessages {
  final HomeMessagesPtBR _parent;
  const CategoriesHomeMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Notas Marcadas"
  /// ```
  String get notes => """Notas Marcadas""";

  /// ```dart
  /// "Movimentos Favoritos"
  /// ```
  String get moves => """Movimentos Favoritos""";

  /// ```dart
  /// "Feitiços Preparados"
  /// ```
  String get spells => """Feitiços Preparados""";

  /// ```dart
  /// "Itens Equipados"
  /// ```
  String get items => """Itens Equipados""";

  /// ```dart
  /// "Ações de Classe"
  /// ```
  String get classActions => """Ações de Classe""";
}

class SummaryHomeMessagesPtBR extends SummaryHomeMessages {
  final HomeMessagesPtBR _parent;
  const SummaryHomeMessagesPtBR(this._parent) : super(_parent);
  LoadSummaryHomeMessagesPtBR get load => LoadSummaryHomeMessagesPtBR(this);
  CoinsSummaryHomeMessagesPtBR get coins => CoinsSummaryHomeMessagesPtBR(this);
}

class LoadSummaryHomeMessagesPtBR extends LoadSummaryHomeMessages {
  final SummaryHomeMessagesPtBR _parent;
  const LoadSummaryHomeMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Carga: $cur/$max"
  /// ```
  String label(String cur, String max) => """Carga: $cur/$max""";

  /// ```dart
  /// "Carga Máxima"
  /// ```
  String get tooltip => """Carga Máxima""";
}

class CoinsSummaryHomeMessagesPtBR extends CoinsSummaryHomeMessages {
  final SummaryHomeMessagesPtBR _parent;
  const CoinsSummaryHomeMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "$amt G"
  /// ```
  String label(String amt) => """$amt G""";

  /// ```dart
  /// "Moedas"
  /// ```
  String get tooltip => """Moedas""";
}

class MenuHomeMessagesPtBR extends MenuHomeMessages {
  final HomeMessagesPtBR _parent;
  const MenuHomeMessagesPtBR(this._parent) : super(_parent);
  CharacterMenuHomeMessagesPtBR get character =>
      CharacterMenuHomeMessagesPtBR(this);

  /// ```dart
  /// "Biografia do Personagem"
  /// ```
  String get bio => """Biografia do Personagem""";

  /// ```dart
  /// "Debilidades"
  /// ```
  String get debilities => """Debilidades""";
}

class CharacterMenuHomeMessagesPtBR extends CharacterMenuHomeMessages {
  final MenuHomeMessagesPtBR _parent;
  const CharacterMenuHomeMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Menu do Personagem"
  /// ```
  String get tooltip => """Menu do Personagem""";

  /// ```dart
  /// "Informações Básicas"
  /// ```
  String get basicInfo => """Informações Básicas""";

  /// ```dart
  /// "Pontuações de Habilidade"
  /// ```
  String get abilityScores => """Pontuações de Habilidade""";

  /// ```dart
  /// "Botões de Rolagem Rápida"
  /// ```
  String get customRolls => """Botões de Rolagem Rápida""";

  /// ```dart
  /// "Tema do Personagem"
  /// ```
  String get theme => """Tema do Personagem""";
}

class EmptyStateHomeMessagesPtBR extends EmptyStateHomeMessages {
  final HomeMessagesPtBR _parent;
  const EmptyStateHomeMessagesPtBR(this._parent) : super(_parent);
  GuestEmptyStateHomeMessagesPtBR get guest =>
      GuestEmptyStateHomeMessagesPtBR(this);

  /// ```dart
  /// "Nenhum Personagem"
  /// ```
  String get title => """Nenhum Personagem""";

  /// ```dart
  /// "Crie um Personagem para começar"
  /// ```
  String get subtitle => """Crie um Personagem para começar""";
}

class GuestEmptyStateHomeMessagesPtBR extends GuestEmptyStateHomeMessages {
  final EmptyStateHomeMessagesPtBR _parent;
  const GuestEmptyStateHomeMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Entre para obter mais recursos"
  /// ```
  String get title => """Entre para obter mais recursos""";

  /// ```dart
  /// "Sincronização de dados online, compartilhamento de biblioteca, campanhas e muito mais!"
  /// ```
  String get subtitle =>
      """Sincronização de dados online, compartilhamento de biblioteca, campanhas e muito mais!""";
}

class AboutMessagesPtBR extends AboutMessages {
  final MessagesPtBR _parent;
  const AboutMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Sobre"
  /// ```
  String get title => """Sobre""";

  /// ```dart
  /// "Versão $version"
  /// ```
  String version(String version) => """Versão $version""";

  /// ```dart
  /// "Copyright © 2018-$year"
  /// ```
  String copyright(int year) => """Copyright © 2018-$year""";

  /// ```dart
  /// "Chen Asraf"
  /// ```
  String get author => """Chen Asraf""";
  ChangelogAboutMessagesPtBR get changelog => ChangelogAboutMessagesPtBR(this);
  DiscordAboutMessagesPtBR get discord => DiscordAboutMessagesPtBR(this);
  FeedbackAboutMessagesPtBR get feedback => FeedbackAboutMessagesPtBR(this);
  DonateAboutMessagesPtBR get donate => DonateAboutMessagesPtBR(this);
  SocialsAboutMessagesPtBR get socials => SocialsAboutMessagesPtBR(this);

  /// ```dart
  /// "Agradecimentos Especiais"
  /// ```
  String get specialThanks => """Agradecimentos Especiais""";

  /// ```dart
  /// "Contribuidores"
  /// ```
  String get contributors => """Contribuidores""";

  /// ```dart
  /// "Créditos dos Ícones"
  /// ```
  String get icons => """Créditos dos Ícones""";
}

class ChangelogAboutMessagesPtBR extends ChangelogAboutMessages {
  final AboutMessagesPtBR _parent;
  const ChangelogAboutMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "O que há de novo?"
  /// ```
  String get title => """O que há de novo?""";

  /// ```dart
  /// "Registro de mudanças das versões lançadas do Dungeon Paper"
  /// ```
  String get subtitle =>
      """Registro de mudanças das versões lançadas do Dungeon Paper""";
}

class DiscordAboutMessagesPtBR extends DiscordAboutMessages {
  final AboutMessagesPtBR _parent;
  const DiscordAboutMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Junte-se ao Nosso Discord"
  /// ```
  String get title => """Junte-se ao Nosso Discord""";

  /// ```dart
  /// "Junte-se à comunidade Discord para fazer perguntas, obter ajuda, enviar feedback ou simplesmente conversar com outros jogadores."
  /// ```
  String get subtitle =>
      """Junte-se à comunidade Discord para fazer perguntas, obter ajuda, enviar feedback ou simplesmente conversar com outros jogadores.""";
}

class FeedbackAboutMessagesPtBR extends FeedbackAboutMessages {
  final AboutMessagesPtBR _parent;
  const FeedbackAboutMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Enviar Feedback"
  /// ```
  String get title => """Enviar Feedback""";

  /// ```dart
  /// "Respondemos mais prontamente através do Discord, mas você pode nos enviar feedback, relatórios de bugs ou sugestões sobre o aplicativo diretamente aqui como alternativa."
  /// ```
  String get subtitle =>
      """Respondemos mais prontamente através do Discord, mas você pode nos enviar feedback, relatórios de bugs ou sugestões sobre o aplicativo diretamente aqui como alternativa.""";
}

class DonateAboutMessagesPtBR extends DonateAboutMessages {
  final AboutMessagesPtBR _parent;
  const DonateAboutMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Faça uma Doação"
  /// ```
  String get title => """Faça uma Doação""";

  /// ```dart
  /// "Se você está procurando uma maneira de apoiar o projeto, pode fazer uma doação na página oficial do Ko-fi do desenvolvedor. Clique aqui para ser redirecionado para a página do Ko-fi."
  /// ```
  String get subtitle =>
      """Se você está procurando uma maneira de apoiar o projeto, pode fazer uma doação na página oficial do Ko-fi do desenvolvedor. Clique aqui para ser redirecionado para a página do Ko-fi.""";
}

class SocialsAboutMessagesPtBR extends SocialsAboutMessages {
  final AboutMessagesPtBR _parent;
  const SocialsAboutMessagesPtBR(this._parent) : super(_parent);

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

class CharacterMessagesPtBR extends CharacterMessages {
  final MessagesPtBR _parent;
  const CharacterMessagesPtBR(this._parent) : super(_parent);
  DataCharacterMessagesPtBR get data => DataCharacterMessagesPtBR(this);
  HeaderCharacterMessagesPtBR get header => HeaderCharacterMessagesPtBR(this);

  /// ```dart
  /// "Sem Categoria"
  /// ```
  String get noCategory => """Sem Categoria""";
  ThemeCharacterMessagesPtBR get theme => ThemeCharacterMessagesPtBR(this);
}

class DataCharacterMessagesPtBR extends DataCharacterMessages {
  final CharacterMessagesPtBR _parent;
  const DataCharacterMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Moedas"
  /// ```
  String get coins => """Moedas""";
  LoadDataCharacterMessagesPtBR get load => LoadDataCharacterMessagesPtBR(this);

  /// ```dart
  /// "Nível"
  /// ```
  String get level => """Nível""";

  /// ```dart
  /// "Dados de Dano"
  /// ```
  String get damageDice => """Dados de Dano""";

  /// ```dart
  /// "Usar dados de dano da classe e itens equipados"
  /// ```
  String get calculateDamage =>
      """Usar dados de dano da classe e itens equipados""";
}

class LoadDataCharacterMessagesPtBR extends LoadDataCharacterMessages {
  final DataCharacterMessagesPtBR _parent;
  const LoadDataCharacterMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Carga"
  /// ```
  String get load => """Carga""";

  /// ```dart
  /// "Carga Máxima"
  /// ```
  String get maxLoad => """Carga Máxima""";

  /// ```dart
  /// "Usar carga base da classe + mod de FOR"
  /// ```
  String get autoMaxLoad => """Usar carga base da classe + mod de FOR""";
}

class HeaderCharacterMessagesPtBR extends HeaderCharacterMessages {
  final CharacterMessagesPtBR _parent;
  const HeaderCharacterMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Nível $lv"
  /// ```
  String level(int lv) => """Nível $lv""";

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

class ThemeCharacterMessagesPtBR extends ThemeCharacterMessages {
  final CharacterMessagesPtBR _parent;
  const ThemeCharacterMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Tema do Personagem"
  /// ```
  String get title => """Tema do Personagem""";

  /// ```dart
  /// "Tema padrão $type"
  /// ```
  String _defaultTheme(String type) => """Tema padrão $type""";

  /// ```dart
  /// "${_defaultTheme('claro')}"
  /// ```
  String get defaultLight => """${_defaultTheme('claro')}""";

  /// ```dart
  /// "${_defaultTheme('escuro')}"
  /// ```
  String get defaultDark => """${_defaultTheme('escuro')}""";
}

class CharacterClassMessagesPtBR extends CharacterClassMessages {
  final MessagesPtBR _parent;
  const CharacterClassMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Carga Base"
  /// ```
  String get baseLoad => """Carga Base""";

  /// ```dart
  /// "HP Base"
  /// ```
  String get baseHp => """HP Base""";

  /// ```dart
  /// "Dados de Dano"
  /// ```
  String get damageDice => """Dados de Dano""";
  IsSpellcasterCharacterClassMessagesPtBR get isSpellcaster =>
      IsSpellcasterCharacterClassMessagesPtBR(this);

  /// ```dart
  /// "Estatísticas"
  /// ```
  String get stats => """Estatísticas""";

  /// ```dart
  /// "Antecedentes"
  /// ```
  String get bio => """Antecedentes""";
  StartingGearCharacterClassMessagesPtBR get startingGear =>
      StartingGearCharacterClassMessagesPtBR(this);
}

class IsSpellcasterCharacterClassMessagesPtBR
    extends IsSpellcasterCharacterClassMessages {
  final CharacterClassMessagesPtBR _parent;
  const IsSpellcasterCharacterClassMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Classe de Feitiçaria"
  /// ```
  String get title => """Classe de Feitiçaria""";

  /// ```dart
  /// "Conjuradores são solicitados a selecionar feitiços (bem como movimentos) durante a criação do personagem e ao subir de nível."
  /// ```
  String get subtitle =>
      """Conjuradores são solicitados a selecionar feitiços (bem como movimentos) durante a criação do personagem e ao subir de nível.""";
}

class StartingGearCharacterClassMessagesPtBR
    extends StartingGearCharacterClassMessages {
  final CharacterClassMessagesPtBR _parent;
  const StartingGearCharacterClassMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Seleções de Equipamento Inicial"
  /// ```
  String get label => """Seleções de Equipamento Inicial""";
}

class StartingGearMessagesPtBR extends StartingGearMessages {
  final MessagesPtBR _parent;
  const StartingGearMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Editar Equipamento Inicial"
  /// ```
  String get titleEdit => """Editar Equipamento Inicial""";

  /// ```dart
  /// "Selecionar Equipamento Inicial"
  /// ```
  String get titleSelect => """Selecionar Equipamento Inicial""";

  /// ```dart
  /// "$amt G"
  /// ```
  String coins(String amt) => """$amt G""";

  /// ```dart
  /// "${amt}× $name"
  /// ```
  String item(String amt, String name) => """${amt}× $name""";
  ChoiceStartingGearMessagesPtBR get choice =>
      ChoiceStartingGearMessagesPtBR(this);
  SelectionStartingGearMessagesPtBR get selection =>
      SelectionStartingGearMessagesPtBR(this);
  OptionStartingGearMessagesPtBR get option =>
      OptionStartingGearMessagesPtBR(this);
}

class ChoiceStartingGearMessagesPtBR extends ChoiceStartingGearMessages {
  final StartingGearMessagesPtBR _parent;
  const ChoiceStartingGearMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Escolha $index"
  /// ```
  String title(int index) => """Escolha $index""";

  /// ```dart
  /// "Uma escolha é uma lista de seleções que o jogador pode fazer. Ela fornece um conjunto possível de itens e moedas que o jogador pode selecionar."
  /// ```
  String get helpText =>
      """Uma escolha é uma lista de seleções que o jogador pode fazer. Ela fornece um conjunto possível de itens e moedas que o jogador pode selecionar.""";
  DescriptionChoiceStartingGearMessagesPtBR get description =>
      DescriptionChoiceStartingGearMessagesPtBR(this);
  MaxSelectionsChoiceStartingGearMessagesPtBR get maxSelections =>
      MaxSelectionsChoiceStartingGearMessagesPtBR(this);

  /// ```dart
  /// "Mover para cima"
  /// ```
  String get moveUp => """Mover para cima""";

  /// ```dart
  /// "Mover para baixo"
  /// ```
  String get moveDown => """Mover para baixo""";
}

class DescriptionChoiceStartingGearMessagesPtBR
    extends DescriptionChoiceStartingGearMessages {
  final ChoiceStartingGearMessagesPtBR _parent;
  const DescriptionChoiceStartingGearMessagesPtBR(this._parent)
      : super(_parent);

  /// ```dart
  /// "Prompt"
  /// ```
  String get label => """Prompt""";

  /// ```dart
  /// "ex. Escolha sua arma"
  /// ```
  String get hintText => """ex. Escolha sua arma""";
}

class MaxSelectionsChoiceStartingGearMessagesPtBR
    extends MaxSelectionsChoiceStartingGearMessages {
  final ChoiceStartingGearMessagesPtBR _parent;
  const MaxSelectionsChoiceStartingGearMessagesPtBR(this._parent)
      : super(_parent);

  /// ```dart
  /// "Limite sugerido de seleção"
  /// ```
  String get label => """Limite sugerido de seleção""";

  /// ```dart
  /// "Isto sugerirá uma quantidade máxima a ser selecionada e exibirá uma contagem, mas não limitará a seleção. Use 0 ou deixe em branco para sem limite."
  /// ```
  String get helpText =>
      """Isto sugerirá uma quantidade máxima a ser selecionada e exibirá uma contagem, mas não limitará a seleção. Use 0 ou deixe em branco para sem limite.""";
}

class SelectionStartingGearMessagesPtBR extends SelectionStartingGearMessages {
  final StartingGearMessagesPtBR _parent;
  const SelectionStartingGearMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Conjunto de Equipamento"
  /// ```
  String get title => """Conjunto de Equipamento""";

  /// ```dart
  /// "Cada conjunto de equipamento consiste em uma quantidade de moedas e uma lista de itens a serem dados ao personagem. Escolher um conjunto de equipamento dará ao personagem todos os itens e ouro daquele conjunto."
  /// ```
  String get helpText =>
      """Cada conjunto de equipamento consiste em uma quantidade de moedas e uma lista de itens a serem dados ao personagem. Escolher um conjunto de equipamento dará ao personagem todos os itens e ouro daquele conjunto.""";

  /// ```dart
  /// "Adicionar Conjunto de Equipamento"
  /// ```
  String get add => """Adicionar Conjunto de Equipamento""";
  DescriptionSelectionStartingGearMessagesPtBR get description =>
      DescriptionSelectionStartingGearMessagesPtBR(this);
  CoinsSelectionStartingGearMessagesPtBR get coins =>
      CoinsSelectionStartingGearMessagesPtBR(this);
}

class DescriptionSelectionStartingGearMessagesPtBR
    extends DescriptionSelectionStartingGearMessages {
  final SelectionStartingGearMessagesPtBR _parent;
  const DescriptionSelectionStartingGearMessagesPtBR(this._parent)
      : super(_parent);

  /// ```dart
  /// "Descrição da seleção"
  /// ```
  String get label => """Descrição da seleção""";

  /// ```dart
  /// "ex. A espada antiga do seu pai, e 10 moedas"
  /// ```
  String get hintText => """ex. A espada antiga do seu pai, e 10 moedas""";
}

class CoinsSelectionStartingGearMessagesPtBR
    extends CoinsSelectionStartingGearMessages {
  final SelectionStartingGearMessagesPtBR _parent;
  const CoinsSelectionStartingGearMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Moedas"
  /// ```
  String get label => """Moedas""";

  /// ```dart
  /// "0"
  /// ```
  String get hintText => """0""";
}

class OptionStartingGearMessagesPtBR extends OptionStartingGearMessages {
  final StartingGearMessagesPtBR _parent;
  const OptionStartingGearMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Itens do Conjunto de Equipamento"
  /// ```
  String get title => """Itens do Conjunto de Equipamento""";

  /// ```dart
  /// "Cada item do conjunto de equipamento consiste em X quantidade de um item específico."
  /// ```
  String get helpText =>
      """Cada item do conjunto de equipamento consiste em X quantidade de um item específico.""";

  /// ```dart
  /// "Adicionar Itens"
  /// ```
  String get add => """Adicionar Itens""";
  AmountOptionStartingGearMessagesPtBR get amount =>
      AmountOptionStartingGearMessagesPtBR(this);
}

class AmountOptionStartingGearMessagesPtBR
    extends AmountOptionStartingGearMessages {
  final OptionStartingGearMessagesPtBR _parent;
  const AmountOptionStartingGearMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Quantidade"
  /// ```
  String get label => """Quantidade""";

  /// ```dart
  /// "1"
  /// ```
  String get hintText => """1""";
}

class DiceMessagesPtBR extends DiceMessages {
  final MessagesPtBR _parent;
  const DiceMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Sugestão: $dice"
  /// ```
  String suggestion(String dice) => """Sugestão: $dice""";
  FormDiceMessagesPtBR get form => FormDiceMessagesPtBR(this);
  RollDiceMessagesPtBR get roll => RollDiceMessagesPtBR(this);
}

class FormDiceMessagesPtBR extends FormDiceMessages {
  final DiceMessagesPtBR _parent;
  const FormDiceMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Quantidade"
  /// ```
  String get amount => """Quantidade""";

  /// ```dart
  /// "Lados"
  /// ```
  String get sides => """Lados""";

  /// ```dart
  /// "d"
  /// ```
  String get diceSeparator => """d""";
  ModifierTypeFormDiceMessagesPtBR get modifierType =>
      ModifierTypeFormDiceMessagesPtBR(this);
  ValueFormDiceMessagesPtBR get value => ValueFormDiceMessagesPtBR(this);
  ModifierFormDiceMessagesPtBR get modifier =>
      ModifierFormDiceMessagesPtBR(this);

  /// ```dart
  /// "$name ($key)"
  /// ```
  String statValue(String name, String key) => """$name ($key)""";
}

class ModifierTypeFormDiceMessagesPtBR extends ModifierTypeFormDiceMessages {
  final FormDiceMessagesPtBR _parent;
  const ModifierTypeFormDiceMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Valor Fixo"
  /// ```
  String get fixed => """Valor Fixo""";

  /// ```dart
  /// "Modificador de Atributo"
  /// ```
  String get modifier => """Modificador de Atributo""";
}

class ValueFormDiceMessagesPtBR extends ValueFormDiceMessages {
  final FormDiceMessagesPtBR _parent;
  const ValueFormDiceMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Número, ex. 2 ou -1"
  /// ```
  String get placeholder => """Número, ex. 2 ou -1""";

  /// ```dart
  /// "Valor do modificador"
  /// ```
  String get label => """Valor do modificador""";
}

class ModifierFormDiceMessagesPtBR extends ModifierFormDiceMessages {
  final FormDiceMessagesPtBR _parent;
  const ModifierFormDiceMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Selecionar atributo"
  /// ```
  String get placeholder => """Selecionar atributo""";

  /// ```dart
  /// "Atributo"
  /// ```
  String get label => """Atributo""";
}

class RollDiceMessagesPtBR extends RollDiceMessages {
  final DiceMessagesPtBR _parent;
  const RollDiceMessagesPtBR(this._parent) : super(_parent);
  TitleRollDiceMessagesPtBR get title => TitleRollDiceMessagesPtBR(this);

  /// ```dart
  /// "Rolar"
  /// ```
  String get action => """Rolar""";

  /// ```dart
  /// "Total $amt"
  /// ```
  String total(int amt) => """Total $amt""";

  /// ```dart
  /// "Dados: $dice | Modificador: $mod"
  /// ```
  String resultBreakdown(String dice, String mod) =>
      """Dados: $dice | Modificador: $mod""";
}

class TitleRollDiceMessagesPtBR extends TitleRollDiceMessages {
  final RollDiceMessagesPtBR _parent;
  const TitleRollDiceMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Rolou $total"
  /// ```
  String rolled(int total) => """Rolou $total""";

  /// ```dart
  /// "Rolando $amt ${_plural(amt, one: 'dado', many: 'dados')}"
  /// ```
  String rolling(int amt) =>
      """Rolando $amt ${_plural(amt, one: 'dado', many: 'dados')}""";
}

class BasicInfoMessagesPtBR extends BasicInfoMessages {
  final MessagesPtBR _parent;
  const BasicInfoMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Informações Básicas"
  /// ```
  String get title => """Informações Básicas""";
  FormBasicInfoMessagesPtBR get form => FormBasicInfoMessagesPtBR(this);
}

class FormBasicInfoMessagesPtBR extends FormBasicInfoMessages {
  final BasicInfoMessagesPtBR _parent;
  const FormBasicInfoMessagesPtBR(this._parent) : super(_parent);
  NameFormBasicInfoMessagesPtBR get name => NameFormBasicInfoMessagesPtBR(this);
  PhotoFormBasicInfoMessagesPtBR get photo =>
      PhotoFormBasicInfoMessagesPtBR(this);
}

class NameFormBasicInfoMessagesPtBR extends NameFormBasicInfoMessages {
  final FormBasicInfoMessagesPtBR _parent;
  const NameFormBasicInfoMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Nome do Personagem"
  /// ```
  String get label => """Nome do Personagem""";

  /// ```dart
  /// "Digite o nome do seu personagem"
  /// ```
  String get placeholder => """Digite o nome do seu personagem""";
  RandomNameFormBasicInfoMessagesPtBR get random =>
      RandomNameFormBasicInfoMessagesPtBR(this);
}

class RandomNameFormBasicInfoMessagesPtBR
    extends RandomNameFormBasicInfoMessages {
  final NameFormBasicInfoMessagesPtBR _parent;
  const RandomNameFormBasicInfoMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "$act para gerar um nome aleatório"
  /// ```
  String tooltip(String act) => """$act para gerar um nome aleatório""";
}

class PhotoFormBasicInfoMessagesPtBR extends PhotoFormBasicInfoMessages {
  final FormBasicInfoMessagesPtBR _parent;
  const PhotoFormBasicInfoMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Alterar Foto..."
  /// ```
  String get change => """Alterar Foto...""";

  /// ```dart
  /// "Remover Foto"
  /// ```
  String get remove => """Remover Foto""";

  /// ```dart
  /// "Escolher Foto..."
  /// ```
  String get choose => """Escolher Foto...""";
  GuestPhotoFormBasicInfoMessagesPtBR get guest =>
      GuestPhotoFormBasicInfoMessagesPtBR(this);

  /// ```dart
  /// "CARREGANDO..."
  /// ```
  String get uploading => """CARREGANDO...""";

  /// ```dart
  /// "OU"
  /// ```
  String get orSeparator => """OU""";
  UrlPhotoFormBasicInfoMessagesPtBR get url =>
      UrlPhotoFormBasicInfoMessagesPtBR(this);
}

class GuestPhotoFormBasicInfoMessagesPtBR
    extends GuestPhotoFormBasicInfoMessages {
  final PhotoFormBasicInfoMessagesPtBR _parent;
  const GuestPhotoFormBasicInfoMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Você precisa estar logado para carregar imagens. "
  /// ```
  String get prefix => """Você precisa estar logado para carregar imagens. """;

  /// ```dart
  /// "Entre ou crie uma conta"
  /// ```
  String get label => """Entre ou crie uma conta""";

  /// ```dart
  /// ", ou faça o upload usando seu próprio URL abaixo."
  /// ```
  String get suffix => """, ou faça o upload usando seu próprio URL abaixo.""";
}

class UrlPhotoFormBasicInfoMessagesPtBR extends UrlPhotoFormBasicInfoMessages {
  final PhotoFormBasicInfoMessagesPtBR _parent;
  const UrlPhotoFormBasicInfoMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "URL da Imagem"
  /// ```
  String get label => """URL da Imagem""";

  /// ```dart
  /// "Cole um URL de imagem"
  /// ```
  String get placeholder => """Cole um URL de imagem""";
}

class DebilitiesMessagesPtBR extends DebilitiesMessages {
  final MessagesPtBR _parent;
  const DebilitiesMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "$name ($key)"
  /// ```
  String label(String name, String key) => """$name ($key)""";
  DialogDebilitiesMessagesPtBR get dialog => DialogDebilitiesMessagesPtBR(this);
}

class DialogDebilitiesMessagesPtBR extends DialogDebilitiesMessages {
  final DebilitiesMessagesPtBR _parent;
  const DialogDebilitiesMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Debilidades"
  /// ```
  String get title => """Debilidades""";

  /// ```dart
  /// "Debilidades são condições ou estados negativos temporários em que seu personagem se encontra. Quando um atributo está debilitado, ele reduz seu modificador em 1 até se recuperar."
  /// ```
  String get info =>
      """Debilidades são condições ou estados negativos temporários em que seu personagem se encontra. Quando um atributo está debilitado, ele reduz seu modificador em 1 até se recuperar.""";
}

class TagsMessagesPtBR extends TagsMessages {
  final MessagesPtBR _parent;
  const TagsMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Copiar de: $name"
  /// ```
  String copyFrom(String name) => """Copiar de: $name""";
  DialogTagsMessagesPtBR get dialog => DialogTagsMessagesPtBR(this);
}

class DialogTagsMessagesPtBR extends DialogTagsMessages {
  final TagsMessagesPtBR _parent;
  const DialogTagsMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Informações da Tag"
  /// ```
  String get title => """Informações da Tag""";
}

class DialogsMessagesPtBR extends DialogsMessages {
  final MessagesPtBR _parent;
  const DialogsMessagesPtBR(this._parent) : super(_parent);
  ConfirmationsDialogsMessagesPtBR get confirmations =>
      ConfirmationsDialogsMessagesPtBR(this);
}

class ConfirmationsDialogsMessagesPtBR extends ConfirmationsDialogsMessages {
  final DialogsMessagesPtBR _parent;
  const ConfirmationsDialogsMessagesPtBR(this._parent) : super(_parent);
  DeleteConfirmationsDialogsMessagesPtBR get delete =>
      DeleteConfirmationsDialogsMessagesPtBR(this);
  ExitConfirmationsDialogsMessagesPtBR get exit =>
      ExitConfirmationsDialogsMessagesPtBR(this);
  DeleteAccountConfirmationsDialogsMessagesPtBR get deleteAccount =>
      DeleteAccountConfirmationsDialogsMessagesPtBR(this);
}

class DeleteConfirmationsDialogsMessagesPtBR
    extends DeleteConfirmationsDialogsMessages {
  final ConfirmationsDialogsMessagesPtBR _parent;
  const DeleteConfirmationsDialogsMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Excluir $ent?"
  /// ```
  String title(String ent) => """Excluir $ent?""";

  /// ```dart
  /// "Tem certeza de que deseja remover o $ent "$name" da lista?"
  /// ```
  String body(String ent, String name) =>
      """Tem certeza de que deseja remover o $ent "$name" da lista?""";
}

class ExitConfirmationsDialogsMessagesPtBR
    extends ExitConfirmationsDialogsMessages {
  final ConfirmationsDialogsMessagesPtBR _parent;
  const ExitConfirmationsDialogsMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Você tem certeza?"
  /// ```
  String get title => """Você tem certeza?""";

  /// ```dart
  /// "Voltar perderá todas as mudanças não salvas.\nTem certeza de que deseja voltar?"
  /// ```
  String get body =>
      """Voltar perderá todas as mudanças não salvas.\nTem certeza de que deseja voltar?""";

  /// ```dart
  /// "Sair e Descartar"
  /// ```
  String get ok => """Sair e Descartar""";

  /// ```dart
  /// "Continuar editando"
  /// ```
  String get cancel => """Continuar editando""";
}

class DeleteAccountConfirmationsDialogsMessagesPtBR
    extends DeleteAccountConfirmationsDialogsMessages {
  final ConfirmationsDialogsMessagesPtBR _parent;
  const DeleteAccountConfirmationsDialogsMessagesPtBR(this._parent)
      : super(_parent);
  Step1DeleteAccountConfirmationsDialogsMessagesPtBR get step1 =>
      Step1DeleteAccountConfirmationsDialogsMessagesPtBR(this);
  Step2DeleteAccountConfirmationsDialogsMessagesPtBR get step2 =>
      Step2DeleteAccountConfirmationsDialogsMessagesPtBR(this);
}

class Step1DeleteAccountConfirmationsDialogsMessagesPtBR
    extends Step1DeleteAccountConfirmationsDialogsMessages {
  final DeleteAccountConfirmationsDialogsMessagesPtBR _parent;
  const Step1DeleteAccountConfirmationsDialogsMessagesPtBR(this._parent)
      : super(_parent);

  /// ```dart
  /// "Excluir sua Conta?"
  /// ```
  String get title => """Excluir sua Conta?""";

  /// ```dart
  /// "Tem certeza de que deseja excluir sua conta?\n\nEsta ação não pode ser desfeita."
  /// ```
  String get body =>
      """Tem certeza de que deseja excluir sua conta?\n\nEsta ação não pode ser desfeita.""";
}

class Step2DeleteAccountConfirmationsDialogsMessagesPtBR
    extends Step2DeleteAccountConfirmationsDialogsMessages {
  final DeleteAccountConfirmationsDialogsMessagesPtBR _parent;
  const Step2DeleteAccountConfirmationsDialogsMessagesPtBR(this._parent)
      : super(_parent);

  /// ```dart
  /// "Tem certeza mesmo?"
  /// ```
  String get title => """Tem certeza mesmo?""";

  /// ```dart
  /// "Não salvamos nenhum dado de contas excluídas. Todos os seus dados serão permanentemente deletados.\n\nTem certeza de que deseja excluir sua conta?\n\nPor favor, confirme uma última vez."
  /// ```
  String get body =>
      """Não salvamos nenhum dado de contas excluídas. Todos os seus dados serão permanentemente deletados.\n\nTem certeza de que deseja excluir sua conta?\n\nPor favor, confirme uma última vez.""";
}

class MovesMessagesPtBR extends MovesMessages {
  final MessagesPtBR _parent;
  const MovesMessagesPtBR(this._parent) : super(_parent);
  CategoryMovesMessagesPtBR get category => CategoryMovesMessagesPtBR(this);
}

class CategoryMovesMessagesPtBR extends CategoryMovesMessages {
  final MovesMessagesPtBR _parent;
  const CategoryMovesMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// """
  /// ${switch (cat) {
  ///   'starting' => 'Inicial',
  ///   'basic' => 'Básico',
  ///   'special' => 'Especial',
  ///   'advanced1' => 'Avançado',
  ///   'advanced2' => 'Avançado+',
  ///   _ => 'Outro'
  /// }}
  /// """
  /// ```
  String shortName(String cat) => """${switch (cat) {
        'starting' => 'Inicial',
        'basic' => 'Básico',
        'special' => 'Especial',
        'advanced1' => 'Avançado',
        'advanced2' => 'Avançado+',
        _ => 'Outro'
      }}""";

  /// ```dart
  /// """
  /// ${switch (cat) {
  ///   'starting' => 'Inicial',
  ///   'basic' => 'Básico',
  ///   'special' => 'Especial',
  ///   'advanced1' => 'Avançado (1-5)',
  ///   'advanced2' => 'Avançado (6-10)',
  ///   _ => 'Outro'
  /// }}
  /// """
  /// ```
  String mediumName(String cat) => """${switch (cat) {
        'starting' => 'Inicial',
        'basic' => 'Básico',
        'special' => 'Especial',
        'advanced1' => 'Avançado (1-5)',
        'advanced2' => 'Avançado (6-10)',
        _ => 'Outro'
      }}""";

  /// ```dart
  /// """
  /// ${switch (cat) {
  ///   'starting' => 'Inicial',
  ///   'basic' => 'Básico',
  ///   'special' => 'Especial',
  ///   'advanced1' => 'Avançado (nível 1-5)',
  ///   'advanced2' => 'Avançado (nível 6-10)',
  ///   _ => 'Outro'
  /// }}
  /// """
  /// ```
  String longName(String cat) => """${switch (cat) {
        'starting' => 'Inicial',
        'basic' => 'Básico',
        'special' => 'Especial',
        'advanced1' => 'Avançado (nível 1-5)',
        'advanced2' => 'Avançado (nível 6-10)',
        _ => 'Outro'
      }}""";
}

class SpellsMessagesPtBR extends SpellsMessages {
  final MessagesPtBR _parent;
  const SpellsMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// """
  /// ${switch (level) {
  ///   'rote' => 'Rotina',
  ///   'cantrip' => 'Truque',
  ///   _ =>  'Nível $level',
  /// }}
  /// """
  /// ```
  String spellLevel(String level) => """${switch (level) {
        'rote' => 'Rotina',
        'cantrip' => 'Truque',
        _ => 'Nível $level',
      }}""";
}

class ItemsMessagesPtBR extends ItemsMessages {
  final MessagesPtBR _parent;
  const ItemsMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "× $amt"
  /// ```
  String amount(String amt) => """× $amt""";

  /// ```dart
  /// "Quantidade"
  /// ```
  String get amountTooltip => """Quantidade""";
  SettingsItemsMessagesPtBR get settings => SettingsItemsMessagesPtBR(this);
}

class SettingsItemsMessagesPtBR extends SettingsItemsMessages {
  final ItemsMessagesPtBR _parent;
  const SettingsItemsMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Contar Armadura"
  /// ```
  String get countArmor => """Contar Armadura""";

  /// ```dart
  /// "Contar Dano"
  /// ```
  String get countDamage => """Contar Dano""";

  /// ```dart
  /// "Contar Peso"
  /// ```
  String get countWeight => """Contar Peso""";
}

class NotesMessagesPtBR extends NotesMessages {
  final MessagesPtBR _parent;
  const NotesMessagesPtBR(this._parent) : super(_parent);
  CategoryNotesMessagesPtBR get category => CategoryNotesMessagesPtBR(this);

  /// ```dart
  /// "Geral"
  /// ```
  String get noCategory => """Geral""";
  EmptyStateNotesMessagesPtBR get emptyState =>
      EmptyStateNotesMessagesPtBR(this);
}

class CategoryNotesMessagesPtBR extends CategoryNotesMessages {
  final NotesMessagesPtBR _parent;
  const CategoryNotesMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Categoria"
  /// ```
  String get label => """Categoria""";
}

class EmptyStateNotesMessagesPtBR extends EmptyStateNotesMessages {
  final NotesMessagesPtBR _parent;
  const EmptyStateNotesMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Sem Notas"
  /// ```
  String get title => """Sem Notas""";

  /// ```dart
  /// "Você pode registrar seu progresso, memorandos, listas, mapas e muito mais usando o diário."
  /// ```
  String get subtitle =>
      """Você pode registrar seu progresso, memorandos, listas, mapas e muito mais usando o diário.""";

  /// ```dart
  /// "Criar Nota"
  /// ```
  String get button => """Criar Nota""";
}

class AlignmentMessagesPtBR extends AlignmentMessages {
  final MessagesPtBR _parent;
  const AlignmentMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// """
  /// ${switch (key) {
  ///   'chaotic' => 'Caótico',
  ///   'evil' => 'Maligno',
  ///   'good' => 'Bom',
  ///   'lawful' => 'Ordeiro',
  ///   'neutral' => 'Neutro',
  ///   _ => key,
  /// }}
  /// """
  /// ```
  String name(String key) => """${switch (key) {
        'chaotic' => 'Caótico',
        'evil' => 'Maligno',
        'good' => 'Bom',
        'lawful' => 'Ordeiro',
        'neutral' => 'Neutro',
        _ => key,
      }}""";
  AlignmentValuesAlignmentMessagesPtBR get alignmentValues =>
      AlignmentValuesAlignmentMessagesPtBR(this);
}

class AlignmentValuesAlignmentMessagesPtBR
    extends AlignmentValuesAlignmentMessages {
  final AlignmentMessagesPtBR _parent;
  const AlignmentValuesAlignmentMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Alinhamentos"
  /// ```
  String get title => """Alinhamentos""";
}

class BioMessagesPtBR extends BioMessages {
  final MessagesPtBR _parent;
  const BioMessagesPtBR(this._parent) : super(_parent);
  DialogBioMessagesPtBR get dialog => DialogBioMessagesPtBR(this);
}

class DialogBioMessagesPtBR extends DialogBioMessages {
  final BioMessagesPtBR _parent;
  const DialogBioMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Biografia do Personagem"
  /// ```
  String get title => """Biografia do Personagem""";
  DescriptionDialogBioMessagesPtBR get description =>
      DescriptionDialogBioMessagesPtBR(this);
  LooksDialogBioMessagesPtBR get looks => LooksDialogBioMessagesPtBR(this);
  AlignmentDialogBioMessagesPtBR get alignment =>
      AlignmentDialogBioMessagesPtBR(this);
  AlignmentDescriptionDialogBioMessagesPtBR get alignmentDescription =>
      AlignmentDescriptionDialogBioMessagesPtBR(this);
}

class DescriptionDialogBioMessagesPtBR extends DescriptionDialogBioMessages {
  final DialogBioMessagesPtBR _parent;
  const DescriptionDialogBioMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Descrição do personagem e antecedentes"
  /// ```
  String get label => """Descrição do personagem e antecedentes""";

  /// ```dart
  /// "Descreva o histórico, a personalidade, os objetivos, etc., do seu personagem."
  /// ```
  String get placeholder =>
      """Descreva o histórico, a personalidade, os objetivos, etc., do seu personagem.""";
}

class LooksDialogBioMessagesPtBR extends LooksDialogBioMessages {
  final DialogBioMessagesPtBR _parent;
  const LooksDialogBioMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Aparência"
  /// ```
  String get label => """Aparência""";

  /// ```dart
  /// "Descreva a aparência do seu personagem. Você pode usar os presets dos botões acima."
  /// ```
  String get placeholder =>
      """Descreva a aparência do seu personagem. Você pode usar os presets dos botões acima.""";
}

class AlignmentDialogBioMessagesPtBR extends AlignmentDialogBioMessages {
  final DialogBioMessagesPtBR _parent;
  const AlignmentDialogBioMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Alinhamento"
  /// ```
  String get label => """Alinhamento""";
}

class AlignmentDescriptionDialogBioMessagesPtBR
    extends AlignmentDescriptionDialogBioMessages {
  final DialogBioMessagesPtBR _parent;
  const AlignmentDescriptionDialogBioMessagesPtBR(this._parent)
      : super(_parent);

  /// ```dart
  /// "Descrição do Alinhamento"
  /// ```
  String get label => """Descrição do Alinhamento""";

  /// ```dart
  /// "Alinhamento é a maneira como seu personagem pensa e sua bússola moral. Isso pode se basear em um ideal ético, restrições religiosas ou eventos da vida inicial. Reflete o que seu personagem valoriza e aspira proteger ou criar."
  /// ```
  String get placeholder =>
      """Alinhamento é a maneira como seu personagem pensa e sua bússola moral. Isso pode se basear em um ideal ético, restrições religiosas ou eventos da vida inicial. Reflete o que seu personagem valoriza e aspira proteger ou criar.""";
}

class SearchMessagesPtBR extends SearchMessages {
  final MessagesPtBR _parent;
  const SearchMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Digite para pesquisar"
  /// ```
  String get placeholder => """Digite para pesquisar""";

  /// ```dart
  /// "Digite para pesquisar $ent"
  /// ```
  String placeholderEntity(String ent) => """Digite para pesquisar $ent""";

  /// ```dart
  /// "Pesquisar em"
  /// ```
  String get searchIn => """Pesquisar em""";
}

class HpMessagesPtBR extends HpMessages {
  final MessagesPtBR _parent;
  const HpMessagesPtBR(this._parent) : super(_parent);
  DialogHpMessagesPtBR get dialog => DialogHpMessagesPtBR(this);
  BarHpMessagesPtBR get bar => BarHpMessagesPtBR(this);
}

class DialogHpMessagesPtBR extends DialogHpMessages {
  final HpMessagesPtBR _parent;
  const DialogHpMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Modificar HP"
  /// ```
  String get title => """Modificar HP""";
  ChangeDialogHpMessagesPtBR get change => ChangeDialogHpMessagesPtBR(this);

  /// ```dart
  /// "Substituir HP Máximo"
  /// ```
  String get overrideMax => """Substituir HP Máximo""";
}

class ChangeDialogHpMessagesPtBR extends ChangeDialogHpMessages {
  final DialogHpMessagesPtBR _parent;
  const ChangeDialogHpMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Curar\n+$amt"
  /// ```
  String add(int amt) => """Curar\n+$amt""";

  /// ```dart
  /// "Dano\n-$amt"
  /// ```
  String remove(int amt) => """Dano\n-$amt""";

  /// ```dart
  /// "Sem Alteração"
  /// ```
  String get neutral => """Sem Alteração""";
}

class BarHpMessagesPtBR extends BarHpMessages {
  final HpMessagesPtBR _parent;
  const BarHpMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "HP"
  /// ```
  String get label => """HP""";

  /// ```dart
  /// "$act para modificar seu HP"
  /// ```
  String tooltip(String act) => """$act para modificar seu HP""";
}

class XpMessagesPtBR extends XpMessages {
  final MessagesPtBR _parent;
  const XpMessagesPtBR(this._parent) : super(_parent);
  DialogXpMessagesPtBR get dialog => DialogXpMessagesPtBR(this);
  BarXpMessagesPtBR get bar => BarXpMessagesPtBR(this);
}

class DialogXpMessagesPtBR extends DialogXpMessages {
  final XpMessagesPtBR _parent;
  const DialogXpMessagesPtBR(this._parent) : super(_parent);
  EndOfSessionDialogXpMessagesPtBR get endOfSession =>
      EndOfSessionDialogXpMessagesPtBR(this);
  LevelUpDialogXpMessagesPtBR get levelUp => LevelUpDialogXpMessagesPtBR(this);
  OverwriteDialogXpMessagesPtBR get overwrite =>
      OverwriteDialogXpMessagesPtBR(this);
}

class EndOfSessionDialogXpMessagesPtBR extends EndOfSessionDialogXpMessages {
  final DialogXpMessagesPtBR _parent;
  const EndOfSessionDialogXpMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Finalizar Sessão"
  /// ```
  String get title => """Finalizar Sessão""";

  /// ```dart
  /// "Finalizar Sessão"
  /// ```
  String get button => """Finalizar Sessão""";
  QuestionsEndOfSessionDialogXpMessagesPtBR get questions =>
      QuestionsEndOfSessionDialogXpMessagesPtBR(this);
}

class QuestionsEndOfSessionDialogXpMessagesPtBR
    extends QuestionsEndOfSessionDialogXpMessages {
  final EndOfSessionDialogXpMessagesPtBR _parent;
  const QuestionsEndOfSessionDialogXpMessagesPtBR(this._parent)
      : super(_parent);

  /// ```dart
  /// "Perguntas de Fim de Sessão"
  /// ```
  String get title => """Perguntas de Fim de Sessão""";

  /// ```dart
  /// "Responda a essas perguntas em grupo. Para cada resposta "sim", marca-se XP."
  /// ```
  String get subtitle =>
      """Responda a essas perguntas em grupo. Para cada resposta "sim", marca-se XP.""";
}

class LevelUpDialogXpMessagesPtBR extends LevelUpDialogXpMessages {
  final DialogXpMessagesPtBR _parent;
  const LevelUpDialogXpMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Subir de Nível"
  /// ```
  String get title => """Subir de Nível""";

  /// ```dart
  /// "Subir de Nível"
  /// ```
  String get button => """Subir de Nível""";

  /// ```dart
  /// "Aumentar um atributo em 1:"
  /// ```
  String get increaseStat => """Aumentar um atributo em 1:""";
  ChooseLevelUpDialogXpMessagesPtBR get choose =>
      ChooseLevelUpDialogXpMessagesPtBR(this);
}

class ChooseLevelUpDialogXpMessagesPtBR extends ChooseLevelUpDialogXpMessages {
  final LevelUpDialogXpMessagesPtBR _parent;
  const ChooseLevelUpDialogXpMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Então, selecione $what:"
  /// ```
  String info(String what) => """Então, selecione $what:""";

  /// ```dart
  /// "$ent1 e $ent2"
  /// ```
  String both(String ent1, String ent2) => """$ent1 e $ent2""";

  /// ```dart
  /// "um movimento avançado"
  /// ```
  String get move => """um movimento avançado""";

  /// ```dart
  /// "um feitiço"
  /// ```
  String get spell => """um feitiço""";
}

class OverwriteDialogXpMessagesPtBR extends OverwriteDialogXpMessages {
  final DialogXpMessagesPtBR _parent;
  const OverwriteDialogXpMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Sobrescrever XP e Nível"
  /// ```
  String get title => """Sobrescrever XP e Nível""";

  /// ```dart
  /// "Sobrescrever"
  /// ```
  String get button => """Sobrescrever""";

  /// ```dart
  /// "Alterar manualmente o XP ou o nível atual fará com que o XP pendente seja descartado, a menos que isso seja desmarcado."
  /// ```
  String get info =>
      """Alterar manualmente o XP ou o nível atual fará com que o XP pendente seja descartado, a menos que isso seja desmarcado.""";

  /// ```dart
  /// "Redefinir vínculos, bandeiras e perguntas de fim de sessão após salvar"
  /// ```
  String get resetCheckbox =>
      """Redefinir vínculos, bandeiras e perguntas de fim de sessão após salvar""";

  /// ```dart
  /// "Sobrescrever XP"
  /// ```
  String get xp => """Sobrescrever XP""";

  /// ```dart
  /// "Sobrescrever Nível"
  /// ```
  String get level => """Sobrescrever Nível""";
}

class BarXpMessagesPtBR extends BarXpMessages {
  final XpMessagesPtBR _parent;
  const BarXpMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "XP"
  /// ```
  String get label => """XP""";

  /// ```dart
  /// "$act para encerrar a sessão, subir de nível ou atualizar seu XP"
  /// ```
  String tooltip(String act) =>
      """$act para encerrar a sessão, subir de nível ou atualizar seu XP""";

  /// ```dart
  /// "$act para adicionar +1 XP"
  /// ```
  String plusOneTooltip(String act) => """$act para adicionar +1 XP""";
}

class ArmorMessagesPtBR extends ArmorMessages {
  final MessagesPtBR _parent;
  const ArmorMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Armadura"
  /// ```
  String get title => """Armadura""";
  DialogArmorMessagesPtBR get dialog => DialogArmorMessagesPtBR(this);
}

class DialogArmorMessagesPtBR extends DialogArmorMessages {
  final ArmorMessagesPtBR _parent;
  const DialogArmorMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Armadura"
  /// ```
  String get title => """Armadura""";

  /// ```dart
  /// "Usar armadura da classe e itens equipados"
  /// ```
  String get autoArmor => """Usar armadura da classe e itens equipados""";
}

class RichTextMessagesPtBR extends RichTextMessages {
  final MessagesPtBR _parent;
  const RichTextMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Pré-visualização"
  /// ```
  String get preview => """Pré-visualização""";

  /// ```dart
  /// "Ajuda de Formatação"
  /// ```
  String get help => """Ajuda de Formatação""";

  /// ```dart
  /// "Negrito"
  /// ```
  String get bold => """Negrito""";

  /// ```dart
  /// "Itálico"
  /// ```
  String get italic => """Itálico""";

  /// ```dart
  /// "Cabeçalhos"
  /// ```
  String get headings => """Cabeçalhos""";

  /// ```dart
  /// "Cabeçalho $depth"
  /// ```
  String heading(int depth) => """Cabeçalho $depth""";

  /// ```dart
  /// "Lista com Marcadores"
  /// ```
  String get bulletList => """Lista com Marcadores""";

  /// ```dart
  /// "Lista Numerada"
  /// ```
  String get numberedList => """Lista Numerada""";
  CheckListRichTextMessagesPtBR get checkList =>
      CheckListRichTextMessagesPtBR(this);

  /// ```dart
  /// "URL"
  /// ```
  String get url => """URL""";

  /// ```dart
  /// "URL da Imagem"
  /// ```
  String get imageURL => """URL da Imagem""";

  /// ```dart
  /// "Tabela"
  /// ```
  String get table => """Tabela""";

  /// ```dart
  /// "Cabeçalho $n"
  /// ```
  String header(Object n) => """Cabeçalho $n""";

  /// ```dart
  /// "Célula $n"
  /// ```
  String cell(int n) => """Célula $n""";

  /// ```dart
  /// "Pré-visualização de Markdown"
  /// ```
  String get markdownPreview => """Pré-visualização de Markdown""";

  /// ```dart
  /// "Adicionar Data Atual"
  /// ```
  String get date => """Adicionar Data Atual""";

  /// ```dart
  /// "Adicionar Hora Atual"
  /// ```
  String get time => """Adicionar Hora Atual""";
}

class CheckListRichTextMessagesPtBR extends CheckListRichTextMessages {
  final RichTextMessagesPtBR _parent;
  const CheckListRichTextMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Lista de Verificação (Não Marcada)"
  /// ```
  String get unchecked => """Lista de Verificação (Não Marcada)""";

  /// ```dart
  /// "Lista de Verificação (Marcada)"
  /// ```
  String get checked => """Lista de Verificação (Marcada)""";
}

class CustomRollsMessagesPtBR extends CustomRollsMessages {
  final MessagesPtBR _parent;
  const CustomRollsMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Botões de Rolagem Rápida"
  /// ```
  String get title => """Botões de Rolagem Rápida""";

  /// ```dart
  /// "Botão Esquerdo"
  /// ```
  String get left => """Botão Esquerdo""";

  /// ```dart
  /// "Botão Direito"
  /// ```
  String get right => """Botão Direito""";

  /// ```dart
  /// "Rótulo do Botão"
  /// ```
  String get buttonLabel => """Rótulo do Botão""";
  SpecialDiceCustomRollsMessagesPtBR get specialDice =>
      SpecialDiceCustomRollsMessagesPtBR(this);
  TooltipCustomRollsMessagesPtBR get tooltip =>
      TooltipCustomRollsMessagesPtBR(this);
  PresetsCustomRollsMessagesPtBR get presets =>
      PresetsCustomRollsMessagesPtBR(this);
}

class SpecialDiceCustomRollsMessagesPtBR
    extends SpecialDiceCustomRollsMessages {
  final CustomRollsMessagesPtBR _parent;
  const SpecialDiceCustomRollsMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Dados Especiais"
  /// ```
  String get title => """Dados Especiais""";

  /// ```dart
  /// "${switch (btn) {'damage' => 'Dano', _ => btn}}"
  /// ```
  String button(String btn) =>
      """${switch (btn) { 'damage' => 'Dano', _ => btn }}""";
}

class TooltipCustomRollsMessagesPtBR extends TooltipCustomRollsMessages {
  final CustomRollsMessagesPtBR _parent;
  const TooltipCustomRollsMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Rolar $dice"
  /// ```
  String rollNormal(String dice) => """Rolar $dice""";

  /// ```dart
  /// "Rolar $dice\n* Rolando com debilidade"
  /// ```
  String rollWithDebility(String dice) =>
      """Rolar $dice\n* Rolando com debilidade""";
}

class PresetsCustomRollsMessagesPtBR extends PresetsCustomRollsMessages {
  final CustomRollsMessagesPtBR _parent;
  const PresetsCustomRollsMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Predefinições"
  /// ```
  String get title => """Predefinições""";

  /// ```dart
  /// "Ação Básica"
  /// ```
  String get basicAction => """Ação Básica""";

  /// ```dart
  /// "Golpear & Retalhar"
  /// ```
  String get hackAndSlash => """Golpear & Retalhar""";

  /// ```dart
  /// "Volêi"
  /// ```
  String get volley => """Volêi""";

  /// ```dart
  /// "Discernir Realidades"
  /// ```
  String get discernRealities => """Discernir Realidades""";
}

class SessionMarksMessagesPtBR extends SessionMarksMessages {
  final MessagesPtBR _parent;
  const SessionMarksMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Vínculos & Bandeiras"
  /// ```
  String get title => """Vínculos & Bandeiras""";

  /// ```dart
  /// "Vínculo"
  /// ```
  String get bond => """Vínculo""";

  /// ```dart
  /// "Vínculos"
  /// ```
  String get bonds => """Vínculos""";

  /// ```dart
  /// "Bandeira"
  /// ```
  String get flag => """Bandeira""";

  /// ```dart
  /// "Bandeiras"
  /// ```
  String get flags => """Bandeiras""";

  /// ```dart
  /// "Você não tem vínculos ou bandeiras. Você pode adicionar alguns usando o botão de edição acima e marcá-los como concluídos à medida que avança em sua aventura."
  /// ```
  String get noData =>
      """Você não tem vínculos ou bandeiras. Você pode adicionar alguns usando o botão de edição acima e marcá-los como concluídos à medida que avança em sua aventura.""";

  /// ```dart
  /// "Você pode adicionar, atualizar ou remover vínculos e bandeiras usando o ícone de edição acima."
  /// ```
  String get info =>
      """Você pode adicionar, atualizar ou remover vínculos e bandeiras usando o ícone de edição acima.""";
  EndOfSessionSessionMarksMessagesPtBR get endOfSession =>
      EndOfSessionSessionMarksMessagesPtBR(this);
}

class EndOfSessionSessionMarksMessagesPtBR
    extends EndOfSessionSessionMarksMessages {
  final SessionMarksMessagesPtBR _parent;
  const EndOfSessionSessionMarksMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Aprendemos algo novo e importante sobre o mundo?"
  /// ```
  String get q1 => """Aprendemos algo novo e importante sobre o mundo?""";

  /// ```dart
  /// "Superamos um monstro ou inimigo notável?"
  /// ```
  String get q2 => """Superamos um monstro ou inimigo notável?""";

  /// ```dart
  /// "Saqueamos um tesouro memorável?"
  /// ```
  String get q3 => """Saqueamos um tesouro memorável?""";
}

class CreateCharacterMessagesPtBR extends CreateCharacterMessages {
  final MessagesPtBR _parent;
  const CreateCharacterMessagesPtBR(this._parent) : super(_parent);
  CharacterClassCreateCharacterMessagesPtBR get characterClass =>
      CharacterClassCreateCharacterMessagesPtBR(this);
  BasicInfoCreateCharacterMessagesPtBR get basicInfo =>
      BasicInfoCreateCharacterMessagesPtBR(this);
  StartingGearCreateCharacterMessagesPtBR get startingGear =>
      StartingGearCreateCharacterMessagesPtBR(this);
  MovesSpellsCreateCharacterMessagesPtBR get movesSpells =>
      MovesSpellsCreateCharacterMessagesPtBR(this);
}

class CharacterClassCreateCharacterMessagesPtBR
    extends CharacterClassCreateCharacterMessages {
  final CreateCharacterMessagesPtBR _parent;
  const CharacterClassCreateCharacterMessagesPtBR(this._parent)
      : super(_parent);

  /// ```dart
  /// "Nenhuma classe selecionada (obrigatório)"
  /// ```
  String get noSelection => """Nenhuma classe selecionada (obrigatório)""";

  /// ```dart
  /// "HP Base: $hp, Carga: $load, Dados de Dano: $damageDice"
  /// ```
  String description(int hp, int load, String damageDice) =>
      """HP Base: $hp, Carga: $load, Dados de Dano: $damageDice""";
}

class BasicInfoCreateCharacterMessagesPtBR
    extends BasicInfoCreateCharacterMessages {
  final CreateCharacterMessagesPtBR _parent;
  const BasicInfoCreateCharacterMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Viajante Sem Nome"
  /// ```
  String get defaultName => """Viajante Sem Nome""";

  /// ```dart
  /// "Selecione nome e imagem (obrigatório)"
  /// ```
  String get helpText => """Selecione nome e imagem (obrigatório)""";

  /// ```dart
  /// "Nível 1 $cls"
  /// ```
  String description(String cls) => """Nível 1 $cls""";
}

class StartingGearCreateCharacterMessagesPtBR
    extends StartingGearCreateCharacterMessages {
  final CreateCharacterMessagesPtBR _parent;
  const StartingGearCreateCharacterMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Selecione seu equipamento inicial determinado pela classe (opcional)"
  /// ```
  String get helpText =>
      """Selecione seu equipamento inicial determinado pela classe (opcional)""";

  /// ```dart
  /// "$amt G"
  /// ```
  String coins(String amt) => """$amt G""";

  /// ```dart
  /// "${amt}× $name"
  /// ```
  String item(String amt, String name) => """${amt}× $name""";
  CountStartingGearCreateCharacterMessagesPtBR get count =>
      CountStartingGearCreateCharacterMessagesPtBR(this);
}

class CountStartingGearCreateCharacterMessagesPtBR
    extends CountStartingGearCreateCharacterMessages {
  final StartingGearCreateCharacterMessagesPtBR _parent;
  const CountStartingGearCreateCharacterMessagesPtBR(this._parent)
      : super(_parent);

  /// ```dart
  /// "$cnt selecionado (limite de classe: $max)"
  /// ```
  String withMax(int cnt, int max) =>
      """$cnt selecionado (limite de classe: $max)""";

  /// ```dart
  /// "$cnt selecionado"
  /// ```
  String noMax(int cnt) => """$cnt selecionado""";
}

class MovesSpellsCreateCharacterMessagesPtBR
    extends MovesSpellsCreateCharacterMessages {
  final CreateCharacterMessagesPtBR _parent;
  const MovesSpellsCreateCharacterMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Movimentos & Feitiços"
  /// ```
  String get title => """Movimentos & Feitiços""";

  /// ```dart
  /// "$moves Movimentos, $spells Feitiços selecionados"
  /// ```
  String description(int moves, int spells) =>
      """$moves Movimentos, $spells Feitiços selecionados""";
}

class AccountMessagesPtBR extends AccountMessages {
  final MessagesPtBR _parent;
  const AccountMessagesPtBR(this._parent) : super(_parent);
  DetailsAccountMessagesPtBR get details => DetailsAccountMessagesPtBR(this);
  ProvidersAccountMessagesPtBR get providers =>
      ProvidersAccountMessagesPtBR(this);
  DeleteAccountAccountMessagesPtBR get deleteAccount =>
      DeleteAccountAccountMessagesPtBR(this);
  UnlinkAccountMessagesPtBR get unlink => UnlinkAccountMessagesPtBR(this);
}

class DetailsAccountMessagesPtBR extends DetailsAccountMessages {
  final AccountMessagesPtBR _parent;
  const DetailsAccountMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Detalhes da conta"
  /// ```
  String get title => """Detalhes da conta""";
  DisplayNameDetailsAccountMessagesPtBR get displayName =>
      DisplayNameDetailsAccountMessagesPtBR(this);
  ImageDetailsAccountMessagesPtBR get image =>
      ImageDetailsAccountMessagesPtBR(this);
  EmailDetailsAccountMessagesPtBR get email =>
      EmailDetailsAccountMessagesPtBR(this);
  PasswordDetailsAccountMessagesPtBR get password =>
      PasswordDetailsAccountMessagesPtBR(this);
}

class DisplayNameDetailsAccountMessagesPtBR
    extends DisplayNameDetailsAccountMessages {
  final DetailsAccountMessagesPtBR _parent;
  const DisplayNameDetailsAccountMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Alterar Nome de Exibição"
  /// ```
  String get title => """Alterar Nome de Exibição""";

  /// ```dart
  /// "Nome de exibição"
  /// ```
  String get label => """Nome de exibição""";

  /// ```dart
  /// "Insira seu nome de exibição público"
  /// ```
  String get placeholder => """Insira seu nome de exibição público""";

  /// ```dart
  /// "Nome de exibição alterado com sucesso"
  /// ```
  String get success => """Nome de exibição alterado com sucesso""";
}

class ImageDetailsAccountMessagesPtBR extends ImageDetailsAccountMessages {
  final DetailsAccountMessagesPtBR _parent;
  const ImageDetailsAccountMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Alterar Foto de Perfil"
  /// ```
  String get title => """Alterar Foto de Perfil""";

  /// ```dart
  /// "Alterar sua foto de perfil"
  /// ```
  String get subtitle => """Alterar sua foto de perfil""";
}

class EmailDetailsAccountMessagesPtBR extends EmailDetailsAccountMessages {
  final DetailsAccountMessagesPtBR _parent;
  const EmailDetailsAccountMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Alterar Endereço de Email"
  /// ```
  String get title => """Alterar Endereço de Email""";

  /// ```dart
  /// "Endereço de email"
  /// ```
  String get label => """Endereço de email""";

  /// ```dart
  /// "Insira um novo endereço de email"
  /// ```
  String get placeholder => """Insira um novo endereço de email""";

  /// ```dart
  /// "Email alterado com sucesso"
  /// ```
  String get success => """Email alterado com sucesso""";
}

class PasswordDetailsAccountMessagesPtBR
    extends PasswordDetailsAccountMessages {
  final DetailsAccountMessagesPtBR _parent;
  const PasswordDetailsAccountMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Alterar Senha"
  /// ```
  String get title => """Alterar Senha""";

  /// ```dart
  /// "Alterar sua senha"
  /// ```
  String get subtitle => """Alterar sua senha""";

  /// ```dart
  /// "Senha alterada com sucesso"
  /// ```
  String get success => """Senha alterada com sucesso""";

  /// ```dart
  /// "Nova senha"
  /// ```
  String get label => """Nova senha""";

  /// ```dart
  /// "Insira sua nova senha"
  /// ```
  String get placeholder => """Insira sua nova senha""";
  VisibilityPasswordDetailsAccountMessagesPtBR get visibility =>
      VisibilityPasswordDetailsAccountMessagesPtBR(this);
  ConfirmPasswordDetailsAccountMessagesPtBR get confirm =>
      ConfirmPasswordDetailsAccountMessagesPtBR(this);

  /// ```dart
  /// "As senhas não coincidem"
  /// ```
  String get error => """As senhas não coincidem""";
}

class VisibilityPasswordDetailsAccountMessagesPtBR
    extends VisibilityPasswordDetailsAccountMessages {
  final PasswordDetailsAccountMessagesPtBR _parent;
  const VisibilityPasswordDetailsAccountMessagesPtBR(this._parent)
      : super(_parent);

  /// ```dart
  /// "Mostrar senha"
  /// ```
  String get show => """Mostrar senha""";

  /// ```dart
  /// "Ocultar senha"
  /// ```
  String get hide => """Ocultar senha""";
}

class ConfirmPasswordDetailsAccountMessagesPtBR
    extends ConfirmPasswordDetailsAccountMessages {
  final PasswordDetailsAccountMessagesPtBR _parent;
  const ConfirmPasswordDetailsAccountMessagesPtBR(this._parent)
      : super(_parent);

  /// ```dart
  /// "Confirmar Nova Senha"
  /// ```
  String get label => """Confirmar Nova Senha""";

  /// ```dart
  /// "Insira a mesma senha novamente"
  /// ```
  String get placeholder => """Insira a mesma senha novamente""";
}

class ProvidersAccountMessagesPtBR extends ProvidersAccountMessages {
  final AccountMessagesPtBR _parent;
  const ProvidersAccountMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Logins conectados"
  /// ```
  String get title => """Logins conectados""";
}

class DeleteAccountAccountMessagesPtBR extends DeleteAccountAccountMessages {
  final AccountMessagesPtBR _parent;
  const DeleteAccountAccountMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Excluir Sua Conta"
  /// ```
  String get title => """Excluir Sua Conta""";

  /// ```dart
  /// "Uma solicitação de exclusão para sua conta foi enviada com sucesso"
  /// ```
  String get success =>
      """Uma solicitação de exclusão para sua conta foi enviada com sucesso""";
}

class UnlinkAccountMessagesPtBR extends UnlinkAccountMessages {
  final AccountMessagesPtBR _parent;
  const UnlinkAccountMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Você desvinculou $provider com sucesso."
  /// ```
  String success(String provider) =>
      """Você desvinculou $provider com sucesso.""";
}

class ActionsMessagesPtBR extends ActionsMessages {
  final MessagesPtBR _parent;
  const ActionsMessagesPtBR(this._parent) : super(_parent);
  MovesActionsMessagesPtBR get moves => MovesActionsMessagesPtBR(this);
  ClassActionsActionsMessagesPtBR get classActions =>
      ClassActionsActionsMessagesPtBR(this);
}

class MovesActionsMessagesPtBR extends MovesActionsMessages {
  final ActionsMessagesPtBR _parent;
  const MovesActionsMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Movimentos Básicos"
  /// ```
  String get basic => """Movimentos Básicos""";

  /// ```dart
  /// "Movimentos Especiais"
  /// ```
  String get special => """Movimentos Especiais""";
}

class ClassActionsActionsMessagesPtBR extends ClassActionsActionsMessages {
  final ActionsMessagesPtBR _parent;
  const ClassActionsActionsMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Ações de Classe"
  /// ```
  String get title => """Ações de Classe""";
  MarkXPClassActionsActionsMessagesPtBR get markXP =>
      MarkXPClassActionsActionsMessagesPtBR(this);
}

class MarkXPClassActionsActionsMessagesPtBR
    extends MarkXPClassActionsActionsMessages {
  final ClassActionsActionsMessagesPtBR _parent;
  const MarkXPClassActionsActionsMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Marcar +1 XP"
  /// ```
  String get button => """Marcar +1 XP""";

  /// ```dart
  /// "+1 XP marcado"
  /// ```
  String get success => """+1 XP marcado""";
}

class AbilityScoresMessagesPtBR extends AbilityScoresMessages {
  final MessagesPtBR _parent;
  const AbilityScoresMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Você pode arrastar e soltar os cartões de estatísticas para mudar a ordem em que eles aparecem nas telas deste personagem."
  /// ```
  String get info =>
      """Você pode arrastar e soltar os cartões de estatísticas para mudar a ordem em que eles aparecem nas telas deste personagem.""";
  RollButtonAbilityScoresMessagesPtBR get rollButton =>
      RollButtonAbilityScoresMessagesPtBR(this);
  StatsAbilityScoresMessagesPtBR get stats =>
      StatsAbilityScoresMessagesPtBR(this);
  FormAbilityScoresMessagesPtBR get form => FormAbilityScoresMessagesPtBR(this);
}

class RollButtonAbilityScoresMessagesPtBR
    extends RollButtonAbilityScoresMessages {
  final AbilityScoresMessagesPtBR _parent;
  const RollButtonAbilityScoresMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Rolar +{stat}"
  /// ```
  String get stat => """Rolar +{stat}""";

  /// ```dart
  /// "Rolar estatística aleatória"
  /// ```
  String get randStat => """Rolar estatística aleatória""";
}

class StatsAbilityScoresMessagesPtBR extends StatsAbilityScoresMessages {
  final AbilityScoresMessagesPtBR _parent;
  const StatsAbilityScoresMessagesPtBR(this._parent) : super(_parent);
  BondStatsAbilityScoresMessagesPtBR get bond =>
      BondStatsAbilityScoresMessagesPtBR(this);
  ChaStatsAbilityScoresMessagesPtBR get cha =>
      ChaStatsAbilityScoresMessagesPtBR(this);
  ConStatsAbilityScoresMessagesPtBR get con =>
      ConStatsAbilityScoresMessagesPtBR(this);
  DexStatsAbilityScoresMessagesPtBR get dex =>
      DexStatsAbilityScoresMessagesPtBR(this);
  StrStatsAbilityScoresMessagesPtBR get str =>
      StrStatsAbilityScoresMessagesPtBR(this);
  WisStatsAbilityScoresMessagesPtBR get wis =>
      WisStatsAbilityScoresMessagesPtBR(this);
  IntlStatsAbilityScoresMessagesPtBR get intl =>
      IntlStatsAbilityScoresMessagesPtBR(this);
}

class BondStatsAbilityScoresMessagesPtBR
    extends BondStatsAbilityScoresMessages {
  final StatsAbilityScoresMessagesPtBR _parent;
  const BondStatsAbilityScoresMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Vínculo"
  /// ```
  String get name => """Vínculo""";

  /// ```dart
  /// "Quando um movimento pede para você rolar+vínculo, você contará o número de vínculos que tem com o personagem em questão e adicionará isso à rolagem."
  /// ```
  String get description =>
      """Quando um movimento pede para você rolar+vínculo, você contará o número de vínculos que tem com o personagem em questão e adicionará isso à rolagem.""";
  DebilityBondStatsAbilityScoresMessagesPtBR get debility =>
      DebilityBondStatsAbilityScoresMessagesPtBR(this);
}

class DebilityBondStatsAbilityScoresMessagesPtBR
    extends DebilityBondStatsAbilityScoresMessages {
  final BondStatsAbilityScoresMessagesPtBR _parent;
  const DebilityBondStatsAbilityScoresMessagesPtBR(this._parent)
      : super(_parent);

  /// ```dart
  /// "Solitário"
  /// ```
  String get name => """Solitário""";

  String get description => """null""";
}

class ChaStatsAbilityScoresMessagesPtBR extends ChaStatsAbilityScoresMessages {
  final StatsAbilityScoresMessagesPtBR _parent;
  const ChaStatsAbilityScoresMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Mede a personalidade de um personagem, magnetismo pessoal, habilidade de liderança e aparência."
  /// ```
  String get description =>
      """Mede a personalidade de um personagem, magnetismo pessoal, habilidade de liderança e aparência.""";

  /// ```dart
  /// "Carisma"
  /// ```
  String get name => """Carisma""";
  DebilityChaStatsAbilityScoresMessagesPtBR get debility =>
      DebilityChaStatsAbilityScoresMessagesPtBR(this);
}

class DebilityChaStatsAbilityScoresMessagesPtBR
    extends DebilityChaStatsAbilityScoresMessages {
  final ChaStatsAbilityScoresMessagesPtBR _parent;
  const DebilityChaStatsAbilityScoresMessagesPtBR(this._parent)
      : super(_parent);

  /// ```dart
  /// "Cicatrizado"
  /// ```
  String get name => """Cicatrizado""";

  /// ```dart
  /// "Pode não ser permanente, mas por enquanto você não parece tão bem."
  /// ```
  String get description =>
      """Pode não ser permanente, mas por enquanto você não parece tão bem.""";
}

class ConStatsAbilityScoresMessagesPtBR extends ConStatsAbilityScoresMessages {
  final StatsAbilityScoresMessagesPtBR _parent;
  const ConStatsAbilityScoresMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Representa a saúde e resistência do seu personagem."
  /// ```
  String get description =>
      """Representa a saúde e resistência do seu personagem.""";

  /// ```dart
  /// "Constituição"
  /// ```
  String get name => """Constituição""";
  DebilityConStatsAbilityScoresMessagesPtBR get debility =>
      DebilityConStatsAbilityScoresMessagesPtBR(this);
}

class DebilityConStatsAbilityScoresMessagesPtBR
    extends DebilityConStatsAbilityScoresMessages {
  final ConStatsAbilityScoresMessagesPtBR _parent;
  const DebilityConStatsAbilityScoresMessagesPtBR(this._parent)
      : super(_parent);

  /// ```dart
  /// "Doente"
  /// ```
  String get name => """Doente""";

  /// ```dart
  /// "Algo não está certo por dentro. Talvez você tenha uma doença ou uma enfermidade debilitante. Talvez você só tenha bebido muita cerveja na noite passada e agora ela esteja voltando para assombrá-lo."
  /// ```
  String get description =>
      """Algo não está certo por dentro. Talvez você tenha uma doença ou uma enfermidade debilitante. Talvez você só tenha bebido muita cerveja na noite passada e agora ela esteja voltando para assombrá-lo.""";
}

class DexStatsAbilityScoresMessagesPtBR extends DexStatsAbilityScoresMessages {
  final StatsAbilityScoresMessagesPtBR _parent;
  const DexStatsAbilityScoresMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Mede agilidade, reflexos e equilíbrio."
  /// ```
  String get description => """Mede agilidade, reflexos e equilíbrio.""";

  /// ```dart
  /// "Destreza"
  /// ```
  String get name => """Destreza""";
  DebilityDexStatsAbilityScoresMessagesPtBR get debility =>
      DebilityDexStatsAbilityScoresMessagesPtBR(this);
}

class DebilityDexStatsAbilityScoresMessagesPtBR
    extends DebilityDexStatsAbilityScoresMessages {
  final DexStatsAbilityScoresMessagesPtBR _parent;
  const DebilityDexStatsAbilityScoresMessagesPtBR(this._parent)
      : super(_parent);

  /// ```dart
  /// "Tremor"
  /// ```
  String get name => """Tremor""";

  /// ```dart
  /// "Você está instável nos pés e tem um tremor nas mãos."
  /// ```
  String get description =>
      """Você está instável nos pés e tem um tremor nas mãos.""";
}

class StrStatsAbilityScoresMessagesPtBR extends StrStatsAbilityScoresMessages {
  final StatsAbilityScoresMessagesPtBR _parent;
  const StrStatsAbilityScoresMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Mede o músculo e o poder físico."
  /// ```
  String get description => """Mede o músculo e o poder físico.""";

  /// ```dart
  /// "Força"
  /// ```
  String get name => """Força""";
  DebilityStrStatsAbilityScoresMessagesPtBR get debility =>
      DebilityStrStatsAbilityScoresMessagesPtBR(this);
}

class DebilityStrStatsAbilityScoresMessagesPtBR
    extends DebilityStrStatsAbilityScoresMessages {
  final StrStatsAbilityScoresMessagesPtBR _parent;
  const DebilityStrStatsAbilityScoresMessagesPtBR(this._parent)
      : super(_parent);

  /// ```dart
  /// "Fraco"
  /// ```
  String get name => """Fraco""";

  /// ```dart
  /// "Você não pode exercer muita força. Talvez seja apenas cansaço e lesão, ou talvez sua força tenha sido drenada por magia."
  /// ```
  String get description =>
      """Você não pode exercer muita força. Talvez seja apenas cansaço e lesão, ou talvez sua força tenha sido drenada por magia.""";
}

class WisStatsAbilityScoresMessagesPtBR extends WisStatsAbilityScoresMessages {
  final StatsAbilityScoresMessagesPtBR _parent;
  const WisStatsAbilityScoresMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Descreve a força de vontade, senso comum, consciência e intuição de um personagem."
  /// ```
  String get description =>
      """Descreve a força de vontade, senso comum, consciência e intuição de um personagem.""";

  /// ```dart
  /// "Sabedoria"
  /// ```
  String get name => """Sabedoria""";
  DebilityWisStatsAbilityScoresMessagesPtBR get debility =>
      DebilityWisStatsAbilityScoresMessagesPtBR(this);
}

class DebilityWisStatsAbilityScoresMessagesPtBR
    extends DebilityWisStatsAbilityScoresMessages {
  final WisStatsAbilityScoresMessagesPtBR _parent;
  const DebilityWisStatsAbilityScoresMessagesPtBR(this._parent)
      : super(_parent);

  /// ```dart
  /// "Confuso"
  /// ```
  String get name => """Confuso""";

  /// ```dart
  /// "Ouvidos zumbindo. Visão embaçada. Você está mais do que um pouco fora de si."
  /// ```
  String get description =>
      """Ouvidos zumbindo. Visão embaçada. Você está mais do que um pouco fora de si.""";
}

class IntlStatsAbilityScoresMessagesPtBR
    extends IntlStatsAbilityScoresMessages {
  final StatsAbilityScoresMessagesPtBR _parent;
  const IntlStatsAbilityScoresMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Determina o quão bem seu personagem aprende e raciocina."
  /// ```
  String get description =>
      """Determina o quão bem seu personagem aprende e raciocina.""";

  /// ```dart
  /// "Inteligência"
  /// ```
  String get name => """Inteligência""";
  DebilityIntlStatsAbilityScoresMessagesPtBR get debility =>
      DebilityIntlStatsAbilityScoresMessagesPtBR(this);
}

class DebilityIntlStatsAbilityScoresMessagesPtBR
    extends DebilityIntlStatsAbilityScoresMessages {
  final IntlStatsAbilityScoresMessagesPtBR _parent;
  const DebilityIntlStatsAbilityScoresMessagesPtBR(this._parent)
      : super(_parent);

  /// ```dart
  /// "Atordoado"
  /// ```
  String get name => """Atordoado""";

  /// ```dart
  /// "Aquela última pancada na cabeça soltou algo. O cérebro não está funcionando muito bem."
  /// ```
  String get description =>
      """Aquela última pancada na cabeça soltou algo. O cérebro não está funcionando muito bem.""";
}

class FormAbilityScoresMessagesPtBR extends FormAbilityScoresMessages {
  final AbilityScoresMessagesPtBR _parent;
  const FormAbilityScoresMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Modificador:\n$mod"
  /// ```
  String modifierValueLabel(String mod) => """Modificador:\n$mod""";
  DebilityDescriptionFormAbilityScoresMessagesPtBR get debilityDescription =>
      DebilityDescriptionFormAbilityScoresMessagesPtBR(this);
  DebilityNameFormAbilityScoresMessagesPtBR get debilityName =>
      DebilityNameFormAbilityScoresMessagesPtBR(this);
  DescriptionFormAbilityScoresMessagesPtBR get description =>
      DescriptionFormAbilityScoresMessagesPtBR(this);
  KeyFormAbilityScoresMessagesPtBR get key =>
      KeyFormAbilityScoresMessagesPtBR(this);
  NameFormAbilityScoresMessagesPtBR get name =>
      NameFormAbilityScoresMessagesPtBR(this);
  IconFormAbilityScoresMessagesPtBR get icon =>
      IconFormAbilityScoresMessagesPtBR(this);
}

class DebilityDescriptionFormAbilityScoresMessagesPtBR
    extends DebilityDescriptionFormAbilityScoresMessages {
  final FormAbilityScoresMessagesPtBR _parent;
  const DebilityDescriptionFormAbilityScoresMessagesPtBR(this._parent)
      : super(_parent);

  /// ```dart
  /// "Descrição da Debilidade"
  /// ```
  String get label => """Descrição da Debilidade""";

  /// ```dart
  /// "Uma descrição do efeito que causa a debilidade e/ou como isso afeta seu personagem"
  /// ```
  String get description =>
      """Uma descrição do efeito que causa a debilidade e/ou como isso afeta seu personagem""";
}

class DebilityNameFormAbilityScoresMessagesPtBR
    extends DebilityNameFormAbilityScoresMessages {
  final FormAbilityScoresMessagesPtBR _parent;
  const DebilityNameFormAbilityScoresMessagesPtBR(this._parent)
      : super(_parent);

  /// ```dart
  /// "Nome da Debilidade"
  /// ```
  String get label => """Nome da Debilidade""";

  /// ```dart
  /// "O nome para a debilidade que ocorre quando este atributo é debilitado (leva -1 até se recuperar)."
  /// ```
  String get description =>
      """O nome para a debilidade que ocorre quando este atributo é debilitado (leva -1 até se recuperar).""";
}

class DescriptionFormAbilityScoresMessagesPtBR
    extends DescriptionFormAbilityScoresMessages {
  final FormAbilityScoresMessagesPtBR _parent;
  const DescriptionFormAbilityScoresMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Descrição da Pontuação de Habilidade"
  /// ```
  String get label => """Descrição da Pontuação de Habilidade""";

  /// ```dart
  /// "Uma descrição do que esta pontuação de habilidade representa"
  /// ```
  String get description =>
      """Uma descrição do que esta pontuação de habilidade representa""";
}

class KeyFormAbilityScoresMessagesPtBR extends KeyFormAbilityScoresMessages {
  final FormAbilityScoresMessagesPtBR _parent;
  const KeyFormAbilityScoresMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Chave da Pontuação de Habilidade"
  /// ```
  String get label => """Chave da Pontuação de Habilidade""";

  /// ```dart
  /// "Uma chave única de 3 letras que identifica esta pontuação de habilidade nos dados e é usada como o rótulo curto para o valor do modificador (e não a pontuação real)"
  /// ```
  String get description =>
      """Uma chave única de 3 letras que identifica esta pontuação de habilidade nos dados e é usada como o rótulo curto para o valor do modificador (e não a pontuação real)""";
}

class NameFormAbilityScoresMessagesPtBR extends NameFormAbilityScoresMessages {
  final FormAbilityScoresMessagesPtBR _parent;
  const NameFormAbilityScoresMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Nome da Pontuação de Habilidade"
  /// ```
  String get label => """Nome da Pontuação de Habilidade""";

  /// ```dart
  /// "O nome desta pontuação de habilidade"
  /// ```
  String get description => """O nome desta pontuação de habilidade""";
}

class IconFormAbilityScoresMessagesPtBR extends IconFormAbilityScoresMessages {
  final FormAbilityScoresMessagesPtBR _parent;
  const IconFormAbilityScoresMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Ícone"
  /// ```
  String get label => """Ícone""";

  /// ```dart
  /// "Alterar Ícone"
  /// ```
  String get button => """Alterar Ícone""";
}

class FeedbackMessagesPtBR extends FeedbackMessages {
  final MessagesPtBR _parent;
  const FeedbackMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Enviar Feedback do App"
  /// ```
  String get title => """Enviar Feedback do App""";

  /// ```dart
  /// "Enviar"
  /// ```
  String get send => """Enviar""";
  FormFeedbackMessagesPtBR get form => FormFeedbackMessagesPtBR(this);
  SuccessFeedbackMessagesPtBR get success => SuccessFeedbackMessagesPtBR(this);
}

class FormFeedbackMessagesPtBR extends FormFeedbackMessages {
  final FeedbackMessagesPtBR _parent;
  const FormFeedbackMessagesPtBR(this._parent) : super(_parent);
  TitleFormFeedbackMessagesPtBR get title =>
      TitleFormFeedbackMessagesPtBR(this);
  BodyFormFeedbackMessagesPtBR get body => BodyFormFeedbackMessagesPtBR(this);
  EmailFormFeedbackMessagesPtBR get email =>
      EmailFormFeedbackMessagesPtBR(this);
}

class TitleFormFeedbackMessagesPtBR extends TitleFormFeedbackMessages {
  final FormFeedbackMessagesPtBR _parent;
  const TitleFormFeedbackMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Título do feedback"
  /// ```
  String get label => """Título do feedback""";
}

class BodyFormFeedbackMessagesPtBR extends BodyFormFeedbackMessages {
  final FormFeedbackMessagesPtBR _parent;
  const BodyFormFeedbackMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Problema, ideia ou descrição do feedback"
  /// ```
  String get label => """Problema, ideia ou descrição do feedback""";
}

class EmailFormFeedbackMessagesPtBR extends EmailFormFeedbackMessages {
  final FormFeedbackMessagesPtBR _parent;
  const EmailFormFeedbackMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Insira seu email"
  /// ```
  String get label => """Insira seu email""";
}

class SuccessFeedbackMessagesPtBR extends SuccessFeedbackMessages {
  final FeedbackMessagesPtBR _parent;
  const SuccessFeedbackMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Feedback enviado!"
  /// ```
  String get title => """Feedback enviado!""";

  /// ```dart
  /// "Obrigado pelo seu feedback! Vamos revisá-lo o mais rápido possível."
  /// ```
  String get message =>
      """Obrigado pelo seu feedback! Vamos revisá-lo o mais rápido possível.""";
}

class MigrationMessagesPtBR extends MigrationMessages {
  final MessagesPtBR _parent;
  const MigrationMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Bem-vindo ao\nDungeon Paper 2!"
  /// ```
  String get title => """Bem-vindo ao\nDungeon Paper 2!""";

  /// ```dart
  /// "Para começar, escolha um nome de usuário e o idioma para o livro de regras e o aplicativo. Se você já possui uma conta Dungeon Paper existente, seus dados podem levar alguns segundos para migrar."
  /// ```
  String get subtitle =>
      """Para começar, escolha um nome de usuário e o idioma para o livro de regras e o aplicativo. Se você já possui uma conta Dungeon Paper existente, seus dados podem levar alguns segundos para migrar.""";
  UsernameMigrationMessagesPtBR get username =>
      UsernameMigrationMessagesPtBR(this);
  LanguageMigrationMessagesPtBR get language =>
      LanguageMigrationMessagesPtBR(this);
}

class UsernameMigrationMessagesPtBR extends UsernameMigrationMessages {
  final MigrationMessagesPtBR _parent;
  const UsernameMigrationMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Nome de usuário"
  /// ```
  String get label => """Nome de usuário""";

  /// ```dart
  /// "Escolha um nome de usuário único"
  /// ```
  String get placeholder => """Escolha um nome de usuário único""";

  /// ```dart
  /// "Seu nome de usuário é único e não pode ser alterado depois, então pense bem! Ele será usado para identificar todos os itens da sua biblioteca ao publicar."
  /// ```
  String get info =>
      """Seu nome de usuário é único e não pode ser alterado depois, então pense bem! Ele será usado para identificar todos os itens da sua biblioteca ao publicar.""";
}

class LanguageMigrationMessagesPtBR extends LanguageMigrationMessages {
  final MigrationMessagesPtBR _parent;
  const LanguageMigrationMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Idioma padrão dos dados"
  /// ```
  String get data => """Idioma padrão dos dados""";
}

class BackupMessagesPtBR extends BackupMessages {
  final MessagesPtBR _parent;
  const BackupMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Exportar/Importar"
  /// ```
  String get title => """Exportar/Importar""";
  ImportingBackupMessagesPtBR get importing =>
      ImportingBackupMessagesPtBR(this);
  ExportingBackupMessagesPtBR get exporting =>
      ExportingBackupMessagesPtBR(this);
}

class ImportingBackupMessagesPtBR extends ImportingBackupMessages {
  final BackupMessagesPtBR _parent;
  const ImportingBackupMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Importar"
  /// ```
  String get title => """Importar""";

  /// ```dart
  /// "Importar"
  /// ```
  String get button => """Importar""";
  ProgressImportingBackupMessagesPtBR get progress =>
      ProgressImportingBackupMessagesPtBR(this);
  FileImportingBackupMessagesPtBR get file =>
      FileImportingBackupMessagesPtBR(this);
  SuccessImportingBackupMessagesPtBR get success =>
      SuccessImportingBackupMessagesPtBR(this);
  ErrorImportingBackupMessagesPtBR get error =>
      ErrorImportingBackupMessagesPtBR(this);
}

class ProgressImportingBackupMessagesPtBR
    extends ProgressImportingBackupMessages {
  final ImportingBackupMessagesPtBR _parent;
  const ProgressImportingBackupMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Importando..."
  /// ```
  String get title => """Importando...""";

  /// ```dart
  /// "Processando $ent..."
  /// ```
  String processing(String ent) => """Processando $ent...""";
}

class FileImportingBackupMessagesPtBR extends FileImportingBackupMessages {
  final ImportingBackupMessagesPtBR _parent;
  const FileImportingBackupMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Navegar..."
  /// ```
  String get browse => """Navegar...""";

  /// ```dart
  /// "Limpar arquivo selecionado"
  /// ```
  String get clearFile => """Limpar arquivo selecionado""";

  /// ```dart
  /// "Para começar a importar, escolha o arquivo do qual deseja importar.\nVocê poderá então selecionar o que salvar e o que deixar de fora."
  /// ```
  String get info =>
      """Para começar a importar, escolha o arquivo do qual deseja importar.\nVocê poderá então selecionar o que salvar e o que deixar de fora.""";
}

class SuccessImportingBackupMessagesPtBR
    extends SuccessImportingBackupMessages {
  final ImportingBackupMessagesPtBR _parent;
  const SuccessImportingBackupMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Importação Bem-sucedida"
  /// ```
  String get title => """Importação Bem-sucedida""";

  /// ```dart
  /// "Seus dados foram importados do arquivo com sucesso"
  /// ```
  String get message =>
      """Seus dados foram importados do arquivo com sucesso""";
}

class ErrorImportingBackupMessagesPtBR extends ErrorImportingBackupMessages {
  final ImportingBackupMessagesPtBR _parent;
  const ErrorImportingBackupMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Falha na Importação"
  /// ```
  String get title => """Falha na Importação""";

  /// ```dart
  /// "Algo deu errado.\nTente novamente ou entre em contato com o suporte se isso persistir"
  /// ```
  String get message =>
      """Algo deu errado.\nTente novamente ou entre em contato com o suporte se isso persistir""";
}

class ExportingBackupMessagesPtBR extends ExportingBackupMessages {
  final BackupMessagesPtBR _parent;
  const ExportingBackupMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Exportar"
  /// ```
  String get title => """Exportar""";

  /// ```dart
  /// "Exportar"
  /// ```
  String get button => """Exportar""";
  ErrorExportingBackupMessagesPtBR get error =>
      ErrorExportingBackupMessagesPtBR(this);
  SuccessExportingBackupMessagesPtBR get success =>
      SuccessExportingBackupMessagesPtBR(this);
  BundlesExportingBackupMessagesPtBR get bundles =>
      BundlesExportingBackupMessagesPtBR(this);
}

class ErrorExportingBackupMessagesPtBR extends ErrorExportingBackupMessages {
  final ExportingBackupMessagesPtBR _parent;
  const ErrorExportingBackupMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Falha na Exportação"
  /// ```
  String get title => """Falha na Exportação""";

  /// ```dart
  /// "Algo deu errado.\nTente novamente ou entre em contato com o suporte se isso persistir"
  /// ```
  String get message =>
      """Algo deu errado.\nTente novamente ou entre em contato com o suporte se isso persistir""";
}

class SuccessExportingBackupMessagesPtBR
    extends SuccessExportingBackupMessages {
  final ExportingBackupMessagesPtBR _parent;
  const SuccessExportingBackupMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Exportação Bem-sucedida"
  /// ```
  String get title => """Exportação Bem-sucedida""";

  /// ```dart
  /// "Seus dados foram exportados para o arquivo com sucesso"
  /// ```
  String get message =>
      """Seus dados foram exportados para o arquivo com sucesso""";
}

class BundlesExportingBackupMessagesPtBR
    extends BundlesExportingBackupMessages {
  final ExportingBackupMessagesPtBR _parent;
  const BundlesExportingBackupMessagesPtBR(this._parent) : super(_parent);
  CharacterClassBundlesExportingBackupMessagesPtBR get characterClass =>
      CharacterClassBundlesExportingBackupMessagesPtBR(this);
}

class CharacterClassBundlesExportingBackupMessagesPtBR
    extends CharacterClassBundlesExportingBackupMessages {
  final BundlesExportingBackupMessagesPtBR _parent;
  const CharacterClassBundlesExportingBackupMessagesPtBR(this._parent)
      : super(_parent);

  /// ```dart
  /// "Exportar Pacote de Classe"
  /// ```
  String get button => """Exportar Pacote de Classe""";

  /// ```dart
  /// "Exportar Pacote de Classe"
  /// ```
  String get title => """Exportar Pacote de Classe""";
}

class ChangelogMessagesPtBR extends ChangelogMessages {
  final MessagesPtBR _parent;
  const ChangelogMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "O que há de novo?"
  /// ```
  String get title => """O que há de novo?""";
  TagsChangelogMessagesPtBR get tags => TagsChangelogMessagesPtBR(this);
}

class TagsChangelogMessagesPtBR extends TagsChangelogMessages {
  final ChangelogMessagesPtBR _parent;
  const TagsChangelogMessagesPtBR(this._parent) : super(_parent);

  /// ```dart
  /// "Última"
  /// ```
  String get latest => """Última""";

  /// ```dart
  /// "Atual"
  /// ```
  String get current => """Atual""";
}

Map<String, String> get messagesPtBRMap => {
      """app.name""": """Dungeon Paper""",
      """platformInteractions.tap""": """Toque""",
      """platformInteractions.drag""": """Arraste""",
      """platformInteractions.pan""": """Mova""",
      """platformInteractions.click""": """Clique""",
      """generic.save""": """Salvar""",
      """generic.cancel""": """Cancelar""",
      """generic.close""": """Fechar""",
      """generic.done""": """Concluído""",
      """generic.view""": """Visualizar""",
      """generic.continue_""": """Continuar""",
      """generic.all""": """Todos""",
      """generic.create""": """Criar""",
      """generic.add""": """Adicionar""",
      """generic.remove""": """Remover""",
      """generic.unselect""": """Desmarcar""",
      """generic.delete""": """Excluir""",
      """generic.edit""": """Editar""",
      """generic.yes""": """Sim""",
      """generic.no""": """Não""",
      """generic.select""": """Selecionar""",
      """generic.selected""": """Selecionado""",
      """generic.selectAll""": """Selecionar Todos""",
      """generic.selectNone""": """Selecionar Nenhum""",
      """generic.my""": """Meu""",
      """generic.change""": """Alterar""",
      """generic.seeAll""": """Ver Todos""",
      """generic.name""": """Nome""",
      """generic.value""": """Valor""",
      """generic.description""": """Descrição""",
      """generic.explanation""": """Explicação""",
      """generic.noDescription""": """‹Nenhuma descrição fornecida›""",
      """generic.useDefault""": """Usar Padrão""",
      """loading.user""": """Entrando...""",
      """loading.characters""": """Obtendo personagens...""",
      """loading.general""": """Carregando...""",
      """errors.userOperationCanceled""": """Operação cancelada""",
      """errors.uploadError""":
          """Erro ao carregar a foto. Tente novamente mais tarde ou entre em contato com o suporte usando a página "Sobre".""",
      """errors.invalidEmail""": """Endereço de email inválido""",
      """errors.invalidPassword.letter""":
          """A senha deve conter pelo menos uma letra maiúscula""",
      """errors.invalidPassword.number""":
          """A senha deve conter pelo menos um número""",
      """errors.onlyLetters""": """Deve conter apenas letras""",
      """numberFields.increase""": """+1""",
      """numberFields.decrease""": """-1""",
      """sort.moveUp""": """Mover para cima""",
      """sort.moveDown""": """Mover para baixo""",
      """playbook.title""": """Playbook""",
      """playbook.myLibrary""": """Minha Biblioteca""",
      """playbook.myCampaigns""": """Minhas Campanhas""",
      """myLibrary.title""": """Minha Biblioteca""",
      """myLibrary.reload""": """Recarregar Biblioteca""",
      """myLibrary.alreadyAdded""": """Já adicionado""",
      """myLibrary.itemTab.playbook""": """Playbook""",
      """myLibrary.itemTab.online""": """Online""",
      """myLibrary.filters.clear""": """Limpar Filtros""",
      """nav.actions""": """Usar""",
      """nav.character""": """Personagem""",
      """nav.journal""": """Diário""",
      """settings.title""": """Configurações""",
      """settings.importExport""": """Exportar/Importar""",
      """settings.categories.general""": """Geral""",
      """settings.keepAwake""":
          """Manter a tela ativa enquanto usa o aplicativo""",
      """settings.locale.title""": """Idioma""",
      """settings.locale.subtitle""":
          """Alterar o idioma irá recarregar o aplicativo""",
      """settings.locales.en_US""": """English (United States)""",
      """settings.locales.pt_BR""": """Português (Brasil)""",
      """settings.locales.pl_PL""": """Polski""",
      """user.recentCharacters""": """Personagens Recentes""",
      """auth.orSeparator""": """OU""",
      """auth.privacyPolicy""": """Política de Privacidade""",
      """auth.changelog""": """O que há de novo?""",
      """auth.notLoggedIn""": """Não conectado""",
      """auth.menuSubtitle(String interact)""": """Detalhes da conta""",
      """auth.providers.unlink""": """Desvincular""",
      """auth.providers.link""": """Vincular""",
      """auth.login.title""": """Entrar""",
      """auth.login.subtitle""":
          """Entre na sua conta para sincronizar seus dados online e obter acesso a muitos outros recursos.""",
      """auth.login.button""": """Entrar""",
      """auth.login.noAccount.label""": """Não tem uma conta?""",
      """auth.login.noAccount.button""": """Inscreva-se""",
      """auth.logout.button""": """Sair""",
      """auth.signup.title""": """Inscrever-se""",
      """auth.signup.subtitle""":
          """Insira os detalhes necessários abaixo para criar sua conta Dungeon Paper.""",
      """auth.signup.button""": """Inscrever-se""",
      """auth.signup.email.label""": """Email""",
      """auth.signup.email.placeholder""": """Digite seu email""",
      """auth.signup.email.error""":
          """Por favor, insira um endereço de email válido""",
      """auth.signup.password.label""": """Senha""",
      """auth.signup.password.placeholder""": """Insira uma senha""",
      """auth.signup.password.confirm.label""": """Confirmar Senha""",
      """auth.signup.password.confirm.placeholder""":
          """Digite a mesma senha novamente""",
      """auth.signup.password.confirm.error""": """As senhas não coincidem""",
      """home.categories.notes""": """Notas Marcadas""",
      """home.categories.moves""": """Movimentos Favoritos""",
      """home.categories.spells""": """Feitiços Preparados""",
      """home.categories.items""": """Itens Equipados""",
      """home.categories.classActions""": """Ações de Classe""",
      """home.summary.load.tooltip""": """Carga Máxima""",
      """home.summary.coins.tooltip""": """Moedas""",
      """home.menu.character.tooltip""": """Menu do Personagem""",
      """home.menu.character.basicInfo""": """Informações Básicas""",
      """home.menu.character.abilityScores""": """Pontuações de Habilidade""",
      """home.menu.character.customRolls""": """Botões de Rolagem Rápida""",
      """home.menu.character.theme""": """Tema do Personagem""",
      """home.menu.bio""": """Biografia do Personagem""",
      """home.menu.debilities""": """Debilidades""",
      """home.emptyState.guest.title""": """Entre para obter mais recursos""",
      """home.emptyState.guest.subtitle""":
          """Sincronização de dados online, compartilhamento de biblioteca, campanhas e muito mais!""",
      """home.emptyState.title""": """Nenhum Personagem""",
      """home.emptyState.subtitle""": """Crie um Personagem para começar""",
      """about.title""": """Sobre""",
      """about.author""": """Chen Asraf""",
      """about.changelog.title""": """O que há de novo?""",
      """about.changelog.subtitle""":
          """Registro de mudanças das versões lançadas do Dungeon Paper""",
      """about.discord.title""": """Junte-se ao Nosso Discord""",
      """about.discord.subtitle""":
          """Junte-se à comunidade Discord para fazer perguntas, obter ajuda, enviar feedback ou simplesmente conversar com outros jogadores.""",
      """about.feedback.title""": """Enviar Feedback""",
      """about.feedback.subtitle""":
          """Respondemos mais prontamente através do Discord, mas você pode nos enviar feedback, relatórios de bugs ou sugestões sobre o aplicativo diretamente aqui como alternativa.""",
      """about.donate.title""": """Faça uma Doação""",
      """about.donate.subtitle""":
          """Se você está procurando uma maneira de apoiar o projeto, pode fazer uma doação na página oficial do Ko-fi do desenvolvedor. Clique aqui para ser redirecionado para a página do Ko-fi.""",
      """about.socials.title""": """Links""",
      """about.socials.twitter""": """Twitter""",
      """about.socials.facebook""": """Facebook""",
      """about.socials.discord""": """Discord""",
      """about.socials.github""": """GitHub""",
      """about.socials.google""": """Play Store""",
      """about.socials.apple""": """App Store""",
      """about.specialThanks""": """Agradecimentos Especiais""",
      """about.contributors""": """Contribuidores""",
      """about.icons""": """Créditos dos Ícones""",
      """character.data.coins""": """Moedas""",
      """character.data.load.load""": """Carga""",
      """character.data.load.maxLoad""": """Carga Máxima""",
      """character.data.load.autoMaxLoad""":
          """Usar carga base da classe + mod de FOR""",
      """character.data.level""": """Nível""",
      """character.data.damageDice""": """Dados de Dano""",
      """character.data.calculateDamage""":
          """Usar dados de dano da classe e itens equipados""",
      """character.header.separator""": """ ∙ """,
      """character.noCategory""": """Sem Categoria""",
      """character.theme.title""": """Tema do Personagem""",
      """characterClass.baseLoad""": """Carga Base""",
      """characterClass.baseHp""": """HP Base""",
      """characterClass.damageDice""": """Dados de Dano""",
      """characterClass.isSpellcaster.title""": """Classe de Feitiçaria""",
      """characterClass.isSpellcaster.subtitle""":
          """Conjuradores são solicitados a selecionar feitiços (bem como movimentos) durante a criação do personagem e ao subir de nível.""",
      """characterClass.stats""": """Estatísticas""",
      """characterClass.bio""": """Antecedentes""",
      """characterClass.startingGear.label""":
          """Seleções de Equipamento Inicial""",
      """startingGear.titleEdit""": """Editar Equipamento Inicial""",
      """startingGear.titleSelect""": """Selecionar Equipamento Inicial""",
      """startingGear.choice.helpText""":
          """Uma escolha é uma lista de seleções que o jogador pode fazer. Ela fornece um conjunto possível de itens e moedas que o jogador pode selecionar.""",
      """startingGear.choice.description.label""": """Prompt""",
      """startingGear.choice.description.hintText""":
          """ex. Escolha sua arma""",
      """startingGear.choice.maxSelections.label""":
          """Limite sugerido de seleção""",
      """startingGear.choice.maxSelections.helpText""":
          """Isto sugerirá uma quantidade máxima a ser selecionada e exibirá uma contagem, mas não limitará a seleção. Use 0 ou deixe em branco para sem limite.""",
      """startingGear.choice.moveUp""": """Mover para cima""",
      """startingGear.choice.moveDown""": """Mover para baixo""",
      """startingGear.selection.title""": """Conjunto de Equipamento""",
      """startingGear.selection.helpText""":
          """Cada conjunto de equipamento consiste em uma quantidade de moedas e uma lista de itens a serem dados ao personagem. Escolher um conjunto de equipamento dará ao personagem todos os itens e ouro daquele conjunto.""",
      """startingGear.selection.add""": """Adicionar Conjunto de Equipamento""",
      """startingGear.selection.description.label""":
          """Descrição da seleção""",
      """startingGear.selection.description.hintText""":
          """ex. A espada antiga do seu pai, e 10 moedas""",
      """startingGear.selection.coins.label""": """Moedas""",
      """startingGear.option.title""": """Itens do Conjunto de Equipamento""",
      """startingGear.option.helpText""":
          """Cada item do conjunto de equipamento consiste em X quantidade de um item específico.""",
      """startingGear.option.add""": """Adicionar Itens""",
      """startingGear.option.amount.label""": """Quantidade""",
      """dice.form.amount""": """Quantidade""",
      """dice.form.sides""": """Lados""",
      """dice.form.diceSeparator""": """d""",
      """dice.form.modifierType.fixed""": """Valor Fixo""",
      """dice.form.modifierType.modifier""": """Modificador de Atributo""",
      """dice.form.value.placeholder""": """Número, ex. 2 ou -1""",
      """dice.form.value.label""": """Valor do modificador""",
      """dice.form.modifier.placeholder""": """Selecionar atributo""",
      """dice.form.modifier.label""": """Atributo""",
      """dice.roll.action""": """Rolar""",
      """basicInfo.title""": """Informações Básicas""",
      """basicInfo.form.name.label""": """Nome do Personagem""",
      """basicInfo.form.name.placeholder""":
          """Digite o nome do seu personagem""",
      """basicInfo.form.photo.change""": """Alterar Foto...""",
      """basicInfo.form.photo.remove""": """Remover Foto""",
      """basicInfo.form.photo.choose""": """Escolher Foto...""",
      """basicInfo.form.photo.guest.prefix""":
          """Você precisa estar logado para carregar imagens. """,
      """basicInfo.form.photo.guest.label""": """Entre ou crie uma conta""",
      """basicInfo.form.photo.guest.suffix""":
          """, ou faça o upload usando seu próprio URL abaixo.""",
      """basicInfo.form.photo.uploading""": """CARREGANDO...""",
      """basicInfo.form.photo.orSeparator""": """OU""",
      """basicInfo.form.photo.url.label""": """URL da Imagem""",
      """basicInfo.form.photo.url.placeholder""": """Cole um URL de imagem""",
      """debilities.dialog.title""": """Debilidades""",
      """debilities.dialog.info""":
          """Debilidades são condições ou estados negativos temporários em que seu personagem se encontra. Quando um atributo está debilitado, ele reduz seu modificador em 1 até se recuperar.""",
      """tags.dialog.title""": """Informações da Tag""",
      """dialogs.confirmations.exit.title""": """Você tem certeza?""",
      """dialogs.confirmations.exit.body""":
          """Voltar perderá todas as mudanças não salvas.\nTem certeza de que deseja voltar?""",
      """dialogs.confirmations.exit.ok""": """Sair e Descartar""",
      """dialogs.confirmations.exit.cancel""": """Continuar editando""",
      """dialogs.confirmations.deleteAccount.step1.title""":
          """Excluir sua Conta?""",
      """dialogs.confirmations.deleteAccount.step1.body""":
          """Tem certeza de que deseja excluir sua conta?\n\nEsta ação não pode ser desfeita.""",
      """dialogs.confirmations.deleteAccount.step2.title""":
          """Tem certeza mesmo?""",
      """dialogs.confirmations.deleteAccount.step2.body""":
          """Não salvamos nenhum dado de contas excluídas. Todos os seus dados serão permanentemente deletados.\n\nTem certeza de que deseja excluir sua conta?\n\nPor favor, confirme uma última vez.""",
      """items.amountTooltip""": """Quantidade""",
      """items.settings.countArmor""": """Contar Armadura""",
      """items.settings.countDamage""": """Contar Dano""",
      """items.settings.countWeight""": """Contar Peso""",
      """notes.category.label""": """Categoria""",
      """notes.noCategory""": """Geral""",
      """notes.emptyState.title""": """Sem Notas""",
      """notes.emptyState.subtitle""":
          """Você pode registrar seu progresso, memorandos, listas, mapas e muito mais usando o diário.""",
      """notes.emptyState.button""": """Criar Nota""",
      """alignment.alignmentValues.title""": """Alinhamentos""",
      """bio.dialog.title""": """Biografia do Personagem""",
      """bio.dialog.description.label""":
          """Descrição do personagem e antecedentes""",
      """bio.dialog.description.placeholder""":
          """Descreva o histórico, a personalidade, os objetivos, etc., do seu personagem.""",
      """bio.dialog.looks.label""": """Aparência""",
      """bio.dialog.looks.placeholder""":
          """Descreva a aparência do seu personagem. Você pode usar os presets dos botões acima.""",
      """bio.dialog.alignment.label""": """Alinhamento""",
      """bio.dialog.alignmentDescription.label""":
          """Descrição do Alinhamento""",
      """bio.dialog.alignmentDescription.placeholder""":
          """Alinhamento é a maneira como seu personagem pensa e sua bússola moral. Isso pode se basear em um ideal ético, restrições religiosas ou eventos da vida inicial. Reflete o que seu personagem valoriza e aspira proteger ou criar.""",
      """search.placeholder""": """Digite para pesquisar""",
      """search.searchIn""": """Pesquisar em""",
      """hp.dialog.title""": """Modificar HP""",
      """hp.dialog.change.neutral""": """Sem Alteração""",
      """hp.dialog.overrideMax""": """Substituir HP Máximo""",
      """hp.bar.label""": """HP""",
      """xp.dialog.endOfSession.title""": """Finalizar Sessão""",
      """xp.dialog.endOfSession.button""": """Finalizar Sessão""",
      """xp.dialog.endOfSession.questions.title""":
          """Perguntas de Fim de Sessão""",
      """xp.dialog.endOfSession.questions.subtitle""":
          """Responda a essas perguntas em grupo. Para cada resposta "sim", marca-se XP.""",
      """xp.dialog.levelUp.title""": """Subir de Nível""",
      """xp.dialog.levelUp.button""": """Subir de Nível""",
      """xp.dialog.levelUp.increaseStat""": """Aumentar um atributo em 1:""",
      """xp.dialog.levelUp.choose.move""": """um movimento avançado""",
      """xp.dialog.levelUp.choose.spell""": """um feitiço""",
      """xp.dialog.overwrite.title""": """Sobrescrever XP e Nível""",
      """xp.dialog.overwrite.button""": """Sobrescrever""",
      """xp.dialog.overwrite.info""":
          """Alterar manualmente o XP ou o nível atual fará com que o XP pendente seja descartado, a menos que isso seja desmarcado.""",
      """xp.dialog.overwrite.resetCheckbox""":
          """Redefinir vínculos, bandeiras e perguntas de fim de sessão após salvar""",
      """xp.dialog.overwrite.xp""": """Sobrescrever XP""",
      """xp.dialog.overwrite.level""": """Sobrescrever Nível""",
      """xp.bar.label""": """XP""",
      """armor.title""": """Armadura""",
      """armor.dialog.title""": """Armadura""",
      """armor.dialog.autoArmor""":
          """Usar armadura da classe e itens equipados""",
      """richText.preview""": """Pré-visualização""",
      """richText.help""": """Ajuda de Formatação""",
      """richText.bold""": """Negrito""",
      """richText.italic""": """Itálico""",
      """richText.headings""": """Cabeçalhos""",
      """richText.bulletList""": """Lista com Marcadores""",
      """richText.numberedList""": """Lista Numerada""",
      """richText.checkList.unchecked""":
          """Lista de Verificação (Não Marcada)""",
      """richText.checkList.checked""": """Lista de Verificação (Marcada)""",
      """richText.url""": """URL""",
      """richText.imageURL""": """URL da Imagem""",
      """richText.table""": """Tabela""",
      """richText.markdownPreview""": """Pré-visualização de Markdown""",
      """richText.date""": """Adicionar Data Atual""",
      """richText.time""": """Adicionar Hora Atual""",
      """customRolls.title""": """Botões de Rolagem Rápida""",
      """customRolls.left""": """Botão Esquerdo""",
      """customRolls.right""": """Botão Direito""",
      """customRolls.buttonLabel""": """Rótulo do Botão""",
      """customRolls.specialDice.title""": """Dados Especiais""",
      """customRolls.presets.title""": """Predefinições""",
      """customRolls.presets.basicAction""": """Ação Básica""",
      """customRolls.presets.hackAndSlash""": """Golpear & Retalhar""",
      """customRolls.presets.volley""": """Volêi""",
      """customRolls.presets.discernRealities""": """Discernir Realidades""",
      """sessionMarks.title""": """Vínculos & Bandeiras""",
      """sessionMarks.bond""": """Vínculo""",
      """sessionMarks.bonds""": """Vínculos""",
      """sessionMarks.flag""": """Bandeira""",
      """sessionMarks.flags""": """Bandeiras""",
      """sessionMarks.noData""":
          """Você não tem vínculos ou bandeiras. Você pode adicionar alguns usando o botão de edição acima e marcá-los como concluídos à medida que avança em sua aventura.""",
      """sessionMarks.info""":
          """Você pode adicionar, atualizar ou remover vínculos e bandeiras usando o ícone de edição acima.""",
      """sessionMarks.endOfSession.q1""":
          """Aprendemos algo novo e importante sobre o mundo?""",
      """sessionMarks.endOfSession.q2""":
          """Superamos um monstro ou inimigo notável?""",
      """sessionMarks.endOfSession.q3""": """Saqueamos um tesouro memorável?""",
      """createCharacter.characterClass.noSelection""":
          """Nenhuma classe selecionada (obrigatório)""",
      """createCharacter.basicInfo.defaultName""": """Viajante Sem Nome""",
      """createCharacter.basicInfo.helpText""":
          """Selecione nome e imagem (obrigatório)""",
      """createCharacter.startingGear.helpText""":
          """Selecione seu equipamento inicial determinado pela classe (opcional)""",
      """createCharacter.movesSpells.title""": """Movimentos & Feitiços""",
      """account.details.title""": """Detalhes da conta""",
      """account.details.displayName.title""": """Alterar Nome de Exibição""",
      """account.details.displayName.label""": """Nome de exibição""",
      """account.details.displayName.placeholder""":
          """Insira seu nome de exibição público""",
      """account.details.displayName.success""":
          """Nome de exibição alterado com sucesso""",
      """account.details.image.title""": """Alterar Foto de Perfil""",
      """account.details.image.subtitle""": """Alterar sua foto de perfil""",
      """account.details.email.title""": """Alterar Endereço de Email""",
      """account.details.email.label""": """Endereço de email""",
      """account.details.email.placeholder""":
          """Insira um novo endereço de email""",
      """account.details.email.success""": """Email alterado com sucesso""",
      """account.details.password.title""": """Alterar Senha""",
      """account.details.password.subtitle""": """Alterar sua senha""",
      """account.details.password.success""": """Senha alterada com sucesso""",
      """account.details.password.label""": """Nova senha""",
      """account.details.password.placeholder""": """Insira sua nova senha""",
      """account.details.password.visibility.show""": """Mostrar senha""",
      """account.details.password.visibility.hide""": """Ocultar senha""",
      """account.details.password.confirm.label""": """Confirmar Nova Senha""",
      """account.details.password.confirm.placeholder""":
          """Insira a mesma senha novamente""",
      """account.details.password.error""": """As senhas não coincidem""",
      """account.providers.title""": """Logins conectados""",
      """account.deleteAccount.title""": """Excluir Sua Conta""",
      """account.deleteAccount.success""":
          """Uma solicitação de exclusão para sua conta foi enviada com sucesso""",
      """actions.moves.basic""": """Movimentos Básicos""",
      """actions.moves.special""": """Movimentos Especiais""",
      """actions.classActions.title""": """Ações de Classe""",
      """actions.classActions.markXP.button""": """Marcar +1 XP""",
      """actions.classActions.markXP.success""": """+1 XP marcado""",
      """abilityScores.info""":
          """Você pode arrastar e soltar os cartões de estatísticas para mudar a ordem em que eles aparecem nas telas deste personagem.""",
      """abilityScores.rollButton.stat""": """Rolar +{stat}""",
      """abilityScores.rollButton.randStat""":
          """Rolar estatística aleatória""",
      """abilityScores.stats.bond.name""": """Vínculo""",
      """abilityScores.stats.bond.description""":
          """Quando um movimento pede para você rolar+vínculo, você contará o número de vínculos que tem com o personagem em questão e adicionará isso à rolagem.""",
      """abilityScores.stats.bond.debility.name""": """Solitário""",
      """abilityScores.stats.cha.description""":
          """Mede a personalidade de um personagem, magnetismo pessoal, habilidade de liderança e aparência.""",
      """abilityScores.stats.cha.name""": """Carisma""",
      """abilityScores.stats.cha.debility.name""": """Cicatrizado""",
      """abilityScores.stats.cha.debility.description""":
          """Pode não ser permanente, mas por enquanto você não parece tão bem.""",
      """abilityScores.stats.con.description""":
          """Representa a saúde e resistência do seu personagem.""",
      """abilityScores.stats.con.name""": """Constituição""",
      """abilityScores.stats.con.debility.name""": """Doente""",
      """abilityScores.stats.con.debility.description""":
          """Algo não está certo por dentro. Talvez você tenha uma doença ou uma enfermidade debilitante. Talvez você só tenha bebido muita cerveja na noite passada e agora ela esteja voltando para assombrá-lo.""",
      """abilityScores.stats.dex.description""":
          """Mede agilidade, reflexos e equilíbrio.""",
      """abilityScores.stats.dex.name""": """Destreza""",
      """abilityScores.stats.dex.debility.name""": """Tremor""",
      """abilityScores.stats.dex.debility.description""":
          """Você está instável nos pés e tem um tremor nas mãos.""",
      """abilityScores.stats.str.description""":
          """Mede o músculo e o poder físico.""",
      """abilityScores.stats.str.name""": """Força""",
      """abilityScores.stats.str.debility.name""": """Fraco""",
      """abilityScores.stats.str.debility.description""":
          """Você não pode exercer muita força. Talvez seja apenas cansaço e lesão, ou talvez sua força tenha sido drenada por magia.""",
      """abilityScores.stats.wis.description""":
          """Descreve a força de vontade, senso comum, consciência e intuição de um personagem.""",
      """abilityScores.stats.wis.name""": """Sabedoria""",
      """abilityScores.stats.wis.debility.name""": """Confuso""",
      """abilityScores.stats.wis.debility.description""":
          """Ouvidos zumbindo. Visão embaçada. Você está mais do que um pouco fora de si.""",
      """abilityScores.stats.intl.description""":
          """Determina o quão bem seu personagem aprende e raciocina.""",
      """abilityScores.stats.intl.name""": """Inteligência""",
      """abilityScores.stats.intl.debility.name""": """Atordoado""",
      """abilityScores.stats.intl.debility.description""":
          """Aquela última pancada na cabeça soltou algo. O cérebro não está funcionando muito bem.""",
      """abilityScores.form.debilityDescription.label""":
          """Descrição da Debilidade""",
      """abilityScores.form.debilityDescription.description""":
          """Uma descrição do efeito que causa a debilidade e/ou como isso afeta seu personagem""",
      """abilityScores.form.debilityName.label""": """Nome da Debilidade""",
      """abilityScores.form.debilityName.description""":
          """O nome para a debilidade que ocorre quando este atributo é debilitado (leva -1 até se recuperar).""",
      """abilityScores.form.description.label""":
          """Descrição da Pontuação de Habilidade""",
      """abilityScores.form.description.description""":
          """Uma descrição do que esta pontuação de habilidade representa""",
      """abilityScores.form.key.label""":
          """Chave da Pontuação de Habilidade""",
      """abilityScores.form.key.description""":
          """Uma chave única de 3 letras que identifica esta pontuação de habilidade nos dados e é usada como o rótulo curto para o valor do modificador (e não a pontuação real)""",
      """abilityScores.form.name.label""":
          """Nome da Pontuação de Habilidade""",
      """abilityScores.form.name.description""":
          """O nome desta pontuação de habilidade""",
      """abilityScores.form.icon.label""": """Ícone""",
      """abilityScores.form.icon.button""": """Alterar Ícone""",
      """feedback.title""": """Enviar Feedback do App""",
      """feedback.send""": """Enviar""",
      """feedback.form.title.label""": """Título do feedback""",
      """feedback.form.body.label""":
          """Problema, ideia ou descrição do feedback""",
      """feedback.form.email.label""": """Insira seu email""",
      """feedback.success.title""": """Feedback enviado!""",
      """feedback.success.message""":
          """Obrigado pelo seu feedback! Vamos revisá-lo o mais rápido possível.""",
      """migration.title""": """Bem-vindo ao\nDungeon Paper 2!""",
      """migration.subtitle""":
          """Para começar, escolha um nome de usuário e o idioma para o livro de regras e o aplicativo. Se você já possui uma conta Dungeon Paper existente, seus dados podem levar alguns segundos para migrar.""",
      """migration.username.label""": """Nome de usuário""",
      """migration.username.placeholder""":
          """Escolha um nome de usuário único""",
      """migration.username.info""":
          """Seu nome de usuário é único e não pode ser alterado depois, então pense bem! Ele será usado para identificar todos os itens da sua biblioteca ao publicar.""",
      """migration.language.data""": """Idioma padrão dos dados""",
      """backup.title""": """Exportar/Importar""",
      """backup.importing.title""": """Importar""",
      """backup.importing.button""": """Importar""",
      """backup.importing.progress.title""": """Importando...""",
      """backup.importing.file.browse""": """Navegar...""",
      """backup.importing.file.clearFile""": """Limpar arquivo selecionado""",
      """backup.importing.file.info""":
          """Para começar a importar, escolha o arquivo do qual deseja importar.\nVocê poderá então selecionar o que salvar e o que deixar de fora.""",
      """backup.importing.success.title""": """Importação Bem-sucedida""",
      """backup.importing.success.message""":
          """Seus dados foram importados do arquivo com sucesso""",
      """backup.importing.error.title""": """Falha na Importação""",
      """backup.importing.error.message""":
          """Algo deu errado.\nTente novamente ou entre em contato com o suporte se isso persistir""",
      """backup.exporting.title""": """Exportar""",
      """backup.exporting.button""": """Exportar""",
      """backup.exporting.error.title""": """Falha na Exportação""",
      """backup.exporting.error.message""":
          """Algo deu errado.\nTente novamente ou entre em contato com o suporte se isso persistir""",
      """backup.exporting.success.title""": """Exportação Bem-sucedida""",
      """backup.exporting.success.message""":
          """Seus dados foram exportados para o arquivo com sucesso""",
      """backup.exporting.bundles.characterClass.button""":
          """Exportar Pacote de Classe""",
      """backup.exporting.bundles.characterClass.title""":
          """Exportar Pacote de Classe""",
      """changelog.title""": """O que há de novo?""",
      """changelog.tags.latest""": """Última""",
      """changelog.tags.current""": """Atual""",
    };
