import '../entities/shipping_address.dart';

abstract class ShippingAddressRepository {
  Future<void> saveShippingAddresses(List<ShippingAddress> addresses);
  Future<List<ShippingAddress>> getShippingAddresses();
  Future<void> updateShippingAddress(ShippingAddress address);
  Future<void> deleteShippingAddress(String addressId);
}