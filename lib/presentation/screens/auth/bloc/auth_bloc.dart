import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginWithEmailEvent>(_onLoginWithEmail);
    on<SignupEvent>(_onSignup);
    on<LoginWithGoogleEvent>(_onLoginWithGoogle);
    on<LoginWithAppleEvent>(_onLoginWithApple);
    on<ForgotPasswordEvent>(_onForgotPassword);
    on<ChangePasswordEvent>(_onChangePassword);
  }

  Future<void> _onLoginWithEmail(
    LoginWithEmailEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // Add your authentication logic here
      if (event.email.isEmpty || event.password.isEmpty) {
        emit(const AuthError(error: 'Please fill all fields'));
        return;
      }

      emit(const AuthSuccess(message: 'Login successful'));
    } catch (e) {
      emit(AuthError(error: e.toString()));
    }
  }

  Future<void> _onSignup(SignupEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      await Future.delayed(const Duration(seconds: 2));

      // Add your signup logic here
      if (event.email.isEmpty || event.password.isEmpty || event.name.isEmpty) {
        emit(const AuthError(error: 'Please fill all fields'));
        return;
      }

      emit(const AuthSuccess(message: 'Signup successful'));
    } catch (e) {
      emit(AuthError(error: e.toString()));
    }
  }

  Future<void> _onForgotPassword(
    ForgotPasswordEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      await Future.delayed(const Duration(seconds: 2));

      // Add your forgot password logic here (send reset email)
      if (event.email.isEmpty) {
        emit(const AuthError(error: 'Please enter email'));
        return;
      }

      emit(
        const AuthSuccess(message: 'Password reset link sent to your email'),
      );
    } catch (e) {
      emit(AuthError(error: e.toString()));
    }
  }

  Future<void> _onLoginWithGoogle(
    LoginWithGoogleEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      await Future.delayed(const Duration(seconds: 2));
      emit(const AuthSuccess(message: 'Google login successful'));
    } catch (e) {
      emit(AuthError(error: e.toString()));
    }
  }

  Future<void> _onLoginWithApple(
    LoginWithAppleEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      await Future.delayed(const Duration(seconds: 2));
      emit(const AuthSuccess(message: 'Apple login successful'));
    } catch (e) {
      emit(AuthError(error: e.toString()));
    }
  }

  Future<void> _onChangePassword(
    ChangePasswordEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      await Future.delayed(const Duration(seconds: 2));

      // Add your change password logic here
      if (event.currentPassword.isEmpty || event.newPassword.isEmpty) {
        emit(const AuthError(error: 'Please fill all fields'));
        return;
      }

      emit(const AuthSuccess(message: 'Password changed successfully'));
    } catch (e) {
      emit(AuthError(error: e.toString()));
    }
  }
}
