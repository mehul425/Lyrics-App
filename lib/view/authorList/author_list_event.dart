import 'package:equatable/equatable.dart';

abstract class AuthorListEvent extends Equatable {
  const AuthorListEvent();
}

class LoadAuthorListDataEvent extends AuthorListEvent {
  const LoadAuthorListDataEvent();

  @override
  List<Object?> get props => [];
}
