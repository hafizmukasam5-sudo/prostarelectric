import 'package:equatable/equatable.dart';

abstract class FavoritesState extends Equatable {
  const FavoritesState();

  @override
  List<Object> get props => [];
}

class FavoritesInitial extends FavoritesState {}

class FavoritesLoading extends FavoritesState {}

class FavoritesLoaded extends FavoritesState {
  final List<Map<String, dynamic>> favoriteProducts;

  const FavoritesLoaded({required this.favoriteProducts});

  @override
  List<Object> get props => [favoriteProducts];

  FavoritesLoaded copyWith({List<Map<String, dynamic>>? favoriteProducts}) {
    return FavoritesLoaded(
      favoriteProducts: favoriteProducts ?? this.favoriteProducts,
    );
  }
}

class FavoritesEmpty extends FavoritesState {}

class FavoritesError extends FavoritesState {
  final String message;

  const FavoritesError(this.message);

  @override
  List<Object> get props => [message];
}
