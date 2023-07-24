import 'package:juna_bhajan/data/model/list_data.dart';

class OtherYoutube {
  String? id;
  String bhajanId;
  String name;
  String videoId;
  String image;
  int duration;
  String channelName;
  String channelId;
  String channelImage;
  List<String>? singer;

  OtherYoutube({
    this.id,
    required this.bhajanId,
    required this.name,
    required this.videoId,
    required this.image,
    required this.duration,
    required this.channelName,
    required this.channelId,
    required this.channelImage,
    this.singer,
  });

  factory OtherYoutube.fromListData(ListData listData) {
    return OtherYoutube(
      id: listData.id,
      bhajanId: listData.data!["bhajan_id"],
      name: listData.data!["name"],
      videoId: listData.data!["video_id"],
      image: listData.data!["image"],
      duration: listData.data!["duration"],
      channelName: listData.data!["channel_name"],
      channelId: listData.data!["channel_id"],
      channelImage: listData.data!["channel_image"],
      singer: listData.data!["singer"] != null
          ? (listData.data!["singer"] as List<dynamic>).cast<String>()
          : <String>[],
    );
  }

  factory OtherYoutube.fromJson(Map<dynamic, dynamic> json) {
    return OtherYoutube(
      id: json["id"],
      bhajanId: json["bhajan_id"],
      name: json["name"],
      videoId: json["video_id"],
      image: json["image"],
      duration: json["duration"],
      channelName: json["channel_name"],
      channelId: json["channel_id"],
      channelImage: json["channel_image"],
      singer: (json["singer"] as List<dynamic>).cast<String>(),
    );
  }

  OtherYoutube copyWith({
    String? id,
    String? bhajanId,
    String? name,
    String? videoId,
    String? image,
    int? duration,
    String? channelName,
    String? channelId,
    String? channelImage,
    List<String>? singer,
  }) {
    return OtherYoutube(
      id: id ?? this.id,
      bhajanId: bhajanId ?? this.bhajanId,
      name: name ?? this.name,
      videoId: videoId ?? this.videoId,
      image: image ?? this.image,
      duration: duration ?? this.duration,
      channelName: channelName ?? this.channelName,
      channelId: channelId ?? this.channelId,
      channelImage: channelImage ?? this.channelImage,
      singer: singer ?? this.singer,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "bhajan_id": bhajanId,
      "name": name,
      "video_id": videoId,
      "image": image,
      "duration": duration,
      "channel_name": channelName,
      "channel_id": channelId,
      "channel_image": channelImage,
      "singer": singer,
    };
  }

  Map<String, dynamic> toLocalJson() {
    return <String, dynamic>{
      "id": id,
      "bhajan_id": bhajanId,
      "name": name,
      "video_id": videoId,
      "image": image,
      "duration": duration,
      "channel_name": channelName,
      "channel_id": channelId,
      "channel_image": channelImage,
      "singer": singer,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OtherYoutube &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
