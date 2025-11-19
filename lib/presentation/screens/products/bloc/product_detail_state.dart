import 'package:equatable/equatable.dart';

abstract class ProductDetailState extends Equatable {
  const ProductDetailState();

  @override
  List<Object> get props => [];
}

class ProductDetailInitial extends ProductDetailState {}

class ProductDetailLoading extends ProductDetailState {}

class ProductDetailLoaded extends ProductDetailState {
  final String productId;
  final String title;
  final String description;
  final List<String> images;
  final int selectedImageIndex;
  final int quantity;
  final bool isFavorite;
  final Map<String, String> specifications;

  const ProductDetailLoaded({
    required this.productId,
    required this.title,
    required this.description,
    required this.images,
    required this.selectedImageIndex,
    required this.quantity,
    required this.isFavorite,
    required this.specifications,
  });

  @override
  List<Object> get props => [
    productId,
    title,
    description,
    images,
    selectedImageIndex,
    quantity,
    isFavorite,
    specifications,
  ];

  ProductDetailLoaded copyWith({
    String? productId,
    String? title,
    String? description,
    List<String>? images,
    int? selectedImageIndex,
    int? quantity,
    bool? isFavorite,
    Map<String, String>? specifications,
  }) {
    return ProductDetailLoaded(
      productId: productId ?? this.productId,
      title: title ?? this.title,
      description: description ?? this.description,
      images: images ?? this.images,
      selectedImageIndex: selectedImageIndex ?? this.selectedImageIndex,
      quantity: quantity ?? this.quantity,
      isFavorite: isFavorite ?? this.isFavorite,
      specifications: specifications ?? this.specifications,
    );
  }
}

class ProductDetailError extends ProductDetailState {
  final String message;

  const ProductDetailError(this.message);

  @override
  List<Object> get props => [message];
}
