class ShippingAddressModel {
  final String id; // 배송지 고유 식별자
  final String userId;
  final String recipientName; // 수령인 이름
  final String phoneNumber; // 연락처
  final String postalCode; // 우편번호
  final String address; // 도로명 주소 혹은 지번 주소
  final String? addressName;
  final String detailAddress; // 상세 주소 (예: 아파트 동, 호수)
  final String? deliveryRequest; // 배송 요청 사항 (옵션)
  final bool isDefaultAddress; // 기본 배송지 여부
  final DateTime createdAt;


  ShippingAddressModel({
    required this.id,
    required this.userId,
    required this.recipientName,
    required this.phoneNumber,
    required this.postalCode,
    required this.address,
    this.addressName,
    required this.detailAddress,
    this.deliveryRequest, // 배송 요청 사항은 옵션이므로 nullable
    this.isDefaultAddress = false, // 기본값은 false로 설정
    required this.createdAt,
  });

}
