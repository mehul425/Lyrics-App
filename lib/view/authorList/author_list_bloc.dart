import 'package:fimber/fimber.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:juna_bhajan/data/model/result_state.dart';
import 'package:juna_bhajan/data/repository/api_repository.dart';
import 'package:juna_bhajan/view/authorList/author_list_event.dart';
import 'package:juna_bhajan/view/authorList/author_list_state.dart';

class AuthorListBloc
    extends Bloc<AuthorListEvent, ResultState<AuthorListState>> {
  final ApiRepository apiRepository;

  AuthorListBloc({
    required this.apiRepository,
  }) : super(const ResultState.loading()) {
    on<LoadAuthorListDataEvent>((event, emit) async {
      bool result = await InternetConnectionChecker().hasConnection;
      if (result) {
        await apiRepository.getAuthorList().first.then((event) {
          emit(ResultState.success(data: AuthorListState(authorList: event)));
        }, onError: (e, str) {
          emit(ResultState.failure(object: e));
          FimberLog("AuthorListBloc")
              .e("Loading Author List", ex: e, stacktrace: str);
        });
      } else {
        emit(const ResultState.noInternet());
      }
    });
  }
}
