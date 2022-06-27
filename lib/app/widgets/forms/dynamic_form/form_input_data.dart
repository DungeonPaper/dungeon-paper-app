import 'dart:async';

import 'package:dungeon_paper/app/data/models/ability_scores.dart';
import 'package:dungeon_paper/app/themes/themes.dart';
import 'package:dungeon_paper/app/widgets/atoms/rich_text_field.dart';
import 'package:dungeon_paper/app/widgets/atoms/select_box.dart';
import 'package:dungeon_paper/app/widgets/forms/dynamic_form/dynamic_form.dart';
import 'package:dungeon_paper/app/widgets/molecules/dice_list_input.dart';
import 'package:dungeon_paper/app/widgets/molecules/tag_list_input.dart';
import 'package:dungeon_paper/core/utils/interfaces.dart';
import 'package:dungeon_paper/core/utils/streams.dart';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

part 'form_dice_input_data.dart';
part 'form_dropdown_input_data.dart';
part 'form_tags_input_data.dart';
part 'form_text_input_data.dart';

enum FormInputType {
  text,
  dropdown,
}

abstract class BaseInputData<T> extends Stream<T> implements Disposable {
  late DynamicFormState form;

  T get value;
  Widget build(BuildContext context);

  void onFormInit() {}
}

class FormInputData<T extends BaseInputData> {
  FormInputData({
    required this.name,
    required this.data,
  });

  final String name;
  final T data;
  Widget build(BuildContext context) => data.build(context);

  void dispose() {
    data.dispose();
  }
}
