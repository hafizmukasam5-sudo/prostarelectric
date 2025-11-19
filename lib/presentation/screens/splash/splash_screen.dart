import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prostarelectrical/core/constants/app_colors.dart';
import 'package:prostarelectrical/core/constants/app_images.dart';
import 'package:prostarelectrical/presentation/screens/auth/bloc/auth_bloc.dart';
import 'package:prostarelectrical/presentation/screens/auth/login/login_screen.dart';
import 'bloc/splash_bloc.dart';
import 'bloc/splash_state.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state is SplashNavigateToHome) {
          // Navigator.of(context).pushReplacement(
          //   MaterialPageRoute(builder: (_) => const HomeScreen()),
          // );
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => AuthBloc(),
                child: const LoginScreen(),
              ),
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white, // Change to your preferred color
        body: BlocBuilder<SplashBloc, SplashState>(
          builder: (context, state) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Your logo/image here
                  Image.asset(
                    AppImages.splashimage, // Your image path
                    // width: 200,
                    // height: 200,
                    fit: BoxFit.contain,
                  ),
                  // const SizedBox(height: 30),

                  // if (state is SplashLoading)
                  //   const CircularProgressIndicator(
                  //     valueColor: AlwaysStoppedAnimation<Color>(
                  //       AppColors.primaryblue,
                  //     ),
                  //   ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
