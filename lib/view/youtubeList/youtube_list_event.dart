import 'package:equatable/equatable.dart';
import 'package:juna_bhajan/data/model/author.dart';
import 'package:juna_bhajan/data/model/related.dart';
import 'package:juna_bhajan/data/model/singer.dart';
import 'package:juna_bhajan/data/model/tag.dart';
import 'package:juna_bhajan/data/model/type.dart';

abstract class YoutubeListEvent extends Equatable {
  const YoutubeListEvent();
}

class LoadYoutubeListDataEvent extends YoutubeListEvent {
  const LoadYoutubeListDataEvent();

  @override
  List<Object> get props => [];
}

class ChangeAuthorEvent extends YoutubeListEvent {
  final Author? author;

  const ChangeAuthorEvent({
    required this.author,
  });

  @override
  List<Object?> get props => [
        author,
      ];
}

class ChangeTypeEvent extends YoutubeListEvent {
  final Type? type;

  const ChangeTypeEvent({
    required this.type,
  });

  @override
  List<Object?> get props => [
        type,
      ];
}

class ChangeTagEvent extends YoutubeListEvent {
  final Tag? tag;

  const ChangeTagEvent({
    required this.tag,
  });

  @override
  List<Object?> get props => [
        tag,
      ];
}

class ChangeRelatedEvent extends YoutubeListEvent {
  final Related? related;

  const ChangeRelatedEvent({
    required this.related,
  });

  @override
  List<Object?> get props => [
        related,
      ];
}

class ChangeSingerEvent extends YoutubeListEvent {
  final Singer? singer;

  const ChangeSingerEvent({
    required this.singer,
  });

  @override
  List<Object?> get props => [
        singer,
      ];
}

class ClearFilterEvent extends YoutubeListEvent {
  const ClearFilterEvent();

  @override
  List<Object?> get props => [];
}

class ToggleExpandedEvent extends YoutubeListEvent {
  const ToggleExpandedEvent();

  @override
  List<Object?> get props => [];
}
