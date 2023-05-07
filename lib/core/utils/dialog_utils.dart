import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> awaitConfirmation(Future<bool> confirmation, void Function() callback) async {
  final res = await confirmation;
  if (res) callback();
}

abstract class ConfirmationDialog<Options> {
  Future<void> _awaitConfirmation(Future<bool> confirmation, void Function() callback) async {
    final res = await confirmation;
    if (res) callback();
  }

  Future<void> confirm<T>(BuildContext context, Options options, void Function() onSuccess) {
    return _awaitConfirmation(_createConfirmation<T>(context, options), onSuccess);
  }

  Widget createConfirmation<T>(BuildContext context, Options options);
  Future<bool> _createConfirmation<T>(BuildContext context, Options options) {
    return Get.dialog<bool>(
      createConfirmation<T>(context, options),
    ).then((res) => res == true);
  }
}
