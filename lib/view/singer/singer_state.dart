import 'package:equatable/equatable.dart';
import 'package:juna_bhajan/data/model/bhajan.dart';
import 'package:juna_bhajan/data/model/result.dart';
import 'package:juna_bhajan/data/model/singer.dart';
import 'package:juna_bhajan/data/model/youtube.dart';
import 'package:tuple/tuple.dart';

class SingerState extends Equatable {
  final Singer singer;
  final Result<List<Tuple2<Bhajan, Youtube>>> bhajanList;

  const SingerState({
    required this.singer,
    required this.bhajanList,
  });

  SingerState copyWith({
    Singer? singer,
    Result<List<Tuple2<Bhajan, Youtube>>>? bhajanList,
  }) =>
      SingerState(
        singer: singer ?? this.singer,
        bhajanList: bhajanList ?? this.bhajanList,
      );

  @override
  List<Object> get props => [
        singer,
        bhajanList,
      ];
}
