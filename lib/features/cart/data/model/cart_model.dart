class CartModel {
  final String? id;
  final String userId;
  final String deliveryPolicyId;
  final DateTime createdAt;
  final DateTime updatedAt;

  CartModel({
    this.id,
    required this.userId,
    required this.deliveryPolicyId,
    required this.createdAt,
    required this.updatedAt,
  });

  // copyWith 메서드 - 일부 속성만 수정하여 새 인스턴스를 생성할 때 사용
  CartModel copyWith({
    String? id,
    String? userId,
    String? deliveryPolicyId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CartModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      deliveryPolicyId: deliveryPolicyId ?? this.deliveryPolicyId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}