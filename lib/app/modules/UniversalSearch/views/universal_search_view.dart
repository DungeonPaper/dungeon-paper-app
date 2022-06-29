import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/universal_search_controller.dart';

class UniversalSearchView extends GetView<UniversalSearchController> {
  const UniversalSearchView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Scaffold(
        backgroundColor: Colors.black54,
        appBar: AppBar(
          title: Text('UniversalSearchView'),
          centerTitle: true,
          backgroundColor: Colors.transparent,
        ),
        body: Center(
          child: Text(
            'UniversalSearchView is working',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
