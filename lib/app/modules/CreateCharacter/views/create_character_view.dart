import 'dart:ui';

import 'package:dungeon_paper/app/data/models/character.dart';
import 'package:dungeon_paper/app/data/models/character_class.dart';
import 'package:dungeon_paper/app/modules/AddRepositoryItems/bindings/add_repository_items_binding.dart';
import 'package:dungeon_paper/app/modules/AddRepositoryItems/controllers/add_repository_items_controller.dart';
import 'package:dungeon_paper/app/modules/AddRepositoryItems/views/add_character_classes_view.dart';
import 'package:dungeon_paper/app/modules/AddRepositoryItems/views/filters/character_class_filters.dart';
import 'package:dungeon_paper/app/modules/BasicInfoForm/bindings/basic_info_form_binding.dart';
import 'package:dungeon_paper/app/modules/BasicInfoForm/views/basic_info_form_view.dart';
import 'package:dungeon_paper/app/themes/colors.dart';
import 'package:dungeon_paper/app/widgets/atoms/advanced_floating_action_button.dart';
import 'package:dungeon_paper/app/widgets/atoms/character_avatar.dart';
import 'package:dungeon_paper/app/widgets/atoms/confirm_exit_view.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/create_character_controller.dart';

class CreateCharacterView extends GetView<CreateCharacterController> {
  CharacterClass? get cls => controller.characterClass.value;
  @override
  Widget build(BuildContext context) {
    return ConfirmExitView(
      dirty: controller.dirty.value,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        // blendMode: BlendMode.darken,
        child: Scaffold(
          backgroundColor: Colors.black.withOpacity(0.85),
          appBar: AppBar(
            title: Container(),
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.white,
          ),
          body: Obx(
            () => Center(
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 340),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _Card(
                            leading: CharacterAvatar.squircle(
                              size: 48,
                              character:
                                  Character.empty().copyWith(avatarUrl: controller.avatarUrl.value),
                            ),
                            // TODO intl
                            title: controller.name.isEmpty
                                ? const Text('Unnamed Traveler')
                                : Text(controller.name.value),
                            subtitle: controller.name.isEmpty
                                ? const Text('Select name & picture (required)')
                                : Text('Level 1 ${cls?.name ?? ''}'),
                            valid: controller.name.isNotEmpty,
                            onTap: () => Get.to(
                              () => BasicInfoFormView(
                                onChanged: controller.setBasicInfo,
                              ),
                              binding: BasicInfoFormBinding(
                                name: controller.name.value,
                                avatarUrl: controller.avatarUrl.value,
                              ),
                              preventDuplicates: false,
                            ),
                          ),
                          _Card(
                            // TODO intl
                            title: cls == null ? const Text('Select Class') : Text(cls!.name),
                            subtitle: cls == null
                                ? const Text('No class selected (required)')
                                : Text(
                                    'Base HP: ${cls!.hp}, Load: ${cls!.load}, Damage Dice: ${cls!.damageDice}'),
                            valid: cls != null,
                            onTap: () => Get.to(
                              () => AddCharacterClassesView(
                                selection: controller.characterClass.value,
                                onChanged: (cls) => controller.setClass(cls),
                              ),
                              binding: AddRepositoryItemsBinding(),
                              arguments: {
                                FiltersGroup.playbook: CharacterClassFilters(),
                                FiltersGroup.my: CharacterClassFilters()
                              },
                              preventDuplicates: false,
                            ),
                          ),
                          _Card(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            // TODO intl
                            title: const Text('Select Roll Stats'),
                            subtitle:
                                const Text('DEX: 10, CHA: 10, WIS: 10, INT: 10, STR: 10, CON: 10'),
                            onTap: () => null,
                          ),
                          _Card(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            // TODO intl
                            title: const Text('Select Starting Gear'),
                            subtitle: const Text(
                                'Select your starting gear determined by class (optional)'),
                            onTap: cls != null ? () => null : null,
                          ),
                          _Card(
                            // contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            // TODO intl
                            title: const Text('Select Moves & Spells'),
                            subtitle: const Text('No Moves, No Spells selected'),
                            onTap: cls != null ? () => null : null,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          floatingActionButton: AdvancedFloatingActionButton.extended(
            onPressed: () => null,
            icon: const Icon(Icons.person_add),
            label: Text(
              S.current.createGeneric(Character),
            ),
          ),
        ),
      ),
    );
  }
}

class _MissingInfoIcon extends StatelessWidget {
  const _MissingInfoIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      child: const Icon(
        Icons.error_outline_rounded,
        size: 16,
        color: Colors.black,
      ),
      decoration: const ShapeDecoration(
        shape: CircleBorder(),
        color: DwColors.warning,
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({
    Key? key,
    this.contentPadding,
    this.leading,
    required this.title,
    required this.subtitle,
    this.valid = true,
    required this.onTap,
  }) : super(key: key);

  final EdgeInsets? contentPadding;
  final Widget? leading;
  final Widget? title;
  final Widget? subtitle;
  final bool valid;
  final GestureTapCallback? onTap;

  bool get isEnabled => onTap != null;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: (isEnabled
              ? valid
                  ? DwColors.success
                  : DwColors.warning
              : Theme.of(context).colorScheme.onSurface)
          .withOpacity(0.2),
      child: ListTile(
        onTap: onTap,
        contentPadding: contentPadding,
        leading: leading,
        title: title != null
            ? DefaultTextStyle.merge(
                child: title!,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isEnabled ? null : Theme.of(context).disabledColor,
                ),
              )
            : null,
        subtitle: subtitle != null
            ? DefaultTextStyle.merge(
                child: subtitle!,
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  color: isEnabled ? null : Theme.of(context).disabledColor,
                ),
              )
            : null,
        // trailing: isIncomplete ?  _MissingInfoIcon() : null,
      ),
    );
  }
}
