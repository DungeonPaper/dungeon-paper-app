import 'dart:async';

import 'package:dungeon_paper/app/model_utils/tag_utils.dart';
import 'package:dungeon_paper/app/themes/themes.dart';
import 'package:dungeon_paper/app/widgets/atoms/select_box.dart';
import 'package:dungeon_paper/app/widgets/chips/tag_chip.dart';
import 'package:dungeon_paper/app/widgets/dialogs/add_tag_dialog.dart';
import 'package:dungeon_paper/core/utils/list_utils.dart';
import 'package:dungeon_paper/core/utils/streams.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

part 'form_tags_input_data.dart';
part 'form_text_input_data.dart';
part 'form_dropdown_input_data.dart';

enum FormInputType {
  text,
  dropdown,
}

abstract class BaseInputData<T> extends Stream<T> {
  void dispose();
  T get value;
  Widget build(BuildContext context);
}

class FormInputData<T extends BaseInputData> {
  FormInputData({
    required this.name,
    required this.data,
  });

  final String name;
  final T data;
  Widget build(BuildContext context) => data.build(context);
}
