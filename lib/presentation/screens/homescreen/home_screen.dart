import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:prostarelectrical/presentation/screens/homescreen/bloc/home_bloc.dart';
import 'package:prostarelectrical/presentation/screens/homescreen/bloc/home_event.dart';
import 'package:prostarelectrical/presentation/screens/homescreen/bloc/home_state.dart';
import 'package:prostarelectrical/presentation/screens/homescreen/widgets/category_card.dart';
import 'package:prostarelectrical/presentation/screens/homescreen/widgets/custom_dots_indicator.dart';
import 'package:prostarelectrical/presentation/screens/homescreen/widgets/feature_product_carrd.dart';
import 'package:prostarelectrical/presentation/screens/profile/profile_screen.dart';
import 'package:prostarelectrical/presentation/screens/subcategories/subcategory_screen.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_images.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc()..add(LoadHomeDataEvent()),
      child: const HomeTabView(),
    );
  }
}

class HomeTabView extends StatelessWidget {
  const HomeTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final carouselController = CarouselSliderController();

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primaryblue),
            );
          }

          if (state is HomeLoaded) {
            return SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top Header Section with White Background
                    Container(
                      color: AppColors.textwhite,
                      child: Column(
                        children: [
                          // Logo and User Icon Row
                          Padding(
                            // padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                            padding: EdgeInsets.only(
                              left: 0,
                              right: 20,
                              top: 20,
                              bottom: 16,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Logo/Star Icon
                                // Image.asset(
                                //   AppImages.splashimage,
                                //   height: 73,
                                //   width: 75,
                                //   fit: BoxFit.cover,
                                // ),
                                SizedBox(
                                  height: 70,
                                  width: 140,
                                  child: Image.asset(
                                    AppImages.splashimage,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                // User Icon
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => ProfileScreen(),
                                      ),
                                    );
                                  },
                                  child: Image.asset(
                                    AppImages.user,
                                    height: 30,
                                    width: 30,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Company Name
                          Column(
                            children: [
                              Text(
                                'P R O S T A R',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.primaryblue,
                                  letterSpacing: 7,
                                  height: 1.3,
                                  fontFamily: 'Bevietnam',
                                ),
                              ),
                              const SizedBox(height: 23),
                              Text(
                                'E L E C T R I C A L',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.primaryblue,
                                  letterSpacing: 4,
                                  height: 1.3,
                                  fontFamily: 'Bevietnam',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Featured Products Carousel
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 8),
                    //   child: CarouselSlider.builder(
                    //     carouselController: carouselController,
                    //     itemCount: state.featuredProducts.length,
                    //     itemBuilder: (context, index, realIndex) {
                    //       return Padding(
                    //         padding: const EdgeInsets.symmetric(horizontal: 10),
                    //         child: FeaturedProductCard(
                    //           image: state.featuredProducts[index]['image']!,
                    //           title: state.featuredProducts[index]['title']!,
                    //           onTap: () {
                    //             // Navigate to product detail
                    //           },
                    //         ),
                    //       );
                    //     },
                    //     options: CarouselOptions(
                    //       height: 155,
                    //       viewportFraction: 0.75,
                    //       enlargeCenterPage: false,
                    //       enableInfiniteScroll: false,
                    //       autoPlay: false,
                    //       autoPlayInterval: const Duration(seconds: 3),
                    //       autoPlayAnimationDuration: const Duration(
                    //         milliseconds: 800,
                    //       ),
                    //       autoPlayCurve: Curves.fastOutSlowIn,
                    //       onPageChanged: (index, reason) {
                    //         context.read<HomeBloc>().add(
                    //           ChangeCarouselIndexEvent(index),
                    //         );
                    //       },
                    //     ),
                    //   ),
                    // ),
                    CarouselSlider.builder(
                      carouselController: carouselController,
                      itemCount: state.featuredProducts.length,
                      itemBuilder: (context, index, realIndex) {
                        return Padding(
                          padding: const EdgeInsets.only(
                            //right: 12,
                            left: 16,
                          ), // Space between items
                          child: FeaturedProductCard(
                            image: state.featuredProducts[index]['image']!,
                            title: state.featuredProducts[index]['title']!,
                            onTap: () {
                              // Navigate to product detail
                            },
                          ),
                        );
                      },
                      options: CarouselOptions(
                        height: 155,
                        viewportFraction: 0.75,
                        enlargeCenterPage: false,
                        enableInfiniteScroll: false,
                        autoPlay: false,
                        padEnds: false, // Removes left padding
                        autoPlayInterval: const Duration(seconds: 3),
                        autoPlayAnimationDuration: const Duration(
                          milliseconds: 800,
                        ),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        onPageChanged: (index, reason) {
                          context.read<HomeBloc>().add(
                            ChangeCarouselIndexEvent(index),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 15),

                    // Custom Dots Indicator
                    CustomDotsIndicator(
                      itemCount: state.featuredProducts.length,
                      currentIndex: state.carouselIndex,
                    ),

                    const SizedBox(height: 15),

                    // Carousel Navigation Arrows
                    Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              carouselController.previousPage();
                            },
                            child: Container(
                              padding: const EdgeInsets.all(0),
                              child: Image.asset(
                                AppImages.arrowprevious,
                                height: 24,
                                width: 20,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          InkWell(
                            onTap: () {
                              carouselController.nextPage();
                            },
                            child: Container(
                              padding: const EdgeInsets.all(0),
                              child: Image.asset(
                                AppImages.arrownext,
                                height: 24,
                                width: 20,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Categories Section
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Categories Header
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: const Text(
                            'Categories',
                            style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textSeconday,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Categories Grid - 2 columns
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
                          itemCount: state.categories.length,
                          itemBuilder: (context, index) {
                            return CategoryCard(
                              image: state.categories[index]['image']!,
                              title: state.categories[index]['title']!,
                              onTap: () {
                                // Navigate to category detail
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => SubCategoriesScreen(
                                      categoryId: (index + 1).toString(),
                                      categoryTitle:
                                          state.categories[index]['title']!,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
