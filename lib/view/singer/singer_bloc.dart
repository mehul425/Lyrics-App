import 'package:collection/collection.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:juna_bhajan/data/model/bhajan.dart';
import 'package:juna_bhajan/data/model/result.dart';
import 'package:juna_bhajan/data/model/result_state.dart';
import 'package:juna_bhajan/data/model/youtube.dart';
import 'package:juna_bhajan/data/repository/analytics_repository.dart';
import 'package:juna_bhajan/data/repository/api_repository.dart';
import 'package:juna_bhajan/view/singer/singer_event.dart';
import 'package:juna_bhajan/view/singer/singer_state.dart';
import 'package:rxdart/rxdart.dart' as rx_dart;
import 'package:tuple/tuple.dart';

class SingerBloc extends Bloc<SingerEvent, ResultState<SingerState>> {
  final ApiRepository apiRepository;
  final AnalyticsRepository analyticsRepository;

  SingerBloc({
    required this.apiRepository,
    required this.analyticsRepository,
  }) : super(const ResultState.loading()) {
    on<LoadSingerDataEvent>((event, emit) async {
      bool result = await InternetConnectionChecker().hasConnection;
      if (result) {
        emit(
          ResultState.success(
            data: SingerState(
              singer: event.singer,
              bhajanList: const Result.loading(),
            ),
          ),
        );
        analyticsRepository.logSinger(event.singer);

        await rx_dart.ZipStream.zip2<List<Youtube>, List<Bhajan>,
            Tuple2<List<Youtube>, List<Bhajan>>>(
          apiRepository.getYoutubeList(),
          apiRepository.getBhajanList(),
          (a, b) => Tuple2(a, b),
        ).first.then((value) {
          state.whenOrNull(success: (data) {
            emit(
              ResultState.success(
                data: data.copyWith(
                  bhajanList: Result.success(
                    data: value.item1
                        .where((element) =>
                            element.singer?.contains(event.singer.id) ?? false)
                        .map((e) => Tuple2(
                              value.item2.firstWhereOrNull(
                                  (element) => element.id! == e.bhajanId),
                              e,
                            ))
                        .where((element) => element.item1 != null)
                        .map((e) => Tuple2(e.item1!, e.item2))
                        .toList()
                        .sorted((a, b) =>
                            a.item1.nameGuj.compareTo(b.item1.nameGuj)),
                  ),
                ),
              ),
            );
          });
        }, onError: (e, str) {
          state.whenOrNull(success: (data) {
            emit(
              ResultState.success(
                data: data.copyWith(
                  bhajanList: const Result.failure(),
                ),
              ),
            );
          });
          FimberLog("SingerBloc")
              .e("Loading Youtube and Bhajan List", ex: e, stacktrace: str);
        });
      } else {
        emit(const ResultState.noInternet());
      }
    });
  }
}
