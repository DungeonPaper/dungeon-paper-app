import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/ability_score_form_controller.dart';

class AbilityScoreFormView extends GetView<AbilityScoreFormController> {
  const AbilityScoreFormView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AbilityScoreFormView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'AbilityScoreFormView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
