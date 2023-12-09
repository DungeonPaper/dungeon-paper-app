import 'package:dungeon_paper/app/data/models/meta.dart';
import 'package:dungeon_paper/app/data/models/user.dart';
import 'package:dungeon_paper/app/data/services/user_service.dart';
import 'package:dungeon_paper/app/widgets/atoms/advanced_floating_action_button.dart';
import 'package:dungeon_paper/app/widgets/atoms/confirm_exit_view.dart';
import 'package:dungeon_paper/app/widgets/forms/entity_share_form.dart';
import 'package:dungeon_paper/core/utils/builder_utils.dart';
import 'package:dungeon_paper/core/utils/enums.dart';
import 'package:dungeon_paper/core/utils/list_utils.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LibraryEntityForm<
    T extends WithMeta,
    Ctrl extends LibraryEntityFormController<T,
        LibraryEntityFormArguments<T>>> extends GetView<Ctrl> {
  const LibraryEntityForm({
    super.key,
    required this.children,
  });

  final List<Widget Function()> children;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ConfirmExitView(
        dirty: controller.dirty.value,
        child: Scaffold(
          appBar: AppBar(
            title: title,
          ),
          body: ItemBuilder.lazyListView(
            padding: const EdgeInsets.all(16).copyWith(bottom: 80),
            children:
                children.joinObjects(() => const SizedBox(height: 16)).toList(),
            trailing: [
              () => const Divider(height: 64),
              () => Obx(
                    () => EntityShareForm(
                      entity: controller.asEntity.value,
                      onChange: controller.updateFromEntity,
                    ),
                  )
            ],
          ),
          floatingActionButton: AdvancedFloatingActionButton.extended(
            onPressed: controller.onSave,
            label: Text(tr.generic.save),
            icon: const Icon(Icons.save),
          ),
        ),
      ),
    );
  }

  User get user => Get.find<UserService>().current;

  Widget get title => Text(
        controller.args.formContext == FormContext.create
            ? tr.generic.addEntity(tr.entity(
                tn(controller.empty().runtimeType),
              ))
            : tr.generic.editEntity(tr.entity(
                tn(controller.empty().runtimeType),
              )),
      );
}

abstract class LibraryEntityFormController<T extends WithMeta,
    Args extends LibraryEntityFormArguments<T>> extends GetxController {
  final dirty = false.obs;
  late final Args args;
  bool afterInit = false;
  List<Rx<ValueNotifier>> get fields;
  late final Rx<Meta> meta;
  late final List<String> _initialValueCache;
  late Rx<T> asEntity;

  @override
  @mustCallSuper
  void onInit() {
    assert(Get.arguments is LibraryEntityFormArguments<T>);
    args = Get.arguments;
    asEntity = Rx(args.entity ?? empty());
    meta = Rx(args.entity?.meta ?? _forkMeta());
    _initialValueCache = List.generate(fields.length, (i) => '');

    for (var field in enumerate(fields)) {
      field.value.value.addListener(_fieldListener(field));
    }
    super.onInit();
  }

  void Function() _fieldListener(Enumerated<Rx<ValueNotifier<dynamic>>> field) {
    return () {
      final asStr = _toString(field.value.value.value);
      final cached = _initialValueCache[field.index];
      if (!afterInit) {
        _initialValueCache[field.index] = asStr;
      }
      if (afterInit && asStr != cached) {
        dirty.value = true;
        meta.value = _forkMeta();
      }
      field.value.refresh();
      asEntity.value = toEntity();
    };
  }

  String _toString(Object object) {
    if (object is TextEditingController) {
      return object.text;
    }
    if (object is TextEditingValue) {
      return object.text;
    }
    if (object is WithMeta) {
      return object.key;
    }
    if (object is Iterable) {
      return '[${object.map((e) => _toString(e)).join(',')}]';
    }
    return object.toString();
  }

  @override
  void onReady() {
    super.onReady();
    afterInit = true;
  }

  @override
  void onClose() {
    for (var field in fields) {
      field.value.dispose();
      field.close();
    }
    super.onClose();
  }

  Meta _forkMeta() {
    var item = args.entity ?? empty();
    if (dirty.value) {
      item = Meta.forkOrIncrease(item);
    }
    return item.meta;
  }

  T empty();
  @protected
  T toEntity() => (args.entity ?? empty()).copyWithInherited(meta: meta.value);

  @mustCallSuper
  void updateFromEntity(T entity) {
    meta.value = entity.meta;
  }

  void onSave() {
    debugPrint('onSave: ${args.onSave}');
    cb(dynamic obj) {
      args.onSave(obj);
    }

    var entity = toEntity();
    cb(entity as dynamic);
    Get.back();
  }
}

class LibraryEntityFormArguments<T extends WithMeta> {
  final void Function(T item) onSave;
  final T? entity;
  final FormContext formContext;

  LibraryEntityFormArguments({
    required this.entity,
    required this.onSave,
    required this.formContext,
  });
}
