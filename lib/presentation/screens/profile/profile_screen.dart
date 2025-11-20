import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:prostarelectrical/core/widgets/custom_appbar.dart';
import 'package:prostarelectrical/presentation/screens/auth/bloc/auth_bloc.dart';
import 'package:prostarelectrical/presentation/screens/auth/changepassword/change_password_screen.dart';
import 'package:prostarelectrical/presentation/screens/auth/editprofile/edit_profile_screen.dart';
import 'package:prostarelectrical/presentation/screens/contactscreen/contactus_screen.dart';
import 'package:prostarelectrical/presentation/screens/profile/bloc/profile_bloc.dart';
import 'package:prostarelectrical/presentation/screens/profile/bloc/profile_event..dart';
import 'package:prostarelectrical/presentation/screens/profile/bloc/profile_state.dart';
import 'package:prostarelectrical/presentation/screens/profile/widgtes/profile_menu_item.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_images.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc()..add(LoadProfileEvent()),
      child: const ProfileView(),
    );
  }
}

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.textwhite,
      appBar: CustomAppBar(
        title: "My Profile",
        centerTitle: true,
        leadingImage: AppImages.backarrow,
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primaryblue),
            );
          }

          if (state is ProfileError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: AppColors.red),
              ),
            );
          }

          if (state is ProfileLoaded) {
            return SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // const SizedBox(height: 20),
                    // // My Profile Title
                    // const Text(
                    //   'My Profile',
                    //   style: TextStyle(
                    //     fontSize: 20,
                    //     fontWeight: FontWeight.w600,
                    //     color: AppColors.textPrimary,
                    //   ),
                    // ),
                    const SizedBox(height: 20),
                    // Profile Image with CachedNetworkImage and Shimmer
                    CachedNetworkImage(
                      imageUrl: state.profileImageUrl,
                      imageBuilder: (context, imageProvider) => Container(
                        width: 125,
                        height: 125,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      placeholder: (context, url) => Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          width: 125,
                          height: 125,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        width: 125,
                        height: 125,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[300],
                        ),
                        child: const Icon(
                          Icons.person,
                          size: 60,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // User Name
                    Text(
                      state.name,
                      style: const TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 30),
                    // Menu Items Container
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: AppColors.textwhite,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          ProfileMenuItem(
                            icon: AppImages.editIcon,
                            title: 'Edit Profile',
                            onTap: () {
                              // Navigate to Edit Profile
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => EditProfileScreen(),
                                ),
                              );
                            },
                          ),
                          ProfileMenuItem(
                            icon: AppImages.quotationIcon,
                            title: 'MY QUOTATIONS',
                            onTap: () {
                              // Navigate to Quotations
                            },
                          ),
                          ProfileMenuItem(
                            icon: AppImages.lockIcon,
                            title: 'Change Password',
                            onTap: () {
                              // Navigate to Change Password
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (_) => ChangePasswordScreen(),
                              //   ),
                              // );
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => BlocProvider(
                                    create: (_) => AuthBloc(),
                                    child: const ChangePasswordScreen(),
                                  ),
                                ),
                              );
                            },
                          ),
                          ProfileMenuItem(
                            icon: AppImages.settingsIcon,
                            title: 'Settings',
                            onTap: () {
                              // Navigate to Settings
                            },
                          ),
                          ProfileMenuItem(
                            icon: AppImages.infoIcon,
                            title: 'About Prostar Electrical',
                            onTap: () {
                              // Navigate to About
                            },
                          ),
                          ProfileMenuItem(
                            icon: AppImages.termsIcon,
                            title: 'Terms & Conditions',
                            onTap: () {
                              // Navigate to Terms
                            },
                          ),
                          ProfileMenuItem(
                            icon: AppImages.deleteIcon,
                            title: 'Delete Account',
                            onTap: () {
                              // Show delete confirmation
                            },
                          ),
                          ProfileMenuItem(
                            icon: AppImages.contactIcon,
                            title: 'Contact Us',
                            onTap: () {
                              // Navigate to Contact
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ContactUsScreen(),
                                ),
                              );
                            },
                          ),
                          ProfileMenuItem(
                            icon: AppImages.logoutIcon,
                            title: 'Logout',
                            //  showDivider: false,
                            onTap: () {
                              // Show logout confirmation
                              _showLogoutDialog(context);
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
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

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                context.read<ProfileBloc>().add(LogoutEvent());
                // Navigate to login
              },
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }
}
