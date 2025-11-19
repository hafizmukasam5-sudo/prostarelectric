import 'package:flutter_bloc/flutter_bloc.dart';
import 'contact_us_event.dart';
import 'contact_us_state.dart';

class ContactUsBloc extends Bloc<ContactUsEvent, ContactUsState> {
  ContactUsBloc() : super(ContactUsInitial()) {
    on<LoadContactInfoEvent>(_onLoadContactInfo);
  }

  Future<void> _onLoadContactInfo(
    LoadContactInfoEvent event,
    Emitter<ContactUsState> emit,
  ) async {
    emit(ContactUsLoading());

    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 500));

    // Mock contact data
    emit(
      const ContactUsLoaded(
        phone: '123456789',
        email: 'debra.holt@example.com',
        address: 'Athens AL 35611',
        latitude: 34.8022, // Athens, Alabama coordinates
        longitude: -86.9714,
      ),
    );
  }
}
