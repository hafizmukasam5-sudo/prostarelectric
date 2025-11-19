import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prostarelectrical/core/widgets/custom_appbar.dart';
import 'package:prostarelectrical/core/widgets/custom_button.dart';
import 'package:prostarelectrical/presentation/screens/products/bloc/product_detail_bloc.dart';
import 'package:prostarelectrical/presentation/screens/products/bloc/product_detail_event.dart';
import 'package:prostarelectrical/presentation/screens/products/bloc/product_detail_state.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_images.dart';

class ProductDetailScreen extends StatelessWidget {
  final String productId;
  final String productTitle;

  const ProductDetailScreen({
    Key? key,
    required this.productId,
    required this.productTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProductDetailBloc()..add(LoadProductDetailEvent(productId)),
      child: const ProductDetailView(),
    );
  }
}

class ProductDetailView extends StatelessWidget {
  const ProductDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: CustomAppBar(
        title: 'New Products',
        centerTitle: true,
        leadingImage: AppImages.backarrow,
        onLeadingPressed: () => Navigator.pop(context),
        actions: [
          BlocBuilder<ProductDetailBloc, ProductDetailState>(
            builder: (context, state) {
              if (state is ProductDetailLoaded) {
                return IconButton(
                  icon: Image.asset(
                    state.isFavorite ? AppImages.favselected : AppImages.fav,
                    width: 24,
                    height: 24,
                  ),
                  onPressed: () {
                    context.read<ProductDetailBloc>().add(
                      ToggleFavoriteDetailEvent(),
                    );
                  },
                );
              }
              return const SizedBox();
            },
          ),
        ],
      ),
      body: BlocBuilder<ProductDetailBloc, ProductDetailState>(
        builder: (context, state) {
          if (state is ProductDetailLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primaryblue),
            );
          }

          if (state is ProductDetailError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: AppColors.red),
              ),
            );
          }

          if (state is ProductDetailLoaded) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Main Product Image
                  Container(
                    height: 300,
                    width: double.infinity,
                    color: AppColors.textwhite,
                    padding: const EdgeInsets.all(20),
                    child: Image.asset(
                      state.images[state.selectedImageIndex],
                      fit: BoxFit.contain,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Thumbnail Images
                  SizedBox(
                    height: 80,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      itemCount: state.images.length,
                      itemBuilder: (context, index) {
                        final isSelected = index == state.selectedImageIndex;
                        return GestureDetector(
                          onTap: () {
                            context.read<ProductDetailBloc>().add(
                              ChangeProductImageEvent(index),
                            );
                          },
                          child: Container(
                            width: 94,
                            height: 94,
                            margin: const EdgeInsets.only(right: 0),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.textwhite,
                              border: Border.all(
                                color: isSelected
                                    ? AppColors.primaryblue
                                    : AppColors.bordergrey,
                                width: isSelected ? 2 : 1,
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Image.asset(
                              state.images[index],
                              fit: BoxFit.contain,
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Product Title and Download Button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          state.title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textPrimary,
                          ),
                        ),

                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: AppColors.primaryblue,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text(
                                  'Download',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textwhite,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Image.asset(
                                  AppImages.download,
                                  height: 16,
                                  width: 16,
                                  fit: BoxFit.contain,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Quantity Selector
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Color(0xffE4D6DC)),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize
                                .min, // Makes row take minimum space
                            children: [
                              IconButton(
                                onPressed: () {
                                  context.read<ProductDetailBloc>().add(
                                    DecreaseQuantityEvent(),
                                  );
                                },
                                icon: const Icon(
                                  Icons.remove,
                                  size: 18,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                child: Text(
                                  '${state.quantity}',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  context.read<ProductDetailBloc>().add(
                                    IncreaseQuantityEvent(),
                                  );
                                },
                                icon: const Icon(
                                  Icons.add,
                                  size: 18,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Add to materials List Button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: CustomButton(
                      text: 'Add to materials List',
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Added to materials list'),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 27),

                  // Description Section
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Description',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Description Text with green underline
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 3,
                          // width: 100,
                          decoration: BoxDecoration(
                            color: AppColors.green,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            state.description,
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.textPrimary.withOpacity(0.8),
                              height: 1.6,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Specification Section
                        // const Padding(
                        //   padding: EdgeInsets.symmetric(horizontal: 16),
                        //   child: Text(
                        //     'Specification',
                        //     style: TextStyle(
                        //       fontSize: 18,
                        //       fontWeight: FontWeight.w600,
                        //       color: AppColors.textPrimary,
                        //     ),
                        //   ),
                        // ),

                        // const SizedBox(height: 12),

                        // Specification Table
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 0),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.bordergrey.withOpacity(0.5),
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Column(
                              children: [
                                // Header Row with green background
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: AppColors
                                        .greenlight, // Light green color
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(4),
                                      topRight: Radius.circular(4),
                                    ),
                                  ),
                                  child: const Text(
                                    'Specification',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 2),
                                // Specification Rows
                                _buildSpecRow(
                                  'Lorem ipsum',
                                  'Aenean velit',
                                  isFirst: true,
                                ),
                                SizedBox(height: 2),
                                _buildSpecRow('Vivamus sit', 'Maximus ac ex'),
                                SizedBox(height: 2),
                                _buildSpecRow('Proin cursus', 'Pellentesque'),
                                SizedBox(height: 2),
                                _buildSpecRow(
                                  'Nullam in laoreet',
                                  'Facilisis orci',
                                ),
                                SizedBox(height: 2),
                                _buildSpecRow(
                                  'Praesent mattis',
                                  'Donec et suscipit',
                                  isLast: true,
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),
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

Widget _buildSpecRow(
  String label,
  String value, {
  bool isFirst = false,
  bool isLast = false,
}) {
  return Container(
    decoration: BoxDecoration(
      color: AppColors.greenlight, // Light green color
      border: Border(
        bottom: isLast
            ? BorderSide.none
            : BorderSide(
                color: AppColors.bordergrey.withOpacity(0.3),
                width: 1,
              ),
      ),
    ),
    child: Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 16,
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        Container(
          width: 1,
          height: 40,
          color: AppColors.bordergrey.withOpacity(0.3),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              value,
              style: TextStyle(
                fontSize: 16,
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
