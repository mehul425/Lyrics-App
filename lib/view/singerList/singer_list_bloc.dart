import 'package:fimber/fimber.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:juna_bhajan/data/model/result_state.dart';
import 'package:juna_bhajan/data/repository/api_repository.dart';
import 'package:juna_bhajan/view/singerList/singer_list_event.dart';
import 'package:juna_bhajan/view/singerList/singer_list_state.dart';

class SingerListBloc
    extends Bloc<SingerListEvent, ResultState<SingerListState>> {
  final ApiRepository apiRepository;

  SingerListBloc({
    required this.apiRepository,
  }) : super(const ResultState.loading()) {
    on<LoadSingerListDataEvent>((event, emit) async {
      bool result = await InternetConnectionChecker().hasConnection;
      if (result) {
        await apiRepository.getSingerList().first.then((event) {
          emit(ResultState.success(data: SingerListState(singerList: event)));
        }, onError: (e, str) {
          emit(ResultState.failure(object: e));
          FimberLog("SingerListBloc")
              .e("Loading Singer List", ex: e, stacktrace: str);
        });
      } else {
        emit(const ResultState.noInternet());
      }
    });
  }
}
