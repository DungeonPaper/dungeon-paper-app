part of 'custom_classes_store.dart';

class SetCustomClasses {
  final Map<String, PlayerClass> classes;

  SetCustomClasses(this.classes);
}

class GetCustomClasses {}

class CustomClassesActions {
  static SetCustomClasses setCustomClasses(Map<String, PlayerClass> classes) =>
      SetCustomClasses(classes);
}
