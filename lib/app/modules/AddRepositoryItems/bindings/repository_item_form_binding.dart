import 'package:dungeon_paper/app/widgets/forms/add_move_form.dart';
import 'package:get/get.dart';

class RepositoryItemFormBinding extends Bindings {
  RepositoryItemFormBinding({
    required this.item,
    this.extraData = const {},
  });

  final dynamic item;
  final Map<String, dynamic> extraData;

  @override
  void dependencies() {
    Get.put<AddMoveFormController>(
      AddMoveFormController(move: item, rollStats: extraData['rollStats']),
    );
  }
}
