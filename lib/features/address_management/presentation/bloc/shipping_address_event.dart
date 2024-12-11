import '../../domain/entities/shipping_address.dart';

abstract class ShippingAddressEvent {}

class LoadShippingAddressesEvent extends ShippingAddressEvent {}

class AddShippingAddressEvent extends ShippingAddressEvent {
  final ShippingAddress address;
  AddShippingAddressEvent(this.address);
}

class RemoveShippingAddressEvent extends ShippingAddressEvent {
  final String id;
  RemoveShippingAddressEvent(this.id);
}

class UpdateShippingAddressEvent extends ShippingAddressEvent {
  final ShippingAddress address;
  UpdateShippingAddressEvent(this.address);
}