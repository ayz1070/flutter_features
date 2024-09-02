import '../models/shipping_address.dart';
import '../repositories/shipping_address_repository.dart';

class SaveShippingAddresses {
  final ShippingAddressRepository repository;

  SaveShippingAddresses(this.repository);

  Future<void> call(List<ShippingAddress> addresses) async {
    await repository.saveShippingAddresses(addresses);
  }
}



class GetShippingAddresses {
  final ShippingAddressRepository repository;

  GetShippingAddresses(this.repository);

  Future<List<ShippingAddress>> call() async {
    return await repository.getShippingAddresses();
  }
}