part of 'favorite_bloc.dart';

abstract class FavoriteEvent extends Equatable {
  const FavoriteEvent();
}

class LoadFavoriteBhajanListDataEvent extends FavoriteEvent {
  const LoadFavoriteBhajanListDataEvent();

  @override
  List<Object?> get props => [];
}
