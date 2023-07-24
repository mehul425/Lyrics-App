import 'package:equatable/equatable.dart';
import 'package:juna_bhajan/data/model/author.dart';

class AuthorListState extends Equatable {
  final List<Author> authorList;

  const AuthorListState({
    required this.authorList,
  });

  AuthorListState copyWith({
    List<Author>? authorList,
  }) =>
      AuthorListState(
        authorList: authorList ?? this.authorList,
      );

  @override
  List<Object?> get props => [
        authorList,
      ];
}
