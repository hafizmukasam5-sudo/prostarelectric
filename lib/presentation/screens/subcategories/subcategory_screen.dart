import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prostarelectrical/core/constants/app_images.dart';
import 'package:prostarelectrical/core/widgets/custom_appbar.dart';
import 'package:prostarelectrical/presentation/screens/homescreen/widgets/category_card.dart';
import 'package:prostarelectrical/presentation/screens/products/products_screen.dart';
import 'package:prostarelectrical/presentation/screens/subcategories/bloc/subcategories_bloc.dart';
import 'package:prostarelectrical/presentation/screens/subcategories/bloc/subcategories_event.dart';
import 'package:prostarelectrical/presentation/screens/subcategories/bloc/subcategories_state.dart';
import '../../../../core/constants/app_colors.dart';

class SubCategoriesScreen extends StatelessWidget {
  final String categoryId;
  final String categoryTitle;

  const SubCategoriesScreen({
    Key? key,
    required this.categoryId,
    required this.categoryTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SubCategoriesBloc()..add(LoadSubCategoriesEvent(categoryId)),
      child: SubCategoriesView(categoryTitle: categoryTitle),
    );
  }
}

class SubCategoriesView extends StatelessWidget {
  final String categoryTitle;

  const SubCategoriesView({Key? key, required this.categoryTitle})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: CustomAppBar(
        title: 'Sub Categories',
        centerTitle: true,
        leadingImage: AppImages.backarrow,
        onLeadingPressed: () => Navigator.pop(context),
      ),
      body: BlocBuilder<SubCategoriesBloc, SubCategoriesState>(
        builder: (context, state) {
          if (state is SubCategoriesLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primaryblue),
            );
          }

          if (state is SubCategoriesError) {
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

          if (state is SubCategoriesLoaded) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  // Categories Grid - Exact same as home screen
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1.1,
                          crossAxisSpacing: 2,
                          mainAxisSpacing: 5,
                        ),
                    itemCount: state.subCategories.length,
                    itemBuilder: (context, index) {
                      return CategoryCard(
                        image: state.subCategories[index]['image']!,
                        title: state.subCategories[index]['title']!,
                        onTap: () {
                          // Navigate to products screen or next level
                          print(
                            'Tapped: ${state.subCategories[index]['title']}',
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ProductListScreen(
                                subcategoryId:
                                    state.subCategories[index]['id']!,
                                subcategoryTitle:
                                    state.subCategories[index]['title']!,
                              ),
                            ),
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
