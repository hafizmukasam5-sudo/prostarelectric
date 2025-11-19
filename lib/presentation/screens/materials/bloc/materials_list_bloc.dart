import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prostarelectrical/presentation/screens/materials/bloc/materials_list_event.dart';
import 'package:prostarelectrical/presentation/screens/materials/bloc/materials_list_state.dart';
import '../../../../core/constants/app_images.dart';

class MaterialsListBloc extends Bloc<MaterialsListEvent, MaterialsListState> {
  MaterialsListBloc() : super(MaterialsListInitial()) {
    on<LoadMaterialsListEvent>(_onLoadMaterialsList);
    on<IncrementQuantityEvent>(_onIncrementQuantity);
    on<DecrementQuantityEvent>(_onDecrementQuantity);
    on<RemoveFromMaterialsEvent>(_onRemoveFromMaterials);
  }

  Future<void> _onLoadMaterialsList(
    LoadMaterialsListEvent event,
    Emitter<MaterialsListState> emit,
  ) async {
    emit(MaterialsListLoading());

    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 500));

    // Mock materials list data
    final materials = [
      {
        'id': '1',
        'image': AppImages.wireCategory,
        'title': 'SURFIX',
        'description':
            'Lorem ipsum dolor sit amet, con Lorem ipsum dolor sit amet',
        'quantity': 1,
      },
      {
        'id': '2',
        'image': AppImages.generalCategory,
        'title': 'GENERAL PURPOSE',
        'description': 'Lorem ipsum dolor sit amet, con......',
        'quantity': 1,
      },
      {
        'id': '3',
        'image': AppImages.contactorCategory,
        'title': 'CONTACTOR (230V - 400V)',
        'description': 'Lorem ipsum dolor sit amet, con......',
        'quantity': 1,
      },
    ];

    if (materials.isEmpty) {
      emit(MaterialsListEmpty());
    } else {
      emit(MaterialsListLoaded(materials: materials));
    }
  }

  void _onIncrementQuantity(
    IncrementQuantityEvent event,
    Emitter<MaterialsListState> emit,
  ) {
    if (state is MaterialsListLoaded) {
      final currentState = state as MaterialsListLoaded;
      final updatedMaterials = currentState.materials.map((material) {
        if (material['id'] == event.productId) {
          return {...material, 'quantity': material['quantity'] + 1};
        }
        return material;
      }).toList();

      emit(currentState.copyWith(materials: updatedMaterials));
    }
  }

  void _onDecrementQuantity(
    DecrementQuantityEvent event,
    Emitter<MaterialsListState> emit,
  ) {
    if (state is MaterialsListLoaded) {
      final currentState = state as MaterialsListLoaded;
      final updatedMaterials = currentState.materials.map((material) {
        if (material['id'] == event.productId && material['quantity'] > 1) {
          return {...material, 'quantity': material['quantity'] - 1};
        }
        return material;
      }).toList();

      emit(currentState.copyWith(materials: updatedMaterials));
    }
  }

  void _onRemoveFromMaterials(
    RemoveFromMaterialsEvent event,
    Emitter<MaterialsListState> emit,
  ) {
    if (state is MaterialsListLoaded) {
      final currentState = state as MaterialsListLoaded;
      final updatedMaterials = currentState.materials
          .where((material) => material['id'] != event.productId)
          .toList();

      if (updatedMaterials.isEmpty) {
        emit(MaterialsListEmpty());
      } else {
        emit(MaterialsListLoaded(materials: updatedMaterials));
      }
    }
  }
}
