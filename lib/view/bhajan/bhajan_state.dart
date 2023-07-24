import 'package:equatable/equatable.dart';
import 'package:juna_bhajan/data/model/author.dart';
import 'package:juna_bhajan/data/model/bhajan.dart';
import 'package:juna_bhajan/data/model/result.dart';
import 'package:juna_bhajan/data/model/youtube.dart';

class BhajanState extends Equatable {
  final Bhajan bhajan;
  final bool? isFavorite;
  final Result<Author> author;
  final Result<List<Youtube>> youtubeList;

  const BhajanState({
    required this.bhajan,
    this.isFavorite,
    required this.author,
    required this.youtubeList,
  });

  BhajanState copyWith({
    Bhajan? bhajan,
    Result<Author>? author,
    Result<List<Youtube>>? youtubeList,
  }) =>
      BhajanState(
        bhajan: bhajan ?? this.bhajan,
        isFavorite: isFavorite,
        author: author ?? this.author,
        youtubeList: youtubeList ?? this.youtubeList,
      );

  BhajanState copyIsFavorite({
    bool? isFavorite,
  }) =>
      BhajanState(
        bhajan: bhajan,
        isFavorite: isFavorite,
        author: author,
        youtubeList: youtubeList,
      );

  @override
  List<Object?> get props => [
        bhajan,
        isFavorite,
        author,
        youtubeList,
      ];
}
