import 'package:equatable/equatable.dart';

class ShippingAddressAddState extends Equatable {
  final String name;
  final String? addressName;
  final String phoneNumber;
  final String postalCode; // 우편번호 필드 추가
  final String address;
  final String addressDetail; // 상세주소 필드 추가
  final String? deliveryRequest; // 배송 요청 사항 필드 추가
  final bool isDefaultAddress;
  final bool formValid;
  final bool isSubmitting;
  final bool isSuccess;
  final String? errorMessage;

  const ShippingAddressAddState({
    this.name = '',
    this.addressName,
    this.phoneNumber = '',
    this.postalCode = '', // 초기값 설정
    this.address = '',
    this.addressDetail = '', // 초기값 설정
    this.deliveryRequest, // 선택적 필드
    this.isDefaultAddress = false,
    this.formValid = false,
    this.isSubmitting = false,
    this.isSuccess = false,
    this.errorMessage,
  });

  ShippingAddressAddState copyWith({
    String? name,
    String? addressName,
    String? phoneNumber,
    String? postalCode, // 우편번호 필드 추가
    String? address,
    String? addressDetail, // 상세주소 필드 추가
    String? deliveryRequest, // 배송 요청 사항 추가
    bool? isDefaultAddress,
    bool? formValid,
    bool? isSubmitting,
    bool? isSuccess,
    String? errorMessage,
  }) {
    return ShippingAddressAddState(
      name: name ?? this.name,
      addressName: addressName ?? this.addressName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      postalCode: postalCode ?? this.postalCode, // 우편번호 처리
      address: address ?? this.address,
      addressDetail: addressDetail ?? this.addressDetail, // 상세주소 처리
      deliveryRequest: deliveryRequest ?? this.deliveryRequest, // 배송 요청 처리
      isDefaultAddress: isDefaultAddress ?? this.isDefaultAddress,
      formValid: formValid ?? this.formValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    name,
    addressName,
    phoneNumber,
    postalCode,
    address,
    addressDetail, // 상세주소 필드 포함
    deliveryRequest, // 배송 요청 필드 포함
    isDefaultAddress,
    formValid,
    isSubmitting,
    isSuccess,
    errorMessage,
  ];
}