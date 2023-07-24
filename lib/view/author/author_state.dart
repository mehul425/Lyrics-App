import 'package:equatable/equatable.dart';
import 'package:juna_bhajan/data/model/author.dart';
import 'package:juna_bhajan/data/model/bhajan.dart';
import 'package:juna_bhajan/data/model/result.dart';

class AuthorState extends Equatable {
  final Author author;
  final Result<List<Bhajan>> bhajanList;
  final Result<Author> guruShree;

  const AuthorState({
    required this.author,
    required this.bhajanList,
    required this.guruShree,
  });

  AuthorState copyWith({
    Author? author,
    Result<List<Bhajan>>? bhajanList,
    Result<Author>? guruShree,
  }) =>
      AuthorState(
        author: author ?? this.author,
        bhajanList: bhajanList ?? this.bhajanList,
        guruShree: guruShree ?? this.guruShree,
      );

  @override
  List<Object?> get props => [
        author,
        bhajanList,
        guruShree,
      ];
}
