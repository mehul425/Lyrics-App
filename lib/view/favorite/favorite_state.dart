part of 'favorite_bloc.dart';

class FavoriteState extends Equatable {
  final List<Bhajan> bhajanList;

  const FavoriteState({
    required this.bhajanList,
  });

  FavoriteState copyWith({
    List<Bhajan>? bhajanList,
  }) =>
      FavoriteState(
        bhajanList: bhajanList ?? this.bhajanList,
      );

  @override
  List<Object?> get props => [
        bhajanList,
      ];
}
