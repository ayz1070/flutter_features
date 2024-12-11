import '../../domain/entities/shipping_address.dart';
import '../../domain/repositories/shipping_address_repository.dart';
import '../datasources/shipping_address_data_source.dart';
import '../mapper/shipping_address_mapper.dart';

class ShippingAddressRepositoryImpl implements ShippingAddressRepository {
  final ShippingAddressDataSource firebaseDataSource; // Firebase 데이터 소스 사용

  ShippingAddressRepositoryImpl(this.firebaseDataSource);

  // 개별 배송지 저장
  @override
  Future<void> saveShippingAddresses(List<ShippingAddress> addresses) async {
    for (var address in addresses) {
      // 도메인 엔티티를 데이터 모델로 변환
      final model = ShippingAddressMapper.toModel(address);

      // Firebase에서 중복 확인 후 저장
      final existingAddresses = await firebaseDataSource.getShippingAddresses();
      final isDuplicate = existingAddresses.any((existingModel) => existingModel.id == model.id);

      if (!isDuplicate) {
        await firebaseDataSource.saveShippingAddress(model);
      } else {
        print('Address with id ${model.id} is already saved.');
      }
    }
  }

  // 모든 배송지 불러오기
  @override
  Future<List<ShippingAddress>> getShippingAddresses() async {
    final models = await firebaseDataSource.getShippingAddresses();
    return models.map((model) => ShippingAddressMapper.toEntity(model)).toList();
  }

  @override
  Future<void> deleteShippingAddress(String addressId) async{
    await firebaseDataSource.deleteShippingAddress(addressId);
  }

  @override
  Future<void> updateShippingAddress(ShippingAddress address) async{
    final model = ShippingAddressMapper.toModel(address);

    await firebaseDataSource.updateShippingAddress(model);

  }
}