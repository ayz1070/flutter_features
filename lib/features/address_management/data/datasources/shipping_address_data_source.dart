import '../models/shipping_address_model.dart';

abstract class ShippingAddressDataSource {
  Future<void> saveShippingAddress(ShippingAddressModel address); // 개별 주소 저장
  Future<List<ShippingAddressModel>> getShippingAddresses();
  Future<void> deleteShippingAddress(String addressId);
  Future<void> updateShippingAddress(ShippingAddressModel address);
}