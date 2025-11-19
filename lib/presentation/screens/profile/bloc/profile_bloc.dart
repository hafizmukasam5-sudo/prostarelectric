import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prostarelectrical/presentation/screens/profile/bloc/profile_event..dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<LoadProfileEvent>(_onLoadProfile);
    on<LogoutEvent>(_onLogout);
  }

  Future<void> _onLoadProfile(
    LoadProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());

    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 500));

    // Mock profile data
    emit(
      const ProfileLoaded(
        name: 'Darlene Robertson',
        profileImageUrl: 'https://randomuser.me/api/portraits/men/32.jpg',
      ),
    );
  }

  Future<void> _onLogout(LogoutEvent event, Emitter<ProfileState> emit) async {
    // Handle logout logic
  }
}
