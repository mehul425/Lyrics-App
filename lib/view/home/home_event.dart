import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class LoadHomeDataEvent extends HomeEvent {
  const LoadHomeDataEvent();

  @override
  List<Object?> get props => [];
}

class RefreshHomeDataEvent extends HomeEvent {
  const RefreshHomeDataEvent();

  @override
  List<Object?> get props => [];
}

class CheckRatingStatusEvent extends HomeEvent {
  const CheckRatingStatusEvent();

  @override
  List<Object?> get props => [];
}

class RatedStatusEvent extends HomeEvent {
  const RatedStatusEvent();

  @override
  List<Object?> get props => [];
}

class RemindMeLaterStatusEvent extends HomeEvent {
  const RemindMeLaterStatusEvent();

  @override
  List<Object?> get props => [];
}
