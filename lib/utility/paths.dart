import 'package:juna_bhajan/utility/key_util.dart';
import 'package:juna_bhajan/utility/path.dart';

class Paths {
  static Path root() {
    return Path.fromPath("");
  }

  static Path authorsPath() {
    return root().child(KeyUtil.author);
  }

  static Path authorPath(String authorId) {
    return authorsPath().child(authorId);
  }

  static Path bhajansPath() {
    return root().child(KeyUtil.bhajan);
  }

  static Path bhajanPath(String bhajanId) {
    return bhajansPath().child(bhajanId);
  }

  static Path singersPath() {
    return root().child(KeyUtil.singer);
  }

  static Path singerPath(String singerId) {
    return singersPath().child(singerId);
  }

  static Path topAuthorPath() {
    return root().child(KeyUtil.topAuthor);
  }

  static Path newAddedBhajanPath() {
    return root().child(KeyUtil.newAddedBhajan);
  }

  static Path ourFavoritePath() {
    return root().child(KeyUtil.ourFavoriteBhajan);
  }

  static Path topYoutubePath() {
    return root().child(KeyUtil.topYoutubeBhajan);
  }

  static Path typesPath() {
    return root().child(KeyUtil.type);
  }

  static Path typePath(String typeId) {
    return typesPath().child(typeId);
  }

  static Path tagsPath() {
    return root().child(KeyUtil.tag);
  }

  static Path tagPath(String tagId) {
    return tagsPath().child(tagId);
  }

  static Path relatedsPath() {
    return root().child(KeyUtil.related);
  }

  static Path relatedPath(String relatedId) {
    return relatedsPath().child(relatedId);
  }

  static Path otherPath() {
    return root().child(KeyUtil.other);
  }

  static Path updatePath() {
    return root().child(KeyUtil.update);
  }

  static Path youtubeVideosPath() {
    return root().child(KeyUtil.youtube);
  }

  static Path youtubeVideoPath(String youtubeId) {
    return youtubeVideosPath().child(youtubeId);
  }

  static Path userPath() {
    return root().child(KeyUtil.user);
  }

  static Path userPathById(String userId) {
    return userPath().child(userId);
  }

  static Path userFavorite(String userId) {
    return userPathById(userId).child(KeyUtil.favorite);
  }

  static Path userFavoritePathById(String userId, String bhajanId) {
    return userFavorite(userId).child(bhajanId);
  }

  static Path changesPath() {
    return root().child(KeyUtil.changes);
  }

  static Path localChangePath() {
    return changesPath().child(KeyUtil.localChange);
  }

  static Path changeListPath() {
    return changesPath().child(KeyUtil.changeList);
  }

  static Path changePathById(String id) {
    return changesPath().child(KeyUtil.changeList).child(id);
  }
}
