import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prostarelectrical/core/widgets/custom_appbar.dart';
import 'package:prostarelectrical/presentation/screens/favorites/bloc/favorites_bloc.dart';
import 'package:prostarelectrical/presentation/screens/favorites/bloc/favorites_event.dart';
import 'package:prostarelectrical/presentation/screens/favorites/bloc/favorites_state.dart';
import 'package:prostarelectrical/presentation/screens/products/product_detail_screen.dart';
import 'package:prostarelectrical/presentation/screens/products/widgets/product_card.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_images.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoritesBloc()..add(LoadFavoritesEvent()),
      child: const FavoritesView(),
    );
  }
}

class FavoritesView extends StatelessWidget {
  const FavoritesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: CustomAppBar(
        title: 'Favorites',
        centerTitle: true,
        leadingImage: AppImages.backarrow,
        onLeadingPressed: () => Navigator.pop(context),
      ),
      body: BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (context, state) {
          if (state is FavoritesLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primaryblue),
            );
          }

          if (state is FavoritesEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Image.asset(
                  //   AppImages.favselected,
                  //   width: 80,
                  //   height: 80,
                  //   color: AppColors.bordergrey,
                  // ),
                  Icon(Icons.favorite, color: AppColors.red),
                  const SizedBox(height: 16),
                  const Text(
                    'No favorites yet',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Add products to your favorites',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textPrimary.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            );
          }

          if (state is FavoritesError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 60,
                    color: AppColors.red,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    state.message,
                    style: const TextStyle(
                      fontSize: 16,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            );
          }

          if (state is FavoritesLoaded) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  // Favorites Grid - Same as product list
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.90,
                          crossAxisSpacing: 2,
                          mainAxisSpacing: 5,
                        ),
                    itemCount: state.favoriteProducts.length,
                    itemBuilder: (context, index) {
                      final product = state.favoriteProducts[index];

                      return ProductCard(
                        image: product['image']!,
                        title: product['title']!,
                        isFavorite: true, // Always true in favorites screen
                        description: product['description'],
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ProductDetailScreen(
                                productId: product['id']!,
                                productTitle: product['title']!,
                              ),
                            ),
                          );
                        },
                        onFavoritePressed: () {
                          // Remove from favorites
                          context.read<FavoritesBloc>().add(
                            RemoveFromFavoritesEvent(product['id']!),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
