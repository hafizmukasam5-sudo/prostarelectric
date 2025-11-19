import 'package:flutter/material.dart';
import 'package:prostarelectrical/core/constants/app_colors.dart';

class CustomDotsIndicator extends StatelessWidget {
  final int itemCount;
  final int currentIndex;

  const CustomDotsIndicator({
    Key? key,
    required this.itemCount,
    required this.currentIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        itemCount,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          height: 9,
          width: currentIndex == index ? 8 : 8,
          decoration: BoxDecoration(
            color: currentIndex == index
                ? AppColors.primaryblue
                : AppColors.bordergrey,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}
