import 'package:dungeon_paper/app/modules/CreateCharacterPage/controllers/create_character_page_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class SelectCharacterClassView extends GetView<CreateCharacterPageController> {
  const SelectCharacterClassView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'SelectCharacterClassView is working',
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
