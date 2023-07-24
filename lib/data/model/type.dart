
import 'package:juna_bhajan/data/model/list_data.dart';

class Type {
  String? id;
  int typeId;
  String nameEng;
  String nameGuj;
  String startColor;
  String centerColor;
  String endColor;
  bool isShow;

  Type({
    this.id,
    required this.typeId,
    required this.nameEng,
    required this.nameGuj,
    required this.startColor,
    required this.centerColor,
    required this.endColor,
    required this.isShow,
  });

  factory Type.fromListData(ListData listData) {
    return Type(
      id: listData.id,
      typeId: listData.data!["typeId"],
      nameEng: listData.data!["nameEng"],
      nameGuj: listData.data!["nameGuj"],
      startColor: listData.data!["startColor"],
      centerColor: listData.data!["centerColor"],
      endColor: listData.data!["endColor"],
      isShow: listData.data!["isShow"] ?? true,
    );
  }

  factory Type.fromJson(Map<dynamic, dynamic> json) {
    return Type(
      id: json["id"],
      typeId: json["typeId"],
      nameEng: json["nameEng"],
      nameGuj: json["nameGuj"],
      startColor: json["startColor"],
      centerColor: json["centerColor"],
      endColor: json["endColor"],
      isShow: json["isShow"] ?? true,
    );
  }

  Type copyWith({
    String? id,
    int? typeId,
    String? nameEng,
    String? nameGuj,
    String? startColor,
    String? centerColor,
    String? endColor,
    bool? isShow,
  }) {
    return Type(
      id: id ?? this.id,
      typeId: typeId ?? this.typeId,
      nameEng: nameEng ?? this.nameEng,
      nameGuj: nameGuj ?? this.nameGuj,
      startColor: startColor ?? this.startColor,
      centerColor: centerColor ?? this.centerColor,
      endColor: endColor ?? this.endColor,
      isShow: isShow ?? this.isShow,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "typeId": typeId,
      "nameEng": nameEng,
      "nameGuj": nameGuj,
      "startColor": startColor,
      "centerColor": centerColor,
      "endColor": endColor,
      "isShow": isShow,
    };
  }

  Map<String, dynamic> toLocalJson() {
    return <String, dynamic>{
      "id": id,
      "typeId": typeId,
      "nameEng": nameEng,
      "nameGuj": nameGuj,
      "startColor": startColor,
      "centerColor": centerColor,
      "endColor": endColor,
      "isShow": isShow,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Type && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
