import 'package:dungeon_paper/app/themes/button_themes.dart';
import 'package:dungeon_paper/app/themes/colors.dart';
import 'package:dungeon_paper/app/themes/themes.dart';
import 'package:dungeon_paper/app/widgets/atoms/hp_bar.dart';
import 'package:dungeon_paper/app/widgets/atoms/number_text_field.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:wheel_spinner/wheel_spinner.dart';

import '../controllers/hp_dialog_controller.dart';

class HPDialogView extends GetView<HPDialogController> {
  const HPDialogView({Key? key}) : super(key: key);

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
                currentHp: controller.overrideHP.value,
                maxHp: controller.maxHP,
              ),
              SizedBox(
                width: 400,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        controller.isChangeNeutral
                            ? S.current.hpDialogChangeNeutral
                            : controller.isChangePositive
                                ? S.current.hpDialogChangeAdd(controller.changeAmount)
                                : S.current.hpDialogChangeRemove(controller.changeAmount),
                        style: textTheme.headline5!.copyWith(
                          color: controller.isChangeNeutral
                              ? null
                              : controller.isChangePositive
                                  ? DwColors.success
                                  : theme.colorScheme.error,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Container(
                        decoration: BoxDecoration(borderRadius: borderRadius, color: Colors.red),
                        clipBehavior: Clip.antiAlias,
                        width: 60,
                        height: 100,
                        child: WheelSpinner(
                          value: controller.overrideHP.value.toDouble(),
                          min: 0,
                          max: controller.char.maxHp.toDouble(),
                          // childBuilder: (_) => Text(_.toString()),
                          minMaxLabelBuilder: (_) => '',
                          onSlideUpdate: (value) => controller.overrideHP.value = value.round(),
                          boxDecoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              stops: [0.0, 0.2, 0.8, 1.0],
                              colors: [
                                Colors.grey[350]!,
                                Colors.grey[50]!,
                                Colors.grey[50]!,
                                Colors.grey[350]!
                              ],
                            ),
                            borderRadius: borderRadius,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                onTap: () =>
                    controller.shouldOverrideMaxHP.value = !controller.shouldOverrideMaxHP.value,
                leading: Checkbox(
                  value: controller.shouldOverrideMaxHP.value,
                  onChanged: (value) => controller.shouldOverrideMaxHP.value = value!,
                ),
                title: Padding(
                  padding: const EdgeInsets.only(top: 24, bottom: 8),
                  child: Text(S.current.hpDialogChangeOverrideMax),
                ),
                subtitle: NumberTextField(
                  controller: controller.overrideMaxHp,
                  numberType: NumberType.int,
                  minValue: 0,
                  enabled: controller.shouldOverrideMaxHP.value,
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
                    onPressed: () => Get.back(),
                    label: Text(S.current.cancel),
                    icon: Icon(Icons.close),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton.icon(
                    onPressed: controller.save,
                    label: Text(S.current.save),
                    icon: Icon(Icons.check),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
