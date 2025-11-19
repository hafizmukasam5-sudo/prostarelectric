import 'package:equatable/equatable.dart';

abstract class SubCategoriesEvent extends Equatable {
  const SubCategoriesEvent();

  @override
  List<Object> get props => [];
}

class LoadSubCategoriesEvent extends SubCategoriesEvent {
  final String categoryId;

  const LoadSubCategoriesEvent(this.categoryId);

  @override
  List<Object> get props => [categoryId];
}
