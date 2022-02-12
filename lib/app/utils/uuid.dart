import 'package:uuid/uuid.dart';

var _uuid = const Uuid();

String uuid() {
  return _uuid.v4();
}
