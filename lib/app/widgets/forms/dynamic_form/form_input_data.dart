import 'dart:async';
import 'dart:math';

import 'package:dungeon_paper/app/data/models/roll_stats.dart';
import 'package:dungeon_paper/app/model_utils/dice_utils.dart';
import 'package:dungeon_paper/app/model_utils/tag_utils.dart';
import 'package:dungeon_paper/app/themes/themes.dart';
import 'package:dungeon_paper/app/widgets/atoms/select_box.dart';
import 'package:dungeon_paper/app/widgets/chips/dice_chip.dart';
import 'package:dungeon_paper/app/widgets/chips/tag_chip.dart';
import 'package:dungeon_paper/app/widgets/dialogs/add_dice_dialog.dart';
import 'package:dungeon_paper/app/widgets/dialogs/add_tag_dialog.dart';
import 'package:dungeon_paper/app/widgets/forms/dynamic_form/dynamic_form.dart';
import 'package:dungeon_paper/core/utils/interfaces.dart';
import 'package:dungeon_paper/core/utils/list_utils.dart';
import 'package:dungeon_paper/core/utils/streams.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

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
