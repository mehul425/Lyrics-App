import 'package:equatable/equatable.dart';
import 'package:juna_bhajan/data/model/list_data.dart';

class Tag extends Equatable {
  final String? id;
  final int tagId;
  final String nameEng;
  final String nameGuj;
  final bool isShow;

  const Tag({
    this.id,
    required this.tagId,
    required this.nameEng,
    required this.nameGuj,
    required this.isShow,
  });

  factory Tag.fromListData(ListData listData) {
    return Tag(
      id: listData.id,
      tagId: listData.data!["tagId"],
      nameEng: listData.data!["nameEng"],
      nameGuj: listData.data!["nameGuj"],
      isShow: listData.data!["isShow"] ?? true,
    );
  }

  factory Tag.fromJson(Map<dynamic, dynamic> json) {
    return Tag(
      id: json["id"],
      tagId: json["tagId"],
      nameEng: json["nameEng"],
      nameGuj: json["nameGuj"],
      isShow: json["isShow"] ?? true,
    );
  }

  Tag copyWith({
    String? id,
    int? tagId,
    String? nameEng,
    String? nameGuj,
    bool? isShow,
  }) {
    return Tag(
      id: id ?? this.id,
      tagId: tagId ?? this.tagId,
      nameEng: nameEng ?? this.nameEng,
      nameGuj: nameGuj ?? this.nameGuj,
      isShow: isShow ?? this.isShow,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "tagId": tagId,
      "nameEng": nameEng,
      "nameGuj": nameGuj,
      "isShow": isShow,
    };
  }

  Map<String, dynamic> toLocalJson() {
    return <String, dynamic>{
      "id": id,
      "tagId": tagId,
      "nameEng": nameEng,
      "nameGuj": nameGuj,
      "isShow": isShow,
    };
  }

  @override
  List<Object?> get props => [
        id,
        tagId,
        nameGuj,
        nameEng,
        isShow,
      ];
}
