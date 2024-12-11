import '../../domain/entities/shipping_address.dart';

abstract class ShippingAddressState {}

class ShippingAddressInitial extends ShippingAddressState {}

class ShippingAddressLoading extends ShippingAddressState {}

class ShippingAddressLoaded extends ShippingAddressState {
  final List<ShippingAddress> addresses;
  ShippingAddressLoaded(this.addresses);
}

class ShippingAddressError extends ShippingAddressState {
  final String message;
  ShippingAddressError(this.message);
}
