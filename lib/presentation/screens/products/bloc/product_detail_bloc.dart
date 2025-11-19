import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_images.dart';
import 'product_detail_event.dart';
import 'product_detail_state.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  ProductDetailBloc() : super(ProductDetailInitial()) {
    on<LoadProductDetailEvent>(_onLoadProductDetail);
    on<ChangeProductImageEvent>(_onChangeProductImage);
    on<IncreaseQuantityEvent>(_onIncreaseQuantity);
    on<DecreaseQuantityEvent>(_onDecreaseQuantity);
    on<ToggleFavoriteDetailEvent>(_onToggleFavorite);
  }

  Future<void> _onLoadProductDetail(
    LoadProductDetailEvent event,
    Emitter<ProductDetailState> emit,
  ) async {
    emit(ProductDetailLoading());

    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 500));

    // Mock product data
    final product = {
      'id': event.productId,
      'title': 'GENERAL PURPOSE',
      'description':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas nam ipsum vitae ipsum rhoncus elementum. Risus eiusmod tempor lorem massa semper efficitur. Vivamus at amet interdum nam, non suscipit leo. Suspendisse id faucibus mauris sed. Quisque sed armet lorem. Faucibus sed varius aliquet massa, nulla massa fringilla quam. Curabitur facilisis ac ac orci facilisis at convallis et, gravida tempus neque.\n\nMauris sed sed nibus nunc, et aliquet lectus. Morbi locus arcu, diqum a sagittis nec, condimentum vitae nulla. Tempor sed libero vel. Fermentum lacus justo. Vestibulum orci eget.',
      'images': [
        AppImages.generalCategory,
        AppImages.wireCategory,
        AppImages.cableCategory,
        AppImages.accessoriesCategory,
      ],
      'specifications': {
        'Lorem ipsum': 'Aenean velit',
        'Vivamus sit': 'Maximus ac ex',
        'Proin cursus': 'Pellentesque',
        'Nullam in laoreet': 'Facilisis orci',
        'Praesent mattis': 'Donec et suscipit',
      },
    };

    emit(
      ProductDetailLoaded(
        productId: product['id'] as String,
        title: product['title'] as String,
        description: product['description'] as String,
        images: product['images'] as List<String>,
        selectedImageIndex: 0,
        quantity: 1,
        isFavorite: false,
        specifications: product['specifications'] as Map<String, String>,
      ),
    );
  }

  void _onChangeProductImage(
    ChangeProductImageEvent event,
    Emitter<ProductDetailState> emit,
  ) {
    if (state is ProductDetailLoaded) {
      emit(
        (state as ProductDetailLoaded).copyWith(
          selectedImageIndex: event.index,
        ),
      );
    }
  }

  void _onIncreaseQuantity(
    IncreaseQuantityEvent event,
    Emitter<ProductDetailState> emit,
  ) {
    if (state is ProductDetailLoaded) {
      final currentState = state as ProductDetailLoaded;
      emit(currentState.copyWith(quantity: currentState.quantity + 1));
    }
  }

  void _onDecreaseQuantity(
    DecreaseQuantityEvent event,
    Emitter<ProductDetailState> emit,
  ) {
    if (state is ProductDetailLoaded) {
      final currentState = state as ProductDetailLoaded;
      if (currentState.quantity > 1) {
        emit(currentState.copyWith(quantity: currentState.quantity - 1));
      }
    }
  }

  void _onToggleFavorite(
    ToggleFavoriteDetailEvent event,
    Emitter<ProductDetailState> emit,
  ) {
    if (state is ProductDetailLoaded) {
      final currentState = state as ProductDetailLoaded;
      emit(currentState.copyWith(isFavorite: !currentState.isFavorite));
    }
  }
}
