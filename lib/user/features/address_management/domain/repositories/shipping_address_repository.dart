import '../models/shipping_address.dart';

abstract class ShippingAddressRepository{
  Future<void> saveShippingAddresses(List<ShippingAddress> addresses);
  Future<List<ShippingAddress>> getShippingAddresses();
}