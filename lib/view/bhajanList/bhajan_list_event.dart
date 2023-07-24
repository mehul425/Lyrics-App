import 'package:equatable/equatable.dart';
import 'package:juna_bhajan/core/constant.dart';
import 'package:juna_bhajan/data/model/author.dart';
import 'package:juna_bhajan/data/model/related.dart';
import 'package:juna_bhajan/data/model/singer.dart';
import 'package:juna_bhajan/data/model/tag.dart';
import 'package:juna_bhajan/data/model/type.dart';

abstract class BhajanListEvent extends Equatable {
  const BhajanListEvent();
}

class LoadBhajanListDataEvent extends BhajanListEvent {
  final BhajanListType? bhajanListType;
  final int? typeId;
  final int? tagId;
  final String? authorId;
  final String? relatedId;

  const LoadBhajanListDataEvent({
    this.bhajanListType,
    this.typeId,
    this.tagId,
    this.authorId,
    this.relatedId,
  });

  @override
  List<Object?> get props => [
        bhajanListType,
        typeId,
        tagId,
        authorId,
        relatedId,
      ];
}

class ChangeAuthorEvent extends BhajanListEvent {
  final Author? author;

  const ChangeAuthorEvent({
    required this.author,
  });

  @override
  List<Object?> get props => [
        author,
      ];
}

class ChangeTypeEvent extends BhajanListEvent {
  final Type? type;

  const ChangeTypeEvent({
    required this.type,
  });

  @override
  List<Object?> get props => [
        type,
      ];
}

class ChangeTagEvent extends BhajanListEvent {
  final Tag? tag;

  const ChangeTagEvent({
    required this.tag,
  });

  @override
  List<Object?> get props => [
        tag,
      ];
}

class ChangeRelatedEvent extends BhajanListEvent {
  final Related? related;

  const ChangeRelatedEvent({
    required this.related,
  });

  @override
  List<Object?> get props => [
        related,
      ];
}

class ChangeSingerEvent extends BhajanListEvent {
  final Singer? singer;

  const ChangeSingerEvent({
    required this.singer,
  });

  @override
  List<Object?> get props => [
        singer,
      ];
}

class ClearFilterEvent extends BhajanListEvent {
  const ClearFilterEvent();

  @override
  List<Object?> get props => [];
}

class ToggleSearchEvent extends BhajanListEvent {
  const ToggleSearchEvent();

  @override
  List<Object?> get props => [];
}

class SearchTextChangeEvent extends BhajanListEvent {
  final String text;

  const SearchTextChangeEvent({required this.text});

  @override
  List<Object?> get props => [text];
}
