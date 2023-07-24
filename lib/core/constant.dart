import 'package:tuple/tuple.dart';

enum BhajanListType { type, author, related, tag }

enum ProjectType { junaBhajan, hindBhajan }

const String hindiDefaultFontFamily = "Noto Sans Devanagari";

const List<Tuple2<String, String>> hindiFontFamilyList = [
  Tuple2("Noto Sans Devanagari", "Noto Sans Devanagari"),
  Tuple2("Hind", "Hind"),
  Tuple2("Poppins", "Poppins"),
];

const String gujaratiDefaultFontFamily = "Rasa";

const List<Tuple2<String, String>> gujaratiFontFamilyList = [
  Tuple2("Hind Vadodara", "Hind Vadodara"),
  Tuple2("Rasa", "Rasa"),
  Tuple2("Noto Sans Gujarati", "Noto Sans Gujarati"),
];
