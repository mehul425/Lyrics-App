import 'package:collection/collection.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:juna_bhajan/data/model/author.dart';
import 'package:juna_bhajan/data/model/result.dart';
import 'package:juna_bhajan/data/model/result_state.dart';
import 'package:juna_bhajan/data/model/youtube.dart';
import 'package:juna_bhajan/data/repository/analytics_repository.dart';
import 'package:juna_bhajan/data/repository/api_repository.dart';
import 'package:juna_bhajan/data/repository/auth_repository.dart';
import 'package:juna_bhajan/view/bhajan/bhajan_event.dart';
import 'package:juna_bhajan/view/bhajan/bhajan_state.dart';

class BhajanBloc extends Bloc<BhajanEvent, ResultState<BhajanState>> {
  final ApiRepository apiRepository;
  final AuthRepository authRepository;
  final AnalyticsRepository analyticsRepository;

  BhajanBloc({
    required this.apiRepository,
    required this.authRepository,
    required this.analyticsRepository,
  }) : super(const ResultState.loading()) {
    on<LoadBhajanDataEvent>((event, emit) async {
      bool result = await InternetConnectionChecker().hasConnection;
      if (result) {
        emit(
          ResultState.success(
            data: BhajanState(
              bhajan: event.bhajan,
              author: const Result.loading(),
              youtubeList: event.bhajan.youtube!.isNotEmpty
                  ? const Result.loading()
                  : const Result.success(
                      data: <Youtube>[],
                    ),
            ),
          ),
        );
        analyticsRepository.logBhajan(event.bhajan);
        if (event.bhajan.author != null) {
          await apiRepository.getAuthorList().first.then((value) {
            state.whenOrNull(success: (data) {
              Author? author = value.firstWhereOrNull(
                  (element) => element.id == event.bhajan.author);

              if (author != null) {
                state.whenOrNull(success: (data) {
                  emit(
                    ResultState.success(
                      data: data.copyWith(
                        author: Result.success(data: author),
                      ),
                    ),
                  );
                });
              } else {
                FimberLog("BhajanBloc").e(
                    "Author is not match : ${event.bhajan.author} ${value.map((e) => e.id).toList()}");
              }
            });
          }, onError: (e, str) {
            state.whenOrNull(success: (data) {
              emit(
                ResultState.success(
                  data: data.copyWith(
                    author: const Result.failure(),
                  ),
                ),
              );
            });
            FimberLog("BhajanBloc").e("Loading Author", ex: e, stacktrace: str);
          });
        }

        if (event.bhajan.youtube!.isNotEmpty) {
          await apiRepository.getYoutubeList().first.then((value) {
            state.whenOrNull(success: (data) {
              emit(
                ResultState.success(
                  data: data.copyWith(
                    youtubeList: Result.success(
                      data: value
                          .where((element) =>
                              event.bhajan.youtube!.contains(element.id))
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
                    youtubeList: const Result.failure(),
                  ),
                ),
              );
            });
            FimberLog("BhajanBloc")
                .e("Loading Youtube List", ex: e, stacktrace: str);
          });
        }

        if (authRepository.status.value != null) {
          await apiRepository
              .getFavorite(userId: authRepository.status.value!.id!)
              .first
              .then((value) {
            state.whenOrNull(success: (data) {
              emit(
                ResultState.success(
                  data: data.copyIsFavorite(
                    isFavorite: value.contains(data.bhajan.id),
                  ),
                ),
              );
            });
          }, onError: (e, str) {
            state.whenOrNull(success: (data) {
              emit(
                ResultState.success(
                  data: data.copyIsFavorite(
                    isFavorite: null,
                  ),
                ),
              );
            });
            FimberLog("BhajanBloc")
                .e("Loading isFavorite", ex: e, stacktrace: str);
          });
        }
      } else {
        emit(const ResultState.noInternet());
      }
    });

    on<BhajanAddOrRemoveFavoriteEvent>((event, emit) async {
      await state.whenOrNull(success: (data) async {
        if (event.isAdd) {
          analyticsRepository.logAddFavorite(data.bhajan);
          await apiRepository
              .addFavorite(
                  userId: authRepository.status.value!.id!,
                  bhajanId: data.bhajan.id!)
              .first
              .then((value) {
            emit(
              ResultState.success(
                data: data.copyIsFavorite(
                  isFavorite: event.isAdd,
                ),
              ),
            );
          }, onError: (e, str) {
            FimberLog("BhajanBloc")
                .e("Add Bhajan to Favorite", ex: e, stacktrace: str);
          });
        } else {
          analyticsRepository.logRemoveFavorite(data.bhajan);
          await apiRepository
              .deleteFavorite(
                  userId: authRepository.status.value!.id!,
                  bhajanId: data.bhajan.id!)
              .first
              .then((value) {
            emit(
              ResultState.success(
                data: data.copyIsFavorite(
                  isFavorite: event.isAdd,
                ),
              ),
            );
          }, onError: (e, str) {
            FimberLog("BhajanBloc")
                .e("Remove Bhajan from Favorite", ex: e, stacktrace: str);
          });
        }
      });
    });
  }
}
