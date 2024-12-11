class ShippingAddress {
  final String id; // 배송지 고유 식별자
  final String userId; // 유저 ID
  final String recipientName; // 수령인 이름
  final String? addressName; // 주소 이름 (옵션)
  final String phoneNumber; // 연락처
  final String postalCode; // 우편번호
  final String address; // 도로명 주소 혹은 지번 주소
  final String detailAddress; // 상세 주소 (예: 아파트 동, 호수)
  final String? deliveryRequest; // 배송 요청 사항 (옵션)
  final bool isDefaultAddress; // 기본 배송지 여부
  final DateTime createdAt; // 생성 일시

  ShippingAddress({
    required this.id,
    required this.userId,
    required this.recipientName,
    this.addressName, // 주소 이름은 선택 사항
    required this.phoneNumber,
    required this.postalCode,
    required this.address,
    required this.detailAddress,
    this.deliveryRequest, // 배송 요청 사항은 선택 사항
    required this.isDefaultAddress,
    required this.createdAt, // 생성 일시는 필수
  });

  // copyWith 메서드 추가
  ShippingAddress copyWith({
    String? id,
    String? userId,
    String? recipientName,
    String? addressName,
    String? phoneNumber,
    String? postalCode,
    String? address,
    String? detailAddress,
    String? deliveryRequest,
    bool? isDefaultAddress,
    DateTime? createdAt,
  }) {
    return ShippingAddress(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      recipientName: recipientName ?? this.recipientName,
      addressName: addressName ?? this.addressName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      postalCode: postalCode ?? this.postalCode,
      address: address ?? this.address,
      detailAddress: detailAddress ?? this.detailAddress,
      deliveryRequest: deliveryRequest ?? this.deliveryRequest,
      isDefaultAddress: isDefaultAddress ?? this.isDefaultAddress,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}