import 'package:collection/collection.dart';
import 'package:fimber/fimber.dart';
import 'package:juna_bhajan/data/model/author.dart';
import 'package:juna_bhajan/data/model/bhajan.dart';
import 'package:juna_bhajan/data/model/change_data.dart';
import 'package:juna_bhajan/data/model/list_data.dart';
import 'package:juna_bhajan/data/model/other.dart';
import 'package:juna_bhajan/data/model/related.dart';
import 'package:juna_bhajan/data/model/singer.dart';
import 'package:juna_bhajan/data/model/tag.dart';
import 'package:juna_bhajan/data/model/type.dart';
import 'package:juna_bhajan/data/model/update.dart';
import 'package:juna_bhajan/data/model/youtube.dart';
import 'package:juna_bhajan/data/sharedpref/preferences.dart';
import 'package:juna_bhajan/data/sharedpref/shared_preference_helper.dart';

class LocalRepository {
  final SharedPreferencesHelper preferencesHelper;

  LocalRepository({
    required this.preferencesHelper,
  });

  Future<bool> saveIsFirstTime() {
    return preferencesHelper.putBool(Preferences.isFirstTime, false);
  }

  Future<bool> rated() {
    return preferencesHelper.putBool(Preferences.rated, true);
  }

  Future<bool> remindMeLater() {
    return preferencesHelper.putBool(Preferences.remindMeLater, true);
  }

  bool isRemindOrRated() {
    return preferencesHelper.getBool(Preferences.remindMeLater,
            defValue: false) ||
        preferencesHelper.getBool(Preferences.rated, defValue: false);
  }

  bool getFirstTime() {
    return preferencesHelper.getBool(Preferences.isFirstTime, defValue: true);
  }

  int getAppOpenCount() {
    return preferencesHelper.getInt(Preferences.appOpenCount, defValue: 0);
  }

  Future<bool> increaseAppOpenCount() {
    return preferencesHelper.putInt(
        Preferences.appOpenCount, getAppOpenCount() + 1);
  }

  Future<bool> setFirstTimeDate() {
    return preferencesHelper.putInt(
        Preferences.firstTimeDate, DateTime.now().millisecondsSinceEpoch);
  }

  DateTime getFirstTimeDate() {
    int dateTime = preferencesHelper.getInt(Preferences.firstTimeDate);
    if (dateTime == -1) {
      return DateTime.now();
    } else {
      return DateTime.fromMillisecondsSinceEpoch(dateTime);
    }
  }

  List<Author> getAuthorList() {
    Fimber.d("Local getAuthorList");
    return preferencesHelper
        .getObjectList(Preferences.author, (json) => Author.fromJson(json))
        .sorted((a, b) => a.name.compareTo(b.name));
  }

  Stream<List<Author>> putAuthorList(List<Author> list) {
    Fimber.d("Local putAuthorList");
    return preferencesHelper
        .putObjectList<Author>(
            Preferences.author, list, (author) => author.toLocalJson())
        .asStream()
        .map((event) => list.sorted((a, b) => a.name.compareTo(b.name)));
  }

  Stream<bool> addUpdateDeleteAuthorToList(ListData listData) {
    Fimber.d("Local addUpdateDeleteAuthorToList");
    return preferencesHelper
        .addUpdateDeleteObjectToList<Author>(
          key: Preferences.author,
          fromJson: (json) => Author.fromJson(json),
          fromListData: (listData) => Author.fromListData(listData),
          value: listData,
          toJson: (author) => author.toLocalJson(),
          test: (value) => listData.id == value.id,
        )
        .asStream();
  }

  List<String> getTopAuthorList() {
    Fimber.d("Local getTopAuthorList");
    return preferencesHelper.getStringList(Preferences.topAuthor);
  }

  Stream<List<String>> putTopAuthorList(List<String> list) {
    Fimber.d("Local putTopAuthorList");
    return preferencesHelper
        .putStringList(Preferences.topAuthor, list)
        .asStream()
        .map((event) => list);
  }

  List<Bhajan> getBhajanList() {
    Fimber.d("Local getBhajanList");
    return preferencesHelper
        .getObjectList(Preferences.bhajan, (json) => Bhajan.fromJson(json))
        .sorted((a, b) => a.nameGuj.compareTo(b.nameGuj));
  }

  Stream<List<Bhajan>> putBhajanList(List<Bhajan> list) {
    Fimber.d("Local putBhajanList");
    return preferencesHelper
        .putObjectList<Bhajan>(
            Preferences.bhajan, list, (bhajan) => bhajan.toLocalJson())
        .asStream()
        .map((event) => list.sorted((a, b) => a.nameGuj.compareTo(b.nameGuj)));
  }

  Stream<bool> addUpdateDeleteBhajanToList(ListData listData) {
    Fimber.d("Local addUpdateDeleteBhajanToList");
    return preferencesHelper
        .addUpdateDeleteObjectToList<Bhajan>(
          key: Preferences.bhajan,
          fromJson: (json) => Bhajan.fromJson(json),
          fromListData: (listData) => Bhajan.fromListData(listData),
          value: listData,
          toJson: (bhajan) => bhajan.toLocalJson(),
          test: (value) => listData.id == value.id,
        )
        .asStream();
  }

  List<String> getNewAddedBhajanList() {
    Fimber.d("Local getNewAddedBhajanList");
    return preferencesHelper.getStringList(Preferences.newAddedBhajan);
  }

  Stream<List<String>> putNewAddedBhajanList(List<String> list) {
    Fimber.d("Local putNewAddedBhajanList");
    return preferencesHelper
        .putStringList(Preferences.newAddedBhajan, list)
        .asStream()
        .map((event) => list);
  }

  List<String> getOurFavoriteBhajanList() {
    Fimber.d("Local getOurFavoriteBhajanList");
    return preferencesHelper.getStringList(Preferences.ourFavoriteBhajan);
  }

  Stream<List<String>> putOurFavoriteBhajanList(List<String> list) {
    Fimber.d("Local putOurFavoriteBhajanList");
    return preferencesHelper
        .putStringList(Preferences.ourFavoriteBhajan, list)
        .asStream()
        .map((event) => list);
  }

  List<Type> getTypeList() {
    Fimber.d("Local getTypeList");
    return preferencesHelper.getObjectList(
        Preferences.type, (json) => Type.fromJson(json));
  }

  Stream<List<Type>> putTypeList(List<Type> list) {
    Fimber.d("Local putTypeList");
    return preferencesHelper
        .putObjectList<Type>(
            Preferences.type, list, (bhajan) => bhajan.toLocalJson())
        .asStream()
        .map((event) => list);
  }

  Stream<bool> addUpdateDeleteTypeToList(ListData listData) {
    Fimber.d("Local addUpdateDeleteTypeToList");
    return preferencesHelper
        .addUpdateDeleteObjectToList<Type>(
          key: Preferences.type,
          fromJson: (json) => Type.fromJson(json),
          fromListData: (listData) => Type.fromListData(listData),
          value: listData,
          toJson: (type) => type.toLocalJson(),
          test: (value) => listData.id == value.id,
        )
        .asStream();
  }

  List<Tag> getTagList() {
    Fimber.d("Local getTagList");
    return preferencesHelper.getObjectList(
        Preferences.tag, (json) => Tag.fromJson(json));
  }

  Stream<List<Tag>> putTagList(List<Tag> list) {
    Fimber.d("Local putTagList");
    return preferencesHelper
        .putObjectList<Tag>(Preferences.tag, list, (tag) => tag.toLocalJson())
        .asStream()
        .map((event) => list);
  }

  Stream<Tag> addTag(Tag tag) {
    Fimber.d("Local addTag");
    return preferencesHelper
        .addObjectToList<Tag>(
      Preferences.tag,
          (json) => Tag.fromJson(json),
      tag,
          (tag) => tag.toLocalJson(),
    )
        .asStream()
        .map((event) => tag);
  }

  Stream<Tag> updateTag(Tag tag) {
    Fimber.d("Local updateTag");
    return preferencesHelper
        .updateObjectToList<Tag>(
      Preferences.tag,
          (json) => Tag.fromJson(json),
      tag,
          (tag) => tag.toLocalJson(),
          (value) => tag.id == value.id,
    )
        .asStream()
        .map((event) => tag);
  }

  List<Related> getRelatedList() {
    Fimber.d("Local getRelatedList");
    return preferencesHelper
        .getObjectList(Preferences.related, (json) => Related.fromJson(json))
        .sorted((a, b) => a.nameGuj.compareTo(b.nameGuj));
  }

  Stream<bool> addUpdateDeleteTAgToList(ListData listData) {
    Fimber.d("Local addUpdateDeleteTagToList");
    return preferencesHelper
        .addUpdateDeleteObjectToList<Tag>(
      key: Preferences.tag,
      fromJson: (json) => Tag.fromJson(json),
      fromListData: (listData) => Tag.fromListData(listData),
      value: listData,
      toJson: (tag) => tag.toLocalJson(),
      test: (value) => listData.id == value.id,
    )
        .asStream();
  }

  Stream<List<Related>> putRelatedList(List<Related> list) {
    Fimber.d("Local putRelatedList");
    return preferencesHelper
        .putObjectList<Related>(
            Preferences.related, list, (related) => related.toLocalJson())
        .asStream()
        .map((event) => list.sorted((a, b) => a.nameGuj.compareTo(b.nameGuj)));
  }

  Stream<bool> addUpdateDeleteRelatedToList(ListData listData) {
    Fimber.d("Local addUpdateDeleteRelatedToList");
    return preferencesHelper
        .addUpdateDeleteObjectToList<Related>(
          key: Preferences.related,
          fromJson: (json) => Related.fromJson(json),
          fromListData: (listData) => Related.fromListData(listData),
          value: listData,
          toJson: (related) => related.toLocalJson(),
          test: (value) => listData.id == value.id,
        )
        .asStream();
  }

  List<Singer> getSingerList() {
    Fimber.d("Local getSingerList");
    return preferencesHelper
        .getObjectList(Preferences.singer, (json) => Singer.fromJson(json))
        .sorted((a, b) => a.name.compareTo(b.name));
  }

  Stream<List<Singer>> putSingerList(List<Singer> list) {
    Fimber.d("Local putSingerList");
    return preferencesHelper
        .putObjectList<Singer>(
            Preferences.singer, list, (author) => author.toLocalJson())
        .asStream()
        .map((event) => list.sorted((a, b) => a.name.compareTo(b.name)));
  }

  Stream<bool> addUpdateDeleteSingerToList(ListData listData) {
    Fimber.d("Local addUpdateDeleteSingerToList");
    return preferencesHelper
        .addUpdateDeleteObjectToList<Singer>(
          key: Preferences.singer,
          fromJson: (json) => Singer.fromJson(json),
          fromListData: (listData) => Singer.fromListData(listData),
          value: listData,
          toJson: (singer) => singer.toLocalJson(),
          test: (value) => listData.id == value.id,
        )
        .asStream();
  }

  List<Youtube> getYoutubeVideoList() {
    Fimber.d("Local getYoutubeVideoList");
    return preferencesHelper.getObjectList(
        Preferences.youtube, (json) => Youtube.fromJson(json));
  }

  Stream<List<Youtube>> putYoutubeVideoList(List<Youtube> list) {
    Fimber.d("Local putYoutubeVideoList");
    return preferencesHelper
        .putObjectList<Youtube>(
            Preferences.youtube, list, (youtube) => youtube.toLocalJson())
        .asStream()
        .map((event) => list);
  }

  Stream<bool> addUpdateDeleteYoutubeToList(ListData listData) {
    Fimber.d("Local addUpdateDeleteYoutubeToList");
    return preferencesHelper
        .addUpdateDeleteObjectToList<Youtube>(
          key: Preferences.youtube,
          fromJson: (json) => Youtube.fromJson(json),
          fromListData: (listData) => Youtube.fromListData(listData),
          value: listData,
          toJson: (youtube) => youtube.toLocalJson(),
          test: (value) => listData.id == value.id,
        )
        .asStream();
  }

  List<String> getTopYoutubeBhajanList() {
    Fimber.d("Local getTopYoutubeBhajanList");
    return preferencesHelper.getStringList(Preferences.topYoutubeBhajan);
  }

  Stream<List<String>> putTopYoutubeBhajanList(List<String> list) {
    Fimber.d("Local putTopYoutubeBhajanList");
    return preferencesHelper
        .putStringList(Preferences.topYoutubeBhajan, list)
        .asStream()
        .map((event) => list);
  }

  List<String> getFavoriteList() {
    Fimber.d("Local getFavoriteList");
    return preferencesHelper.getStringList(Preferences.favorite);
  }

  Stream<List<String>> putFavoriteList(List<String> list) {
    Fimber.d("Local putFavoriteList");
    return preferencesHelper
        .putStringList(Preferences.favorite, list)
        .asStream()
        .map((event) => list);
  }

  Stream<bool> deleteFavoriteList() {
    Fimber.d("Local deleteFavoriteList");
    return preferencesHelper.remove(Preferences.favorite).asStream();
  }

  bool hasFavoriteList() {
    Fimber.d("Local hasFavoriteList");
    return preferencesHelper.haveKey(Preferences.favorite);
  }

  Stream<String> addFavorite(String value) {
    Fimber.d("Local addFavorite");
    return preferencesHelper
        .addStringToList(Preferences.favorite, value)
        .asStream()
        .map((event) => value);
  }

  Stream<String> deleteFavorite(String value) {
    Fimber.d("Local deleteFavorite");
    return preferencesHelper
        .deleteStringToList(Preferences.favorite, value)
        .asStream()
        .map((event) => value);
  }

  Other? getOther() {
    Fimber.d("Local getOther");
    return preferencesHelper.getObject(
        Preferences.other, (json) => Other.fromJson(json));
  }

  Stream<Other> putOther(Other other) {
    Fimber.d("Local putOther");
    return preferencesHelper
        .putObject(Preferences.other, () => other.toLocalJson())
        .asStream()
        .map((event) => other);
  }

  Update? getUpdate() {
    Fimber.d("Local getUpdate");
    return preferencesHelper.getObject(
        Preferences.update, (json) => Update.fromJson(json));
  }

  Stream<Update> putUpdate(Update update) {
    Fimber.d("Local putUpdate");
    return preferencesHelper
        .putObject(Preferences.update, () => update.toLocalJson())
        .asStream()
        .map((event) => update);
  }

  List<ChangeData> getChangeList() {
    Fimber.d("Local getChangeList");
    return preferencesHelper.getObjectList(
        Preferences.changeList, (json) => ChangeData.fromJson(json));
  }

  Stream<List<ChangeData>> putChangeList(List<ChangeData> list) {
    Fimber.d("Local putChangeList");
    return preferencesHelper
        .putObjectList<ChangeData>(
            Preferences.changeList, list, (change) => change.toLocalJson())
        .asStream()
        .map((event) => list);
  }
}
