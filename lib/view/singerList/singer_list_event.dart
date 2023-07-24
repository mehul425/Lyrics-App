import 'package:equatable/equatable.dart';

abstract class SingerListEvent extends Equatable {
  const SingerListEvent();
}

class LoadSingerListDataEvent extends SingerListEvent {
  const LoadSingerListDataEvent();

  @override
  List<Object?> get props => [];
}
