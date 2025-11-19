import 'package:equatable/equatable.dart';

abstract class ProductListState extends Equatable {
  const ProductListState();

  @override
  List<Object> get props => [];
}

class ProductListInitial extends ProductListState {}

class ProductListLoading extends ProductListState {}

class ProductListLoaded extends ProductListState {
  final List<Map<String, dynamic>> products;
  final Set<String> favoriteProductIds;

  const ProductListLoaded({
    required this.products,
    required this.favoriteProductIds,
  });

  @override
  List<Object> get props => [products, favoriteProductIds];

  ProductListLoaded copyWith({
    List<Map<String, dynamic>>? products,
    Set<String>? favoriteProductIds,
  }) {
    return ProductListLoaded(
      products: products ?? this.products,
      favoriteProductIds: favoriteProductIds ?? this.favoriteProductIds,
    );
  }
}

class ProductListError extends ProductListState {
  final String message;

  const ProductListError(this.message);

  @override
  List<Object> get props => [message];
}
