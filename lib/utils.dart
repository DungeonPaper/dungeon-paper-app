capitalize(String string, [String sep = ' ']) {
  return string
      .split(sep)
      .map((s) => s[0].toUpperCase() + s.substring(1))
      .join(sep);
}
