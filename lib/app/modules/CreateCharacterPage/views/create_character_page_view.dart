import 'package:dungeon_paper/app/modules/CreateCharacterPage/views/character_information_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../generated/l10n.dart';
import '../controllers/create_character_page_controller.dart';

class CreateCharacterPageView extends GetView<CreateCharacterPageController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.createCharacterTitle),
        centerTitle: true,
      ),
      body: CharacterInformationView(),
    );
  }
}
