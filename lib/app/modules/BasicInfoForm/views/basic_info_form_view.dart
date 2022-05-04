import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/basic_info_form_controller.dart';

class BasicInfoFormView extends GetView<BasicInfoFormController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BasicInfoFormView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'BasicInfoFormView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
