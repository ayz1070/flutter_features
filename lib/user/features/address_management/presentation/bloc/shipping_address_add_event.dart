import 'package:equatable/equatable.dart';

abstract class ShippingAddressAddEvent extends Equatable {
  const ShippingAddressAddEvent();

  @override
  List<Object?> get props => [];
}

class NameChanged extends ShippingAddressAddEvent {
  final String name;

  const NameChanged({required this.name});

  @override
  List<Object?> get props => [name];
}

class AddressNameChanged extends ShippingAddressAddEvent {
  final String addressName;

  const AddressNameChanged({required this.addressName});

  @override
  List<Object?> get props => [addressName];
}

class PhoneNumberChanged extends ShippingAddressAddEvent {
  final String phoneNumber;

  const PhoneNumberChanged({required this.phoneNumber});

  @override
  List<Object?> get props => [phoneNumber];
}

class AddressChanged extends ShippingAddressAddEvent {
  final String address;

  const AddressChanged({required this.address});

  @override
  List<Object?> get props => [address];
}

class AddressDetailChanged extends ShippingAddressAddEvent {
  final String addressDetail;

  const AddressDetailChanged({required this.addressDetail});

  @override
  List<Object?> get props => [addressDetail];
}

class IsDefaultAddressToggled extends ShippingAddressAddEvent {
  final bool isDefaultAddress;

  const IsDefaultAddressToggled({required this.isDefaultAddress});

  @override
  List<Object?> get props => [isDefaultAddress];
}

class FormSubmitted extends ShippingAddressAddEvent {
  final String id;

  const FormSubmitted({required this.id});

  @override
  List<Object?> get props => [id];
}