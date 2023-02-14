bool isNumeric(String? s) {
  if (s == null) {
    return false;
  }
  var value = int.tryParse(s);
  return value == null ? false : true;
}
