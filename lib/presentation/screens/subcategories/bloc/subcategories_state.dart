import 'package:equatable/equatable.dart';

abstract class SubCategoriesState extends Equatable {
  const SubCategoriesState();

  @override
  List<Object> get props => [];
}

class SubCategoriesInitial extends SubCategoriesState {}

class SubCategoriesLoading extends SubCategoriesState {}

class SubCategoriesLoaded extends SubCategoriesState {
  final String categoryTitle;
  final List<Map<String, String>> subCategories;

  const SubCategoriesLoaded({
    required this.categoryTitle,
    required this.subCategories,
  });

  @override
  List<Object> get props => [categoryTitle, subCategories];
}

class SubCategoriesError extends SubCategoriesState {
  final String message;

  const SubCategoriesError(this.message);

  @override
  List<Object> get props => [message];
}
