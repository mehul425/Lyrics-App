extension StringExtension on String {
  bool isEnglishLang() {
    return RegExp(r'^[a-zA-Z0-9., ]+$').hasMatch(this);
  }
}
