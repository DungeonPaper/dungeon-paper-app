import 'package:dungeon_paper/app/data/models/move.dart';
import 'package:dungeon_paper/app/modules/AddRepositoryItems/views/add_repository_items_view.dart';
import 'package:dungeon_paper/app/widgets/cards/move_card.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class AddMovesView extends GetView {
  const AddMovesView({
    Key? key,
    required this.onAdd,
  }) : super(key: key);

  final void Function(List<Move> moves) onAdd;

  @override
  Widget build(BuildContext context) {
    return AddRepositoryItemsView<Move>(
      title: Text(S.current.addMoves),
      cardBuilder: (ctx, move) => MoveCard(move: move),
      onAdd: onAdd,
    );
  }
}
