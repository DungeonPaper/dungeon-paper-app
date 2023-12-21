import 'package:flutter/material.dart';

T getArgs<T>(BuildContext context, {bool nullOk = false}) {
  final route = ModalRoute.of(context);
  assert(nullOk || route != null);
  final args = route!.settings.arguments;
  assert(nullOk || args != null);
  return args as T;
}
