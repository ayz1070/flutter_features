class DeliveryPolicy {
  final String id; // 배송 정책 ID
  final double baseShippingFee; // 기본 배송 요금
  final String companyName; // 택배사 이름
  final double extraFee; // 산간지역 추가 요금
  final int estimatedDeliveryTime; // 예상 소요 시간

  const DeliveryPolicy({
    required this.id,
    required this.baseShippingFee,
    required this.companyName,
    required this.extraFee,
    required this.estimatedDeliveryTime,
  });

  // copyWith 메서드 (필요시 기존 객체 복사하며 일부 필드만 변경 가능)
  DeliveryPolicy copyWith({
    String? id,
    double? baseShippingFee,
    String? courierService,
    double? extraFee,
    int? estimatedDeliveryTime,
  }) {
    return DeliveryPolicy(
      id: id ?? this.id,
      baseShippingFee: baseShippingFee ?? this.baseShippingFee,
      companyName: courierService ?? this.companyName,
      extraFee: extraFee ?? this.extraFee,
      estimatedDeliveryTime:
          estimatedDeliveryTime ?? this.estimatedDeliveryTime,
    );
  }

  // JSON 변환 메서드 (Firebase 등 데이터베이스 연동 시 유용)
  factory DeliveryPolicy.fromJson(Map<String, dynamic> json) {
    return DeliveryPolicy(
      id: json['id'],
      baseShippingFee: json['baseShippingFee'].toDouble(),
      companyName: json['companyName'],
      extraFee: json['extraFee'].toDouble(),
      estimatedDeliveryTime: json['estimatedDeliveryTime'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'baseShippingFee': baseShippingFee,
      'companyName': companyName,
      'extraFee': extraFee,
      'estimatedDeliveryTime': estimatedDeliveryTime,
    };
  }
}
