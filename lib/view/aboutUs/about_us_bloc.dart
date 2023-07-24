import 'package:fimber/fimber.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:juna_bhajan/data/model/result_state.dart';
import 'package:juna_bhajan/data/repository/api_repository.dart';
import 'package:juna_bhajan/view/aboutUs/about_us_event.dart';
import 'package:juna_bhajan/view/aboutUs/about_us_state.dart';

class AboutUsBloc extends Bloc<AboutUsEvent, ResultState<AboutUsState>> {
  final ApiRepository apiRepository;

  AboutUsBloc({
    required this.apiRepository,
  }) : super(const ResultState.loading()) {
    on<LoadAboutUsDataEvent>((event, emit) async {
      bool result = await InternetConnectionChecker().hasConnection;
      if (result) {
        await apiRepository.getOther().first.then((event) {
          emit(ResultState.success(data: AboutUsState(other: event)));
        }, onError: (e, str) {
          emit(ResultState.failure(object: e));
          FimberLog("AboutUsBloc")
              .e("Loading About Us", ex: e, stacktrace: str);
        });
      } else {
        emit(const ResultState.noInternet());
      }
    });
  }
}
