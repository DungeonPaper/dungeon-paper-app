import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../generated/l10n.dart';
import '../../../widgets/atoms/main_app_bar.dart';
import '../controllers/home_controller.dart';
import 'home_character_view.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16).copyWith(top: 0),
        child: HomeCharacterView(),
      ),
    );
  }
}
