import '../../domain/models/shipping_address.dart';

class ShippingAddressEntity {
  final String id;
  final String name;
  final String? addressName;
  final String phoneNumber;
  final String address;
  final int isDefaultAddress; // 1이면 기본 배송지, 0이면 기본 배송지가 아님

  ShippingAddressEntity({
    required this.id,
    required this.name,
    this.addressName,
    required this.phoneNumber,
    required this.address,
    required this.isDefaultAddress,
  });

  // 엔티티에서 모델로 변환하는 메서드
  ShippingAddress toModel() {
    return ShippingAddress(
      id: id,
      name: name,
      addressName: addressName,
      phoneNumber: phoneNumber,
      address: address,
      isDefaultAddress: isDefaultAddress == 1, // int를 Boolean으로 변환
    );
  }

  // 데이터베이스에서 가져온 Map을 엔티티로 변환하는 메서드
  factory ShippingAddressEntity.fromMap(Map<String, dynamic> map) {
    return ShippingAddressEntity(
      id: map['id'],
      name: map['name'],
      addressName: map['addressName'],
      phoneNumber: map['phoneNumber'],
      address: map['address'],
      isDefaultAddress: map['isDefaultAddress'],
    );
  }

  // 엔티티를 데이터베이스에 저장할 Map으로 변환하는 메서드
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'addressName': addressName,
      'phoneNumber': phoneNumber,
      'address': address,
      'isDefaultAddress': isDefaultAddress,
    };
  }
}