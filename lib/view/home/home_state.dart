import 'package:equatable/equatable.dart';
import 'package:juna_bhajan/data/model/author.dart';
import 'package:juna_bhajan/data/model/bhajan.dart';
import 'package:juna_bhajan/data/model/related.dart';
import 'package:juna_bhajan/data/model/singer.dart';
import 'package:juna_bhajan/data/model/tag.dart';
import 'package:juna_bhajan/data/model/type.dart';
import 'package:juna_bhajan/data/model/update.dart';
import 'package:juna_bhajan/data/model/youtube.dart';
import 'package:tuple/tuple.dart';

class HomeState extends Equatable {
  final List<Bhajan> bhajanList;
  final List<Author> authorList;
  final List<Singer> singerList;
  final List<Author> topAuthorList;
  final List<Bhajan> newAddedBhajanList;
  final List<Bhajan> ourFavoriteBhajanList;
  final List<Tuple2<Bhajan, Youtube>> topYoutubeBhajanList;
  final List<Type> typeList;
  final List<Tag> tagList;
  final List<Related> relatedList;
  final bool canShowRatingDialog;
  final Update update;
  final int currentAppVersion;

  const HomeState({
    required this.bhajanList,
    required this.authorList,
    required this.singerList,
    required this.topAuthorList,
    required this.newAddedBhajanList,
    required this.ourFavoriteBhajanList,
    required this.topYoutubeBhajanList,
    required this.typeList,
    required this.tagList,
    required this.relatedList,
    required this.canShowRatingDialog,
    required this.update,
    required this.currentAppVersion,
  });

  // factory HomeState.initial() => const HomeState(
  //       bhajanList: null,
  //       authorList: null,
  //       topAuthorList: null,
  //       newAddedBhajanList: null,
  //       ourFavoriteBhajanList: null,
  //       typeList: null,
  //       relatedList: null,
  //     );

  HomeState copyWith({
    List<Bhajan>? bhajanList,
    List<Author>? authorList,
    List<Singer>? singerList,
    List<Author>? topAuthorList,
    List<Bhajan>? newAddedBhajanList,
    List<Bhajan>? ourFavoriteBhajanList,
    List<Tuple2<Bhajan, Youtube>>? topYoutubeBhajanList,
    List<Type>? typeList,
    List<Tag>? tagList,
    List<Related>? relatedList,
    bool? canShowRatingDialog,
    Update? update,
    int? currentAppVersion,
  }) =>
      HomeState(
        bhajanList: bhajanList ?? this.bhajanList,
        authorList: authorList ?? this.authorList,
        singerList: singerList ?? this.singerList,
        topAuthorList: topAuthorList ?? this.topAuthorList,
        newAddedBhajanList: newAddedBhajanList ?? this.newAddedBhajanList,
        ourFavoriteBhajanList:
            ourFavoriteBhajanList ?? this.ourFavoriteBhajanList,
        topYoutubeBhajanList: topYoutubeBhajanList ?? this.topYoutubeBhajanList,
        relatedList: relatedList ?? this.relatedList,
        typeList: typeList ?? this.typeList,
        tagList: tagList ?? this.tagList,
        canShowRatingDialog: canShowRatingDialog ?? this.canShowRatingDialog,
        update: update ?? this.update,
        currentAppVersion: currentAppVersion ?? this.currentAppVersion,
      );

  @override
  List<Object?> get props => [
        bhajanList,
        authorList,
        singerList,
        topAuthorList,
        newAddedBhajanList,
        ourFavoriteBhajanList,
        topYoutubeBhajanList,
        relatedList,
        typeList,
        tagList,
        canShowRatingDialog,
        update,
        currentAppVersion
      ];
}
