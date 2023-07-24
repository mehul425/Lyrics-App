import 'package:equatable/equatable.dart';
import 'package:juna_bhajan/data/model/singer.dart';

class SingerListState extends Equatable {
  final List<Singer> singerList;

  const SingerListState({
    required this.singerList,
  });

  SingerListState copyWith({
    List<Singer>? singerList,
  }) =>
      SingerListState(
        singerList: singerList ?? this.singerList,
      );

  @override
  List<Object?> get props => [
        singerList,
      ];
}
