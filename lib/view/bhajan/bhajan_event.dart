import 'package:equatable/equatable.dart';
import 'package:juna_bhajan/data/model/bhajan.dart';

abstract class BhajanEvent extends Equatable {
  const BhajanEvent();
}

class LoadBhajanDataEvent extends BhajanEvent {
  final Bhajan bhajan;

  const LoadBhajanDataEvent({required this.bhajan});

  @override
  List<Object?> get props => [bhajan];
}

class BhajanAddOrRemoveFavoriteEvent extends BhajanEvent {
  final bool isAdd;

  const BhajanAddOrRemoveFavoriteEvent({required this.isAdd});

  @override
  List<Object?> get props => [isAdd];
}
