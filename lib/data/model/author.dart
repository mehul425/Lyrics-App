import 'package:juna_bhajan/data/model/list_data.dart';

class Author {
  String? id;
  String name;
  String imageUrl;
  String imageName;
  String bornTime;
  String bornPlace;
  String nirvanaTime;
  String nirvanaPlace;
  String? otherDetails;
  String? guruShri;
  int? lastUpdatedDt;

  Author({
    this.id,
    required this.name,
    required this.imageUrl,
    required this.imageName,
    this.lastUpdatedDt,
    required this.bornTime,
    required this.bornPlace,
    required this.nirvanaTime,
    required this.nirvanaPlace,
    this.otherDetails,
    this.guruShri,
  });

  factory Author.fromListData(ListData listData) {
    return Author(
      id: listData.id,
      name: listData.data!["name"],
      imageUrl: listData.data!["imageUrl"],
      imageName: listData.data!["imageName"],
      bornTime: listData.data!["bornTime"],
      bornPlace: listData.data!["bornPlace"],
      nirvanaTime: listData.data!["nirvanaTime"],
      nirvanaPlace: listData.data!["nirvanaPlace"],
      otherDetails: listData.data!["otherDetails"],
      guruShri: listData.data!["guruShri"],
      lastUpdatedDt: listData.data!["lastUpdatedDt"],
    );
  }

  Author copyWith({
    String? id,
    String? name,
    String? imageUrl,
    String? imageName,
    String? bornTime,
    String? bornPlace,
    String? nirvanaTime,
    String? nirvanaPlace,
    String? otherDetails,
    String? guruShri,
    int? lastUpdatedDt,
  }) {
    return Author(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      imageName: imageName ?? this.imageName,
      bornTime: bornTime ?? this.bornTime,
      bornPlace: bornPlace ?? this.bornPlace,
      nirvanaTime: nirvanaTime ?? this.nirvanaTime,
      nirvanaPlace: nirvanaPlace ?? this.nirvanaPlace,
      otherDetails: otherDetails ?? this.otherDetails,
      lastUpdatedDt: lastUpdatedDt ?? this.lastUpdatedDt,
      guruShri: guruShri,
    );
  }

  Map<String, dynamic> toJson(Map<String, String> lastUpdatedDt) {
    return <String, dynamic>{
      "name": name,
      "imageUrl": imageUrl,
      "imageName": imageName,
      "bornTime": bornTime,
      "bornPlace": bornPlace,
      "nirvanaTime": nirvanaTime,
      "nirvanaPlace": nirvanaPlace,
      "otherDetails": otherDetails,
      "guruShri": guruShri,
      "lastUpdatedDt": lastUpdatedDt,
    };
  }


  Map<String, dynamic> toLocalJson() {
    return <String, dynamic>{
      "id":id,
      "name": name,
      "imageUrl": imageUrl,
      "imageName": imageName,
      "bornTime": bornTime,
      "bornPlace": bornPlace,
      "nirvanaTime": nirvanaTime,
      "nirvanaPlace": nirvanaPlace,
      "otherDetails": otherDetails,
      "guruShri": guruShri,
      "lastUpdatedDt": lastUpdatedDt,
    };
  }

  factory Author.fromJson(Map<dynamic, dynamic> json) {
    return Author(
      id: json["id"],
      name: json["name"],
      imageUrl: json["imageUrl"],
      imageName: json["imageName"],
      bornTime: json["bornTime"],
      bornPlace: json["bornPlace"],
      nirvanaTime: json["nirvanaTime"],
      nirvanaPlace: json["nirvanaPlace"],
      otherDetails: json["otherDetails"],
      guruShri: json["guruShri"],
      lastUpdatedDt: json["lastUpdatedDt"],
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Author && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
