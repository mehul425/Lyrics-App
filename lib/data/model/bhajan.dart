import 'dart:collection';
import 'package:equatable/equatable.dart';
import 'package:juna_bhajan/data/model/list_data.dart';

class Bhajan extends Equatable {
  final String? id;
  final String nameGuj;
  final String nameEng;
  final String bhajan;
  final int type;
  final int? tag;
  final String? author;
  final String? relatedTo;
  final int like;
  final List<String>? youtube;
  final int? lastUpdatedDt;

  const Bhajan({
    this.id,
    required this.nameGuj,
    required this.nameEng,
    required this.type,
    required this.bhajan,
    required this.like,
    this.tag,
    this.author,
    this.relatedTo,
    this.youtube,
    this.lastUpdatedDt,
  });

  factory Bhajan.fromListData(ListData listData) {
    return Bhajan(
      id: listData.id,
      nameGuj: listData.data!["nameGuj"],
      nameEng: listData.data!["nameEng"],
      bhajan: listData.data!["bhajan"],
      type: listData.data!["type"],
      tag: listData.data!["tag"],
      author: listData.data!["author"],
      relatedTo: listData.data!["relatedTo"],
      like: listData.data!["like"],
      youtube: listData.data!["youtube"] != null
          ? (listData.data!["youtube"] as LinkedHashMap<dynamic, dynamic>)
          .entries
          .map((e) => e.key.toString())
          .toList()
          : <String>[],
      lastUpdatedDt: listData.data!["lastUpdatedDt"],
    );
  }

  factory Bhajan.fromJson(Map<dynamic, dynamic> json) {
    return Bhajan(
      id: json["id"],
      nameGuj: json["nameGuj"],
      nameEng: json["nameEng"],
      bhajan: json["bhajan"],
      type: json["type"],
      tag: json["tag"],
      author: json["author"],
      relatedTo: json["relatedTo"],
      like: json["like"],
      youtube: (json["youtube"] as List<dynamic>).cast<String>(),
      lastUpdatedDt: json["lastUpdatedDt"],
    );
  }

  Bhajan copyWith({
    String? id,
    String? nameGuj,
    String? nameEng,
    String? bhajan,
    int? type,
    int? tag,
    String? author,
    String? relatedTo,
    int? like,
    List<String>? youtube,
    int? lastUpdatedDt,
  }) {
    return Bhajan(
      id: id ?? this.id,
      nameGuj: nameGuj ?? this.nameGuj,
      nameEng: nameEng ?? this.nameEng,
      bhajan: bhajan ?? this.bhajan,
      type: type ?? this.type,
      tag: tag ?? this.tag,
      like: like ?? this.like,
      author: author,
      relatedTo: relatedTo,
      youtube: youtube ?? this.youtube,
      lastUpdatedDt: lastUpdatedDt ?? this.lastUpdatedDt,
    );
  }

  Map<String, dynamic> toJson(Map<String, String> lastUpdatedDt) {
    return <String, dynamic>{
      "nameGuj": nameGuj,
      "nameEng": nameEng,
      "bhajan": bhajan,
      "type": type,
      "tag": tag,
      "author": author,
      "relatedTo": relatedTo,
      "like": like,
      // "youtube": youtube != null ? Map.fromIterable(
      //   youtube!, key: (element) => element, value: (element) => true,) : null,
      "lastUpdatedDt": lastUpdatedDt,
    };
  }

  Map<String, dynamic> toLocalJson() {
    return <String, dynamic>{
      "id": id,
      "nameGuj": nameGuj,
      "nameEng": nameEng,
      "bhajan": bhajan,
      "type": type,
      "tag": tag,
      "author": author,
      "relatedTo": relatedTo,
      "like": like,
      "youtube": youtube,
      "lastUpdatedDt": lastUpdatedDt,
    };
  }

  @override
  List<Object?> get props => [
    id,
    nameGuj,
    nameEng,
    bhajan,
    type,
    tag,
    author,
    relatedTo,
    like,
    youtube,
    lastUpdatedDt,
  ];
}
