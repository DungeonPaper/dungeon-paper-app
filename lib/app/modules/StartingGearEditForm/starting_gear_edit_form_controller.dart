import 'package:dungeon_paper/app/data/models/gear_choice.dart';
import 'package:dungeon_paper/app/data/models/gear_selection.dart';
import 'package:dungeon_paper/app/data/models/item.dart';
import 'package:dungeon_paper/app/data/models/item_settings.dart';
import 'package:dungeon_paper/app/data/models/meta.dart';
import 'package:dungeon_paper/app/model_utils/model_pages.dart';
import 'package:dungeon_world_data/gear_option.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:dungeon_paper/app/data/services/character_provider.dart';
import 'package:dungeon_paper/app/data/services/user_provider.dart';
import 'package:dungeon_paper/core/utils/uuid.dart';

class StartingGearEditFormController extends ChangeNotifier
    with CharacterProviderMixin, UserProviderMixin {
  final BuildContext context;
  late final StartingGearEditFormControllerArgs args;
  late final List<GearChoiceData> choices;

  StartingGearEditFormController(this.context) {
    args = ModalRoute.of(context)!.settings.arguments
        as StartingGearEditFormControllerArgs;
    choices = args.choices.map((c) => GearChoiceData(c)).toList();
  }

  void save() {
    final choices = this.choices.map((c) => c.data).toList();
    args.onSave(choices);
  }

  void swapChoices(int idx1, int idx2) {
    final tmp = choices[idx1];
    choices[idx1] = choices[idx2];
    choices[idx2] = tmp;
    notifyListeners();
  }

  void moveChoiceBy(GearChoice choice, int amount) {
    final idx = _findChoice(choice, true);
    final newIdx = (idx + amount).clamp(0, choices.length - 1);
    swapChoices(idx, newIdx);
  }

  GearChoiceData addChoice([GearChoice? choice]) {
    final choice = GearChoice(
      key: uuid(),
      description: '',
      selections: [],
      maxSelections: 1,
    );
    final data = GearChoiceData(choice);
    choices.add(data);

    addSelection(choice);

    notifyListeners();
    return data;
  }

  GearChoiceData updateChoice(GearChoice choice) {
    final idx = _findChoice(choice, true);
    choices[idx].data = choice;

    notifyListeners();
    return choices[idx];
  }

  void removeChoice(GearChoice choice) {
    choices.removeWhere((c) => c.data.key == choice.key);
    notifyListeners();
  }

  GearSelectionData addSelection(GearChoice choice) {
    final idx = _findChoice(choice, true);
    final selection = GearSelection(
      key: uuid(),
      coins: 0,
      description: '',
      options: [],
    );
    final data = GearSelectionData(selection);
    final choiceData = choices[idx];
    choiceData.selections.add(data);
    choiceData.data = GearChoice.fromDwGearChoice(
      choice.copyWith(selections: choice.selections + [selection]),
    );
    notifyListeners();
    return data;
  }

  void removeSelection(GearChoice choice, GearSelection selection) {
    final choiceIdx = _findChoice(choice, true);
    final idx = _findSelection(choice, selection, true);

    final choiceData = choices[choiceIdx];
    final selections = choiceData.data.selections;
    choiceData.selections.removeAt(idx);
    choiceData.data = GearChoice.fromDwGearChoice(
      choiceData.data.copyWith(
        selections: selections.sublist(0, idx) + selections.sublist(idx + 1),
      ),
    );
    notifyListeners();
  }

  GearOptionData addOption(GearChoice choice, GearSelection selection,
      [Item? item]) {
    final choiceIdx = _findChoice(choice, true);
    final selectionIdx = _findSelection(choice, selection, true);
    final option = GearOption(
      key: uuid(),
      amount: 1,
      item: item ??
          Item(
            key: uuid(),
            name: '',
            tags: [],
            description: '',
            meta: Meta.empty(),
            settings: ItemSettings(),
          ),
    );
    final data = GearOptionData(option);
    final choiceData = choices[choiceIdx];
    final selectionData = choiceData.selections[selectionIdx];
    final options = selectionData.data.options;
    selectionData.options.add(data);
    selectionData.data = GearSelection.fromDwGearSelection(
      selectionData.data.copyWith(
        options: options.map((x) => GearOption.fromJson(x.toJson())).toList() +
            [option],
      ),
    );
    notifyListeners();
    return data;
  }

  void removeOption(
      GearChoice choice, GearSelection selection, GearOption option) {
    final choiceIdx = _findChoice(choice, true);
    final selectionIdx = _findSelection(choice, selection, true);
    final optionIdx = _findOption(choice, selection, option, true);
    final choiceData = choices[choiceIdx];
    final selectionData = choiceData.selections[selectionIdx];
    final options = selectionData.data.options;
    selectionData.options.removeAt(optionIdx);
    selectionData.data = GearSelection.fromDwGearSelection(
      selectionData.data.copyWith(
        options: options.sublist(0, optionIdx) + options.sublist(optionIdx + 1),
      ),
    );
    notifyListeners();
  }

  void selectItemsToAdd(GearChoice choice, GearSelection selection) {
    ModelPages.openItemsList(
      context,
      preSelections: selection.options.map((o) => Item.fromDwItem(o.item)),
      onSelected: (items) {
        for (final item in items) {
          addOption(choice, selection, item);
        }
      },
    );
  }

  int _findChoice(GearChoice choice, [bool shouldThrow = false]) {
    final idx = choices.indexWhere((c) => c.data.key == choice.key);
    if (shouldThrow && idx == -1) {
      throw Exception('Unknown choice: ${choice.key}');
    }
    return idx;
  }

  int _findSelection(GearChoice choice, GearSelection selection,
      [bool shouldThrow = false]) {
    final choiceIdx = _findChoice(choice, shouldThrow);
    final idx = choices[choiceIdx]
        .selections
        .indexWhere((s) => s.data.key == selection.key);
    if (shouldThrow && idx == -1) {
      throw Exception('Unknown selection: ${selection.key}');
    }
    return idx;
  }

  int _findOption(GearChoice choice, GearSelection selection, GearOption option,
      [bool shouldThrow = false]) {
    final choiceIdx = _findChoice(choice, shouldThrow);
    final selectionIdx = _findSelection(choice, selection, shouldThrow);
    if (choiceIdx == -1 || selectionIdx == -1) return -1;
    final idx = choices[choiceIdx]
        .selections[selectionIdx]
        .options
        .indexWhere((o) => o.data.key == option.key);
    if (shouldThrow && idx == -1) {
      throw Exception('Unknown option: ${option.key}');
    }
    return idx;
  }

  static StartingGearEditFormController of(BuildContext context) =>
      Provider.of<StartingGearEditFormController>(context, listen: false);
}

class StartingGearEditFormControllerArgs {
  final List<GearChoice> choices;
  final void Function(List<GearChoice>) onSave;

  StartingGearEditFormControllerArgs({
    required this.choices,
    required this.onSave,
  });
}

class GearChoiceData {
  GearChoice _data;
  TextEditingController description;
  TextEditingController maxAllowance;
  List<GearSelectionData> selections;

  GearChoiceData(GearChoice data)
      : _data = data,
        description = TextEditingController(text: data.description),
        maxAllowance =
            TextEditingController(text: (data.maxSelections ?? '').toString()),
        selections = data.selections.map((s) => GearSelectionData(s)).toList();

  GearChoice get data => GearChoice.fromDwGearChoice(
        _data.copyWith(
          description: description.text,
          maxSelections: int.tryParse(maxAllowance.text) ?? 1,
          selections: selections.map((s) => s._data).toList(),
        ),
      );

  set data(GearChoice data) {
    _data = data;
    description.text = data.description;
    maxAllowance.text = (data.maxSelections ?? '').toString();
    selections = data.selections.map((s) => GearSelectionData(s)).toList();
  }
}

class GearSelectionData {
  GearSelection _data;
  TextEditingController description;
  TextEditingController coins;
  List<GearOptionData> options;

  GearSelectionData(GearSelection data)
      : _data = data,
        coins = TextEditingController(text: data.coins.toString()),
        description = TextEditingController(text: data.description),
        options = data.options.map((o) => GearOptionData(o)).toList();

  GearSelection get data => GearSelection.fromDwGearSelection(
        _data.copyWith(
          description: description.text,
          coins: double.tryParse(coins.text) ?? 0.0,
          options: options.map((o) => o._data).toList(),
        ),
      );

  set data(GearSelection data) {
    _data = data;
    description.text = data.description;
    coins.text = data.coins.toString();
    options = data.options.map((o) => GearOptionData(o)).toList();
  }
}

class GearOptionData {
  GearOption _data;
  ValueNotifier<Item> item;
  TextEditingController amount;

  GearOptionData(GearOption data)
      : _data = data,
        item = ValueNotifier(Item.fromDwItem(data.item)),
        amount = TextEditingController(text: data.amount.toString());

  GearOption get data => _data.copyWith(
        amount: double.tryParse(amount.text) ?? 1.0,
        item: item.value,
      );

  set data(GearOption data) {
    _data = data;
    item.value = Item.fromDwItem(data.item);
    amount.text = data.amount.toString();
  }
}

