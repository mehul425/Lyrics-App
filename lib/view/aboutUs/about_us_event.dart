import 'package:equatable/equatable.dart';

abstract class AboutUsEvent extends Equatable {
  const AboutUsEvent();
}

class LoadAboutUsDataEvent extends AboutUsEvent {
  const LoadAboutUsDataEvent();

  @override
  List<Object?> get props => [];
}
