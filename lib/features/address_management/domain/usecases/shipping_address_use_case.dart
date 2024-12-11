import '../entities/shipping_address.dart';
import '../repositories/shipping_address_repository.dart';

class ShippingAddressUseCases {
  final AddShippingAddressUseCase addShippingAddressUseCase;
  final GetShippingAddressesUseCase getShippingAddressesUseCase;
  final RemoveShippingAddressUseCase removeShippingAddressUseCase;
  final SaveShippingAddressesUseCase saveShippingAddressesUseCase;
  final UpdateShippingAddressUseCase updateShippingAddressUseCase; // 추가

  ShippingAddressUseCases(ShippingAddressRepository repository)
      : addShippingAddressUseCase = AddShippingAddressUseCase(repository),
        getShippingAddressesUseCase = GetShippingAddressesUseCase(repository),
        removeShippingAddressUseCase = RemoveShippingAddressUseCase(repository),
        saveShippingAddressesUseCase = SaveShippingAddressesUseCase(repository),
        updateShippingAddressUseCase = UpdateShippingAddressUseCase(repository); // 초기화 추가
}

class SaveShippingAddressesUseCase {
  final ShippingAddressRepository repository;

  SaveShippingAddressesUseCase(this.repository);

  Future<void> call(List<ShippingAddress> addresses) async {
    await repository.saveShippingAddresses(addresses);
  }
}

class GetShippingAddressesUseCase {
  final ShippingAddressRepository repository;

  GetShippingAddressesUseCase(this.repository);

  Future<List<ShippingAddress>> call() async {
    final addresses = await repository.getShippingAddresses();

    // 기본 배송지를 최상단에 배치하고, 나머지는 createdAt을 기준으로 최근 순으로 정렬
    addresses.sort((a, b) {
      // 기본 배송지는 최상단에 배치
      if (a.isDefaultAddress && !b.isDefaultAddress) return -1;
      if (!a.isDefaultAddress && b.isDefaultAddress) return 1;

      // 기본 배송지가 아닌 경우 createdAt으로 최근 순 정렬
      return b.createdAt.compareTo(a.createdAt);
    });

    return addresses;
  }
}

class AddShippingAddressUseCase {
  final ShippingAddressRepository repository;

  AddShippingAddressUseCase(this.repository);

  Future<void> call(ShippingAddress address) async {
    final currentAddresses = await repository.getShippingAddresses();
    currentAddresses.add(address);
    await repository.saveShippingAddresses(currentAddresses);
  }
}


class RemoveShippingAddressUseCase {
  final ShippingAddressRepository repository;

  RemoveShippingAddressUseCase(this.repository);

  Future<void> call(String addressId) async {
    await repository.deleteShippingAddress(addressId);
  }
}

class UpdateShippingAddressUseCase {
  final ShippingAddressRepository repository;

  UpdateShippingAddressUseCase(this.repository);

  Future<void> call(ShippingAddress updatedAddress) async {
    // 개별 주소 수정
    await repository.updateShippingAddress(updatedAddress);
  }
}