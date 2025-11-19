import 'package:flutter/material.dart';
import 'package:prostarelectrical/core/constants/app_colors.dart';

class MaterialListItem extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onTap;

  const MaterialListItem({
    Key? key,
    required this.image,
    required this.title,
    required this.description,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.only(bottom: 2),
        decoration: BoxDecoration(
          color: AppColors.textwhite,
          border:
              //Border(
              // bottom: BorderSide(color: AppColors.textPrimary, width: 1),
              //  ),
              Border.all(color: AppColors.primaryblue, width: 1),
        ),
        child: Row(
          children: [
            // Product Image
            Container(
              width: 100,
              height: 100,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                // color: Colors.green,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Image.asset(image, fit: BoxFit.contain),
            ),
            const SizedBox(width: 12),
            // Product Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    //maxLines: 2,
                    // overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textPrimary.withOpacity(0.6),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.green,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          onTap: onDecrement,
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            child: const Icon(
                              Icons.remove,
                              size: 24,
                              color: AppColors.primaryblue,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            '$quantity',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.primaryblue,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: onIncrement,
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            child: const Icon(
                              Icons.add,
                              size: 24,
                              color: AppColors.primaryblue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // const SizedBox(width: 12),
            // Quantity Controls
          ],
        ),
      ),
    );
  }
}
