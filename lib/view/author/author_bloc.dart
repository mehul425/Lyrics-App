import 'package:collection/collection.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:juna_bhajan/data/model/author.dart';
import 'package:juna_bhajan/data/model/result.dart';
import 'package:juna_bhajan/data/model/result_state.dart';
import 'package:juna_bhajan/data/repository/analytics_repository.dart';
import 'package:juna_bhajan/data/repository/api_repository.dart';
import 'package:juna_bhajan/view/author/author_event.dart';
import 'package:juna_bhajan/view/author/author_state.dart';

class AuthorBloc extends Bloc<AuthorEvent, ResultState<AuthorState>> {
  final ApiRepository apiRepository;
  final AnalyticsRepository analyticsRepository;

  AuthorBloc({
    required this.apiRepository,
    required this.analyticsRepository,
  }) : super(const ResultState.loading()) {
    on<LoadAuthorDataEvent>((event, emit) async {
      bool result = await InternetConnectionChecker().hasConnection;
      if (result) {
        emit(ResultState.success(
          data: AuthorState(
            author: event.author,
            bhajanList: const Result.loading(),
            guruShree: const Result.loading(),
          ),
        ));
        analyticsRepository.logAuthor(event.author);
        if (event.author.guruShri != null) {
          await apiRepository.getAuthorList().first.then((value) {
            Author? guruShree = value.firstWhereOrNull(
                (element) => element.id == event.author.guruShri);

            if (guruShree != null) {
              state.whenOrNull(success: (data) {
                emit(
                  ResultState.success(
                    data: data.copyWith(
                      bhajanList: const Result.loading(),
                      guruShree: Result.success(data: guruShree),
                    ),
                  ),
                );
              });
            } else {
              FimberLog("AuthorBloc").e(
                  "GuruShree is not match : ${event.author.guruShri} ${value.map((e) => e.id).toList()}");
            }
          }, onError: (e, str) {
            state.whenOrNull(success: (data) {
              emit(
                ResultState.success(
                  data: data.copyWith(
                    bhajanList: const Result.loading(),
                    guruShree: const Result.failure(),
                  ),
                ),
              );
            });
            FimberLog("AuthorBloc")
                .e("Loading Author List", ex: e, stacktrace: str);
          });
        }
        await apiRepository.getBhajanList().first.then((value) {
          state.whenOrNull(success: (data) {
            emit(
              ResultState.success(
                data: data.copyWith(
                  bhajanList: Result.success(
                    data: value
                        .where((element) => element.author == event.author.id)
                        .toList(),
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
          FimberLog("AuthorBloc")
              .e("Loading Bhajan List", ex: e, stacktrace: str);
        });
      } else {
        emit(const ResultState.noInternet());
      }
    });
  }
}
