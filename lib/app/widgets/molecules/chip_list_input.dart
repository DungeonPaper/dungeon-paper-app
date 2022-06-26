import 'package:dungeon_paper/app/data/models/ability_scores.dart';
import 'package:dungeon_paper/app/widgets/chips/dice_chip.dart';
import 'package:dungeon_paper/app/widgets/dialogs/add_dice_dialog.dart';
import 'package:dungeon_paper/core/utils/list_utils.dart';
import 'package:flutter/material.dart';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;
import 'package:get/get.dart';

import '../../../generated/l10n.dart';

class ChipListInput<T> extends StatefulWidget {
  const ChipListInput({
    super.key,
    this.controller,
    required this.chipBuilder,
    this.dialogBuilder,
    this.addValue,
    this.trailing = const [],
    this.leading = const [],
    this.label,
  }) : assert(dialogBuilder != null || addValue != null);

  final ValueNotifier<List<T>>? controller;
  final Widget? label;
  final T? addValue;
  final Widget Function(
    BuildContext context,
    Enumerated<T>? value, {
    void Function()? onDeleteChip,
    required void Function() onTapChip,
  }) chipBuilder;

  final Widget Function(
    BuildContext context,
    Enumerated<T>? value, {
    required void Function(T _dice) onSave,
  })? dialogBuilder;
  final List<Widget> trailing;
  final List<Widget> leading;

  @override
  State<ChipListInput> createState() => _ChipListInputState<T>();
}

class _ChipListInputState<T> extends State<ChipListInput<T>> {
  late ValueNotifier<List<T>> controller;

  @override
  void initState() {
    controller = (widget.controller ?? ValueNotifier([]))..addListener(_listener);
    super.initState();
  }

  void _listener() {
    setState(() {});
  }

  @override
  void dispose() {
    controller.removeListener(_listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DefaultTextStyle(
          child: widget.label ?? Text(S.current.entityPlural(T)),
          style: Theme.of(context).textTheme.caption!,
        ),
        const SizedBox(height: 6),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            ...widget.leading,
            for (final dice in enumerate(controller.value))
              widget.chipBuilder(
                context,
                dice,
                onDeleteChip: () =>
                    setState(() => controller.value = [...controller.value..removeAt(dice.index)]),
                onTapChip: widget.dialogBuilder != null
                    ? () => Get.dialog(
                          widget.dialogBuilder!(
                            context,
                            dice,
                            onSave: (_value) {
                              setState(() => controller.value =
                                  updateByIndex(controller.value, _value, dice.index));
                            },
                          ),
                        )
                    // ignore: avoid_returning_null_for_void
                    : () => null,
              ),
            widget.chipBuilder(
              context,
              null,
              onTapChip: widget.dialogBuilder != null
                  ? () => Get.dialog(
                        widget.dialogBuilder!(
                          context,
                          null,
                          onSave: (_value) {
                            setState(() => controller.value = [...controller.value, _value]);
                          },
                        ),
                      )
                  : () =>
                      setState(() => controller.value = [...controller.value, widget.addValue!]),
            ),
            ...widget.trailing,
          ],
        ),
      ],
    );
  }
}

Widget Function(
  BuildContext context,
  Enumerated<dynamic>? value, {
  void Function()? onDeleteChip,
  required void Function() onTapChip,
}) chipBuilderWrapper<T>(
  Widget Function(
    BuildContext context,
    Enumerated<T>? value, {
    void Function()? onDeleteChip,
    required void Function() onTapChip,
  })
      chipBuilder,
) {
  return (context, value, {onDeleteChip, required onTapChip}) => chipBuilder(
        context,
        value as dynamic,
        onDeleteChip: onDeleteChip,
        onTapChip: onTapChip,
      );
}
