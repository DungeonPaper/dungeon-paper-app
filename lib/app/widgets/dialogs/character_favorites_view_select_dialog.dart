import 'package:dungeon_paper/app/data/models/character_settings.dart';
import 'package:dungeon_paper/app/data/services/character_provider.dart';
import 'package:dungeon_paper/app/widgets/molecules/dialog_controls.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:flutter/material.dart';

class CharacterFavoritesViewSelectDialog extends StatefulWidget {
  const CharacterFavoritesViewSelectDialog({super.key});

  @override
  State<CharacterFavoritesViewSelectDialog> createState() =>
      _CharacterFavoritesViewSelectDialogState();
}

class _CharacterFavoritesViewSelectDialogState
    extends State<CharacterFavoritesViewSelectDialog>
    with CharacterProviderMixin {
  late FavoritesView value;

  @override
  void initState() {
    super.initState();
    value = char.settings.favoritesView;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Select View'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile.adaptive(
              value: FavoritesView.cards,
              groupValue: value,
              onChanged: _onSelect,
              title: Row(
                children: [
                  Icon(Icons.grid_view),
                  const SizedBox(width: 8),
                  Expanded(child: Text(tr.character.favoritesView.cards)),
                ],
              ),
            ),
            RadioListTile.adaptive(
              value: FavoritesView.list,
              groupValue: value,
              onChanged: _onSelect,
              title: Row(
                children: [
                  Icon(Icons.list),
                  const SizedBox(width: 8),
                  Expanded(child: Text(tr.character.favoritesView.list)),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: DialogControls.save(
        context,
        onSave: () {
          charProvider.updateCharacter(
            char.copyWith(
              settings: char.settings.copyWith(favoritesView: value),
            ),
          );
          Navigator.of(context).pop();
        },
        onCancel: () => Navigator.of(context).pop(),
      ),
    );
  }

  void _onSelect(FavoritesView? value) {
    setState(() {
      this.value = value!;
    });
  }
}
