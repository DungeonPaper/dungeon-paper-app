import 'package:dungeon_paper/app/data/models/meta.dart';
import 'package:dungeon_paper/app/widgets/atoms/advanced_floating_action_button.dart';
import 'package:dungeon_paper/app/widgets/atoms/confirm_exit_view.dart';
import 'package:dungeon_paper/app/widgets/forms/entity_share_form.dart';
import 'package:dungeon_paper/core/route_arguments.dart';
import 'package:dungeon_paper/core/utils/builder_utils.dart';
import 'package:dungeon_paper/core/utils/enums.dart';
import 'package:dungeon_paper/core/utils/list_utils.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LibraryEntityForm<
    T extends WithMeta,
    Ctrl extends LibraryEntityFormController<T,
        LibraryEntityFormArguments<T>>> extends StatelessWidget {
  const LibraryEntityForm({
    super.key,
    required this.children,
  });

  final List<Widget Function()> children;

  @override
  Widget build(BuildContext context) {
    return Consumer<Ctrl>(
      builder: (context, controller, _) => ConfirmExitView(
        dirty: controller.dirty,
        child: Scaffold(
          appBar: AppBar(
            title: title(controller),
          ),
          body: Center(
            child: SizedBox(
            width: 800,
              child: ItemBuilder.lazyListView(
                padding: const EdgeInsets.all(16).copyWith(bottom: 80),
                children:
                    children.joinObjects(() => const SizedBox(height: 16)).toList(),
                // trailing: [
                //   () => const Divider(height: 64),
                //   () => EntityShareForm(
                //         entity: controller.asEntity,
                //         onChange: controller.updateFromEntity,
                //       ),
                // ],
              ),
            ),
          ),
          floatingActionButton: AdvancedFloatingActionButton.extended(
            onPressed: () => controller.onSave(context),
            label: Text(tr.generic.save),
            icon: const Icon(Icons.save),
          ),
        ),
      ),
    );
  }

  Widget title(Ctrl controller) => Text(
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
    Args extends LibraryEntityFormArguments<T>> extends ChangeNotifier {
  var dirty = false;
  late final Args args;
  bool afterInit = false;
  /// Creates listeners for each field and sets the initial value cache.
  List<ValueNotifier> get fields;
  late Meta meta;
  late final List<String> _initialValueCache;
  late T asEntity;

  LibraryEntityFormController(BuildContext context) {
    args = getArgs(context);
    asEntity = args.entity ?? empty();
    meta = args.entity?.meta ?? _forkMeta();
    _initialValueCache = List.generate(fields.length, (i) => '');

    for (var field in enumerate(fields)) {
      field.value.addListener(_fieldListener(field));
    }
    afterInit = true;
  }

  void Function() _fieldListener(Enumerated<ValueNotifier<dynamic>> field) {
    return () {
      final asStr = _toString(field.value.value);
      final cached = _initialValueCache[field.index];
      if (!afterInit) {
        _initialValueCache[field.index] = asStr;
      }
      if (afterInit && asStr != cached) {
        dirty = true;
        meta = _forkMeta();
      }
      asEntity = toEntity();
      notifyListeners();
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
  void dispose() {
    super.dispose();
    for (var field in fields) {
      field.dispose();
    }
  }

  Meta _forkMeta() {
    var item = args.entity ?? empty();
    if (dirty) {
      item = Meta.forkOrIncrease(item);
    }
    return item.meta;
  }

  T empty();
  @protected
  T toEntity() => (args.entity ?? empty()).copyWithInherited(meta: meta);

  @mustCallSuper
  void updateFromEntity(T entity) {
    meta = entity.meta;
    notifyListeners();
  }

  void onSave(BuildContext context) {
    debugPrint('onSave: ${args.onSave}');
    cb(dynamic obj) {
      args.onSave(obj);
    }

    var entity = toEntity();
    cb(entity as dynamic);
    Navigator.of(context).pop();
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

