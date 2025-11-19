import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_images.dart';
import 'favorites_event.dart';
import 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc() : super(FavoritesInitial()) {
    on<LoadFavoritesEvent>(_onLoadFavorites);
    on<RemoveFromFavoritesEvent>(_onRemoveFromFavorites);
  }

  Future<void> _onLoadFavorites(
    LoadFavoritesEvent event,
    Emitter<FavoritesState> emit,
  ) async {
    emit(FavoritesLoading());

    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 500));

    // Mock favorite products data
    final favoriteProducts = [
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
        'title': 'CONTACTOR\n(230V - 400V)',
        'description': 'consectetur adipiscing elit',
      },
      {
        'id': '6',
        'image': AppImages.generalCategory,
        'title': 'GENERAL PURPOSE',
        'description':
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit',
      },
    ];

    if (favoriteProducts.isEmpty) {
      emit(FavoritesEmpty());
    } else {
      emit(FavoritesLoaded(favoriteProducts: favoriteProducts));
    }
  }

  void _onRemoveFromFavorites(
    RemoveFromFavoritesEvent event,
    Emitter<FavoritesState> emit,
  ) {
    if (state is FavoritesLoaded) {
      final currentState = state as FavoritesLoaded;
      final updatedFavorites = currentState.favoriteProducts
          .where((product) => product['id'] != event.productId)
          .toList();

      if (updatedFavorites.isEmpty) {
        emit(FavoritesEmpty());
      } else {
        emit(FavoritesLoaded(favoriteProducts: updatedFavorites));
      }
    }
  }
}
