class Conversion {
  double replaceCommaToDot(String value) {
    return double.parse(value.replaceAll(",", "."));
  }
}
