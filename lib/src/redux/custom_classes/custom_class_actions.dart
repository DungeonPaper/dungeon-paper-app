part of 'custom_classes_controller.dart';

class SetCustomClasses {
  final Map<String, CustomClass> classes;
  SetCustomClasses(this.classes);

  factory SetCustomClasses.fromIterable(Iterable<CustomClass> iterable) =>
      SetCustomClasses({
        for (final cls in iterable) cls.documentID: cls,
      });
}

class UpsertCustomClass {
  final CustomClass customClass;
  UpsertCustomClass(this.customClass);
}

class RemoveCustomClass {
  final CustomClass customClass;
  RemoveCustomClass(this.customClass);
}

class GetCustomClasses {}

class CustomClassesActions {
  static SetCustomClasses setCustomClasses(Map<String, CustomClass> classes) =>
      SetCustomClasses(classes);
}
