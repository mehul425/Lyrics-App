import 'package:equatable/equatable.dart';

abstract class RelatedListEvent extends Equatable {
  const RelatedListEvent();
}

class LoadRelatedListDataEvent extends RelatedListEvent {
  const LoadRelatedListDataEvent();

  @override
  List<Object?> get props => [];
}
