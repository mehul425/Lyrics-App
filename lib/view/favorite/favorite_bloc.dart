import 'package:equatable/equatable.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:juna_bhajan/data/model/bhajan.dart';
import 'package:juna_bhajan/data/model/result_state.dart';
import 'package:juna_bhajan/data/repository/analytics_repository.dart';
import 'package:juna_bhajan/data/repository/api_repository.dart';
import 'package:juna_bhajan/data/repository/auth_repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tuple/tuple.dart';

part 'favorite_event.dart';

part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, ResultState<FavoriteState>> {
  final ApiRepository apiRepository;
  final AuthRepository authRepository;
  final AnalyticsRepository analyticsRepository;

  FavoriteBloc({
    required this.apiRepository,
    required this.authRepository,
    required this.analyticsRepository,
  }) : super(const ResultState.loading()) {
    on<LoadFavoriteBhajanListDataEvent>((event, emit) async {
      bool result = await InternetConnectionChecker().hasConnection;
      if (result) {
        await ZipStream.zip2<List<Bhajan>, List<String>,
                Tuple2<List<Bhajan>, List<String>>>(
            apiRepository.getBhajanList(),
            apiRepository.getFavorite(userId: authRepository.status.value!.id!),
            (a, b) =>
                Tuple2<List<Bhajan>, List<String>>(a, b)).first.then((value) {
          emit(
            ResultState.success(
              data: FavoriteState(
                bhajanList: value.item1
                    .where((element) => value.item2.contains(element.id!))
                    .toList(),
              ),
            ),
          );
        }, onError: (e, str) {
          emit(ResultState.failure(object: e));
          FimberLog("FavoriteBloc")
              .e("Loading Favorite Bhajan List", ex: e, stacktrace: str);
        });
      } else {
        emit(const ResultState.noInternet());
      }
    });
  }
}
