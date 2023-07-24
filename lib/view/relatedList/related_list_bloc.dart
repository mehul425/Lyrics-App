import 'package:fimber/fimber.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:juna_bhajan/data/model/result_state.dart';
import 'package:juna_bhajan/data/repository/api_repository.dart';
import 'package:juna_bhajan/view/relatedList/related_list_event.dart';
import 'package:juna_bhajan/view/relatedList/related_list_state.dart';

class RelatedListBloc
    extends Bloc<RelatedListEvent, ResultState<RelatedListState>> {
  final ApiRepository apiRepository;

  RelatedListBloc({
    required this.apiRepository,
  }) : super(const ResultState.loading()) {
    on<LoadRelatedListDataEvent>((event, emit) async {
      bool result = await InternetConnectionChecker().hasConnection;
      if (result) {
        await apiRepository.getRelatedList().first.then((event) {
          emit(ResultState.success(data: RelatedListState(relatedList: event)));
        }, onError: (e, str) {
          emit(ResultState.failure(object: e));
          FimberLog("RelatedListBloc")
              .e("Loading Related List", ex: e, stacktrace: str);
        });
      } else {
        emit(const ResultState.noInternet());
      }
    });
  }
}
