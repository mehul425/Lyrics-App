import 'package:juna_bhajan/data/model/list_data.dart';

class Other {
  String desc;
  String end;
  String link;
  bool showLink;

  Other({
    required this.desc,
    required this.end,
    required this.showLink,
    this.link = "",
  });

  factory Other.fromListData(ListData listData) {
    return Other(
      desc: listData.data!["desc"],
      end: listData.data!["end"],
      link: listData.data!["link"],
      showLink: listData.data!["showLink"],
    );
  }

  factory Other.fromJson(Map<dynamic, dynamic> json) {
    return Other(
      desc: json["desc"],
      end: json["end"],
      link: json["link"],
      showLink: json["showLink"],
    );
  }

  Other copyWith({
    String? desc,
    String? end,
    String? link,
    bool? showLink,
  }) {
    return Other(
      desc: desc ?? this.desc,
      end: end ?? this.end,
      link: link ?? this.link,
      showLink: showLink ?? this.showLink,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "desc": desc,
      "end": end,
      "link": link,
      "showLink": showLink,
    };
  }

  Map<String, dynamic> toLocalJson() {
    return <String, dynamic>{
      "desc": desc,
      "end": end,
      "link": link,
      "showLink": showLink,
    };
  }
}
