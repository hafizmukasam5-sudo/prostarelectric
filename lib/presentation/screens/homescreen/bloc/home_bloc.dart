import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_images.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<LoadHomeDataEvent>(_onLoadHomeData);
    on<ChangeCarouselIndexEvent>(_onChangeCarouselIndex);
  }

  Future<void> _onLoadHomeData(
    LoadHomeDataEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());

    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 500));

    // Featured Products Data
    final featuredProducts = [
      {'image': AppImages.featured11, 'title': 'Featured Product'},
      {'image': AppImages.featured12, 'title': 'Featured Product'},
      {'image': AppImages.featured13, 'title': 'Featured Product'},
      {'image': AppImages.featured14, 'title': 'Featured Product'},
      {'image': AppImages.featured1, 'title': 'Featured Product'},
      {'image': AppImages.featured2, 'title': 'Coming soon'},
    ];

    // Categories Data
    final categories = [
      {'image': AppImages.wireCategory, 'title': 'Wire'},
      {'image': AppImages.cableCategory, 'title': 'CABLE'},
      {'image': AppImages.accessoriesCategory, 'title': 'ACCESSORIES'},
      {'image': AppImages.submersibleCategory, 'title': 'SUBMERSIBLE CABLE'},
      {
        'image': AppImages.contactorCategory,
        'title': 'CONTACTOR (230V - 400V)',
      },
      {'image': AppImages.generalCategory, 'title': 'GENERAL PURPOSE'},
    ];

    emit(
      HomeLoaded(
        carouselIndex: 0,
        featuredProducts: featuredProducts,
        categories: categories,
      ),
    );
  }

  void _onChangeCarouselIndex(
    ChangeCarouselIndexEvent event,
    Emitter<HomeState> emit,
  ) {
    if (state is HomeLoaded) {
      emit((state as HomeLoaded).copyWith(carouselIndex: event.index));
    }
  }
}
