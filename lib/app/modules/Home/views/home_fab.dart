import 'package:dungeon_paper/app/data/models/note.dart';
import 'package:dungeon_paper/app/data/services/character_service.dart';
import 'package:dungeon_paper/app/model_utils/character_utils.dart';
import 'package:dungeon_paper/app/model_utils/model_pages.dart';
import 'package:dungeon_paper/app/widgets/atoms/advanced_floating_action_button.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';

class HomeFAB extends StatefulWidget {
  const HomeFAB({super.key});

  @override
  State<HomeFAB> createState() => _HomeFABState();
}

class _HomeFABState extends State<HomeFAB> with CharacterServiceMixin {
  @override
  void initState() {
    super.initState();
    charService.pageController.addListener(_refresh);
  }

  @override
  void dispose() {
    charService.pageController.removeListener(_refresh);
    super.dispose();
  }

  static const pageNum = 2;
  static const duration = Duration(milliseconds: 250);

  @override
  Widget build(BuildContext context) {
    final distance = (charService.page - pageNum.toDouble()).abs();
    final inPageRange = distance <= 0.5;

    return AnimatedScale(
      scale: inPageRange ? 1.0 : 0.0,
      duration: duration,
      child: AnimatedOpacity(
        opacity: inPageRange ? 1.0 : 0.0,
        duration: duration,
        child: AdvancedFloatingActionButton.extended(
          label: AnimatedScale(
            scale: inPageRange ? 1.0 : 0.0,
            duration: duration,
            child: Text(
              S.current.createGeneric(Note),
            ),
          ),
          icon: AnimatedScale(
            scale: inPageRange ? 1.0 : 0.0,
            duration: duration,
            child: const Icon(Icons.add),
          ),
          onPressed: inPageRange
              ? ModelPages.openNotePage(
                  note: null,
                  onSave: (note) => charService.updateCharacter(
                    CharacterUtils.addByType<Note>(char, [note]),
                  ),
                )
              : null,
        ),
      ),
    );
  }

  void _refresh() {
    setState(() {});
  }
}
