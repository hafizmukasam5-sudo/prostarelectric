import 'package:equatable/equatable.dart';

abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object> get props => [];
}

class LoadFavoritesEvent extends FavoritesEvent {}

class RemoveFromFavoritesEvent extends FavoritesEvent {
  final String productId;

  const RemoveFromFavoritesEvent(this.productId);

  @override
  List<Object> get props => [productId];
}
