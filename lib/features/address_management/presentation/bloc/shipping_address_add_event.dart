import 'package:equatable/equatable.dart';

// 기본 이벤트 클래스
abstract class ShippingAddressAddEvent extends Equatable {
  const ShippingAddressAddEvent();

  @override
  List<Object?> get props => [];
}

// 이름 변경 이벤트
class NameChanged extends ShippingAddressAddEvent {
  final String name;

  const NameChanged({required this.name});

  @override
  List<Object?> get props => [name];
}

// 주소 이름 변경 이벤트
class AddressNameChanged extends ShippingAddressAddEvent {
  final String addressName;

  const AddressNameChanged({required this.addressName});

  @override
  List<Object?> get props => [addressName];
}

// 전화번호 변경 이벤트
class PhoneNumberChanged extends ShippingAddressAddEvent {
  final String phoneNumber;

  const PhoneNumberChanged({required this.phoneNumber});

  @override
  List<Object?> get props => [phoneNumber];
}

// 주소 변경 이벤트
class AddressChanged extends ShippingAddressAddEvent {
  final String address;

  const AddressChanged({required this.address});

  @override
  List<Object?> get props => [address];
}

// 상세 주소 변경 이벤트
class AddressDetailChanged extends ShippingAddressAddEvent {
  final String addressDetail;

  const AddressDetailChanged({required this.addressDetail});

  @override
  List<Object?> get props => [addressDetail];
}

class PostalCodeChanged extends ShippingAddressAddEvent {
  final String postalCode;

  const PostalCodeChanged({required this.postalCode});

  @override
  List<Object?> get props => [postalCode];
}

// 기본 주소 토글 이벤트
class IsDefaultAddressToggled extends ShippingAddressAddEvent {
  final bool isDefaultAddress;

  const IsDefaultAddressToggled({required this.isDefaultAddress});

  @override
  List<Object?> get props => [isDefaultAddress];
}

// 폼 제출 이벤트
class FormSubmitted extends ShippingAddressAddEvent {
  final String id;
  final bool isEditMode;
  final String userId; // 유저 ID 추가

  const FormSubmitted({required this.id, required this.isEditMode, required this.userId});

  @override
  List<Object?> get props => [id, isEditMode, userId];
}