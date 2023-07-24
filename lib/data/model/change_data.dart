import 'package:equatable/equatable.dart';
import 'package:juna_bhajan/data/model/list_data.dart';
import 'package:juna_bhajan/extension/other_extension.dart';

class ChangeData extends Equatable {
  final int id;
  final bool? topAuthor;
  final bool? newAdded;
  final bool? ourFavorite;
  final bool? topYoutube;
  final bool? update;
  final bool? other;
  final List<String>? author;
  final List<String>? bhajan;
  final List<String>? type;
  final List<String>? tag;
  final List<String>? related;
  final List<String>? singer;
  final List<String>? youtube;
  final int? lastUpdatedDt;

  const ChangeData({
    required this.id,
    this.topAuthor,
    this.newAdded,
    this.ourFavorite,
    this.topYoutube,
    this.update,
    this.other,
    this.author,
    this.bhajan,
    this.type,
    this.tag,
    this.related,
    this.singer,
    this.youtube,
    this.lastUpdatedDt,
  });

  factory ChangeData.initial() {
    return const ChangeData(id: 0);
  }

  factory ChangeData.fromListData(ListData listData) {
    return ChangeData(
      id: listData.data!["id"],
      topAuthor: listData.data!["top-author"],
      newAdded: listData.data!["new-added"],
      ourFavorite: listData.data!["our-favorite"],
      topYoutube: listData.data!["top-youtube"],
      update: listData.data!["update"],
      other: listData.data!["other"],
      author: listData.data!["author"] != null
          ? (listData.data!["author"] as List<dynamic>).cast<String>()
          : null,
      bhajan: listData.data!["bhajan"] != null
          ? (listData.data!["bhajan"] as List<dynamic>).cast<String>()
          : null,
      type: listData.data!["type"] != null
          ? (listData.data!["type"] as List<dynamic>).cast<String>()
          : null,
      tag: listData.data!["tag"] != null
          ? (listData.data!["tag"] as List<dynamic>).cast<String>()
          : null,
      related: listData.data!["related"] != null
          ? (listData.data!["related"] as List<dynamic>).cast<String>()
          : null,
      singer: listData.data!["singer"] != null
          ? (listData.data!["singer"] as List<dynamic>).cast<String>()
          : null,
      youtube: listData.data!["youtube"] != null
          ? (listData.data!["youtube"] as List<dynamic>).cast<String>()
          : null,
      lastUpdatedDt: listData.data!["lastUpdatedDt"],
    );
  }

  factory ChangeData.fromJson(Map<dynamic, dynamic> json) {
    return ChangeData(
      id: json["id"],
      topAuthor: json["top-author"],
      newAdded: json["new-added"],
      ourFavorite: json["our-favorite"],
      topYoutube: json["top-youtube"],
      update: json["update"],
      other: json["other"],
      author: json["author"] != null
          ? (json["author"] as List<dynamic>).cast<String>()
          : null,
      bhajan: json["bhajan"] != null
          ? (json["bhajan"] as List<dynamic>).cast<String>()
          : null,
      type: json["type"] != null
          ? (json["type"] as List<dynamic>).cast<String>()
          : null,
      tag: json["tag"] != null
          ? (json["tag"] as List<dynamic>).cast<String>()
          : null,
      related: json["related"] != null
          ? (json["related"] as List<dynamic>).cast<String>()
          : null,
      singer: json["singer"] != null
          ? (json["singer"] as List<dynamic>).cast<String>()
          : null,
      youtube: json["youtube"] != null
          ? (json["youtube"] as List<dynamic>).cast<String>()
          : null,
      lastUpdatedDt: json["lastUpdatedDt"],
    );
  }

  ChangeData copyWith({
    int? id,
    bool? topAuthor,
    bool? newAdded,
    bool? ourFavorite,
    bool? topYoutube,
    bool? update,
    bool? other,
    List<String>? author,
    List<String>? bhajan,
    List<String>? type,
    List<String>? tag,
    List<String>? related,
    List<String>? singer,
    List<String>? youtube,
    int? lastUpdatedDt,
  }) {
    return ChangeData(
      id: id ?? this.id,
      topAuthor: topAuthor ?? this.topAuthor,
      newAdded: newAdded ?? this.newAdded,
      ourFavorite: ourFavorite ?? this.ourFavorite,
      topYoutube: topYoutube ?? this.topYoutube,
      update: update ?? this.update,
      other: other ?? this.other,
      author: author.mergeStringList(this.author),
      bhajan: bhajan.mergeStringList(this.bhajan),
      type: type.mergeStringList(this.type),
      tag: tag.mergeStringList(this.tag),
      related: related.mergeStringList(this.related),
      singer: singer.mergeStringList(this.singer),
      youtube: youtube.mergeStringList(this.youtube),
      lastUpdatedDt: lastUpdatedDt ?? this.lastUpdatedDt,
    );
  }

  Map<String, dynamic> toJson(Map<String, String> lastUpdatedDt) {
    return <String, dynamic>{
      "id": id,
      "top-author": topAuthor,
      "new-added": newAdded,
      "our-favorite": ourFavorite,
      "top-youtube": topYoutube,
      "update": update,
      "other": other,
      "author": author,
      "bhajan": bhajan,
      "type": type,
      "tag": tag,
      "related": related,
      "singer": singer,
      "youtube": youtube,
      "lastUpdatedDt": lastUpdatedDt,
    };
  }

  Map<String, dynamic> toLocalJson() {
    return <String, dynamic>{
      "id": id,
      "top-author": topAuthor,
      "new-added": newAdded,
      "our-favorite": ourFavorite,
      "top-youtube": topYoutube,
      "update": update,
      "other": other,
      "author": author,
      "bhajan": bhajan,
      "type": type,
      "tag": tag,
      "related": related,
      "singer": singer,
      "youtube": youtube,
      "lastUpdatedDt": lastUpdatedDt,
    };
  }

  @override
  List<Object?> get props => [
    topAuthor,
    newAdded,
    ourFavorite,
    topYoutube,
    update,
    other,
    author,
    bhajan,
    type,
    tag,
    related,
    singer,
    youtube,
  ];

  ChangeData mergeChangeData(ChangeData other) {
    return ChangeData(
      id: other.id,
      topAuthor: topAuthor.mergeBool(other.topAuthor),
      newAdded: newAdded.mergeBool(other.newAdded),
      ourFavorite: ourFavorite.mergeBool(other.ourFavorite),
      topYoutube: topYoutube.mergeBool(other.topYoutube),
      update: update.mergeBool(other.update),
      other: this.other.mergeBool(other.other),
      author: author.mergeStringList(other.author),
      bhajan: bhajan.mergeStringList(other.bhajan),
      type: type.mergeStringList(other.type),
      tag: tag.mergeStringList(other.tag),
      related: related.mergeStringList(other.related),
      singer: singer.mergeStringList(other.singer),
      youtube: youtube.mergeStringList(other.youtube),
      lastUpdatedDt: other.lastUpdatedDt,
    );
  }

  String toFormattedString() {
    return (topAuthor != null ? "Top Author : $topAuthor , " : "") +
        (newAdded != null ? "New Added : $newAdded , " : "") +
        (ourFavorite != null ? "Our Favorite : $ourFavorite , " : "") +
        (topYoutube != null ? "Top Youtube : $topYoutube , " : "") +
        (update != null ? "Update : $update , " : "") +
        (other != null ? "Other : $other , " : "");
  }

  String toFormattedListString() {
    return (bhajan != null ? "Bhajan : ${bhajan!.join(" , ")} , " : "") +
        (author != null ? "\nAuthor : ${author!.join(" , ")} , " : "") +
        (type != null ? "\nType : ${type!.join(" , ")} , " : "") +
        (tag != null ? "\nTag : ${tag!.join(" , ")} , " : "") +
        (related != null ? "\nRelated : ${related!.join(" , ")} , " : "") +
        (singer != null ? "\nSinger : ${singer!.join(" , ")} , " : "") +
        (youtube != null ? "\nYoutube : ${youtube!.join(" , ")} , " : "");
  }
}
