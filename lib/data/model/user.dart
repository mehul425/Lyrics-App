import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:juna_bhajan/data/model/list_data.dart';

class UserData extends Equatable {
  final String? id;
  final String? name;
  final String email;
  final String? imageUrl;
  final String? number;
  final List<String> favorite;

  const UserData({
    this.id,
    this.name,
    required this.email,
    this.imageUrl,
    this.number,
    required this.favorite,
  });

  factory UserData.fromListData(ListData listData) {
    return UserData(
      id: listData.id,
      name: listData.data!["name"],
      email: listData.data!["email"],
      imageUrl: listData.data!["imageUrl"],
      number: listData.data!["number"],
      favorite: listData.data!["favorite"] != null
          ? Map<String, dynamic>.from(listData.data!["favorite"])
              .entries
              .map((e) => e.key)
              .toList()
          : <String>[],
    );
  }

  factory UserData.fromFirebaseUse(User user) {
    return UserData(
      id: user.uid,
      name: user.displayName,
      email: user.email!,
      imageUrl: user.photoURL,
      number: user.phoneNumber,
      favorite: const <String>[],
    );
  }

  factory UserData.fromJson(Map<dynamic, dynamic> json) {
    return UserData(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      imageUrl: json["imageUrl"],
      number: json["number"],
      favorite: (json["favorite"] as List<dynamic>).cast<String>(),
    );
  }

  UserData copyWith({
    String? id,
    String? name,
    String? email,
    String? imageUrl,
    String? number,
    List<String>? favorite,
  }) {
    return UserData(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      imageUrl: imageUrl ?? this.imageUrl,
      number: number ?? this.number,
      favorite: favorite ?? this.favorite,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "name": name,
      "email": email,
      "imageUrl": imageUrl,
      "number": number,
      // "favorite": favorite,
    };
  }

  Map<String, dynamic> toLocalJson() {
    return <String, dynamic>{
      "id": id,
      "name": name,
      "email": email,
      "imageUrl": imageUrl,
      "number": number,
      "favorite": favorite,
    };
  }

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        imageUrl,
        number,
        favorite,
      ];
}
