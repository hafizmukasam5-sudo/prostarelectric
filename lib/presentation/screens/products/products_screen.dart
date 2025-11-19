import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prostarelectrical/core/widgets/custom_appbar.dart';
import 'package:prostarelectrical/presentation/screens/products/bloc/product_list_bloc.dart';
import 'package:prostarelectrical/presentation/screens/products/bloc/product_list_event.dart';
import 'package:prostarelectrical/presentation/screens/products/bloc/product_list_state.dart';
import 'package:prostarelectrical/presentation/screens/products/product_detail_screen.dart';
import 'package:prostarelectrical/presentation/screens/products/widgets/product_card.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_images.dart';

class ProductListScreen extends StatelessWidget {
  final String subcategoryId;
  final String subcategoryTitle;

  const ProductListScreen({
    Key? key,
    required this.subcategoryId,
    required this.subcategoryTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProductListBloc()..add(LoadProductsEvent(subcategoryId)),
      child: ProductListView(subcategoryTitle: subcategoryTitle),
    );
  }
}

class ProductListView extends StatelessWidget {
  final String subcategoryTitle;

  const ProductListView({Key? key, required this.subcategoryTitle})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: CustomAppBar(
        title: 'Product List',
        centerTitle: true,
        leadingImage: AppImages.backarrow,
        onLeadingPressed: () => Navigator.pop(context),
      ),
      body: BlocBuilder<ProductListBloc, ProductListState>(
        builder: (context, state) {
          if (state is ProductListLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primaryblue),
            );
          }

          if (state is ProductListError) {
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

          if (state is ProductListLoaded) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  // Product Grid - Same spacing as categories
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1,
                          crossAxisSpacing: 2,
                          mainAxisSpacing: 5,
                        ),
                    itemCount: state.products.length,
                    itemBuilder: (context, index) {
                      final product = state.products[index];
                      final isFavorite = state.favoriteProductIds.contains(
                        product['id'],
                      );

                      return ProductCard(
                        image: product['image']!,
                        title: product['title']!,
                        description: product['description']!,
                        isFavorite: isFavorite,
                        onTap: () {
                          // Navigate to product detail
                          print('Tapped product: ${product['title']}');
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
                          context.read<ProductListBloc>().add(
                            ToggleFavoriteEvent(product['id']!),
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
