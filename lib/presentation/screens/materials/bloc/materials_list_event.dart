import 'package:equatable/equatable.dart';

abstract class MaterialsListEvent extends Equatable {
  const MaterialsListEvent();

  @override
  List<Object> get props => [];
}

class LoadMaterialsListEvent extends MaterialsListEvent {}

class IncrementQuantityEvent extends MaterialsListEvent {
  final String productId;

  const IncrementQuantityEvent(this.productId);

  @override
  List<Object> get props => [productId];
}

class DecrementQuantityEvent extends MaterialsListEvent {
  final String productId;

  const DecrementQuantityEvent(this.productId);

  @override
  List<Object> get props => [productId];
}

class RemoveFromMaterialsEvent extends MaterialsListEvent {
  final String productId;

  const RemoveFromMaterialsEvent(this.productId);

  @override
  List<Object> get props => [productId];
}
