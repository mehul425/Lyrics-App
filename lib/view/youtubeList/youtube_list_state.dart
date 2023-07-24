import 'package:equatable/equatable.dart';
import 'package:juna_bhajan/data/model/author.dart';
import 'package:juna_bhajan/data/model/bhajan.dart';
import 'package:juna_bhajan/data/model/related.dart';
import 'package:juna_bhajan/data/model/singer.dart';
import 'package:juna_bhajan/data/model/tag.dart';
import 'package:juna_bhajan/data/model/type.dart';
import 'package:juna_bhajan/data/model/youtube.dart';
import 'package:tuple/tuple.dart';

class YoutubeListState extends Equatable {
  final List<Tuple2<Bhajan, Youtube>> bhajanMainList;
  final List<Tuple2<Bhajan, Youtube>> bhajanList;
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
  final bool isExpanded;

  const YoutubeListState({
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
    required this.isExpanded,
  });

  YoutubeListState copyWith({
    List<Tuple2<Bhajan, Youtube>>? bhajanMainList,
    List<Tuple2<Bhajan, Youtube>>? bhajanList,
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
    bool? isExpanded,
  }) =>
      YoutubeListState(
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
        isExpanded: isExpanded ?? this.isExpanded,
      );

  YoutubeListState copyAuthor({
    Author? author,
  }) =>
      YoutubeListState(
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
        isExpanded: isExpanded,
      );

  YoutubeListState copyType({
    Type? type,
  }) =>
      YoutubeListState(
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
        isExpanded: isExpanded,
      );

  YoutubeListState copyTag({
    Tag? tag,
  }) =>
      YoutubeListState(
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
        isExpanded: isExpanded,
      );

  YoutubeListState copyRelated({
    Related? related,
  }) =>
      YoutubeListState(
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
        isExpanded: isExpanded,
      );

  YoutubeListState copySinger({
    Singer? singer,
  }) =>
      YoutubeListState(
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
        isExpanded: isExpanded,
      );

  YoutubeListState copyAuthorTypeTagRelatedSinger({
    Author? author,
    Type? type,
    Tag? tag,
    Related? related,
    Singer? singer,
  }) =>
      YoutubeListState(
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
        isExpanded: isExpanded,
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
        isExpanded,
      ];
}
