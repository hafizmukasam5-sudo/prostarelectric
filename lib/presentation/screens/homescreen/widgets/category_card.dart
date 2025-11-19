import 'package:flutter/material.dart';
import 'package:prostarelectrical/core/constants/app_colors.dart';

class CategoryCard extends StatelessWidget {
  final String image;
  final String title;
  final VoidCallback onTap;

  const CategoryCard({
    Key? key,
    required this.image,
    required this.title,
    required this.onTap,
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
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(1),
                decoration: const BoxDecoration(
                  color: AppColors.textwhite,
                  // borderRadius: BorderRadius.only(
                  //   topLeft: Radius.circular(8),
                  //   topRight: Radius.circular(8),
                  // ),
                ),
                child: Image.asset(image, fit: BoxFit.contain),
              ),
            ),

            // Title section at bottom with grey background
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.textwhite,
                // borderRadius: const BorderRadius.only(
                //   bottomLeft: Radius.circular(8),
                //   bottomRight: Radius.circular(8),
                // ),
              ),
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
          ],
        ),
      ),
    );
  }
}
