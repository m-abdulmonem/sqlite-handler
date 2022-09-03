extension CustomStringExtenstion on String {
  String removeLastCharacter({String char = ',', int count = 1}) {
    String result = "";
    if (endsWith(char)) {
      result = substring(0, length - count);
    }
    return result;
  }
  String get toCapitalize => "${this[0].toUpperCase()}${substring(1)}";
}