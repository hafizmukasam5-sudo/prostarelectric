import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final int carouselIndex;
  final List<Map<String, String>> featuredProducts;
  final List<Map<String, String>> categories;

  const HomeLoaded({
    required this.carouselIndex,
    required this.featuredProducts,
    required this.categories,
  });

  @override
  List<Object> get props => [carouselIndex, featuredProducts, categories];

  HomeLoaded copyWith({
    int? carouselIndex,
    List<Map<String, String>>? featuredProducts,
    List<Map<String, String>>? categories,
  }) {
    return HomeLoaded(
      carouselIndex: carouselIndex ?? this.carouselIndex,
      featuredProducts: featuredProducts ?? this.featuredProducts,
      categories: categories ?? this.categories,
    );
  }
}
