import 'package:equatable/equatable.dart';
import 'package:juna_bhajan/data/model/author.dart';

abstract class AuthorEvent extends Equatable {
  const AuthorEvent();
}

class LoadAuthorDataEvent extends AuthorEvent {
  final Author author;

  const LoadAuthorDataEvent({required this.author});

  @override
  List<Object?> get props => [author];
}
