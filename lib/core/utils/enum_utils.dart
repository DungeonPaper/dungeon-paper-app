T getEnumByName<T>(List<T> enumValues, String name) {
  return enumValues.firstWhere((element) {
    try {
      return (element as dynamic).title == name;
    } catch (e) {
      return element.toString().split('.').last == name;
    }
  });
}
