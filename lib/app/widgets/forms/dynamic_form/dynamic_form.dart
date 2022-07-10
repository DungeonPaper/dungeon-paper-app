import 'dart:async';

import 'package:dungeon_paper/app/data/models/item.dart';
import 'package:dungeon_paper/app/data/models/meta.dart';
import 'package:dungeon_paper/app/data/models/user.dart';
import 'package:dungeon_paper/app/data/services/repository_service.dart';
import 'package:dungeon_paper/app/data/services/user_service.dart';
import 'package:dungeon_paper/app/model_utils/model_json.dart';
import 'package:dungeon_paper/app/model_utils/model_meta.dart';
import 'package:dungeon_paper/app/widgets/forms/entity_share_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'form_input_data.dart';

class DynamicForm<T extends WithMeta> extends StatefulWidget {
  const DynamicForm({
    Key? key,
    required this.inputs,
    required this.onChange,
    required this.onReplace,
    this.builder,
    required this.entity,
  }) : super(key: key);

  final Iterable<FormInputData> inputs;
  final T entity;
  final void Function(Map<String, dynamic> data) onChange;
  final void Function(dynamic data) onReplace;
  final Widget Function(BuildContext context, List<Widget> inputs, T entity)? builder;

  @override
  State<DynamicForm> createState() => DynamicFormState();
}

class DynamicFormState<T extends WithMeta> extends State<DynamicForm<T>> {
  late List<StreamSubscription> listeners;
  late Map<String, dynamic> data;

  @override
  void initState() {
    listeners = [];
    data = {};
    for (final input in widget.inputs) {
      // debugPrint('init form data ${input.name}');
      input.data.form = this;
      listeners.add(input.data.listen(_sendUpdate(input.name)));
      data[input.name] = input.data.value;
    }
    super.initState();
    for (final input in widget.inputs) {
      input.data.onFormInit();
    }
  }

  @override
  void dispose() {
    for (final listener in listeners) {
      listener.cancel();
    }
    for (final input in widget.inputs) {
      input.dispose();
    }
    super.dispose();
  }

  void Function(dynamic item) _sendUpdate(String name) => (dynamic item) {
        setState(() {
          data[name] = item;
        });
        // debugPrint('sending $data');
        widget.onChange(data);
      };

  @override
  Widget build(BuildContext context) {
    var builder = widget.builder ?? _defaultBuilder;
    return builder(
      context,
      [
        ...widget.inputs.map((input) => input.build(context)),
        EntityShareForm<T>(
          entity: widget.entity,
          onChange: widget.onReplace,
        ),
      ],
      widget.entity,
    );
  }

  Widget _defaultBuilder(BuildContext context, List<Widget> inputs, dynamic entity) {
    return ListView(
      // shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 70),
      children: [
        for (final input in inputs)
          Padding(padding: const EdgeInsets.only(bottom: 16), child: input),
      ],
    );
  }
}

abstract class DynamicFormController<T extends WithMeta> extends GetxController {
  final repo = Get.find<RepositoryService>();

  abstract final Rx<T> entity;
  final dirty = false.obs;

  @mustCallSuper
  T setData(Map<String, dynamic> data) {
    for (final input in inputs) {
      if (data.containsKey(input.name) && !input.data.equals(data[input.name])) {
        debugPrint(
            'updating form data: ${input.name}: [${input.data.value}] != [${data[input.name]}]');
        input.data.value = data[input.name];
      }
    }
    if (data.containsKey('meta')) {
      entity.value = entity.value.copyWithInherited(meta: data['meta']);
    }
    return entity.value;
  }

  late final List<FormInputData> inputs;

  @mustCallSuper
  FutureOr<void> init() {
    if (argument != null) {
      // when editing, create a fork of the move
      // entity.value = forkMeta(argument, user);
      createInputs();
      debugPrint("Before copy");
      final copy = entity.value.copyWithInherited(key: argument!.key, meta: argument!.meta);
      debugPrint("copy $copy");
      entity.value = copy;
      setFromEntity(argument!);
    } else {
      // when creating new item, set the correct owner now
      createInputs();
    }
  }

  UserService get users => Get.find();
  User get user => users.current;

  T setFromEntity(T argument);

  void createInputs();

  T? get argument;

  @override
  void onInit() {
    super.onInit();
    init();
  }
}
