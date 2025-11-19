import 'package:equatable/equatable.dart';

abstract class MaterialsListState extends Equatable {
  const MaterialsListState();

  @override
  List<Object> get props => [];
}

class MaterialsListInitial extends MaterialsListState {}

class MaterialsListLoading extends MaterialsListState {}

class MaterialsListLoaded extends MaterialsListState {
  final List<Map<String, dynamic>> materials;

  const MaterialsListLoaded({required this.materials});

  @override
  List<Object> get props => [materials];

  MaterialsListLoaded copyWith({List<Map<String, dynamic>>? materials}) {
    return MaterialsListLoaded(materials: materials ?? this.materials);
  }
}

class MaterialsListEmpty extends MaterialsListState {}

class MaterialsListError extends MaterialsListState {
  final String message;

  const MaterialsListError(this.message);

  @override
  List<Object> get props => [message];
}
