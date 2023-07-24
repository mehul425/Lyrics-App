import 'package:juna_bhajan/data/model/list_data.dart';

class Related {
  String? id;
  String nameEng;
  String nameGuj;
  String imageUrl;
  String imageName;

  Related({
    this.id,
    required this.nameEng,
    required this.nameGuj,
    required this.imageUrl,
    required this.imageName,
  });

  factory Related.fromListData(ListData listData) {
    return Related(
      id: listData.id,
      nameEng: listData.data!["nameEng"],
      nameGuj: listData.data!["nameGuj"],
      imageUrl: listData.data!["imageUrl"],
      imageName: listData.data!["imageName"],
    );
  }

  factory Related.fromJson(Map<dynamic, dynamic> json) {
    return Related(
      id: json["id"],
      nameEng: json["nameEng"],
      nameGuj: json["nameGuj"],
      imageUrl: json["imageUrl"],
      imageName: json["imageName"],
    );
  }

  Related copyWith({
    String? id,
    String? nameEng,
    String? nameGuj,
    String? imageUrl,
    String? imageName,
  }) {
    return Related(
      id: id ?? this.id,
      nameEng: nameEng ?? this.nameEng,
      nameGuj: nameGuj ?? this.nameGuj,
      imageUrl: imageUrl ?? this.imageUrl,
      imageName: imageName ?? this.imageName,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "nameEng": nameEng,
      "nameGuj": nameGuj,
      "imageUrl": imageUrl,
      "imageName": imageName,
    };
  }

  Map<String, dynamic> toLocalJson() {
    return <String, dynamic>{
      "id": id,
      "nameEng": nameEng,
      "nameGuj": nameGuj,
      "imageUrl": imageUrl,
      "imageName": imageName,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Related && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
