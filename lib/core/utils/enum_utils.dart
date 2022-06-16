T getEnumByName<T>(List<T> enumValues, String name) {
  return enumValues.firstWhere((element) {
    try {
      return (element as dynamic).name == name;
    } catch (e) {
      return element.toString().split('.').last == name;
    }
  });
}
