// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:prostarelectrical/core/widgets/custom_appbar.dart';
// import 'package:prostarelectrical/presentation/screens/contactscreen/bloc/contact_us_bloc.dart';
// import 'package:prostarelectrical/presentation/screens/contactscreen/bloc/contact_us_event.dart';
// import 'package:prostarelectrical/presentation/screens/contactscreen/bloc/contact_us_state.dart';
// // import 'package:url_launcher/url_launcher.dart';
// import '../../../../core/constants/app_colors.dart';
// import '../../../../core/constants/app_images.dart';

// class ContactUsScreen extends StatelessWidget {
//   const ContactUsScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => ContactUsBloc()..add(LoadContactInfoEvent()),
//       child: const ContactUsView(),
//     );
//   }
// }

// class ContactUsView extends StatelessWidget {
//   const ContactUsView({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.textwhite,
//       appBar: CustomAppBar(
//         title: 'Contact Us',
//         centerTitle: true,
//         leadingImage: AppImages.backarrow,
//         onLeadingPressed: () => Navigator.pop(context),
//       ),
//       body: BlocBuilder<ContactUsBloc, ContactUsState>(
//         builder: (context, state) {
//           if (state is ContactUsLoading) {
//             return const Center(
//               child: CircularProgressIndicator(color: AppColors.primaryblue),
//             );
//           }

//           if (state is ContactUsError) {
//             return Center(
//               child: Text(
//                 state.message,
//                 style: const TextStyle(color: AppColors.red),
//               ),
//             );
//           }

//           if (state is ContactUsLoaded) {
//             return SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   const SizedBox(height: 20),

//                   // Our Contact Information Title
//                   const Text(
//                     'Our Contact Information',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.w600,
//                       color: AppColors.textPrimary,
//                     ),
//                   ),

//                   const SizedBox(height: 20),

//                   // Phone Number Box
//                   Container(
//                     margin: const EdgeInsets.symmetric(horizontal: 20),
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 16,
//                       vertical: 14,
//                     ),
//                     decoration: BoxDecoration(
//                       color: AppColors.textwhite,
//                       borderRadius: BorderRadius.circular(8),
//                       border: Border.all(
//                         color: AppColors.bordergrey.withOpacity(0.5),
//                       ),
//                     ),
//                     child: Row(
//                       children: [
//                         const Icon(
//                           Icons.phone_outlined,
//                           size: 24,
//                           color: AppColors.textPrimary,
//                         ),
//                         const SizedBox(width: 12),
//                         Expanded(
//                           child: Text(
//                             state.phone,
//                             style: const TextStyle(
//                               fontSize: 16,
//                               color: AppColors.textPrimary,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),

//                   const SizedBox(height: 12),

//                   // Email Box
//                   Container(
//                     margin: const EdgeInsets.symmetric(horizontal: 20),
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 16,
//                       vertical: 14,
//                     ),
//                     decoration: BoxDecoration(
//                       color: AppColors.textwhite,
//                       borderRadius: BorderRadius.circular(8),
//                       border: Border.all(
//                         color: AppColors.bordergrey.withOpacity(0.5),
//                       ),
//                     ),
//                     child: Row(
//                       children: [
//                         const Icon(
//                           Icons.email_outlined,
//                           size: 24,
//                           color: AppColors.textPrimary,
//                         ),
//                         const SizedBox(width: 12),
//                         Expanded(
//                           child: Text(
//                             state.email,
//                             style: const TextStyle(
//                               fontSize: 16,
//                               color: AppColors.textPrimary,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),

//                   const SizedBox(height: 20),

//                   // Social Media Icons
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       InkWell(
//                         onTap: () => _launchURL('https://instagram.com'),
//                         child: Image.asset(
//                           AppImages.apple,
//                           width: 48,
//                           height: 48,
//                         ),
//                       ),
//                       const SizedBox(width: 20),
//                       InkWell(
//                         onTap: () => _launchURL('https://facebook.com'),
//                         child: Image.asset(
//                           AppImages.google,
//                           width: 48,
//                           height: 48,
//                         ),
//                       ),
//                     ],
//                   ),

//                   const SizedBox(height: 30),

//                   // Our Location Title
//                   const Text(
//                     'Our Location',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.w600,
//                       color: AppColors.textPrimary,
//                     ),
//                   ),

//                   const SizedBox(height: 20),

//                   // Google Map
//                   Container(
//                     margin: const EdgeInsets.symmetric(horizontal: 0),
//                     height: 300,
//                     child: GoogleMap(
//                       initialCameraPosition: CameraPosition(
//                         target: LatLng(state.latitude, state.longitude),
//                         zoom: 14.0,
//                       ),
//                       markers: {
//                         Marker(
//                           markerId: const MarkerId('office_location'),
//                           position: LatLng(state.latitude, state.longitude),
//                           infoWindow: InfoWindow(
//                             title: 'Prostar Electrical',
//                             snippet: state.address,
//                           ),
//                         ),
//                       },
//                       zoomControlsEnabled: true,
//                       myLocationButtonEnabled: false,
//                       mapToolbarEnabled: false,
//                     ),
//                   ),

//                   const SizedBox(height: 20),
//                 ],
//               ),
//             );
//           }

//           return const SizedBox();
//         },
//       ),
//     );
//   }

//   Future<void> _launchURL(String url) async {
//     final Uri uri = Uri.parse(url);
//     // if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
//     //   throw Exception('Could not launch $url');
//     // }
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prostarelectrical/core/widgets/custom_appbar.dart';
import 'package:prostarelectrical/presentation/screens/contactscreen/bloc/contact_us_bloc.dart';
import 'package:prostarelectrical/presentation/screens/contactscreen/bloc/contact_us_event.dart';
import 'package:prostarelectrical/presentation/screens/contactscreen/bloc/contact_us_state.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_images.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContactUsBloc()..add(LoadContactInfoEvent()),
      child: const ContactUsView(),
    );
  }
}

class ContactUsView extends StatelessWidget {
  const ContactUsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: CustomAppBar(
        title: 'Contact Us',
        centerTitle: true,
        leadingImage: AppImages.backarrow,
        onLeadingPressed: () => Navigator.pop(context),
      ),
      body: BlocBuilder<ContactUsBloc, ContactUsState>(
        builder: (context, state) {
          if (state is ContactUsLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primaryblue),
            );
          }

          if (state is ContactUsError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: AppColors.red),
              ),
            );
          }

          if (state is ContactUsLoaded) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),

                  // Our Contact Information Title
                  const Text(
                    'Our Contact Information',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Phone Number Box
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.textwhite,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: AppColors.bordergrey.withOpacity(0.5),
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.phone_outlined,
                          size: 24,
                          color: AppColors.textPrimary,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            state.phone,
                            style: const TextStyle(
                              fontSize: 16,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Email Box
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.textwhite,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: AppColors.bordergrey.withOpacity(0.5),
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.email_outlined,
                          size: 24,
                          color: AppColors.textPrimary,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            state.email,
                            style: const TextStyle(
                              fontSize: 16,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Social Media Icons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () => _launchURL('https://instagram.com'),
                        child: Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: Colors.pink.shade100,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            color: Colors.pink,
                            size: 28,
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      InkWell(
                        onTap: () => _launchURL('https://facebook.com'),
                        child: Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: Colors.blue.shade100,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.facebook,
                            color: Colors.blue,
                            size: 32,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  // Our Location Title
                  const Text(
                    'Our Location',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Map Placeholder with Address
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 0),
                    height: 300,
                    child: Stack(
                      children: [
                        // Static map placeholder - you can use a screenshot or placeholder image
                        Container(
                          width: double.infinity,
                          height: 300,
                          color: Colors.grey.shade200,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.location_on,
                                  size: 60,
                                  color: AppColors.bordergrey,
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  'Map will be shown here',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: AppColors.textPrimary.withOpacity(
                                      0.6,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Address Label
                        Positioned(
                          top: 20,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.secondarygrey,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Text(
                                state.address,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textwhite,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    // if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
    //   throw Exception('Could not launch $url');
    // }
  }
}
