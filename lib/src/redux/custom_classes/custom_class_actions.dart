part of 'custom_classes_store.dart';

class SetCustomClasses {
  final Map<String, CustomClass> classes;
  SetCustomClasses(this.classes);
}

class UpsertCustomClass {
  final CustomClass customClass;
  UpsertCustomClass(this.customClass);
}

class GetCustomClasses {}

class CustomClassesActions {
  static SetCustomClasses setCustomClasses(Map<String, CustomClass> classes) =>
      SetCustomClasses(classes);
}
