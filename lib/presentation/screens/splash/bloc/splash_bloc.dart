import 'package:flutter_bloc/flutter_bloc.dart';
import 'splash_event.dart';
import 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<StartSplashEvent>(_onStartSplash);
    on<NavigateToHomeEvent>(_onNavigateToHome);
  }

  Future<void> _onStartSplash(
    StartSplashEvent event,
    Emitter<SplashState> emit,
  ) async {
    emit(SplashLoading());

    // Simulate loading time (check authentication, load data, etc.)
    await Future.delayed(const Duration(seconds: 3));

    emit(SplashLoaded());

    // Auto navigate after loading
    add(NavigateToHomeEvent());
  }

  Future<void> _onNavigateToHome(
    NavigateToHomeEvent event,
    Emitter<SplashState> emit,
  ) async {
    emit(SplashNavigateToHome());
  }
}
