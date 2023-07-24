import 'package:firebase_database/firebase_database.dart';
import 'package:juna_bhajan/data/model/author.dart';
import 'package:juna_bhajan/data/model/bhajan.dart';
import 'package:juna_bhajan/data/model/other.dart';
import 'package:juna_bhajan/data/model/related.dart';
import 'package:juna_bhajan/data/model/singer.dart';
import 'package:juna_bhajan/data/model/tag.dart';
import 'package:juna_bhajan/data/model/type.dart';
import 'package:juna_bhajan/data/model/update.dart';
import 'package:juna_bhajan/data/model/user.dart';
import 'package:juna_bhajan/data/model/youtube.dart';
import 'package:juna_bhajan/data/sharedpref/shared_preference_helper.dart';
import 'package:juna_bhajan/extension/list_data_extension.dart';
import 'package:juna_bhajan/utility/path.dart';
import 'package:juna_bhajan/utility/paths.dart';
import 'package:juna_bhajan/utility/rx_realtime.dart';
import 'package:rxdart/rxdart.dart';
import 'package:collection/collection.dart';

class ApiRepository {
  final FirebaseDatabase firebaseDatabase;
  final SharedPreferencesHelper preferencesHelper;

  static DatabaseReference? _ref;
  ReplayStream<List<Author>>? authorList;
  ReplayStream<List<Bhajan>>? bhajanList;
  ReplayStream<List<Type>>? typeList;
  ReplayStream<List<Tag>>? tagList;
  ReplayStream<List<Related>>? relatedList;
  ReplayStream<List<Singer>>? singerList;
  ReplayStream<List<Youtube>>? youtubeList;

  ApiRepository({
    required this.firebaseDatabase,
    required this.preferencesHelper,
  });

  DatabaseReference _reference(Path path) {
    _ref ??= firebaseDatabase.ref()..keepSynced(true);
    return _ref!.child(path.toString());
  }

  Stream<List<Author>> getAuthorList({
    bool refresh = false,
    List<String>? ids,
  }) {
    authorList ??= RXRealtime()
        .get(_reference(Paths.authorsPath()))
        .parseToListOfListData()
        .map((event) => event
            .map((e) => Author.fromListData(e))
            .toList()
            .sorted((a, b) => a.name.compareTo(b.name)))
        .shareReplay();
    return authorList!;
  }

  Stream<List<String>> getTopAuthorList({bool refresh = false}) {
    return RXRealtime()
        .get(_reference(Paths.topAuthorPath()))
        .parseToListOfString();
  }

  Stream<List<Bhajan>> getBhajanList({
    bool refresh = false,
    List<String>? ids,
  }) {
    bhajanList ??= RXRealtime()
        .get(_reference(Paths.bhajansPath()))
        .parseToListOfListData()
        .map((event) => event
            .map((e) => Bhajan.fromListData(e))
            .toList()
            .sorted((a, b) => a.nameGuj.compareTo(b.nameGuj)))
        .shareReplay();
    return bhajanList!;
  }

  Stream<List<String>> getNewAddedBhajanList({bool refresh = false}) {
    return RXRealtime()
        .get(_reference(Paths.newAddedBhajanPath()))
        .parseToListOfString();
  }

  Stream<List<String>> getOurFavoriteBhajanList({bool refresh = false}) {
    return RXRealtime()
        .get(_reference(Paths.ourFavoritePath()))
        .parseToListOfString();
  }

  Stream<List<Type>> getTypeList({
    bool refresh = false,
    List<String>? ids,
  }) {
    typeList ??= RXRealtime()
        .get(_reference(Paths.typesPath()))
        .parseToListOfListData()
        .map((event) => event.map((e) => Type.fromListData(e)).toList())
        .shareReplay();
    return typeList!;
  }

  Stream<List<Tag>> getTagList({
    bool refresh = false,
    List<String>? ids,
  }) {
    tagList ??= RXRealtime()
        .get(_reference(Paths.tagsPath()))
        .parseToListOfListData()
        .map((event) => event.map((e) => Tag.fromListData(e)).toList())
        .shareReplay();
    return tagList!;
  }

  Stream<List<Related>> getRelatedList({
    bool refresh = false,
    List<String>? ids,
  }) {
    relatedList ??= RXRealtime()
        .get(_reference(Paths.relatedsPath()))
        .parseToListOfListData()
        .map((event) => event
            .map((e) => Related.fromListData(e))
            .toList()
            .sorted((a, b) => a.nameGuj.compareTo(b.nameGuj)))
        .shareReplay();
    return relatedList!;
  }

  Stream<List<Singer>> getSingerList({
    bool refresh = false,
    List<String>? ids,
  }) {
    singerList ??= RXRealtime()
        .get(_reference(Paths.singersPath()))
        .parseToListOfListData()
        .map((event) => event
            .map((e) => Singer.fromListData(e))
            .toList()
            .sorted((a, b) => a.name.compareTo(b.name)))
        .shareReplay();
    return singerList!;
  }

  Stream<List<Youtube>> getYoutubeList({
    bool refresh = false,
    List<String>? ids,
  }) {
    youtubeList ??= RXRealtime()
        .get(_reference(Paths.youtubeVideosPath()))
        .parseToListOfListData()
        .map((event) => event.map((e) => Youtube.fromListData(e)).toList())
        .shareReplay();
    return youtubeList!;
  }

  Stream<List<String>> getTopYoutubeBhajanList({bool refresh = false}) {
    return RXRealtime()
        .get(_reference(Paths.topYoutubePath()))
        .parseToListOfString();
  }

  Stream<List<String>> getFavorite({required String userId}) {
    return RXRealtime()
        .get(_reference(Paths.userFavorite(userId)))
        .parseArrayToListOfString();
  }

  Stream<void> addFavorite({
    required String userId,
    required String bhajanId,
  }) {
    return RXRealtime()
        .add(_reference(Paths.userFavoritePathById(userId, bhajanId)), true);
  }

  Stream<void> deleteFavorite({
    required String userId,
    required String bhajanId,
  }) {
    return RXRealtime()
        .delete(_reference(Paths.userFavoritePathById(userId, bhajanId)));
  }

  Stream<Other> getOther({bool refresh = false}) {
    return RXRealtime()
        .get(_reference(Paths.otherPath()))
        .parseToListData()
        .map((event) => Other.fromListData(event));
  }

  Stream<Update> getUpdate({bool refresh = false}) {
    return RXRealtime()
        .get(_reference(Paths.updatePath()))
        .parseToListData()
        .map((event) => Update.fromListData(event));
  }

  Stream<void> addUser(UserData user) {
    return RXRealtime()
        .update(_reference(Paths.userPathById(user.id!)), user.toJson());
  }
}
