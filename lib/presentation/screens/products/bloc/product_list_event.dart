import 'package:equatable/equatable.dart';

abstract class ProductListEvent extends Equatable {
  const ProductListEvent();

  @override
  List<Object> get props => [];
}

class LoadProductsEvent extends ProductListEvent {
  final String subcategoryId;

  const LoadProductsEvent(this.subcategoryId);

  @override
  List<Object> get props => [subcategoryId];
}

class ToggleFavoriteEvent extends ProductListEvent {
  final String productId;

  const ToggleFavoriteEvent(this.productId);

  @override
  List<Object> get props => [productId];
}
