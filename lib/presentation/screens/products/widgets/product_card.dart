import 'package:flutter/material.dart';
import 'package:prostarelectrical/core/constants/app_colors.dart';
import 'package:prostarelectrical/core/constants/app_images.dart';

class ProductCard extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final bool isFavorite;
  final VoidCallback onTap;
  final VoidCallback onFavoritePressed;

  const ProductCard({
    Key? key,
    required this.image,
    required this.title,
    required this.description,
    required this.isFavorite,
    required this.onTap,
    required this.onFavoritePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.textwhite,
          borderRadius: BorderRadius.circular(0),
          border: Border.all(color: AppColors.primaryblue, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            // Image section - takes most of the space
            Expanded(
              flex: 8,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(1),
                    decoration: const BoxDecoration(color: AppColors.textwhite),
                    child: Image.asset(image, fit: BoxFit.contain),
                  ),
                  // Heart icon positioned at top right
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: onFavoritePressed,
                      child:
                          //  Image.asset(
                          //   isFavorite ? AppImages.favselected : AppImages.fav,
                          //   width: 24,
                          //   height: 24,
                          //   fit: BoxFit.contain,
                          //   color: isFavorite ? AppColors.red : null,
                          // ),
                          Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? AppColors.red : null,
                          ),
                    ),
                  ),
                ],
              ),
            ),

            // Title section at bottom with grey background
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              decoration: BoxDecoration(color: AppColors.textwhite),
              child: Text(
                title,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textPrimary,
                  height: 1.3,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              decoration: BoxDecoration(color: AppColors.textwhite),
              child: Text(
                description,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textPrimary,
                  height: 1.3,
                ),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
