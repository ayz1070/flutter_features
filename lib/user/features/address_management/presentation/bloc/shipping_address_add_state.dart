import 'package:equatable/equatable.dart';

class ShippingAddressAddState extends Equatable {
  final String name;
  final String? addressName;
  final String phoneNumber;
  final String address;
  final bool isDefaultAddress;
  final bool formValid;

  const ShippingAddressAddState({
    this.name = '',
    this.addressName,
    this.phoneNumber = '',
    this.address = '',
    this.isDefaultAddress = false,
    this.formValid = false,
  });

  ShippingAddressAddState copyWith({
    String? name,
    String? addressName,
    String? phoneNumber,
    String? address,
    bool? isDefaultAddress,
    bool? formValid,
  }) {
    return ShippingAddressAddState(
      name: name ?? this.name,
      addressName: addressName ?? this.addressName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      isDefaultAddress: isDefaultAddress ?? this.isDefaultAddress,
      formValid: formValid ?? this.formValid,
    );
  }

  @override
  List<Object?> get props =>
      [name, addressName, phoneNumber, address, isDefaultAddress, formValid];
}
