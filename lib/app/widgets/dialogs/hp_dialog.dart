import 'dart:async';
import 'dart:math';

import 'package:dungeon_paper/app/data/services/character_service.dart';
import 'package:dungeon_paper/app/themes/button_themes.dart';
import 'package:dungeon_paper/app/themes/colors.dart';
import 'package:dungeon_paper/app/themes/themes.dart';
import 'package:dungeon_paper/app/widgets/atoms/hp_bar.dart';
import 'package:dungeon_paper/app/widgets/atoms/number_text_field.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:wheel_spinner/wheel_spinner.dart';

enum ValueChange { positive, neutral, negative }

class HPDialog extends StatefulWidget {
  const HPDialog({Key? key}) : super(key: key);

  @override
  State<HPDialog> createState() => _HPDialogState();
}

class _HPDialogState extends State<HPDialog> with CharacterServiceMixin {
  late int overrideHP;
  late bool shouldOverrideMaxHP;
  late TextEditingController overrideMaxHp;

  @override
  void initState() {
    overrideHP = char.currentHp;
    shouldOverrideMaxHP = char.stats.maxHp != null;
    overrideMaxHp = TextEditingController(text: char.maxHp.toString())..addListener(clampCurrentHP);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return AlertDialog(
      title: Text(S.current.hpDialogTitle),
      content: SingleChildScrollView(
        child: Obx(
          () => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              HpBar(
                currentHp: overrideHP,
                maxHp: maxHP,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: 400,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        isChangeNeutral
                            ? S.current.hpDialogChangeNeutral
                            : isChangePositive
                                ? S.current.hpDialogChangeAdd(changeAmount)
                                : S.current.hpDialogChangeRemove(changeAmount),
                        style: textTheme.headline5!.copyWith(
                          color: isChangeNeutral
                              ? null
                              : isChangePositive
                                  ? DwColors.success
                                  : theme.colorScheme.error,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Container(
                        decoration: BoxDecoration(borderRadius: borderRadius),
                        clipBehavior: Clip.antiAlias,
                        width: 60,
                        height: 100,
                        child: WheelSpinner(
                          value: overrideHP.toDouble(),
                          min: 0,
                          max: maxHP.toDouble(),
                          // childBuilder: (_) => Text(_.toString()),
                          borderRadius: borderRadius,
                          minMaxLabelBuilder: (_) => '',
                          onSlideUpdate: (value) => setState(() => overrideHP = value.round()),
                          dividerColor:
                              theme.brightness == Brightness.light ? null : Colors.grey[800],
                          boxDecoration: (theme.brightness == Brightness.light
                                  ? BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        stops: const [0.0, 0.2, 0.8, 1.0],
                                        colors: [
                                          Colors.grey[350]!,
                                          Colors.grey[50]!,
                                          Colors.grey[50]!,
                                          Colors.grey[350]!
                                        ],
                                      ),
                                    )
                                  : BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        stops: const [0.0, 0.2, 0.8, 1.0],
                                        colors: [
                                          Colors.black,
                                          Colors.grey[900]!,
                                          Colors.grey[900]!,
                                          Colors.black
                                        ],
                                      ),
                                    ))
                              .copyWith(borderRadius: borderRadius),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                onTap: () => setState(() => shouldOverrideMaxHP = !shouldOverrideMaxHP),
                leading: Checkbox(
                  value: shouldOverrideMaxHP,
                  onChanged: (value) => setState(() => shouldOverrideMaxHP = value!),
                ),
                title: Padding(
                  padding: const EdgeInsets.only(top: 24, bottom: 8),
                  child: Text(S.current.hpDialogChangeOverrideMax),
                ),
                subtitle: NumberTextField(
                  controller: overrideMaxHp,
                  numberType: NumberType.int,
                  minValue: 0,
                  enabled: shouldOverrideMaxHP,
                ),
                dense: true,
                visualDensity: VisualDensity.compact,
                minLeadingWidth: 24,
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton.icon(
                    onPressed: close,
                    label: Text(S.current.cancel),
                    icon: const Icon(Icons.close),
                    style: ButtonThemes.errorText(context),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton.icon(
                    onPressed: save,
                    label: Text(S.current.save),
                    icon: const Icon(Icons.check),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  int get currentHP => char.currentHp;
  int get maxHP => shouldOverrideMaxHP
      ? int.tryParse(overrideMaxHp.text) ?? char.defaultMaxHp
      : char.defaultMaxHp;

  ValueChange get change => currentHP == overrideHP
      ? ValueChange.neutral
      : currentHP > overrideHP
          ? ValueChange.negative
          : ValueChange.positive;

  int get changeAmount => (overrideHP - currentHP).abs();

  bool get isChangePositive => change == ValueChange.positive;
  bool get isChangeNegative => change == ValueChange.negative;
  bool get isChangeNeutral => change == ValueChange.neutral;

  clampCurrentHP([dynamic value]) {
    setState(() => overrideHP = min(maxHP, overrideHP));
  }

  void save() {
    charService.updateCharacter(
      char.copyWith(
        stats: char.stats
            .copyWith(currentHp: overrideHP)
            .copyWithMaxHp(shouldOverrideMaxHP ? maxHP : null),
      ),
    );
    close();
  }

  void close() async {
    Get.back();
  }
}
