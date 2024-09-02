import '../../data/entities/shipping_address_entity.dart';

class ShippingAddress {
  final String id;
  final String name;
  final String? addressName;
  final String phoneNumber;
  final String address;
  final bool isDefaultAddress;

  ShippingAddress({
    required this.id,
    required this.name,
    this.addressName,
    required this.phoneNumber,
    required this.address,
    required this.isDefaultAddress,
  });

  // 모델에서 엔티티로 변환하는 메서드
  ShippingAddressEntity toEntity() {
    return ShippingAddressEntity(
      id: id,
      name: name,
      addressName: addressName,
      phoneNumber: phoneNumber,
      address: address,
      isDefaultAddress: isDefaultAddress ? 1 : 0, // Boolean을 int로 변환
    );
  }

  factory ShippingAddress.fromEntity(ShippingAddressEntity entity) {
    return ShippingAddress(
      id: entity.id,
      name: entity.name,
      addressName: entity.addressName,
      phoneNumber: entity.phoneNumber,
      address: entity.address,
      isDefaultAddress: entity.isDefaultAddress == 1, // int를 Boolean으로 변환
    );
  }

  // JSON 데이터를 모델로 변환하는 메서드
  factory ShippingAddress.fromJson(Map<String, dynamic> json) {
    return ShippingAddress(
      id: json['id'],
      name: json['name'],
      addressName: json['addressName'],
      phoneNumber: json['phoneNumber'],
      address: json['address'],
      isDefaultAddress: json['isDefaultAddress'] == 1, // int를 Boolean으로 변환
    );
  }

  // 모델을 JSON 데이터로 변환하는 메서드
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'addressName': addressName,
      'phoneNumber': phoneNumber,
      'address': address,
      'isDefaultAddress': isDefaultAddress ? 1 : 0,
    };
  }
}