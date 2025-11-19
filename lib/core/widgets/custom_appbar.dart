import 'package:flutter/material.dart';
import 'package:prostarelectrical/core/constants/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final String? leadingImage;
  final IconData? leadingIcon;
  final VoidCallback? onLeadingPressed;
  final List<Widget>? actions;
  final bool centerTitle;
  final Color? backgroundColor;

  const CustomAppBar({
    Key? key,
    this.title,
    this.leadingImage,
    this.leadingIcon,
    this.onLeadingPressed,
    this.actions,
    this.centerTitle = false,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? AppColors.textwhite,
      elevation: 0,
      centerTitle: centerTitle,
      title: title != null
          ? Text(
              title!,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            )
          : null,
      leading: leadingImage != null
          ? IconButton(
              icon: Image.asset(
                leadingImage!,
                width: 24,
                height: 24,
                fit: BoxFit.contain,
              ),
              onPressed: onLeadingPressed ?? () => Navigator.pop(context),
            )
          : leadingIcon != null
          ? IconButton(
              icon: Icon(leadingIcon, color: AppColors.textPrimary),
              onPressed: onLeadingPressed ?? () => Navigator.pop(context),
            )
          : null,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
