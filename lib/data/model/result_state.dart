import 'package:freezed_annotation/freezed_annotation.dart';

part 'result_state.freezed.dart';

@freezed
class ResultState<T> with _$ResultState<T> {
  const factory ResultState.loading() = Loading<T>;

  const factory ResultState.success({required T data}) = Success<T>;

  const factory ResultState.noInternet() = NoInternet<T>;

  const factory ResultState.failure({Object? object}) = Failure<T>;
}
