import 'package:equatable/equatable.dart';
import 'package:juna_bhajan/data/model/related.dart';

class RelatedListState extends Equatable {
  final List<Related> relatedList;

  const RelatedListState({
    required this.relatedList,
  });

  RelatedListState copyWith({
    List<Related>? relatedList,
  }) =>
      RelatedListState(
        relatedList: relatedList ?? this.relatedList,
      );

  @override
  List<Object?> get props => [
        relatedList,
      ];
}
