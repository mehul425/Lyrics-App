import 'package:equatable/equatable.dart';
import 'package:juna_bhajan/data/model/singer.dart';

abstract class SingerEvent extends Equatable {
  const SingerEvent();
}

class LoadSingerDataEvent extends SingerEvent {
  final Singer singer;

  const LoadSingerDataEvent({required this.singer});

  @override
  List<Object?> get props => [singer];
}
