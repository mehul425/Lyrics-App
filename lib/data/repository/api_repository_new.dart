import 'package:firebase_database/firebase_database.dart';
import 'package:juna_bhajan/data/model/author.dart';
import 'package:juna_bhajan/data/model/bhajan.dart';
import 'package:juna_bhajan/data/model/change_data.dart';
import 'package:juna_bhajan/data/model/other.dart';
import 'package:juna_bhajan/data/model/related.dart';
import 'package:juna_bhajan/data/model/singer.dart';
import 'package:juna_bhajan/data/model/tag.dart';
import 'package:juna_bhajan/data/model/type.dart';
import 'package:juna_bhajan/data/model/update.dart';
import 'package:juna_bhajan/data/model/user.dart';
import 'package:juna_bhajan/data/model/youtube.dart';
import 'package:juna_bhajan/data/repository/local_repository.dart';
import 'package:juna_bhajan/data/sharedpref/shared_preference_helper.dart';
import 'package:juna_bhajan/extension/list_data_extension.dart';
import 'package:juna_bhajan/utility/path.dart';
import 'package:juna_bhajan/utility/paths.dart';
import 'package:juna_bhajan/utility/rx_realtime.dart';
import 'package:rxdart/rxdart.dart';

class ApiRepositoryNew {
  final FirebaseDatabase firebaseDatabase;
  final SharedPreferencesHelper preferencesHelper;
  final LocalRepository localRepository;

  static DatabaseReference? _ref;
  ReplayStream<List<Author>>? authorList;
  ReplayStream<List<Bhajan>>? bhajanList;
  ReplayStream<List<Type>>? typeList;
  ReplayStream<List<Tag>>? tagList;
  ReplayStream<List<Related>>? relatedList;
  ReplayStream<List<Singer>>? singerList;
  ReplayStream<List<Youtube>>? youtubeList;
  ReplayStream<List<String>>? favoriteList;
  ReplayStream<List<ChangeData>>? changeList;

  ApiRepositoryNew({
    required this.firebaseDatabase,
    required this.preferencesHelper,
    required this.localRepository,
  }) {
    changeList = RXRealtime()
        .get(_reference(Paths.changeListPath()))
        .parseToListOfListData()
        .map((event) => event.map((e) => ChangeData.fromListData(e)).toList()
          ..sort((a, b) => a.id.compareTo(b.id)))
        .flatMap((list) => localRepository.putChangeList(list))
        .shareReplay();
  }

  DatabaseReference _reference(Path path) {
    _ref ??= firebaseDatabase.ref();
    return _ref!.child(path.toString());
  }

  Stream<List<Author>> getAuthorList({
    bool refresh = false,
    List<String>? ids,
  }) {
    if (authorList == null) {
      if (ids == null) {
        if (refresh) {
          authorList = RXRealtime()
              .get(_reference(Paths.authorsPath()))
              .parseToListOfListData()
              .map((event) => event.map((e) => Author.fromListData(e)).toList())
              .flatMap((list) => localRepository.putAuthorList(list))
              .shareReplay();
        } else {
          authorList =
              Stream.value(localRepository.getAuthorList()).shareReplay();
        }
      } else {
        authorList = Stream.fromIterable(ids)
            .flatMap((value) => getAuthor(id: value))
            .toList()
            .asStream()
            .flatMap((value) => Stream.value(localRepository.getAuthorList()))
            .shareReplay();
      }
    }
    return authorList!;
  }

  Stream<bool> getAuthor({required String id}) {
    return RXRealtime()
        .get(_reference(Paths.authorPath(id)))
        .parseToListData()
        .flatMap((value) => localRepository.addUpdateDeleteAuthorToList(value));
  }

  Stream<List<String>> getTopAuthorList({bool refresh = false}) {
    if (refresh) {
      return RXRealtime()
          .get(_reference(Paths.topAuthorPath()))
          .parseToListOfString()
          .flatMap((list) => localRepository.putTopAuthorList(list));
    } else {
      return Stream.value(localRepository.getTopAuthorList());
    }
  }

  Stream<List<Bhajan>> getBhajanList({
    bool refresh = false,
    List<String>? ids,
  }) {
    if (bhajanList == null) {
      if (ids == null) {
        if (refresh) {
          bhajanList = RXRealtime()
              .get(_reference(Paths.bhajansPath()))
              .parseToListOfListData()
              .map((event) => event.map((e) => Bhajan.fromListData(e)).toList())
              .flatMap((list) => localRepository.putBhajanList(list))
              .shareReplay();
        } else {
          bhajanList =
              Stream.value(localRepository.getBhajanList()).shareReplay();
        }
      } else {
        bhajanList = Stream.fromIterable(ids)
            .flatMap((value) => getBhajan(id: value))
            .toList()
            .asStream()
            .flatMap((value) => Stream.value(localRepository.getBhajanList()))
            .shareReplay();
      }
    }
    return bhajanList!;
  }

  Stream<bool> getBhajan({required String id}) {
    return RXRealtime()
        .get(_reference(Paths.bhajanPath(id)))
        .parseToListData()
        .flatMap((value) => localRepository.addUpdateDeleteBhajanToList(value));
  }

  Stream<List<String>> getNewAddedBhajanList({bool refresh = false}) {
    if (refresh) {
      return RXRealtime()
          .get(_reference(Paths.newAddedBhajanPath()))
          .parseToListOfString()
          .flatMap((list) => localRepository.putNewAddedBhajanList(list));
    } else {
      return Stream.value(localRepository.getNewAddedBhajanList());
    }
  }

  Stream<List<String>> getOurFavoriteBhajanList({bool refresh = false}) {
    if (refresh) {
      return RXRealtime()
          .get(_reference(Paths.ourFavoritePath()))
          .parseToListOfString()
          .flatMap((list) => localRepository.putOurFavoriteBhajanList(list));
    } else {
      return Stream.value(localRepository.getOurFavoriteBhajanList());
    }
  }

  Stream<List<Type>> getTypeList({
    bool refresh = false,
    List<String>? ids,
  }) {
    if (typeList == null) {
      if (ids == null) {
        if (refresh) {
          typeList = RXRealtime()
              .get(_reference(Paths.typesPath()))
              .parseToListOfListData()
              .map((event) => event.map((e) => Type.fromListData(e)).toList())
              .flatMap((list) => localRepository.putTypeList(list))
              .shareReplay();
        } else {
          typeList = Stream.value(localRepository.getTypeList()).shareReplay();
        }
      } else {
        typeList = Stream.fromIterable(ids)
            .flatMap((value) => getType(id: value))
            .toList()
            .asStream()
            .flatMap((value) => Stream.value(localRepository.getTypeList()))
            .shareReplay();
      }
    }
    return typeList!;
  }

  Stream<bool> getType({required String id}) {
    return RXRealtime()
        .get(_reference(Paths.typePath(id)))
        .parseToListData()
        .flatMap((value) => localRepository.addUpdateDeleteTypeToList(value));
  }

  Stream<List<Tag>> getTagList({
    bool refresh = false,
    List<String>? ids,
  }) {
    if (tagList == null) {
      if (ids == null) {
        if (refresh) {
          tagList = RXRealtime()
              .get(_reference(Paths.tagsPath()))
              .parseToListOfListData()
              .map((event) => event.map((e) => Tag.fromListData(e)).toList())
              .flatMap((list) => localRepository.putTagList(list))
              .shareReplay();
        } else {
          tagList = Stream.value(localRepository.getTagList()).shareReplay();
        }
      } else {
        tagList = Stream.fromIterable(ids)
            .flatMap((value) => getTag(id: value))
            .toList()
            .asStream()
            .flatMap((value) => Stream.value(localRepository.getTagList()))
            .shareReplay();
      }
    }
    return tagList!;
  }

  Stream<bool> getTag({required String id}) {
    return RXRealtime()
        .get(_reference(Paths.tagPath(id)))
        .parseToListData()
        .flatMap((value) => localRepository.addUpdateDeleteTAgToList(value));
  }

  Stream<List<Related>> getRelatedList({
    bool refresh = false,
    List<String>? ids,
  }) {
    if (relatedList == null) {
      if (ids == null) {
        if (refresh) {
          relatedList = RXRealtime()
              .get(_reference(Paths.relatedsPath()))
              .parseToListOfListData()
              .map(
                  (event) => event.map((e) => Related.fromListData(e)).toList())
              .flatMap((list) => localRepository.putRelatedList(list))
              .shareReplay();
        } else {
          relatedList =
              Stream.value(localRepository.getRelatedList()).shareReplay();
        }
      } else {
        relatedList = Stream.fromIterable(ids)
            .flatMap((value) => getRelated(id: value))
            .toList()
            .asStream()
            .flatMap((value) => Stream.value(localRepository.getRelatedList()))
            .shareReplay();
      }
    }
    return relatedList!;
  }

  Stream<bool> getRelated({required String id}) {
    return RXRealtime()
        .get(_reference(Paths.relatedPath(id)))
        .parseToListData()
        .flatMap(
            (value) => localRepository.addUpdateDeleteRelatedToList(value));
  }

  Stream<List<Singer>> getSingerList({
    bool refresh = false,
    List<String>? ids,
  }) {
    if (singerList == null) {
      if (ids == null) {
        if (refresh) {
          singerList = RXRealtime()
              .get(_reference(Paths.singersPath()))
              .parseToListOfListData()
              .map((event) => event.map((e) => Singer.fromListData(e)).toList())
              .flatMap((list) => localRepository.putSingerList(list))
              .shareReplay();
        } else {
          singerList =
              Stream.value(localRepository.getSingerList()).shareReplay();
        }
      } else {
        singerList = Stream.fromIterable(ids)
            .flatMap((value) => getSinger(id: value))
            .toList()
            .asStream()
            .flatMap((value) => Stream.value(localRepository.getSingerList()))
            .shareReplay();
      }
    }
    return singerList!;
  }

  Stream<bool> getSinger({required String id}) {
    return RXRealtime()
        .get(_reference(Paths.singerPath(id)))
        .parseToListData()
        .flatMap((value) => localRepository.addUpdateDeleteSingerToList(value));
  }

  Stream<List<Youtube>> getYoutubeList({
    bool refresh = false,
    List<String>? ids,
  }) {
    if (youtubeList == null) {
      if (ids == null) {
        if (refresh) {
          youtubeList = RXRealtime()
              .get(_reference(Paths.youtubeVideosPath()))
              .parseToListOfListData()
              .map(
                  (event) => event.map((e) => Youtube.fromListData(e)).toList())
              .flatMap((list) => localRepository.putYoutubeVideoList(list))
              .shareReplay();
        } else {
          youtubeList =
              Stream.value(localRepository.getYoutubeVideoList()).shareReplay();
        }
      } else {
        youtubeList = Stream.fromIterable(ids)
            .flatMap((value) => getYoutube(id: value))
            .toList()
            .asStream()
            .flatMap(
                (value) => Stream.value(localRepository.getYoutubeVideoList()))
            .shareReplay();
      }
    }
    return youtubeList!;
  }

  Stream<bool> getYoutube({required String id}) {
    return RXRealtime()
        .get(_reference(Paths.youtubeVideoPath(id)))
        .parseToListData()
        .flatMap(
            (value) => localRepository.addUpdateDeleteYoutubeToList(value));
  }

  Stream<List<String>> getTopYoutubeBhajanList({bool refresh = false}) {
    if (refresh) {
      return RXRealtime()
          .get(_reference(Paths.topYoutubePath()))
          .parseToListOfString()
          .flatMap((list) => localRepository.putTopYoutubeBhajanList(list));
    } else {
      return Stream.value(localRepository.getTopYoutubeBhajanList());
    }
  }

  Stream<List<String>> getFavorite({required String userId}) {
    if (localRepository.hasFavoriteList()) {
      favoriteList =
          Stream.value(localRepository.getFavoriteList()).shareReplay();
    } else {
      favoriteList = RXRealtime()
          .get(_reference(Paths.userFavorite(userId)))
          .parseArrayToListOfString()
          .flatMap((list) => localRepository.putFavoriteList(list))
          .shareReplay();
    }
    return favoriteList!;
  }

  Stream<void> addFavorite({
    required String userId,
    required String bhajanId,
  }) {
    return RXRealtime()
        .add(_reference(Paths.userFavoritePathById(userId, bhajanId)), true)
        .flatMap((value) => localRepository.addFavorite(bhajanId));
  }

  Stream<void> deleteFavorite({
    required String userId,
    required String bhajanId,
  }) {
    return RXRealtime()
        .delete(_reference(Paths.userFavoritePathById(userId, bhajanId)))
        .flatMap((value) => localRepository.deleteFavorite(bhajanId));
  }

  Stream<Other> getOther({bool refresh = false}) {
    if (refresh) {
      return RXRealtime()
          .get(_reference(Paths.otherPath()))
          .parseToListData()
          .map((event) => Other.fromListData(event))
          .flatMap((list) => localRepository.putOther(list));
    } else {
      return Stream.value(localRepository.getOther()).flatMap((value) {
        if (value == null) {
          return RXRealtime()
              .get(_reference(Paths.otherPath()))
              .parseToListData()
              .map((event) => Other.fromListData(event))
              .flatMap((list) => localRepository.putOther(list));
        } else {
          return Stream.value(value);
        }
      });
    }
  }

  Stream<Update> getUpdate({bool refresh = false}) {
    if (refresh) {
      return RXRealtime()
          .get(_reference(Paths.updatePath()))
          .parseToListData()
          .map((event) => Update.fromListData(event))
          .flatMap((list) => localRepository.putUpdate(list));
    } else {
      return Stream.value(localRepository.getUpdate()!);
    }
  }

  Stream<void> addUser(UserData user) {
    return RXRealtime()
        .update(_reference(Paths.userPathById(user.id!)), user.toJson());
  }

  Stream<List<ChangeData>> getChangeList() {
    return changeList!;
  }
}
