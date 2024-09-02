import '../../domain/models/shipping_address.dart';
import '../../domain/repositories/shipping_address_repository.dart';
import '../datasources/shipping_address_local_data_source.dart';

class ShippingAddressRepositoryImpl implements ShippingAddressRepository {
  final ShippingAddressLocalDataSource localDataSource;

  ShippingAddressRepositoryImpl(this.localDataSource);

  @override
  Future<void> saveShippingAddresses(List<ShippingAddress> addresses) async {
    final entities = addresses.map((address) => address.toEntity()).toList();
    await localDataSource.saveShippingAddress(entities);
  }

  @override
  Future<List<ShippingAddress>> getShippingAddresses() async {
    final entities = await localDataSource.getShippingAddresses();
    return entities.map((entity) => ShippingAddress.fromEntity(entity)).toList();
  }
}