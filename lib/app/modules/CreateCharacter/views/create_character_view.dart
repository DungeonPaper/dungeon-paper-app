import 'dart:ui';

import 'package:dungeon_paper/app/data/models/character.dart';
import 'package:dungeon_paper/app/themes/colors.dart';
import 'package:dungeon_paper/app/widgets/atoms/character_avatar.dart';
import 'package:dungeon_paper/app/widgets/atoms/confirm_exit_view.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/create_character_controller.dart';

class CreateCharacterView extends GetView<CreateCharacterController> {
  @override
  Widget build(BuildContext context) {
    return ConfirmExitView(
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
          body: Center(
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
                          leading: CharacterAvatar.squircle(size: 48, character: Character.empty()),
                          // TODO intl
                          title: const Text('Unnamed Traveler'),
                          subtitle: const Text('Select name & picture'),
                          isIncomplete: true,
                        ),
                        const _Card(
                          // TODO intl
                          title: Text('Select Class'),
                          subtitle: Text('No class selected'),
                          isIncomplete: true,
                        ),
                        const _Card(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          // TODO intl
                          title: Text('Select Roll Stats'),
                          subtitle: Text('DEX: 10, CHA: 10, WIS: 10, INT: 10, STR: 10, CON: 10'),
                        ),
                        const _Card(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          // TODO intl
                          title: Text('Select Starting Gear'),
                          subtitle: Text('Select your starting gear determined by class'),
                        ),
                        const _Card(
                          // contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          // TODO intl
                          title: Text('Select Moves & Spells'),
                          subtitle: Text('No Moves, No Spells selected'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            backgroundColor: DwColors.success,
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
    this.isIncomplete = false,
  }) : super(key: key);

  final EdgeInsets? contentPadding;
  final Widget? leading;
  final Widget? title;
  final Widget? subtitle;
  final bool isIncomplete;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
      child: ListTile(
        contentPadding: contentPadding,
        leading: leading,
        title: title != null
            ? DefaultTextStyle.merge(
                child: title!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              )
            : null,
        subtitle: subtitle != null
            ? DefaultTextStyle.merge(
                child: subtitle!,
                style: const TextStyle(fontWeight: FontWeight.w300),
              )
            : null,
        trailing: isIncomplete ? const _MissingInfoIcon() : null,
      ),
    );
  }
}
