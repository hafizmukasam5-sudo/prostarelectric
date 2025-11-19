import 'package:equatable/equatable.dart';

abstract class ProductDetailEvent extends Equatable {
  const ProductDetailEvent();

  @override
  List<Object> get props => [];
}

class LoadProductDetailEvent extends ProductDetailEvent {
  final String productId;

  const LoadProductDetailEvent(this.productId);

  @override
  List<Object> get props => [productId];
}

class ChangeProductImageEvent extends ProductDetailEvent {
  final int index;

  const ChangeProductImageEvent(this.index);

  @override
  List<Object> get props => [index];
}

class IncreaseQuantityEvent extends ProductDetailEvent {}

class DecreaseQuantityEvent extends ProductDetailEvent {}

class ToggleFavoriteDetailEvent extends ProductDetailEvent {}
