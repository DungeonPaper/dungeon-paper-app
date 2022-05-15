import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/bonds_flags_form_controller.dart';

class BondsFlagsFormView extends GetView<BondsFlagsFormController> {
  const BondsFlagsFormView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BondsFlagsFormView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'BondsFlagsFormView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
