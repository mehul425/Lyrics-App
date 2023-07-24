import 'package:juna_bhajan/data/model/author.dart';
import 'package:juna_bhajan/data/model/bhajan.dart';
import 'package:juna_bhajan/data/model/other.dart';
import 'package:juna_bhajan/data/model/related.dart';
import 'package:juna_bhajan/data/model/singer.dart';
import 'package:juna_bhajan/data/model/tag.dart';
import 'package:juna_bhajan/data/model/type.dart';
import 'package:juna_bhajan/data/model/update.dart';
import 'package:juna_bhajan/data/model/youtube.dart';

class HomeModel {
  final List<Author> authorList;
  final List<Bhajan> bhajanList;
  final List<Singer> singleList;
  final List<Youtube> youtubeList;
  final List<String> topAuthorList;
  final List<String> newAddBhajanList;
  final List<String> ourFavoriteBhajanList;
  final List<String> topYoutubeBhajanList;
  final List<Type> typeList;
  final List<Tag> tagList;
  final List<Related> relatedList;
  final Update update;
  final Other other;

  HomeModel({
    required this.authorList,
    required this.bhajanList,
    required this.singleList,
    required this.youtubeList,
    required this.topAuthorList,
    required this.newAddBhajanList,
    required this.ourFavoriteBhajanList,
    required this.topYoutubeBhajanList,
    required this.typeList,
    required this.tagList,
    required this.relatedList,
    required this.update,
    required this.other,
  });
}
