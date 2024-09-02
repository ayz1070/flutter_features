import '../models/shipping_address.dart';
import '../repositories/shipping_address_repository.dart';

class ShippingAddressService {
  final ShippingAddressRepository repository;

  ShippingAddressService(this.repository);

  Future<void> saveShippingAddresses(List<ShippingAddress> addresses) async {
    await repository.saveShippingAddresses(addresses);
  }

  Future<List<ShippingAddress>> getShippingAddresses() async {
    return await repository.getShippingAddresses();
  }

  Future<void> addShippingAddress(ShippingAddress address) async {
    final currentAddresses = await repository.getShippingAddresses();
    currentAddresses.add(address);
    await repository.saveShippingAddresses(currentAddresses);
  }

  Future<void> removeShippingAddress(String id) async {
    final currentAddresses = await repository.getShippingAddresses();
    final updatedAddresses = currentAddresses.where((address) => address.id != id).toList();
    await repository.saveShippingAddresses(updatedAddresses);
  }
}