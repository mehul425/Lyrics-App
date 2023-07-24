import 'package:equatable/equatable.dart';
import 'package:juna_bhajan/data/model/author.dart';
import 'package:juna_bhajan/data/model/bhajan.dart';
import 'package:juna_bhajan/data/model/related.dart';
import 'package:juna_bhajan/data/model/singer.dart';
import 'package:juna_bhajan/data/model/tag.dart';
import 'package:juna_bhajan/data/model/type.dart';
import 'package:juna_bhajan/data/model/youtube.dart';
import 'package:tuple/tuple.dart';

class BhajanListState extends Equatable {
  final List<Tuple2<Bhajan, List<Youtube>>> bhajanMainList;
  final List<Tuple2<Bhajan, List<Youtube>>> bhajanList;
  final List<Author> authorList;
  final List<Type> typeList;
  final List<Tag> tagList;
  final List<Related> relatedList;
  final List<Singer> singerList;
  final Author? author;
  final Type? type;
  final Tag? tag;
  final Related? related;
  final Singer? singer;
  final bool isSearchActive;
  final String search;

  const BhajanListState({
    required this.bhajanMainList,
    required this.bhajanList,
    required this.authorList,
    required this.typeList,
    required this.tagList,
    required this.relatedList,
    required this.singerList,
    required this.author,
    required this.type,
    required this.tag,
    required this.related,
    required this.singer,
    required this.isSearchActive,
    required this.search,
  });

  BhajanListState copyWith({
    List<Tuple2<Bhajan, List<Youtube>>>? bhajanMainList,
    List<Tuple2<Bhajan, List<Youtube>>>? bhajanList,
    List<Author>? authorList,
    List<Type>? typeList,
    List<Tag>? tagList,
    List<Related>? relatedList,
    List<Singer>? singerList,
    Author? author,
    Type? type,
    Tag? tag,
    Related? related,
    Singer? singer,
    bool? isSearchActive,
    String? search,
  }) =>
      BhajanListState(
        bhajanMainList: bhajanMainList ?? this.bhajanMainList,
        bhajanList: bhajanList ?? this.bhajanList,
        authorList: authorList ?? this.authorList,
        typeList: typeList ?? this.typeList,
        tagList: tagList ?? this.tagList,
        relatedList: relatedList ?? this.relatedList,
        singerList: singerList ?? this.singerList,
        author: author ?? this.author,
        type: type ?? this.type,
        tag: tag ?? this.tag,
        related: related ?? this.related,
        singer: singer ?? this.singer,
        isSearchActive: isSearchActive ?? this.isSearchActive,
        search: search ?? this.search,
      );

  BhajanListState copyAuthor({
    Author? author,
  }) =>
      BhajanListState(
        bhajanMainList: bhajanMainList,
        bhajanList: bhajanList,
        authorList: authorList,
        typeList: typeList,
        tagList: tagList,
        relatedList: relatedList,
        singerList: singerList,
        author: author,
        type: type,
        tag: tag,
        related: related,
        singer: singer,
        isSearchActive: isSearchActive,
        search: search,
      );

  BhajanListState copyType({
    Type? type,
  }) =>
      BhajanListState(
        bhajanMainList: bhajanMainList,
        bhajanList: bhajanList,
        authorList: authorList,
        typeList: typeList,
        tagList: tagList,
        relatedList: relatedList,
        singerList: singerList,
        author: author,
        type: type,
        tag: tag,
        related: related,
        singer: singer,
        isSearchActive: isSearchActive,
        search: search,
      );

  BhajanListState copyTag({
    Tag? tag,
  }) =>
      BhajanListState(
        bhajanMainList: bhajanMainList,
        bhajanList: bhajanList,
        authorList: authorList,
        typeList: typeList,
        tagList: tagList,
        relatedList: relatedList,
        singerList: singerList,
        author: author,
        type: type,
        tag: tag,
        related: related,
        singer: singer,
        isSearchActive: isSearchActive,
        search: search,
      );

  BhajanListState copyRelated({
    Related? related,
  }) =>
      BhajanListState(
        bhajanMainList: bhajanMainList,
        bhajanList: bhajanList,
        authorList: authorList,
        typeList: typeList,
        tagList: tagList,
        relatedList: relatedList,
        singerList: singerList,
        author: author,
        type: type,
        tag: tag,
        related: related,
        singer: singer,
        isSearchActive: isSearchActive,
        search: search,
      );

  BhajanListState copySinger({
    Singer? singer,
  }) =>
      BhajanListState(
        bhajanMainList: bhajanMainList,
        bhajanList: bhajanList,
        authorList: authorList,
        typeList: typeList,
        tagList: tagList,
        relatedList: relatedList,
        singerList: singerList,
        author: author,
        type: type,
        tag: tag,
        related: related,
        singer: singer,
        isSearchActive: isSearchActive,
        search: search,
      );

  BhajanListState copyAuthorTypeTagRelatedSinger({
    Author? author,
    Type? type,
    Tag? tag,
    Related? related,
    Singer? singer,
  }) =>
      BhajanListState(
        bhajanMainList: bhajanMainList,
        bhajanList: bhajanList,
        authorList: authorList,
        typeList: typeList,
        tagList: tagList,
        relatedList: relatedList,
        singerList: singerList,
        author: author,
        type: type,
        tag: tag,
        related: related,
        singer: singer,
        isSearchActive: isSearchActive,
        search: search,
      );

  @override
  List<Object?> get props => [
        bhajanMainList,
        bhajanList,
        authorList,
        typeList,
        tagList,
        relatedList,
        singerList,
        author,
        type,
        tag,
        related,
        singer,
        isSearchActive,
        search,
      ];
}
