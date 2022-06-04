T getEnumByName<T>(dynamic enumValues, String name) {
  return (enumValues as dynamic).values.firstWhere((element) => element.name == name);
}
