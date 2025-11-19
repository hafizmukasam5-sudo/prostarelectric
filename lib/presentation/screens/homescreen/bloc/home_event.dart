import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class LoadHomeDataEvent extends HomeEvent {}

class ChangeCarouselIndexEvent extends HomeEvent {
  final int index;

  const ChangeCarouselIndexEvent(this.index);

  @override
  List<Object> get props => [index];
}
