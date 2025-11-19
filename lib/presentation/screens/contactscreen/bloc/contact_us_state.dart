import 'package:equatable/equatable.dart';

abstract class ContactUsState extends Equatable {
  const ContactUsState();

  @override
  List<Object> get props => [];
}

class ContactUsInitial extends ContactUsState {}

class ContactUsLoading extends ContactUsState {}

class ContactUsLoaded extends ContactUsState {
  final String phone;
  final String email;
  final String address;
  final double latitude;
  final double longitude;

  const ContactUsLoaded({
    required this.phone,
    required this.email,
    required this.address,
    required this.latitude,
    required this.longitude,
  });

  @override
  List<Object> get props => [phone, email, address, latitude, longitude];
}

class ContactUsError extends ContactUsState {
  final String message;

  const ContactUsError(this.message);

  @override
  List<Object> get props => [message];
}
