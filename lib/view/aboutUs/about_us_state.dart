import 'package:equatable/equatable.dart';
import 'package:juna_bhajan/data/model/other.dart';

class AboutUsState extends Equatable {
  final Other other;

  const AboutUsState({
    required this.other,
  });

  AboutUsState copyWith({
    Other? other,
  }) =>
      AboutUsState(
        other: other ?? this.other,
      );

  @override
  List<Object?> get props => [
    other,
  ];
}
