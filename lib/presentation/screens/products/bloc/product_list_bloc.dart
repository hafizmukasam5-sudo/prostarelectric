import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_images.dart';
import 'product_list_event.dart';
import 'product_list_state.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  ProductListBloc() : super(ProductListInitial()) {
    on<LoadProductsEvent>(_onLoadProducts);
    on<ToggleFavoriteEvent>(_onToggleFavorite);
  }

  Future<void> _onLoadProducts(
    LoadProductsEvent event,
    Emitter<ProductListState> emit,
  ) async {
    emit(ProductListLoading());

    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 500));

    // Mock products data
    final products = [
      {
        'id': '1',
        'image': AppImages.wireCategory,
        'title': 'SURFIX',
        'description':
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit',
      },
      {
        'id': '2',
        'image': AppImages.cableCategory,
        'title': 'ARMOURED',
        'description':
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit',
      },
      {
        'id': '3',
        'image': AppImages.accessoriesCategory,
        'title': 'ACCESSORIES',
        'description':
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit',
      },
      {
        'id': '4',
        'image': AppImages.submersibleCategory,
        'title': 'SUBMERSIBLE CABLE',
        'description': 'consectetur adipiscing elit',
      },
      {
        'id': '5',
        'image': AppImages.contactorCategory,
        'title': 'CONTACTOR (230V - 400V)',
        'description': 'consectetur adipiscing elit',
      },
      {
        'id': '6',
        'image': AppImages.generalCategory,
        'title': 'GENERAL PURPOSE',
        'description': 'consectetur adipiscing elit',
      },
      {
        'id': '7',
        'image': AppImages.accessoriesCategory,
        'title': 'ACCESSORIES',
        'description':
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit',
      },
      {
        'id': '8',
        'image': AppImages.submersibleCategory,
        'title': 'SUBMERSIBLE CABLE',
        'description': 'consectetur adipiscing elit',
      },
    ];

    emit(ProductListLoaded(products: products, favoriteProductIds: {}));
  }

  void _onToggleFavorite(
    ToggleFavoriteEvent event,
    Emitter<ProductListState> emit,
  ) {
    if (state is ProductListLoaded) {
      final currentState = state as ProductListLoaded;
      final favoriteIds = Set<String>.from(currentState.favoriteProductIds);

      if (favoriteIds.contains(event.productId)) {
        favoriteIds.remove(event.productId);
      } else {
        favoriteIds.add(event.productId);
      }

      emit(currentState.copyWith(favoriteProductIds: favoriteIds));
    }
  }
}
