import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prostarelectrical/core/constants/app_colors.dart';
import 'package:prostarelectrical/presentation/screens/splash/bloc/splash_bloc.dart';
import 'package:prostarelectrical/presentation/screens/splash/bloc/splash_event.dart';
import 'package:prostarelectrical/presentation/screens/splash/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pro Star Electrical',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryblue),
        useMaterial3: true,
      ),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.linear(1.0), // Prevent text scaling
          ),
          child: SafeArea(top: false, bottom: true, child: child!),
        );
      },
      home: BlocProvider(
        create: (context) => SplashBloc()..add(StartSplashEvent()),
        child: const SplashScreen(),
      ),
    );
  }
}
